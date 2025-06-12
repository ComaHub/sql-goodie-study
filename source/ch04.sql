/*
4. 데이터 집계
4.1 집계함수(Aggregate Function)란?
*/

-- 통계적 계산을 간편하게 수행할 수 있도록 도와주는 기능
-- 종류: MAX(), MIN(), COUNT(), SUM(), AVG()

-- 데이터를 가져와 개발 코드에서 반복문을 돌면서 직접 계산하는 것이 아니라
-- 데이터를 가져올 때부터 계산된 값을 가져올 수 있음

-- MAX(): 특정 속성의 가장 큰 값(최대값) 반환
-- MIN(): 특정 속성의 가장 작은 값(최소값) 반환
-- COUNT(): 레코드의 개수 반환(ex. 학생 테이블의 총 학생 수)
-- SUM(): 합계 반환(ex. 장바구니 안 모든 아이템의 가격 총합)
-- AVG(): 평균 반환(ex. 학생들의 수학 점수 평균)

-- 실습 데이터 준비(맵도날드)
USE mapdonalds;
DESC burgers;

-- 가장 비싼 버거와 가장 싼 버거의 가격?
-- 최대값, 최소값 구하기
SELECT MAX(price), MIN(price) FROM burgers;

-- 참고
-- SELECT *, MAX(price), MIN(price) FROM burgers; <= 이렇게는 사용할 수 없음
-- 집계는 그룹 단위 연산이고, *는 행 단위 열람이기 때문
-- 집계 함수를 다른 일반 컬럼들과 함께 사용할 때는 GROUP BY를 사용해야 함

-- 무게가 240g을 초과하는 버거의 개수?
-- 레코드의 개수를 세는 방법: COUNT()
SELECT COUNT(*) FROM burgers
WHERE gram > 240;

-- 주의
-- COUNT() 함수는 입력에 따라 다른 결과가 나옴
-- COUNT(*): 전체 레코드 수 반환
-- COUNT(column): 해당 속성의 값이 Null이 아닌 레코드의 수

-- COUNT() 테스트
-- employees 테이블 생성
CREATE TABLE employees (
	id INTEGER,              -- 아이디(정수형 숫자)
	name VARCHAR(50),        -- 직원명(문자형: 최대 50자)
	department VARCHAR(200), -- 소속 부서(문자형: 최대 200자)
	PRIMARY KEY (id)         -- 기본키 지정: id
);

INSERT INTO employees (id, name, department)
VALUES
	(1, 'Alice', 'Sales'),
	(2, 'Bob', 'Marketing'),
	(3, 'Carol', NULL),
	(4, 'Dave', 'Marketing'),
	(5, 'Joseph', 'Sales');
  
-- 잘 들어갔는지 일단 확인
SELECT * FROM employees;

-- 모든 직원 수 세기
SELECT count(*) FROM employees;

-- 부서가 있는 직원 수 세기
SELECT count(department) FROM employees;

-- 모든 종류의 버거를 다 사면 얼마?
-- 합계 구하기(SUM)
SELECT SUM(price) From burgers;

-- 버거의 평균 가격은?
-- 평균 구하기
-- AVG()
SELECT AVG(price)
FROM burgers;

-- Quiz
-- 1. burgers 테이블에 다음 쿼리를 실행했을 때, 
-- 결과 테이블 1~3에 들어갈 값을 쉼표로 구분하여 적으시오. (예: 123, 45, 67890)

-- burgers
-- id | name              | price  | gram  | kcal  | protein
-- ---------------------------------------------------------
-- 1    빅맨                 5300     223     583      27
-- 2    베이컨 틈메이러 디럭스   6200     242     545      27
-- 3    맨스파이시 상해 버거     5300     235     494      20
-- 4    슈비두밥 버거          6200     269     563      21
-- 5    더블 쿼터파운드 치즈     7700     275     770      50

-- SELECT MAX(kcal), MIN(protein), SUM(price)
-- FROM burgers
-- WHERE price < 6000;

-- 결과 테이블
-- ---------------------------------------
-- MAX(kcal)  | MIN(protein)  | SUM(price)
-- ---------------------------------------
-- ①          | ②             | ③

-- 정답: 583, 20, 10600


/*
4.2 집계 함수 실습: 은행 DB
*/
-- 데이터 셋 만들기: 은행 계좌 거래 내역
-- bank DB 생성 및 진입
CREATE DATABASE bank;
USE bank;

-- transactions 테이블 생성
CREATE TABLE transactions (
	id INTEGER,
  amount DECIMAL(12, 2), -- 12자리수 중 정수는 10자리까지, 소수점 이하는 2자리까지 허용
  msg VARCHAR(15),
  created_at DATETIME,   -- 거래 일시
  PRIMARY KEY(id)
);

-- 새로운 자료형
-- 1) DECIMAL 타입
-- 소수점을 포함한 고정 길이 숫자를 위한 자료형
-- 주로 돈거래 할 때나, 정확한 수식 계산이 필요할 때 사용
-- 형식: 컬럼명 DECIMAL(P, S)
-- P(정밀도): 전체 자릿수(정수부 + 소수부 포함)
-- S(스케일): 소수점 이하 자릿수

-- 2) DATETIME 타입
-- 날짜와 시간을 나타내는 자료형
-- 형식: 컬럼명 DATETIME
-- 데이터 입력 시 포맷은 아래와 같음
-- 날짜: YYYY-MM-DD
-- 시간: hh:mm:ss
-- 날짜와 시간을 저장할 때, 저장 형식 자체는 직접 지정할 수 없음(변경 불가! 데이터는 항상 같은 형식으로 저장됨)
-- 대신 출력 시 DATE_FORMAT() 함수 등을 사용해 표시 형식을 바꿀 수 있음

