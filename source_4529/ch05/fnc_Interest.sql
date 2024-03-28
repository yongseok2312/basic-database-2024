USE madang -- madang �����ͺ��̽� ���ο� �Լ� ����
DROP FUNCTION fnc_Interest -- ������ ���ǵ� �Լ��� ������ ����
GO

-- ��Į�� ����� �Լ� fnc_Interest ����
CREATE FUNCTION fnc_Interest (@Price INT)
RETURNS INT
AS
BEGIN
	DECLARE @myInterest INT
	-- ������ 30,000�� �̻��̸� 10%, 30,000�� �̸��̸� 5%
	IF @Price >= 30000
		SET @myInterest = @Price * 0.1;
	ELSE SET @myInterest = @Price * 0.05;
	RETURN @myInterest
	END
GO


/* Orders ���̺��� �� �ֹ��� ���� ������ ��� */
SELECT custid, orderid, saleprice, dbo.fnc_Interest(saleprice) interest 
FROM Orders;