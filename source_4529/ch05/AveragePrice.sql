USE madang -- madang �����ͺ��̽� ���ο� ���ν����� ����
DROP PROCEDURE AveragePrice -- ������ ���ǵ� ���ν����� ������ ����
GO

-- AveragePrice ���ν��� ����
CREATE PROCEDURE AveragePrice @AverageVal INT OUTPUT AS
BEGIN
	SET @AverageVal = (SELECT AVG(price) FROM Book
WHERE price IS NOT NULL);
END
GO
