USE madang -- madang �����ͺ��̽� ���ο� ���ν����� ����
DROP PROCEDURE Interest -������ ���ǵ� ���ν����� ������ ����
GO

-- Interest ���ν��� ����
CREATE PROCEDURE Interest AS
BEGIN
	DECLARE @myInterest AS NUMERIC(10,1)
	DECLARE @Price AS INT
	SET @myInterest = 0.0
	DECLARE InterestCursor CURSOR FOR
		SELECT saleprice FROM Orders;
	OPEN InterestCursor
	FETCH NEXT FROM InterestCursor INTO @Price;
	WHILE @@FETCH_STATUS=0
	BEGIN
		IF @Price >= 30000
			SET @myInterest = @myInterest + @Price * 0.1;
		ELSE SET @myInterest = @myInterest + @Price * 0.05;
		FETCH NEXT FROM InterestCursor INTO @Price;
	END
	CLOSE InterestCursor;
	DEALLOCATE InterestCursor;
	PRINT ' ��ü ���� �ݾ� = '+ CONVERT(CHAR(15), @myInterest);
END
GO