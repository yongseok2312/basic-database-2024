
BEGIN TRANSACTION;
USE madang;
UPDATE Book 
SET     price=price+100
WHERE  bookid=1;

UPDATE Book 
SET     price=price+100
WHERE  bookid=2;

/*��(������)��*/

 
COMMIT;
