
BEGIN TRANSACTION
USE madang;
SET TRANSACTION ISOLATION LEVEL READ
UNCOMMITTED;

SELECT * 
FROM   Users
WHERE  id=1;


SELECT * 
FROM   Users
WHERE  id=1;


SELECT * 
FROM   Users
WHERE  id=1;

COMMIT;
