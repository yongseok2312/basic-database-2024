USE madang -- madang �����ͺ��̽� ���ο� ���ν����� ���� 
DROP PROCEDURE BookInsertOrUpdate -- ������ ���ǵ� ���ν����� ������ ����
GO

-- BookInsertOrUpdate ���ν��� ����
CREATE PROCEDURE BookInsertOrUpdate(@myBookID INT,
	@myBookName VARCHAR(40), @myPublisher VARCHAR(40), @myPrice INT) AS
BEGIN
	IF EXISTS (SELECT * FROM Book WHERE bookname = @myBookName)
		UPDATE Book SET price = @myPrice
			WHERE bookname = @myBookName;
	ELSE
		INSERT INTO Book(bookid, bookname, publisher, price)
			SELECT @myBookID, @myBookName, @myPublisher, @myPrice;
IF @@Error <> 0 RAISERROR ('BOOK ���̺� ���� ����', 16, 1)
END
GO