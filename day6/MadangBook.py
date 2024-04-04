# 파이썬 DB 연동 프로그램

import sys
from PyQt5 import uic
from PyQt5.QtCore import Qt
from PyQt5.QtWidgets import *
from PyQt5.QtGui import *
import webbrowser
from PyQt5.QtWidgets import QWidget

## MSSQL 연동할 라이브러리(모듈)
import pymssql

## 전역변수(나중에 변것이 여기면 변경하면 됨)
serverName = '127.0.0.1'
userid = 'sa'
userpass = 'mssql_p@ss'
dbName = 'Madang'
dbCharset = 'UTF8'

# 저장 버튼 클릭시 삽입, 수정을 구분짓기 위한 구분자
mode = 'I' # U I:Insert, U:Update

## 화면 불러오기
class qtAPP(QMainWindow):
    def __init__(self) -> None:
        super().__init__()
        uic.loadUi('./day6/MadangBook.ui', self) ## 나한테 ui를 던져줘
        self.initUI()
        self.btnReloadClicked()

    def initUI(self) -> None:
        # 입력제한
        self.txtBookid.setValidator(QIntValidator(self)) # 숫자만 입력하도록 제한
        self.txtPrice.setValidator(QIntValidator(self))

        # Button 4개에 대해서 사용등록
        self.btnNew.clicked.connect(self.btnNewClicked) ## 신규버튼 시그널(이벤트)에 대한 슬롯함수(26행) 생성
        self.btnSave.clicked.connect(self.btnSaveClicked) ## 저장버튼
        self.btnDel.clicked.connect(self.btnDelClicked) ## 삭제버튼
        self.btnReload.clicked.connect(self.btnReloadClicked) ## 조회버튼
        self.tblBooks.itemSelectionChanged.connect(self.tblBooksSelected) ## 테이블위젯 결과를 클릭 시 발생
        self.show()

    def btnNewClicked(self): # 신규버튼 클릭
        global mode
        mode = 'I'
        self.txtBookid.setText('')
        self.txtBookname.setText('')
        self.txtPublisher.setText('')
        self.txtPrice.setText('')
        #  선택한 데이터에서 신규를 누르면 slef.txtBookid 사용여부 변경
        self.txtBookid.setEnabled(True)
    
    def btnSaveClicked(self): # 저장버튼 클릭
        # 입력 검증(Validation Check) 반드시
        # 1. 텍스트박스를 비워두고 저장버튼 누르면 안댐
        bookid = self.txtBookid.text()
        bookname = self.txtBookname.text()
        publisher = self.txtPublisher.text()
        price = self.txtPrice.text()

      
        # print(bookid,bookname,publisher,price)
        warningmessage = '' # 경고 메세지
        isValid = True # 빈 값이 있으면 False로 바뀜
        if bookid == None or bookid == '':
            warningmessage += '책 번호가 없습니다.\n'
            isValid = False
        elif bookname == None or bookname == '':
            warningmessage += '책 제목이 없습니다.\n'
            isValid = False
        elif publisher == None or publisher == '':
            warningmessage += '출판사가 없습니다.\n'
            isValid = False
        elif price == None or price == '':
            warningmessage += '책 가격이 없습니다.\n'
            isValid = False

        if isValid == False: # 입력 값중에 하난라도 빈값이 존재
            QMessageBox.warning(self,'저장경고',warningmessage)
            return

        ## mode = 'I'일때는 중복번호를 체크해야 하지만, Mode = 'U'일때는 체크해서 막으면 수정자체가 안됨
        if mode == 'I':
        # 2.현재 존재하는 번호와 같은 번호를 사용했는지 체크, 이미 있는 번호면 DB입력 쿼리 실행이 안되도록 막아야 함
            conn = pymssql.connect(serverName, userid, password=userpass, database=dbName, charset=dbCharset)
            cursor = conn.cursor(as_dict=False) # COUNT(*)는 데이터가 딱 1개 이기 때문에 as_dict=false로 해야함

            query = f'''SELECT COUNT(*)
	                FROM Book
	                WHERE bookid = {bookid}''' # 현재 입력하고자하는 번호가 있는지 확인하는 쿼리
            cursor.execute(query)
            #print(cursor.fetchone()[0]) # COUNT(*)는 데이터가 딱 1개 이기 때문에 cusor.fetchone() 함수로 (1,) 튜플을 가져옴
            valide=cursor.fetchone()[0]
            conn.close()

            if valide == 1:
                QMessageBox.warning(self, '저장 경고','책 번호의 데이터가 중복되었습니다! \n번호를 변경하세요')
                return
        
        

        # 3. 입력 검증 후 DB Book테이블에 삽입 시작!
        # bookid, bookName, publisher, price
        if mode == 'I':
            query = f'''
                        INSERT INTO Book
                             VALUES('{bookid}','{bookname}','{publisher}','{price}')'''
        elif mode == 'U':   # 수정
            query = f'''
                        UPDATE Book
                            SET bookname = '{bookname}'
                            , publisher = '{publisher}'
                            , price = '{price}'
                            WHERE bookid = '{bookid}'
                    '''
        conn = pymssql.connect(serverName, userid, password=userpass, database=dbName, charset=dbCharset)
        cursor = conn.cursor(as_dict=False) # INSERT는 데이터를 가지고 오는게 아니기 때문

        try:
            cursor.execute(query)
            conn.commit() # 저장을 확립

            if mode == 'I':QMessageBox.about(self,'저장성공','데이터를 저장했습니다')
            else: QMessageBox.about(self,'수정','수정되었습니다')

        except Exception as e:
            QMessageBox.warning(self, '저장 실패',f'{e}')
            conn.rollback() # 저장이 실패하면 원상 복귀
        finally:
            conn.close() # 오류의 상관없이 DB close
        self.btnReloadClicked() # 조회버튼 클릭

    def btnDelClicked(self): # 삭제버튼 클릭
        # 삭제
        bookid = self.txtBookid.text()
        # Validtaion Check
        if bookid == None or bookid =='':
            QMessageBox.warning(self,'삭제경고','책 번호 없이 삭제할 수 없습니다.')
            return
        
        re = QMessageBox.question(self, '삭제여부', '정말로 삭제하시겠습니까?', QMessageBox.Yes | QMessageBox.No)
        if re == QMessageBox.No:
            return    
        
        conn = pymssql.connect(serverName, userid, password=userpass, database=dbName, charset=dbCharset)
        cursor = conn.cursor(as_dict=False)
        query = f'''
                    DELETE FROM Book
                        WHERE bookid = '{bookid}'
                    '''
        try:
            cursor.execute(query)
            conn.commit()

            QMessageBox.about(self,'삭제','삭제되었습니다')
        except Exception as e:
            QMessageBox.warning(self,'삭제 실패',f'{e}')
            conn.rollback()
        finally:
            conn.close()
        self.btnReloadClicked()

    def btnReloadClicked(self): # 조회버튼 클릭
        lstResult = []
        conn = pymssql.connect(serverName, userid, password=userpass, database=dbName, charset=dbCharset)
        cursor = conn.cursor(as_dict=True)

        query = '''
                 SELECT bookid
                         ,bookname
                         ,publisher
                         ,ISNULL(FORMAT(price, '#,#'), '0') AS price
                          FROM Book
                '''

        cursor.execute(query)
        for row in cursor:
               #print(f'bookid={row["bookid"]}, bookname{row["bookname"]}, publisher={row["publisher"]}, price={row["price"]}')
               # dictionary로 만든 결과를 lstResult에 append()
               temp ={'bookid' : row["bookid"], 'bookname' : row["bookname"], 'publisher': row["publisher"], 'price' : row["price"]}
               lstResult.append(temp)

        conn.close() # DB는 접속해서 일이 끝나면 무조건 닫는다.

        #print(lstResult) # tblBooks 테이블 위젯에 표시
        self.makeTable(lstResult)

    def makeTable(self, data):  # tblBooks 위젯을 데이터와 컬럼 생성해주는 함수
        self.tblBooks.setColumnCount(4) # bookid, bookname, publisher, price
        self.tblBooks.setRowCount(len(data))    # 조회에서 나온 리스트의 갯수로 결정
        self.tblBooks.setHorizontalHeaderLabels(['책번호', '책제목', '출판사','정가'])

        n = 0 
        for item in data:
            #print(item['bookid']) 디버깅시 필요
            idItem = QTableWidgetItem(str(item['bookid']))
            idItem.setTextAlignment(Qt.AlignmentFlag.AlignRight | Qt.AlignmentFlag.AlignVCenter)
            self.tblBooks.setItem(n, 0, idItem) # set(row, column, text)
            bookname = QTableWidgetItem(item['bookname'])
            bookname.setTextAlignment(Qt.AlignmentFlag.AlignCenter)
            self.tblBooks.setItem(n, 1, bookname) # set(row, column, text)
            bookpublisher = QTableWidgetItem(item['publisher'])
            bookpublisher.setTextAlignment(Qt.AlignmentFlag.AlignCenter)
            self.tblBooks.setItem(n, 2, bookpublisher) # set(row, column, text)
            price1 = QTableWidgetItem(str(item['price']))
            price1.setTextAlignment(Qt.AlignmentFlag.AlignRight | Qt.AlignmentFlag.AlignVCenter)
            self.tblBooks.setItem(n, 3, price1 ) # set(row, column, text)

            n+=1
        
        self.tblBooks.setColumnWidth(0,65)
        self.tblBooks.setColumnWidth(1,230)
        self.tblBooks.setColumnWidth(2,150)
        self.tblBooks.setColumnWidth(3,90)
        # 컬럼 더블 클릭 금지
        self.tblBooks.setEditTriggers(QAbstractItemView.NoEditTriggers)
    

    def tblBooksSelected(self): # 조회결과 테이블위젯 내용 클릭
        rowIndex = self.tblBooks.currentRow() #현재 마우스로 선택된 행의 인덱스
        bookid = self.tblBooks.item(rowIndex, 0).text() # 책 번호
        bookname = self.tblBooks.item(rowIndex,1).text() 
        publisher = self.tblBooks.item(rowIndex,2).text() 
        price = self.tblBooks.item(rowIndex,3).text().replace(',', '') 
        #print(bookid,bookname,publisher,price)
        # 지정된 lineEdit(TextBox)에 할당
        self.txtBookid.setText(bookid)
        self.txtBookname.setText(bookname)
        self.txtPublisher.setText(publisher)
        self.txtPrice.setText(price)
        # 모드를 update로 변경
        global mode #전역 변수를 내부에서 사용가능
        mode = 'U'
        # txtBookid를 사용하지 못하게 설정
        self.txtBookid.setEnabled(False)

    # 원래 PyQt에 있는 함수 closeEvent를 재정의(Override)
    def closeEvent(self, event) -> None:
        ae = QMessageBox.question(self, '종료여부', '종료하시겠습니까?', QMessageBox.Yes | QMessageBox.No)
        if ae == QMessageBox.Yes:
            event.accept() # 완전히 꺼짐
        else:
            event.ignore()

if __name__ == '__main__':
    app = QApplication(sys.argv)
    inst = qtAPP()
    sys.exit(app.exec_())