-- OUTER JOIN(외부 조인)
-- LEFT OUTER JOIN vs RIGHT OUTER JOIN

SELECT *
	FROM TableA A
	LEFT OUTER JION TableB B
		ON A.key = B.key;

		-- 이 둘은 같은 쿼리
SELECT *
	FROM TableB B
	RIGHT OUTER JION TableA A
		ON A.key = B.key;