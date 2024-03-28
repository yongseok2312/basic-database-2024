USE madang; /* �����ͺ��̽� �̸� */

DROP TABLE SummerPrice; /* ���� ���̺��� ������ ���� */
DROP TABLE SummerEnroll; /* ���� ���̺��� ������ ���� */

/* SummerPrice ���̺� ���� */
CREATE TABLE SummerPrice
( class VARCHAR(20),
  price INTEGER
);

INSERT INTO SummerPrice VALUES ('FORTRAN', 20000);
INSERT INTO SummerPrice VALUES ('PASCAL', 15000);
INSERT INTO SummerPrice VALUES ('C', 10000);

SELECT *
FROM   SummerPrice;


/* SummerEnroll ���̺� ���� */
CREATE TABLE SummerEnroll
( sid INTEGER,
  class VARCHAR(20)
);

INSERT INTO SummerEnroll VALUES (100, 'FORTRAN');
INSERT INTO SummerEnroll VALUES (150, 'PASCAL');
INSERT INTO SummerEnroll VALUES (200, 'C');
INSERT INTO SummerEnroll VALUES (250, 'FORTRAN');

SELECT *
FROM SummerEnroll;

