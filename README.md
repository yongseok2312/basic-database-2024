# basic-database-2024
IoT 개발자과정 SQLserver 학습 리포지토리

## 1일차
- MS SQL Server 설치: https://www.microsoft.com/ko-kr/sql-server/sql-server-downloads
    - DBMS 엔진 -> 개발자 버전
        - iso 다운로드 후 설치 추천
        - SQL Server에 대한 Azure 확장 비활성
        - 데이터베이스 엔진 구성 (혼합모드로 선택!)
            - WINDOWS인증모드 : 외부에서 접근 불가 
            - 혼합모드(sa) : sa에 대한 암호를 지정(8자이상, 대소문자구분, 특수문자 포함) / 현재 mssql_p@ss 으로 설정함
            ![서버 연결](https://raw.githubusercontent.com/yongseok2312/basic-database-2024/main/images/db003.png)
            - 데이터루트 디렉토리는 변경
    ![개발툴 설치](https://raw.githubusercontent.com/yongseok2312/basic-database-2024/main/images/db001.png)
        - SSMS(SQL Server Management Studio) DB에 접근, 여러개발 작업을 할 수 있는 툴

- 데이터베이스 개념
    - 데이터를 보관, 관리, 서비스하는 시스템
    - Data, Information, Knowledge 개념
    - DBMS > Database > Data(Model)

- DB언어 
    - SQL(Structured Query Language) : 구조화된 질의 언어 - 객체지향 X
        - DDL(DAta Definition Language) : 데이터베이스, 테이블, 인덱스 생성
        - DML(Data Manipulation Language) : 검색, 삽입, 수정, 삭제 등의 기능
        - DCL(Data Control Language) : 권한 부여
        - TCL(Transaction Control Language) : 트랜스 액션 제어하는 기능 COMMIT, ROLLBACK 원래는 DCL의 일부

- SQL 기본학습
    - SSMS 실행

    ![SSMS로그인](https://raw.githubusercontent.com/yongseok2312/basic-database-2024/main/images/db002.png)

    - 특이사항 - SSMS 쿼리창에서 소스코드 작성시 빨간색 오류 밑줄이 가끔 표현

- DML 학습
    - SQL 명령어 키워드: SELECT, INSERT, UPDATE, DELETE
    - IT 개발 표현 언어: Request, Create, Update, Delete(CRUD라 부름 , CRU 개발 뜻은 INSERT, UPDATE, SELECT를 할 수있는 기능을 개발)
    - SELECT
    ```sql
    SELECT [ALL | DISTINCT] 속성이름(들)
        FROM 테이블이름(들)
    [WHERE 검색조건(들)]
    [GROUP BY 속성이름(들)]
    [HAVING 검색조건(들)]
    [ORDER BY 속성이름(들) [ASC|DESC]]
    ```

- SELECT 문 학습
    - 기본, 조건검색 학습 중

## 2일차
- Database 학습
    - DB 개발 시 사용할 수 있는 툴
        - SSMS(기본)
        - Visual studio - 아무런 설치 없이 개발 가능
        - Visual Studio Code - SQL Server(mssql) 플러그인 설치하고 개발
    - ServerName(HostName) - 내 컴퓨터이름|내 네트워크주소|127.0.0.1(LoopBack IP)|localhost(LoopBack URL)
    - 관계 데이터 모델
        - 릴레이션 - 행과 열로 구성된 테이블(관계 데이터 모델 에서만)
            - 행, 튜플, 열, 속성, 스키마, 인스턴스
        - 매핑되는 테이블(실제 DB) 명
            - 행, 레코드, 열, 컬럼, 컬럼 이름
        - 차수(degree) : 속성의 개수
        - 카디널리티(cardinality) : 튜플의 수

        - 릴레이션 특징
            1. 속성은 단일값을 가짐 (책 이름이 여러개 들어가면 안댐)
            2. 속성은 다른 이름을 가짐 ( 책 이름이라는 속성이 두번 있으면 안댐)
            3. 속성의 값은 정의된 도메인 값만 가짐(대학교 학년에 1~4학년만 들어감)
            4. 속성의 순서는 상관없음
            5. 릴레이션의 중복된 튜플은 허용 안함(같은 책 정보를 두 번 넣을 수 없음)
            6. 튜플 순서는 상관없음

        - 관계 데이터 모델은 아래의 요소로 구성됨
            - 릴레이션(Relation)
            - 제약조건(Constraint)
            - 관계대수(Reational algebra)
- DML 학습
    - SELECT 문
        - 복합조건, 정렬
        - 집계함수와 Group By
            - SUM(종합), AVG(평균), COUNT(개수), MIN(최소), MAX(최대)
            - 집계함수 외 일반 컬럼은 GROUP BY 절에 속한 컬럼만 SELECT문에 사용가능
            - HAVING은 집계함수의 필터로 GROUP BY 뒤에 작성, WHERE절과 필터링이 다르다

        - 두 개 이상의 테이블 질의(Query)
            - 관계형 DB에서 가장 중요한 기법 중 하나: JOIN! [참조](https://hongong.hanbit.co.kr/sql-%EA%B8%B0%EB%B3%B8-%EB%AC%B8%EB%B2%95-joininner-outer-cross-self-join/)
            - INNER JOIN(내부 조인)
            - LEFT|RIGHT OUTER JOIN(외부 조인) - 어느 테이블이 기준인지에 따라서 결과가 상이함
            ![외부조인](https://raw.githubusercontent.com/yongseok2312/basic-database-2024/main/images/db004.png)

## 3일차
- Database 학습
    - 관계 데이터 모델
        - 무결성 제약조건
            - 슈퍼키 - 유일한 값으로 구분 지을 수 있는 속성 또는 속성 집합(고객번호| 고객번호/이름| 고객번호/주소| 고객번호/이름/전화번호.. 이름만 사용 불가능)
            - 후보키 - 튜플을 유일한 값으로 구분 지을 수 있는 최소한의 속성 집합
            - 복합키 - 후보키 중 속성을 2개이상 집합을 한 키
            - 기본키(Primary Key!) - 여러 후부키 중에서 하나를 선정하여 대표로 삼는 키(고객번호)
                - 고려사항 - 고유한값(Unique), NULL불가(NOT NULL), 최소 속성의 집합
            - 대리키 - 기본키가 여러개의 속성으로 구성되어 복잡하거나, 보안문제가 생길때 새롭게 대체해주는 키를 생성
            - 대리키 - 기본키로 선정되지 않은 후보키
            - 외래키(Foriegn Key!) - 기본키를 참조하여 사용하는 것
                - 고려사항 - 다른 릴레이션과의 관계, 다른 릴레이션의 기본키를 호칭, 서로 같은 값이 사용, 기본키가 변경되면 외래키도 변경되어야 함
                            NULL과 중복을 허용(NOT NULL인 경우도 있음), 자기자신의 기본키를 외래키로 사용할 수도 있음, 외래키가 기본키의 속성중 하나가 될 수도 있음
            - 데이터 무결성(Integrity) - DB에 저장된 데이터의 일관성과 정확성을 지키는 것
                - 도메인 무결성 제약조건 - 데이터 타입, NULL, 기본값, 체크 특성을 지키는 것
                - 개체 무결성 제약조건 - 기본키 제약조건으로도 부름. Unique에 NOT NULL.(값이 중복되어도 안되고, 빠져도 안됨)
                - 참조 무결성 제약조건 - 외래키 제약조건으로도 부름. 부모의 키가 아닌 값은 사용할 수 없음. 외래키가 바뀔때 기본키의 값이 아닌 겂은 제약을 받는다.
                    - RESTRICT(자식에서 키를 사용하고 있으면 부모 삭제 금지), CASCADE(부모가 삭제 되면 해당 자식도 같이 삭제), DEFAULT(부모가 지워지면 자식은 지정된 기본값으로 변경),NULL(부모가 지워지면 해당 자식에 해당 값을 NULL로 변경)
                - 유일성 제약조건 - 일반 속성의 값이 중복되면 안되는 제약조건. NULL값은 허용.

- DML 학습
    - SELECT문
        - JOIN
            - OUTER JOIN(외부 조인)
                -LEFT|RIGHT|FULL(FULL은 거의 사용안함) - 왼쪽 테이블을 기준으로 조건에 일치하지 않는 왼쪽테이블 데이터도 모두 표시(LEFT OUTER JOIN). 오른쪽 테이블 기준으로 조건에 일치하지 않는 오른쪽테이블 데이터 모두 표시(RIGHT OUTER JOIN)

            - 부속질의(SubQuery)
                - 쿼리 내에 다시 쿼리를 작성하는 것
                - 서브쿼리를 쓸 수 있는 장소
                    - SELECT 절 - 한 컬럼에 하나의 값만
                    - FROM 절   - 가상의 테이블로 사용
                    - WHERE 절  - 여러 조건에 많이 사용
            
            - 집합연산 - JOIN도 집합이지만, 속성별로 가로로 병합하기 때문에 집합이라 부르지 않음. 집합은 데이터를 세로롤 합치는 것
                - 합집합(UNION) - UNION(중복 제거), UNION ALL(중복허용)
                - 차집합(EXCEPT) - 하나의 테이블에서 교집합 값을 뺀 나머지
                - 교집합(INERSECT) - 두 테이블에 모두 존재하는 값
                - EXISTS - 데이터 자체의 존재여부로

- DDL 학습 - SSMS에서 마우스로 조작이 편리
    - CREATE - 개체(데이터베이스, 테이블, 뷰, 사용자 등)을 생성하는 구문
        ```sql
        -- 테이블 생성에 한정
        CREATE TABLE 테이블 명
        ({속성 이름 데이터 타입
            [NOT NULL]
            [UNIQUE]
            [DEFAULT 기본값]
            [CHECK 체크 조건]
        }
        [PRIMARY KEY 속성이름(들)]
        {[FORIEGN KEY 속성이름 REFERENCES 테이블이름(속성이름)]
         [ON UPDATE [NO ACTION | CASCADE | SET NULL | SET DEFAULT]]
         }
        )
        ```
    - ALTER - 개체를 변경(수정)하는 구문
    ``` sql
    ALTER TABLE 테이블명
        [ADD 속성 이름 데이터 타입]
        [DROP COLUMN 속성이름]
        [ALTER COLUMN 속성이름 데이터 타입]
        [ALTER COLUMN 속성이름 [NULL | NOT NULL]]
        [ADD PRIMARY KEY(속성이름)]
        [[ADD | DROP] 제약조건이름]
    ```
    - DROP - 개체를 삭제하는 구문
    ```sql
    DROP TABLE 테이블명;
    ```

    - 외래키로 사용되는 기본키가 있으면, 외래키를 사용하는 테이블 삭제 후, 기본키의 테이블 삭제 해야 함!!

## 4일차
- DML 학습(SELECT외)
    - INSERT
    - UPDATE
    - DELETE

- SQL 고급
    - 내장함수
    - 서브쿼리 리뷰
    - 뷰
    - 인덱스