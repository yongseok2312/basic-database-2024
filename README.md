# basic-database-2024
IoT 개발자과정 SQLserver 학습 리포지토리

## 1일차
- MS SQL Server 설치: https://www.microsoft.com/ko-kr/sql-server/sql-server-downloads
    - DBMS 엔진 -> 개발자 버전
        - iso 다운로드 후 설치 추천
        - SQL Server에 대한 Azure 확장 비활성
        - 데이터베이스 엔진 구성 (혼합모드로 선택!)
            - WINDOWS인증모드 : 외부에서 접근 불가 
            - 혼합모드(sa) : sa에 대한 암호를 지정(8자이상, 대소문자구분, 특수문자 포함) / 현재 DESKTOP-QO2E9L6/ mssql_p@ss 으로 설정함
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
- 관계 데이터 모델
    - 관계 대수 - 릴레이션에서 원하는 결과를 얻기위한 수학의 대수와 같은 연산 사용 기술하는 언어
    - 셀렉션, 프로젝션, 집합, 조인, 카티션 프로덕트, etc...

- DML 학습(SELECT외)
    - INSERT

        ```sql
        INSERT INTO 테이블이름[(속성리스트)]
            VALUES(값리스트);
        ```

    - UPDATE

        ```sql
         -- 트랜잭션을 걸어서 복구 대비
        UPDATE 테이블이름
            SET 속성이름1=값, [속성이름2=값 ....]
            WHERE <검색조건> -- 실무에서 빼지 않는게 좋음
        ```

    - DELETE

    ```sql
    -- 트랜잭션을 걸어서 보국 대비
    DELETE FROM 테이블이름
    WHERE <검색조건> -- 실무에서는 빼면 큰일남
    ```

- SQL 고급
    - 내장함수
        - 수학 함수, 문자열 함수, 날짜/시간 함수, 변환 함수, 커서 함수(!), 보안 함ㅅ, 시스템 함수 등
        - NULL(!)
    - 서브쿼리 리뷰
        - SELECT - 단일행, 단일열 (스칼라 서브쿼리)
        - FROM - 다수행, 다수열
        - WHERE - 다수행, 단일열(보통)
            - 비교연산, 집합연산, 한정연산, 존재연산 가능

## 5일차
- SQL 고급
    - 서브쿼리 리뷰
    - 뷰 - 자주 사용되는 복잡한 쿼리로 생성되는 결과를 자주 사용하기 위해서 만드는 개체
        - 편리하고, 보안에 강하며, 논리적 독립성을 띰
        - 원본데이터가 변경되면 같이 변경되고, 인덱스 생성은 어렵, CUD 연산에 제약이 있음

        ``` sql
        -- 생성
        CREATE VIEW 뷰이름 [(열이름 [, ...])]
        AS <SELECT 쿼리문>

        -- 수정
        ALTER VIEW 뷰이름 [(열이름 [, ...])]
        AS <SELECT 쿼리문>

        -- 삭제
        DROP VIEW 뷰이름
        ```
    
    - 인덱스
    ```sql
    --생성
    CREATE [UNIQUE] [CLUSTERED|NONCLUSTERED] INDEX 인덱스이름
    ON 테이블명 (속성이름 [ASC|DESC] [,...n])

    --수정
    ALTER INDEX {인덱스이름|ALL}
    ON 테이블명 { REBUILD | DISABLE | REORGANIZE}

    --삭제
    DROP INDEX 인덱스이름 ON 테이블명;
    ```
    - SQL 서버의 인데스는 B-tree구조
    a. 클러스터 인덱스
    - 테이블 생성시 기본키(PK)를 생성하면 자동 생성
    b. 비클러스터 인덱스
    - SSMS에서 실행 계획을 가지고 쿼리 실행 성능을 체크할 수 있음
        - SSMS - 마당테이블 - dbo.Book 오른쪽 클릭/ dbo.Mybook 각각 -모든행 선택 - 상단쿼리 - 예상실행계획표시 
