-- 트랜스액션(트랜잭션)
-- SELECT 만 있으면 굳이 트랜잭션을 안걸어도 댐
-- INSERT, UPDATE, DELETE에서 중요한 로직을 처리할 때 트랜잭션 반드시 필요
SELECT *
    FROM Customer

-- 트랜잭션은 실수를 방지하기 위해서
BEGIN TRAN; -- 트랜잭션 시작

-- CUD에 대한 쿼리
UPDATE Customer
    SET phone = '010-7777-7777'
    WHERE custid = 2;

COMMIT; -- 제대로 실행되면 

ROLLBACK; -- 잘못 실행 되면