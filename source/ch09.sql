/*
9. 서브쿼리 활용
9.1 서브쿼리란?
*/
-- 서브쿼리: 쿼리 안에 포함된 또 다른 쿼리
-- 안쪽 서브쿼리의 실행 결과를 받아 바깥쪽 메인 쿼리가 실행됨

-- 서브쿼리 예시: 다음 학생 중 성적이 평균보다 높은 학생은?
-- students
-- ----------------------
-- id  | name    | score
-- ----------------------
-- 1   | 엘리스    | 85
-- 2   | 밥       | 78
-- 3   | 찰리     | 92
-- 4   | 데이브    | 65
-- 5   | 이브     | 88

-- sub_query DB 생성 및 진입
CREATE DATABASE sub_query;
USE sub_query;

-- students 테이블 생성
CREATE TABLE students (
	id INTEGER AUTO_INCREMENT, 	-- 아이디(자동으로 1씩 증가)
	name VARCHAR(30), 			-- 이름
	score INTEGER, 				-- 성적
	PRIMARY KEY (id) 			-- 기본키 지정: id
);

-- students 데이터 삽입
INSERT INTO students (name, score)
VALUES
	('엘리스', 85),
	('밥', 78),
	('찰리', 92),
	('데이브', 65),
	('이브', 88);
  
-- 데이터 확인
SELECT * FROM students;

-- 평균 점수보다 더 높은 점수를 받은 학생 조회
-- 메인쿼리
SELECT * FROM students
WHERE score > (
	SELECT AVG(score) FROM students -- 서브쿼리: 평균점수 계산
);

-- 서브쿼리 특징
-- 1) 중첩 구조: 메인 쿼리 내부에 중첩해 작성
-- SELECT ... FROM ...
-- WHERE ... ( 서브쿼리 );

-- 2) 메인쿼리와는 독립적으로 실행됨
-- 서브쿼리 우선 실행 후 그 결과를 받아 메인 쿼리가 수행됨

-- 3) 다양한 위치에서 사용 가능
-- SELECT, FROM/JOIN, WHERE/HAVING 등

-- 4) 단일 값 또는 다중 값을 반환
-- 단일 값 서브쿼리: 특정 값을 반환
-- 다중 값 서브쿼리: 여러 레코드를 반환 - IN, ANY, ALL, EXIST 연산자와 함께 사용

-- 5) 복잡하고 정교한 데이터 분석에 유용
-- 필터링 조건 추출, 데이터 집계 결과 추출 => 이를 기준으로 메인 쿼리 수행

-- Quiz
-- 1. 다음 설명이 맞으면 O, 틀리면 X를 표시하세요.
-- ① 서브쿼리는 메인쿼리 내부에 중첩해 작성한다. (  )
-- ② 서브쿼리는 다양한 위치에서 사용할 수 있다. (  )
-- ③ 서브쿼리는 단일 값만 반환한다. (  )

-- 정답: O O X


/*
9.2 다양한 위치에서의 서브쿼리
*/

-- 8장의 market DB를 활용
USE market;

-- 1. SELECT 절에서의 서브쿼리
-- 단일값만 반환하는 서브쿼리만 사용 가능
-- 여러 행 또는 여러 컬럼을 반환하면 에러 발생

-- 모든 결제 정보에 대한 평균 결제 금액과의 차이는?
SELECT payment_type "결제 유형", amount "결제 금액", (amount - (
	SELECT AVG(amount) FROM payments
)) "평균 결제 금액과의 차이" FROM payments;

-- 잘못 사용된 예시
-- SELECT payment_type "결제 유형", amount "결제 금액", (amount - (
-- 	SELECT AVG(amount), '123' FROM payments
-- )) "평균 결제 금액과의 차이" FROM payments;