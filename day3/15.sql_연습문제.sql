-- 1. 박지성의 구매한 도서의 출판사 수
SELECT COUNT(DISTINCT publisher) AS '박지성 구매 책 출판사 수'
    FROM Book
    WHERE bookid IN (
    SELECT bookid
    FROM Orders
    WHERE custid = (SELECT custid FROM Customer WHERE [name]='박지성'))

-- 똑같은 문제 조언으로
SELECT COUNT(DISTINCT b.publisher) AS '구매책 출판사 수'
    FROM Book AS b, Orders as O, Customer AS c
    WHERE b.bookid = O.bookid
     AND O.custid = c.custid
     AND c.[name] = '박지성';

-- 2. 박지성이 구매한 도서의 이름, 가격, 정가와 판매가격 차이
SELECT b.bookname, b.price, O.saleprice ,(b.price - O.saleprice) AS '정가와의 차'
    FROM Book AS b, Orders as O, Customer AS c
    WHERE b.bookid = O.bookid
     AND O.custid = c.custid
     AND c.[name] = '박지성';



-- 3. 박지성이 구매하지 않은 도서의 이름
SELECT bookname
    FROM Book AS b
    WHERE b.bookid NOT IN(
        SELECT o.bookid
        FROM Orders AS o, Customer AS c
        WHERE o.custid = c.custid
        AND c.[name]='박지성'
    )