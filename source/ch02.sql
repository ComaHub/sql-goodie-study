-- 주석
-- 쿼리 설명을 위한 코드 (실행되지 않음)

-- 한 줄 주석 <- 많이 씀
# 한 줄 주석

/*
여러 줄 주석
*/

-- 쿼리(Query)란? => '문의', '질문하다'
-- 예) DB에 사용자가 원하는 특정 데이터를 보여달라고 요청하는 것
-- SQL을 이용해 하나의 명령문으로 작성
-- 하나의 쿼리는 하나의 ;로 구분

SELECT 'Hello World!'; -- 쿼리문의 예시

/*
권장 SQL 작성 방법
1. SQL 키워드는 대문자로!
2. 사용자 변수 및 테이블은 소문자로!
*/

/*
2. 데이터 생성, 조회, 수정, 삭제하기
2.1 데이터 CRUD
*/

-- CRUD란? DB가 제공하는 기본 동작
-- 생성(Create)
-- 조회(Read)
-- 수정(Update)
-- 삭제(Delete)

-- CRUD 실습
-- 맵도날드 DB 만들어보기

/*
2.2 DB 만들기
*/

-- DB 목록 조회
SHOW DATABASES;

-- MySQL 설치 시 기본 제공하는 시스템 DB
-- (MySQL 서버 운영 및 유지관리에 중요한 역할, 건드릴 일 없음)

-- DB 생성
-- CREATE DATABASE DB_Name;
CREATE DATABASE mapdonalds;

-- DB 진입(접속)
-- USE DB_Name;
USE mapdonalds;

-- 현재 사용 중인 DB 조회
SELECT database();

-- DB 삭제
-- DROP DATABASE DB_Name;
DROP DATABASE mapdonalds;

-- Quiz
-- 1. 다음 설명 중 옳지 않은 것은?
-- ① 데이터 CRUD란 데이터를 생성(Create), 조회(Read), 수정(Update), 삭제(Delete)하는 것을 말한다. 
-- ② 쿼리란 데이터베이스에 내릴 명령을 SQL 문으로 작성한 것이다.
-- ③ 쿼리는 하나의 ;(세미콜론)으로 구분한다.
-- ④ MySQL은 쿼리의 대소문자를 구분한다.
-- ⑤ 주석은 쿼리 실행에 영향을 미치지 않는다.

-- 정답: 4

/*
2.3 데이터 삽입 및 조회하기
*/

-- 실습: 맵도날드 DB에 버거 테이블을 만들고, 데이터를 삽입 및 조회

-- Quiz: 다시 mapdonalds DB 생성하고 진입하기
CREATE DATABASE mapdonalds;
USE mapdonalds;

-- 테이블 생성
/* 
CREATE TABLE table_name (
				 컬럼형1, 자료형1
         컬럼형2, 자료형2
         ...
         PRIMART KEY (cloumn_Name)
);
*/

CREATE TABLE burgers (
id INTEGER, -- 아이디 (정수)
name VARCHAR(50), -- 이름 (최대 50자) => VARCHAR(N): 문자를 최대 N자리까지 저장, 문법상 필수 (가변 길이 타입이라 최대 길이 제한을 알아야 함)
price INTEGER, -- 가격 (정수: 원)
gram INTEGER, -- 무게 (정수: g)
kcal INTEGER, -- 열량 (정수: kcal)
protein INTEGER, -- 단백질량 (정수: g)
PRIMARY KEY (id) -- 기본 키 지정: id
);

-- 기본 키: 레코드를 대표하는 컬럼(예: 주민번호 등)
-- 테이블에 저장된 모든 버거를 구분하기 위한 컬럼
-- 중복되지 않는 값을 가짐

-- 테이블 구조 조회
-- DESC 테이블명;
DESC burgers; -- 버거 테이블의 구조 설명
-- Field: 테이블의 컬럼
-- Type: 컬럼의 자료형(int는 INTEGER의 별칭)
-- Null: 컬럼에 빈 값을 넣어도 되는지. 즉, 입력값이 없어도 되는지 여부(기본키는 NO: 반드시 값이 들어가야 함)
-- Key: 대표성을 가진 컬럼(기본키, 외래키, 고유키 등의 특별한 대표성을 가지는지를 의미)
-- Default: 컬럼의 기본값(입력값이 없을 시 설정할 기본값)
-- Extra: 추가 설정(컬럼에 적용된 추가 속성)

-- 단일 데이터 삽입하기
-- INSERT INTO Table_Name (Column_Name1, Column_Name2, ...)
-- VALUES (inputValue1, inputValue2, ...);
-- 컬럼 순서에 맞게 값을 입력해야 함
INSERT INTO burgers (id, name, price, gram, kcal, protein)
VALUES (1, '빅맨', 5300, 223, 583, 27);

-- 컬럼 생략 가능 (테이블의 정의와 정확히 일치해야 가능) => 항상 컬럼을 명시하는 것을 권장

-- 데이터 조회하기
-- SELECT column1, column2, ... <- 모든 컬럼을 조회하려면 * 을 입력
-- FROM Table_Name
-- WHERE condition; <- 검색 조건 (생략하면 전체 조회)

