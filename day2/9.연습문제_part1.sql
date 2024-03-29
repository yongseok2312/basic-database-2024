-- 연습문제 part2
-- 1. 마당도서의 총 개수
SELECT COUNT(*) AS [마당도서의 총 개수]
	FROM Book

-- 2. 마당서점에 도서를 출고하는 출판사의 총 수
SELECT COUNT(distinct publisher) AS [마당도서의 총 출판수]
	FROM Book
	

-- 3. 모든 고객의 이름과 주소
SELECT [name], [address]
	FROM Customer

-- 4. 7/4-7/7 주문 번호
SELECT orderid
	FROM Orders
	WHERE orderdate BETWEEN '2023-07-04' AND '2023-07-07'

-- 5. 7/4-7/7가 아닌 주문 번호
SELECT orderid
	FROM Orders
	WHERE orderdate NOT BETWEEN '2023-07-04' AND '2023-07-07'

-- 6. 성이 '김'씨인 고객의 이름과 주소
SELECT  [name], [address]
	FROM Customer
	WHERE [name] LIKE '김%'

-- 7. 성이 '김'씨이고 이름이 '아'로 끝나는 고객의 이름과 주소
SELECT  [name], [address]
	FROM Customer
	WHERE [name] LIKE '김%' And
	[name] LIKE '%아'