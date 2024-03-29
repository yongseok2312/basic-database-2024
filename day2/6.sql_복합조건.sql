-- 조회 복합조건
-- 도서 중 축구에 관하고, 가격이 20,000원 이상인 책을 조회

SELECT  bookid, bookname, publisher, price
	FROM Book
	WHERE bookname LIKE '%축구%'
	AND price >= 20000;

-- 출판사가 굿스포츠 혹은 대한미디어 인 도서검색
SELECT *
	FROM Book
	WHERE publisher = '굿스포츠'
		OR publisher = '대한미디어';