-- burgers 테이블의 모든 컬럼 조회
SELECT * FROM burgers;

-- 다중 데이터 삽입
INSERT INTO burgers (id, name, price, gram, kcal, protein)
VALUES 
	(2, '베이컨 틈메이러 디럭스', 6200, 242, 545, 27),
	(3, '맨스파이시 상하이 버거', 5300, 235, 494, 20),
	(4, '슈비두밥 버거', 6200, 269, 563, 21),
	(5, '더블 쿼터파운드 치즈', 7700, 275, 770, 50);
  
-- burgers 테이블의 이름과 가격만 조회
SELECT name, price FROM burgers;

-- Quiz
-- 2. 다음 빈칸에 들어갈 용어를 순서대로 고르면? (입력 예: ㄱㄴㄷㄹㅁ)
-- ① __________: 테이블을 만드는 SQL 문
-- ② __________: 정수형 숫자(-1, 0. 1, )를 저장하기 위한 자료형
-- ③ __________: 문자를 저장하기 위한 자료형(최대 길이 지정 가능)
-- ④ __________: 테이블에 데이터를 삽입하는 SQL 문
-- ⑤ __________: 테이블의 데이터를 조회하는 SQL 문

-- (ㄱ) INSERT INTO 문
-- (ㄴ) CREATE TABLE 문
-- (ㄷ) INTEGER
-- (ㄹ) VARCHAR
-- (ㅁ) SELECT 문

-- 정답: ㄴㄷㄹㄱㅁ

/*
2.4 데이터 수정 및 삭제하기
*/

-- 데이터 수정하기: UPDATE
-- UPDATE Table_Name
-- SET column = inputValue <= 어떤 컬럼에 어떤 값을 입력할지 지정
-- WHERE condition; <= 수정 대상을 찾는 조건 입력 !!조건이 없으면 column의 모든 값이 inputValue가 되어버림!!

-- 모든 레코드 수정하기: 모든 버거의 가격을 1000원에 판매하는 이벤트가 열렸다고 가정
-- 수정하기 위한 쿼리문은?

-- 모든 버거의 가격을 1000으로 수정
UPDATE burgers SET price = 1000;
-- 에러 발생: MySQL Workbench의 기본 세팅으로 인한 에러 (Safe Update Mode)
-- 모든 값을 일괄적으로 변경하는 것을 제한함 (사고 방지) => 조건에 KEY 컬럼을 사용하지 않은 UPDATE/DELETE를 차단

-- 임시로 Safe Update Mode 해제 (권장하지 않음!)
SET SQL_SAFE_UPDATES = 0; -- 0: 해제, 1: 설정

-- 전체 버거 조회
SELECT * FROM burgers;

-- 안전모드 재설정
SET SQL_SAFE_UPDATES = 1;

-- 특정(단일) 레코드 수정하기
-- 추가 이벤트! '빅맨' 버거 단 500원! 을 위한 쿼리문은?

-- '빅맨' 버거만 가격을 500으로 수정
UPDATE burgers SET price = 500
WHERE name = '빅맨'; -- 특정 대상값 변경 시, 조건은 반드시 primary key를 사용
-- 안전 모드에서는 KEY(기본 키 또는 유니크 키) 컬럼이 아닌 다른 값을 사용하면 UPDATE/DELETE를 차단

-- 수정 대상 조건 개선: KEY를 통한 변경 쿼리
UPDATE burgers SET price = 500
WHERE id = 1;

-- 데이터 삭제하기: DELETE
-- DELETE FROM Table_Name WHERE condition; <= 삭제할 대상을 찾는 조건 입력

-- '슈비두밥 버거'가 단종되었다면 이를 위한 데이터 삭제 쿼리는?
DELETE FROM burgers WHERE name = '슈비두밥 버거'; -- 안전 모드로 인한 에러 발생

-- 슈비두밥 버거 삭제 -> id가 4인 버거 삭제
DELETE FROM burgers WHERE id = 4;

-- 테이블 삭제하기
-- 테이블 속 데이터 뿐만 아니라 테이블 자체를 삭제하려면?
-- DROP TABLE Table_Name;

-- burgers 테이블을 삭제하는 쿼리는?
DROP TABLE burgers;

-- burgers 테이블 구조 확인
DESC burgers;

-- 전체 데이터 조회
SELECT * FROM burgers;

-- Quiz
-- 3. 다음 설명에 대한 용어를 고르면? (입력 예: ㄱㄴㄷㄹㅁ)
-- ① 테이블의 데이터를 수정하는 SQL 문
-- ② 특정조건을 만족하는 튜플을 조회하는 SQL 문
-- ③ 테이블의 데이터를 튜플 단위로 삭제하는 SQL 문
-- ④ 테이블 자체를 삭제하는 SQL 문
-- ⑤ 데이터베이스 자체를 삭제하는 SQL 문

-- (ㄱ) DELETE 문
-- (ᄂ) DROP TABLE 문
-- (ᄃ) UPDATE 문
-- (ᄅ) SELECT 문
-- (ᄆ) DROP DATABASE 문

-- 정답: ㄷㄹㄱㄴㅁ