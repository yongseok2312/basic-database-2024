/* ���ϸ� : AfterInsertBook.sql */
USE madang -- madang �����ͺ��̽� ���ο� Ʈ���Ÿ� ����
DROP TRIGGER AfterInsertBook -- ������ ���ǵ� Ʈ���Ű� ������ ����
GO

CREATE TRIGGER AfterInsertBook ON Book AFTER INSERT AS
BEGIN
  INSERT INTO Book_log 
  SELECT getdate( ), bookid, bookname, publisher, price from Inserted; 
END;