- 파이썬 SQL Server 연동 프로그래밍
    - Madang DB 관리 프로그램
        - PyQT GUI 생성 (파일명 MadangBook.ui)
            - QT designer 진입 - Main window 선택 - 생성
            - group box(책정보)/ table widget/ label(책번호, 책제목, 출판사, 정가)/ line Edit/ pushbutton(신규등록, 저장, 삭제, 조회)
        - SQL Server 데이터 핸들링
            - pymssql 라이브러리 설치
            
            '''sql
            pip install pymssql
            ```
            - DB연결 설정
                a. 윈도우 앱 - SQL server 2022 - 구성관리자 접속
                b. sql서버 네트워크 구성-> MSSQL에 대한 프로토콜
                c. TCP/IP 사용으로 변경(TCP/IP 더블클릭 - TCP/IP 속성창)
                d. TCP/IP속성창 - IP주소탭에서 IP2(본인아이피인것)랑 IP4(127.1.0.1으로 된 주소) 사용을 예로 변경
                e. 적용 후 오른쪽 탭 SQL Server 서비스 > SQL Server(MSSQLServer) 더블클릭 - 다시시작 버튼 클릭, 재시작 필요 
![image](https://github.com/yongseok2312/basic-database-2024/assets/135982451/db3d5fa3-93f5-449f-9fd5-7c4c99e9bf21)

## 6일차
- 파이썬 SQL Server 연동 프로그램
    - Madang DB 관리 프로그램
        - PyQt5 + pymssql

    - 문제점 - 한글 깨짐 문제
        1. DB 테이블의 varchar(ASCII) -> nvarchar(UTF-8) 변경
        2. Python에서 pymssql로 접속할 때, charset을 'UTF8'로 설정
        3. INSERT 쿼리에 한글 입력되는 컬럼은 N''을 붙여줌(유니코드로 입력하라는 뜻)

    - 실행화면


https://github.com/yongseok2312/basic-database-2024/assets/135982451/04590bcf-f45e-4382-a403-e430f8b7ee41


## 7일차
- SQL 고급
    - 트랜잭션 - All or Nothing
    - 트랜잭션 속성 - A(Atomicity), C(constitancy), I(Isolation),D(Durability)
         1) 원자성(Atomicity) : 트랜잭션 포함 작업은 전부 수행되거나 전부 수행되지 않아야한다. 
            * 트랜잭션 제어 명령어(TCL)
                - BEGIN : 트랜잭션의 시작
                - COMMIT : 트랙잭션의 종료
                - ROLLBACK : 트랜잭션을 전체 혹은 savepoint까지 무효화시킴 
                - SAVE : savepoint를 만듦 
        2) 일관성(Consistency) : 트랜잭션 수행 전이나 수행 후나 데이터베이스는 일관된 상태를 유지해야한다. 
        3) 고립성(Isolation, 독립성) : 트랜잭션 수행중에 다른 트랜잭션이 끼어들어 변경 중인 값을 훼손해서는 안된다. 
            - 동시성 제어(Concurrency Control) : 같은 데이터를 읽고 쓸 경우, 변경중인 데이터를 다른 트랜잭션이 사용할때 일관성 훼손 시키지 않기 위한(충돌방지) 제어하는(Lock) 작업 
         4) 지속성(Durability) : 수행을 성공적으로 완료한 트랜잭션은 변경 데이터를 영구히 저장해야한다. 
        
        - SQL Sercer는 기본적으로 Auto Commit(시스템이 자동으로 트랜잭션을 건다)
        - SSMS > 도구 > 옵션 > 쿼리 실행 > SQL Server > ANSI
            -> SET IMPLICIT_TRANSACTIONS 체크, 프로그램 재시작

        - 트랜잭션 - 로직 처리시 다른 트랜잭션의 간섭을 받지 않기 위한 것(LOCK), 중요한 데이터 수정, 삭제시 잘못된 변경을 방지하기 위한 것
    
- 데이터베이스 모델링
    - 설계(모델링) 순서 - 개념 설계 -> 논리 설계 -> 물리 설계
    - 개념 모델링 - 요구사항을 받으면서 정해지지않은 여러 개체들을 정립화 하는 단계
    - 논리 모델링 - 기본키 지정, 외래키 지정, 관계 정립, 속성들 이름(한글) 개체를 정하는 단계
    - 물리 모델링 - DB에 맞춰서 컬럼이름, 컬럼데이터 타입 및 크기 지정, DB에 대한 검토로 테이블을 만들기 직전의 설계를 완성

    - ER 모델링 - ERD를 그리기위한 기본 이론

- 인덱스 예제
    - PK나 인덱스가 없는 상태에서 성능문제 체크
    - 인덱스가 설정되면 성능이 어떤지 비교
    - 더미 생성시 100만건으로 제약을 두고 시작
    <img src = "https://raw.githubusercontent.com/yongseok2312/basic-database-2024/main/images/index.png" width = "800">

## 8일차
- 인덱스 예제
- 정규화
    - DB 상에서 생기는 이상현상(삽임, 삭제, 수정)이 생기지 않는 릴레이션(테이블) 분리해서 데이터베이스 설계
    - 이상현상이 생기는 테이블을 분리해서 해결
    - 기본키와 함수종속성을 파악
    - 1정규형 - 도메인이 원자값을 가짐
    - 2정규형 - 기본키가 아닌 속성이 기본키에 완전 종속일 때(학생번호[PK],강좌이름 --> 성적을 결정)
    - 3정규형 - 기본키가 아닌 속성이 기본키에 비이행적으로 종속할때(학생번호 --> 강좌이름 --> 수강료 [이행종속성])
    - BCNF - 함수 종속성 x -> y 가 성립할 때 모든 결정지 x가 후보키(기본키가 될 수 있는 속성)이면
    - 보통 BCNF까지 정규화 함
    - 4정규형(다치 종속성), 5정규형(조인 종속성, 무손실 분해)

- 실무실습(사용자, 권한...)
    1. DB관리자
        - DB관리자로 hr데이터베이스 생성, 관게를 설정
        - DB관리자로 hr DB를 사용할 사용자 계정을 생성, 필요한 권한 설정
            - 추가 - sa의 비번을 잃어버리면, Windows 인증으로 로그인 후
            - SSMS > 보안 > 로그인 > sa 존재> 속성에서 비밀번호 변경 이후 SQL Server 인증으로 sa 비밀번호 입력후 로그인 
            - SSMS > 보안 > 로그인 > 새로그인 클릭
            - 사용자계정 : hr_user, 비밀번호 :hr_p@ss!
            - 일반 : 기본 데이터베이스 - hr
            - 사용자 매핑 : hr 선택, 데이터베이스 역할 멤버 : db_owner 선택
    2. HR사용자 로그인(VS code)
        - SELECT
        - WHERE, ORDER BY
        - FUNCTION
        - AGGREAGATE FUNC
        - JOIN
        - SET ...

## 9일차
- 실무실습
    - 쿼리실습
        - 기본 SELECT, WHERE, ORDER BY
        - 집계함수 GROUP BY, ROLLUP
        - JOIN, SUBQUERY, UNION ...
        - CASE WHEN THEN END...
        - 내장함수...

![HR_ERD](https://raw.githubusercontent.com/yongseok2312/basic-database-2024/main/images/db007.png)

- 공부를 더할 부분
    - 트랜잭션
    - DB 보안 백업과 복원
    - 모델링 + 정규화
    - 데이터 모델링 실습
