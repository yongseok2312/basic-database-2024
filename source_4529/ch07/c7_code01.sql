USE madang; /* �����ͺ��̽� �̸� */
DROP TABLE Summer; /* ���� ���̺��� ������ ���� */

CREATE TABLE Summer
(sid INTEGER,
  class VARCHAR(20),
  price INTEGER
);

INSERT INTO Summer VALUES (100, 'FORTRAN', 20000);
INSERT INTO Summer VALUES (150, 'PASCAL', 15000);
INSERT INTO Summer VALUES (200, 'C', 10000);
INSERT INTO Summer VALUES (250, 'FORTRAN', 20000);

/* ������ Summer ���̺� Ȯ�� */
SELECT *
FROM   Summer;

 