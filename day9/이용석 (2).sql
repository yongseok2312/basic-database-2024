-- 1. 회원 테이블에서 이메일, 모바일, 이름, 주소 순으로 나오도록 검색하시오.
-- (결과는 아래와 동일하게 나와야 하며, 전체 행의 개수는 31개입니다)
SELECT Email AS 'email'
     , Mobile   AS 'mobile'
     , [Names]  as 'names'
     , Addr AS 'addr'
    FROM membertbl
    ORDER BY Addr DESC , email asc;

-- 2. 함수를 사용하여 아래와 같은 결과가 나오도록 쿼리를 작성하시오.(전채 행의 개수는 59개입니다)
SELECT [Names] AS '도서명'
     , Author AS '저자'
     , ISBN 
     , Price AS '정가'
    FROM bookstbl
    ORDER BY Price DESC;

-- 3. 다음과 같은 결과가 나오도록 SQL 문을 작성하시오.(책을 한번도 빌린적이 없는 회원을 뜻합니다)
SELECT a.[Names] AS '회원명'
     , a.Levels AS '회원등급'
     , a.Addr AS '회원주소'
     , NULL AS '대여일'
    FROM  membertbl AS a
    WHERE a.[Names] NOT IN (SELECT [Names]
    from membertbl AS m, rentaltbl AS r
    WHERE m.memberIdx = r.memberIdx)
    ORDER BY Levels ASC;


SELECT a.[Names] AS '회원명'
     , a.Levels AS '회원등급'
     , a.Addr AS '회원주소'
     , rentalDate AS '대여일'
  FROM  membertbl AS a
  LEFT OUTER JOIN rentaltbl AS b
    ON a.memberIdx = b.memberIdx
 WHERE rentalDate IS NULL
 ORDER BY a.Levels ASC;




-- 4. 다음과 같은 결과가 나오도록 SQL 문을 작성하시오.
SELECT d.[Names] AS '책 장르'
     , format(sum(price),'#,#') + '원' AS '총합계금액'
    FROM bookstbl AS b, divtbl AS d
    WHERE b.Division = d.Division
    GROUP BY d.[Names]

-- 5. 다음과 같은 결과가 나오도록 SQL 문을 작성하시오.

SELECT  ISNULL(d.[Names],'--합계--') AS '책 장르'
        , count(*) AS '권수'
        , format(sum(price),'#,#') + '원' AS '총합계금액'
    FROM bookstbl AS b, divtbl AS d
    WHERE b.Division = d.Division
    GROUP BY d.[Names] WITH ROLLUP
