-- VIEW(뷰)
-- 고객명과 책이름을 같이 볼 수 있는 주문 뷰를 만들어라
CREATE VIEW v_orderdetail
    AS
SELECT o.orderid
     , o.custid
     , c.[name]
     , o.bookid
     , b.bookname
     , o.saleprice
     , b.price
     , o.orderdate
    FROM Customer AS c, Orders AS o, Book AS b
    WHERE c.custid = o.custid
    AND o.bookid = b.bookid

-- 대한민국 고객으로 구성된 뷰를 만드시오
CREATE VIEW v_kcustomer
    AS
SELECT *
    FROM Customer
    WHERE [address] LIKE '%대한민국%'

-- 조회
SELECT *
    FROM v_kcustomer

-- 데이터 삽입, 수정, 삭제 가능 (하나의 테이블) 되도록 사용하지 말 것!!!
INSERT INTO v_kcustomer
    VALUES (6, '손흥민', '대한민국 강원도', '010-1234-5678')

-- v_orderdetail(JOIN으로 만든 여러개의 테이블) -> 삽입, 수정, 삭제 불가능
INSERT INTO v_orderdetail
VALUES (11,6,'손흥민',1,'축구의 역사',6500,7000,'2024-04-03')

DROP VIEW v_kcustomer

-- 시스템 뷰, DBMS가 미리 만들어논 뷰들
-- 내 데이터베이스에 있는 db종류
SELECT * FROM sys.databases

-- 테이블 내에 존재하는 컬럼명 조회
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'Book'

