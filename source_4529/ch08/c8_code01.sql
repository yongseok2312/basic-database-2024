BEGIN TRANSACTION;
USE madang
INSERT INTO Book VALUES(99, '�����ͺ��̽�', '�Ѻ�', 25000);
SELECT bookname "bookname1" FROM Book WHERE bookid=99;  
/*���: �����ͺ��̽� , SAVEPOINT: a */
SAVE TRANSACTION a;

UPDATE Book SET bookname='�����ͺ��̽� ����' WHERE bookid=99;
SELECT bookname "bookname2" FROM Book WHERE bookid=99;   
  /* ���: �����ͺ��̽� ���� , SAVEPOINT: b */
SAVE TRANSACTION b;

UPDATE Book SET bookname='�����ͺ��̽� ���� �� �ǽ�' WHERE bookid=99;
SELECT bookname "bookname3" FROM Book WHERE bookid=99;    
/*���: �����ͺ��̽� ���� �� �ǽ� */

ROLLBACK TRANSACTION b;
SELECT bookname "bookname4" FROM Book WHERE bookid=99;   
/*���: �����ͺ��̽� ���� , SAVEPOINT: b �� �ѹ� */

ROLLBACK TRANSACTION a;
SELECT bookname "bookname5" FROM Book WHERE bookid=99;    
/*���: �����ͺ��̽� , SAVEPOINT: a �� �ѹ�*/
COMMIT;

BEGIN TRANSACTION
UPDATE Book SET bookname='�����ͺ��̽� ���� �� �ǽ�2' WHERE bookid=99; 
SELECT bookname "bookname6" FROM Book WHERE bookid=99;    
/*���: �����ͺ��̽� ���� �� �ǽ�2 */

ROLLBACK TRANSACTION;
SELECT bookname "bookname5" FROM Book WHERE bookid=99;    
/*���: �����ͺ��̽� , �ѹ� */
DELETE FROM  Book WHERE bookid=99;

COMMIT TRANSACTION; /* ����.. �̹� ROLLBACK �Ǿ��� */