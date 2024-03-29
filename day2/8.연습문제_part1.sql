-- 연습문제
-- 1. 도서번호가 1인 도서검색
SELECT *
	FROM Book
	WHERE bookid = 1;

-- 2. 가격이 2만원 이상
SELECT *
	FROM Book
	WHERE price >= 20000;

-- 3. 박지성의 총 구매액
SELECT *
	FROM Customer;

SELECT SUM(saleprice) AS [박지성의 총 구매액]
	FROM Orders
	WHERE custid = 1;

-- 4. 박지성의 구매한 도서의 수
SELECT COUNT(saleprice) AS [박지성의 총 구매수]
	FROM Orders
	WHERE custid = 1;
