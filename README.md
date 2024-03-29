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
