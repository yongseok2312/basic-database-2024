-- 책중에서 '축구의 역사'라는 도서의 출판사와 가격을 알고 싶어.
-- dbo는 DataBase Owner


SELECT publisher, price
	FROM Book
	WHERE bookname = '축구의 역사';


--김연아 고객의 전화번호를 찾으시오.
--1
SELECT * -- ALL이라고 호칭
	FROM Customer;

--2	(1 step에서 수정)
SELECT *
	FROM Customer
	WHERE [name] = '김연아';

--3	(2 step에서 수정)
SELECT phone
	FROM Customer
	WHERE [name] = '김연아';