-- 기본적으로 PK를 걸면 클러스터드 인덱스가 설정됨
ALTER TABLE Users ADD PRIMARY KEY(userid)

-- username에 넌클러스터드 인덱스 설정
CREATE CLUSTERED INDEX IX_Users_username ON Users(username);

DROP INDEX IX_Users_username ON username