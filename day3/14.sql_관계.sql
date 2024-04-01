-- 전체 고객 중 도서를 구매하지 않은 고객의 이름을 조회

SELECT [name]
    FROM Customer
EXCEPT
SELECT [name]
    FROM Customer
    WHERE custid IN (SELECT DISTINCT custid FROM Orders);

-- 합지합 중복을 허용안함
SELECT [name]
    FROM Customer
UNION
SELECT [name]
    FROM Customer
    WHERE custid IN (SELECT DISTINCT custid FROM Orders);

-- 합지합 중복을 허용
SELECT [name]
    FROM Customer
UNION ALL
SELECT [name]
    FROM Customer
    WHERE custid IN (SELECT DISTINCT custid FROM Orders);

-- 교집합
SELECT [name]
    FROM Customer
INTERSECT
SELECT [name]
    FROM Customer
    WHERE custid IN (SELECT DISTINCT custid FROM Orders);

-- UNION - 각 컬럼의 타입형이 각각 일치해야 함
SELECT bookid
     , bookname
    FROM Book
    UNION
SELECT custid
        , [name]
    FROM Customer;

-- EXISTS
SELECT c.[name]
     , c.address
    FROM Customer AS c
    WHERE EXISTS (SELECT)

