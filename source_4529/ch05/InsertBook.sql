USE madang --madang �����ͺ��̽� ���ο� ���ν����� ����
DROP PROCEDURE InsertBook -- ������ ���ǵ� ���ν����� ������ ����
GO

-- InsertBook ���ν��� ����
CREATE PROCEDURE InsertBook(@BookID INT, 
   @BookName VARCHAR(40), @Publisher VARCHAR(40), @Price INT) AS
BEGIN
	INSERT INTO dbo.Book(bookid, bookname, publisher, price)
		VALUES (@BookID, @BookName, @Publisher, @Price);
END
GO