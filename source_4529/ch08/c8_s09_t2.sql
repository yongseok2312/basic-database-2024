
BEGIN TRANSACTION
USE madang;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

SELECT SUM(price) �Ѿ�
FROM   Book;

/* ������� �����غ� �� ���� */
INSERT INTO Book VALUES (12, '�׽�Ʈ', '�׽�Ʈ���ǻ�', 5500);

SELECT SUM(price) �Ѿ�
FROM   Book;

COMMIT;
