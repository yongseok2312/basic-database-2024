-- 삽입(INSERT)
INSERT INTO Book(bookid, bookname, publisher, price)
        VALUES (11,'스포츠 의학','한솔의학서적',90000);

-- 컬럼 순서를 변경가능
INSERT INTO Book(bookid, bookname, price,publisher )
        VALUES (11,'스포츠 의학',90000,'한솔의학서적');

-- 속성리스트를 생략가능(컬럼 개수 일치해야함)
INSERT INTO Book
        VALUES (12,'스포츠 의학2','한솔의학서적',90000);

-- 값을 생략가능
INSERT INTO Book(bookid, bookname, publisher)
        VALUES (13,'스포츠 의학3','한솔의학서적');

-- Imported_book 테이블 생성
CREATE TABLE Imported_Book (
  bookid      INT,
  bookname    VARCHAR(40),
  publisher   VARCHAR(40),
  price       INT 
);
INSERT INTO Imported_Book VALUES(21, 'Zen Golf', 'Pearson', 12000);
INSERT INTO Imported_Book VALUES(22, 'Soccer Skills', 'Human Kinetics', 15000);

-- 특수 INSERT INTO SELECT
INSERT INTO Book(bookid, bookname, publisher, price)
    SELECT bookid, bookname, publisher, price
        FROM Imported_Book

-- 수정(UPDATE)
-- 사전 준비
SELECT custid, [name],[address],phone   -- 복사
    INTO CustomerNew
    FROM Customer;

-- Customer 테이블에서 고객번호가 5인 고객의 주소를 대한민국 부산으로 변경
UPDATE Customer
    SET [address] = '대한민국 부산'
    WHERE custid = 5;

-- CustomerNew에서 고객 번호가 5인 고객의 주소를 대한민국 광주로 변경
UPDATE CustomerNew
    SET [address] = '대한민국 광주'
    WHERE custid = 5;

-- Customer 테이블에서 박세리 고객의 주소를 김연아 주소로 변경

    UPDATE Customer
    set [name] = (SELECT [address]
                        FROM Customer
                        WHERE [name] = '김연아')
    WHERE [name] = '박세리'

-- 수정은 여러컬럼(속성) 같이 가능
UPDATE CustomerNew
    SET [name] = '박채리'
    , [address] = '미국 보스턴'
    , phone = '010-1233-3244'
    WHERE custid= 5;

-- 삭제
DELETE FROM CustomerNew
    WHERE custid = 5;
    
-- 수정, 삭제는 항상 트랜잭션과 같이 실행해야 함
