﻿-- 테이블 생성
-- basic2024 데이터베이스 사용
USE basic2024;
GO

-- 유저 테이블생성
CREATE TABLE Users (
	userid BIGINT IDENTITY(1,1) NOT NULL, -- 유저아이디 IDENTITY(1,1) 자동증가 insert문에 values에 추가할 필요 없음
	username NVARCHAR(40) NOT NULL, -- 유저 이름
	guildno INT DEFAULT 0,
	regdate DATETIME DEFAULT GETDATE() -- 등록일시
);
GO

-- 인벤토리 테이블 생성
CREATE TABLE Inventory(
	itemno BIGINT IDENTITY(1,1) NOT NULL,
	userid BIGINT NOT NULL,
	itemid INT NOT NULL,
	regdate DATETIME DEFAULT GETDATE()
);
GO


-- 만건 더미데이터 생성
DECLARE @i INT; -- 변수 선언
	SET @i = 0;
	WHILE (@i < 10000000)
	BEGIN
		SET @i = @i+1;
		INSERT INTO Users (username, guildno, regdate)
		values(CONCAT('user',@i),@i/100, DATEADD(dd, -@i/100, GeTDATE()));
	END;

SELECT *
	FROM Users

TRUNCATE TABLE Users -- 데이터 초기화
