/* �ǽ� ���̺� ���� */
BEGIN TRANSACTION
USE madang;
Drop TABLE Users;
CREATE TABLE Users (
  id	INTEGER,
  name	VARCHAR(20),
  age	INTEGER);

INSERT INTO Users VALUES (1, 'HONG GILDONG', 30);

SELECT * 
FROM   Users;


COMMIT;