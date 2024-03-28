-- 모든 도서의 이름과 가격을 검색하시오
-- Ctrl+Shift+U-->대문자, L소문자
SELECT bookname, price
	FROM Book;

-- 모든 도서의 가격과 이름을 검색하시오
SELECT price, bookname
	FROM Book;

-- 모든 도서의 도서번호, 도서이름, 출판사, 가격을 검색하시오
SELECT *
	FROM Book;

SELECT bookid, bookname, publisher, price
	FROM Book;

-- 도서에서 출판사를 검색하시오(중복제거)
SELECT DISTINCT publisher
	FROM Book;

-- 조건검색(조건 연산자 사용)
-- 가격이 20000원 미만인 도서를 검색하시오
SELECT *
	FROM Book
	WHERE price <20000

-- 가격이 10000원 이상 20000원 미만인 도서를 검색하시오
SELECT *
	FROM Book
	WHERE price BETWEEN 10000 AND 20000;

SELECT *
	FROM Book
	WHERE price >= 10000 AND price <= 20000;

-- 출판사가 굿스포츠와 대한미디어인 도서를 검색하시오
SELECT *
	FROM Book
	WHERE publisher IN('굿스포츠', '대한미디어');

-- 출판사가 굿스포츠와 대한미디어가 아닌 도서를 검색하시오
SELECT *
	FROM Book
	WHERE publisher NOT IN('굿스포츠', '대한미디어');

-- 축구의 역사를 출판한 출판사를 검색하시오
SELECT bookname, publisher
	FROM Book
	WHERE bookname LIKE '축구%'; -- 축구로 시작하는

SELECT bookname, publisher
	FROM Book
	WHERE bookname LIKE '%축구'; -- 축구로 끝나는

SELECT bookname, publisher
	FROM Book
	WHERE bookname LIKE '%축구%'; -- 축구가 들어가는

SELECT bookname, publisher
	FROM Book
	WHERE bookname LIKE '_구%'; -- 축구가 들어가는