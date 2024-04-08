-- 잘못 만든 데이터를 전부 초기화
-- 삭제

DELETE FROM Users; -- WHERE 절이 없으면 모두 삭제
-- 단, identity(1,1)로 설정한 테이블에서 1부터 다시 넣도록 설정하려면
TRUNCATE TABLE Users;

DECLARE @i INT; -- 변수 선언
	SET @i = 0;
	WHILE (@i < 20000000)
	BEGIN
		SET @i = @i+1;
		INSERT INTO Users (username, guildno, regdate)
		values(CONCAT('user',@i),@i/100, DATEADD(dd, -@i/100, GeTDATE()));
	END;

-- 인덱스가 없는 상태
-- 100만건 정도 데이터 조회시 5~8초 사이 시간 소요

-- 인덱스를 걸기 위해서 userid에 기본키(PK)를 설정
ALTER TABLE Users ADD PRIMARY KEY(userid)

-- PK에 클러스터 인덱스가 설정됨

-- ! WHERE절에 검색을 위해서 username을 사용
-- 인덱스를 PK에 거는 것이 아니라 username에 걸어야 함
CREATE CLUSTERED INDEX IX_Users_username ON Users(username)
DROP INDEX IX_Users_username ON Users;

-- 인데스는 대량의 데이터에서 찾고자하는 데이터를 빨리 찾게 해주는 목적.
-- WHERE절, JOIN의 ON 절에 들어가는 컬럼에 인덱스를 설정하는 것이 속도 개선에 도움
-- 1번 PK, 2번 FK, 3번 WHERE절에 검색시 들어가는 컬럼에 인덱스를 설정
-- 단, NULL값이 많거나, 중복이 많은 컬럼에 인덱스를 걸면 성능에 도움을 받지 못함
