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
            - 데이터루트 디렉토리는 변경
    - 개발툴 설치
        - SSMS(SQL Server Management Studio) DB에 접근, 여러개발 작업을 할 수 있는 툴

- 데이터베이스 개념
    - 데이터를 보관, 관리, 서비스하는 시스템
    - Data, Information, Knowledge 개념
    - DBMS > Database > Data(Model)

- DB언어 
    - SQL(Structured Query Language) : 구조화된 질의 언어 - 객체지향 X
        - DDL(DAta Definition Language) : 데이터베이스, 테이블, 인덱스 생성
        - DML(Data Manipulation Language) : 검색, 삽입, 수정, 삭제 등의 기능
        - DCL(Data Control Language) : 권한

- SQL 기본학습
    - SSMS 실행

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