

BEGIN TRANSACTION
USE madang;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

UPDATE Book 
SET     price=price+500
WHERE  bookid=1;
(������ �����ϴ� �� ...)
/* ��� ���°� ��, T1�� COMMIT�ϸ� ����� */

SELECT SUM(price) �Ѿ�
FROM   Book;


COMMIT;