-- transactions 데이터 삽입
INSERT INTO transactions (id, amount, msg, created_at)
VALUES
	(1, -24.20, 'Google', '2024-11-01 10:02:48'),
	(2, -36.30, 'Amazon', '2024-11-02 10:01:05'),
	(3, 557.13, 'Udemy', '2024-11-10 11:00:09'),
	(4, -684.04, 'Bank of America', '2024-11-15 17:30:16'),
	(5, 495.71, 'PayPal', '2024-11-26 10:30:20'),
	(6, 726.87, 'Google', '2024-11-26 10:31:04'),
	(7, 124.71, 'Amazon', '2024-11-26 10:32:02'),
	(8, -24.20, 'Google', '2024-12-01 10:00:21'),
	(9, -36.30, 'Amazon', '2024-12-02 10:03:43'),
	(10, 821.63, 'Udemy', '2024-12-10 11:01:19'),
	(11, -837.25, 'Bank of America', '2024-12-14 17:32:54'),
	(12, 695.96, 'PayPal', '2024-12-27 10:32:02'),
	(13, 947.20, 'Google', '2024-12-28 10:33:40'),
	(14, 231.97, 'Amazon', '2024-12-28 10:35:12'),
	(15, -24.20, 'Google', '2025-01-03 10:01:20'),
	(16, -36.30, 'Amazon', '2025-01-03 10:02:35'),
	(17, 1270.87, 'Udemy', '2025-01-10 11:03:55'),
	(18, -540.64, 'Bank of America', '2025-01-14 17:33:01'),
	(19, 732.33, 'PayPal', '2025-01-25 10:31:21'),
	(20, 1328.72, 'Google', '2025-01-26 10:32:45'),
	(21, 824.71, 'Amazon', '2025-01-27 10:33:01'),
	(22, 182.55, 'Coupang', '2025-01-27 10:33:25'),
	(23, -24.20, 'Google', '2025-02-03 10:02:23'),
	(24, -36.30, 'Amazon', '2025-02-03 10:02:34'),
	(25, -36.30, 'Notion', '2025-02-03 10:04:51'),
	(26, 1549.27, 'Udemy', '2025-02-14 11:00:01'),
	(27, -480.78, 'Bank of America', '2025-02-14 17:30:12');

-- 잘 들어갔나 확인
SELECT * FROM transactions;

-- 거래 금액 총합 구하기
SELECT SUM(amount) AS "거래 금액 총합" FROM transactions;

-- 구글과 거래한 금액의 총합 구하기
SELECT SUM(amount) AS "구글과의 거래 금액 총합" FROM transactions
WHERE msg = 'Google';

-- 거래 금액의 최대값과 최소값 구하기
SELECT MAX(amount) AS "거래 금액 최대값", MIN(amount) AS "거래 금액 최소값" FROM transactions;

-- 페이팔과 거래한 금액의 최대값과 최소값 구하기
SELECT MAX(amount) AS "페이팔과의 거래 금액 최대값", MIN(amount) AS "페이팔과의 거래 금액 최소값" FROM transactions
WHERE msg = 'Paypal';

-- 전체 거래 횟수 세기
SELECT COUNT(*) AS "전체 거래 횟수" FROM transactions;

-- 쿠팡 및 아마존과 거래한 총 횟수는?
SELECT COUNT(*) AS "쿠팡 및 아마존과의 거래 횟수" FROM transactions
WHERE msg = 'Coupang' OR msg = 'Amazon';

-- 위 쿼리를 IN 연산자를 활용해 작성하기
SELECT COUNT(*) AS "쿠팡 및 아마존과의 거래 횟수" FROM transactions
WHERE msg IN ('Coupang', 'Amazon');
-- IN의 의미: msg가 () 안에 포함되어 있다면
-- IN을 사용하면 훨씬 직관적이고 편리함

-- 입금 금액의 평균 구하기
SELECT AVG(amount) AS "입금된 금액 평균" FROM transactions
WHERE amount >= 0;

-- 구글과 아마존에서 입금받은 금액의 평균은?
SELECT AVG(amount) AS "구글과 아마존에서 입금된 금액 평균" FROM transactions
WHERE amount >= 0 AND (msg IN ('Google', 'Amazon'));

-- 거래처 목록 조회하기
-- 거래처를 담은 msg만 조회하면 중복된 결과가 나옴
SELECT msg FROM transactions;

-- 중복을 제거하고 조회하려면? DISTINCT 중복 제거 키워드를 적용
SELECT DISTINCT msg FROM transactions;

-- 거래처의 목록이 아니라 거래처의 수를 조회하려면?
SELECT COUNT(DISTINCT msg) FROM transactions;

-- Quiz
-- 2. 다음 빈칸에 들어갈 용어를 차례로 고르면? (예: ㄱㄴㄷㄹㅁ) 
-- ① __________: 소수점을 포함한 고정 길이의 숫자를 나타내는 자료형
-- ② __________: YYYY-MM-DD hh:mm: ss 형식으로 날짜와 시간을 나타내는 자료형
-- ③ __________: 평균을 계산하는 함수
-- ④ __________: 주어진 목록 값 중 하나에 해당하는지 확인해 주는 연산자
-- ⑤ __________: 중복을 제거하여 유일한 값만 남기는 키워드

-- (ㄱ) IN
-- (ᄂ) DATETIME
-- (ᄃ) DISTINCT
-- (ᄅ) AVG()
-- (ᄆ) DECIMAL

-- 정답: ㅁㄴㄹㄱㄷ