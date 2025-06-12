/*
3. 데이터 필터링
3.1 데이터 필터링이란?
*/

-- 무엇? 많은 데이터들 중에 원하는 데이터만 골라내는 작업
-- 주로 WHERE 절을 통해 특정 데이터를 추출

-- 예를 들어
-- (a) SELECT문: 데이터 조회
-- SELECT 컬럼명1, 컬럼명2, ...
-- FROM 테이블명
-- WHERE 조건;

-- (b) UPDATE문: 데이터 수정
-- UPDATE 테이블명
-- SET 컬럼명 = 입력값
-- WHERE 조건;

-- (c) DELETE문: 데이터 삭제
-- DELETE FORM 테이블명
-- WHERE 조건;

-- 실습 데이터 준비
-- 2장에서 만든 맵도날드 DB를 활용
-- DB 진입
USE mapdonalds;

-- burger 테이블 조회
SELECT * FROM burgers;

-- burgers 테이블 생성
CREATE TABLE burgers (
	id INTEGER, 		  -- 아이디(정수형 숫자)
	name VARCHAR(50), -- 이름(문자형: 최대 50자)
	price INTEGER, 		-- 가격(정수형 숫자)
	gram INTEGER, 		-- 그램(정수형 숫자)
	kcal INTEGER, 		-- 열량(정수형 숫자)
	protein INTEGER, 	-- 단백질량(정수형 숫자)
	PRIMARY KEY (id) 	-- 기본키 지정: id
);

-- burgers 데이터 삽입
INSERT INTO burgers (id, name, price, gram, kcal, protein)
VALUES
	(1, '빅맨', 5300, 223, 583, 27),
	(2, '베이컨 틈메이러 디럭스', 6200, 242, 545, 27),
	(3, '맨스파이시 상해 버거', 5300, 235, 494, 20),
	(4, '슈비두밥 버거', 6200, 269, 563, 21),
	(5, '더블 쿼터파운드 치즈', 7700, 275, 770, 50);
  
  
-- 1) 비교 연산자
-- 두 값을 비교하는 연산 기호
-- WHERE 절에 사용 / 특정 데이터로 필터링 가능
-- 종류: =, !=, >, >=, <, <=

-- 가격이 5500원 보다 싼 버거 찾기
SELECT * FROM burgers
WHERE price < 5500;

-- 가격이 5500원 보다 비싼 버거 찾기
SELECT * FROM burgers
WHERE price > 5500;

-- 단백질량이 25g보다 적은 버거 찾기
SELECT * FROM burgers
WHERE protein < 25;

-- 2) 논리 연산자
-- 조건을 조합하거나 반전해 새 조건을 만듦
-- 종류: AND, OR, NOT

-- A AND B: A, B를 동시에 만족하는 데이터 필터링 (교집합)
-- A OR B: A, B 중 하나라도 만족하는 데이터 필터링 (합집합)
-- NOT A: A를 만족하지 않는 데이터 필터링 (여집합)

-- TRUE/FALSE의 논리 연산
-- TRUE(참: 1) / FALSE(거짓: 0)
-- AND 연산: 둘 다 참이어야 참
SELECT TRUE AND TRUE; -- 1
SELECT TRUE AND FALSE; -- 0
SELECT FALSE AND TRUE; -- 0
SELECT FALSE AND FALSE; -- 0

-- OR 연산: 둘 중 하나라도 참이면 참
SELECT TRUE OR TRUE; -- 1
SELECT TRUE OR FALSE; -- 1
SELECT FALSE OR TRUE; -- 1
SELECT FALSE OR FALSE; -- 0 

-- 5500원 보다 싸고, 동시에 단백질량이 25g 보다 많은 버거
SELECT * FROM burgers
WHERE price < 5500 AND protein > 25;

-- 5500원 보다 싸거나, 단백질량이 25g 보다 많은 버거
SELECT * FROM burgers
WHERE price < 5500 OR protein > 25;

-- 단백질량이 25g 보다 많지 않은 버거
SELECT * FROM burgers
WHERE NOT protein > 25;
-- WHERE !(protein > 25); <= 이 방식은 MySQL에서만 작동함 / 가독성과 이식성을 위해 NOT을 명시하는 방법을 사용하자


-- 3) 산술 연산자
-- 사칙연산 등을 위한 수학적 기호
-- WHERE 절과 SELECT 절에서 사용 가능
SELECT 100 + 20;
SELECT 100 - 20;
SELECT 100 * 20;
SELECT 100 / 20;
SELECT 100 % 20;

-- 산술 연산자 활용 예
-- SELECT문에서의 활용 예시
SELECT *, ((price / gram) * 100) AS 'price / 100g' FROM burgers; -- 따옴표 또는 백틱으로 감싸기
-- 100g당 가격을 계산해 price / 100g 이라는 별칭으로 출력

-- WHERE문에서의 활용 예시
-- 가격에 10%를 더한 값이 6500원을 넘는 버거만 조회
SELECT * FROM burgers
WHERE (price * 1.1) > 6500;

-- 짝수 ID를 가진 버거만 조회
SELECT * FROM burgers
WHERE (id % 2) = 0;

-- UPDATE문에서의 활용 예시
UPDATE burgers SET price = price - 500
WHERE id = 5;

-- 4) 연산자의 우선순위
-- 어떤 연산자를 먼저 수행할 것인지?
-- 우선순위가 높은 것부터 낮은 순으로 수행

-- Quiz: 다음 쿼리의 수행 결과는?
SELECT 3 + 5 * 2; -- 13
SELECT (3 + 5) * 2; -- 16
SELECT TRUE OR TRUE AND FALSE; -- TRUE <= AND가 OR보다 우선
SELECT (TRUE OR TRUE) AND FALSE; -- FALSE

-- Quiz
-- 1. 다음 빈칸에 들어갈 용어는? (입력 예: ㄱㄴㄷㄹㅁ)
-- ① __________: 테이블 조회 시 필터링 조건을 작성하기 위해 사용하는 명령 
-- ② __________: 같지 않음을 비교하는 연산자
-- ③ __________: 두 조건을 동시에 만족하는 논리 연산자
-- ④ __________: 두 조건 중 하나라도 만족하는 논리 연산자
-- ⑤ __________: 특정 조건을 만족하지 않는 논리 연산자

-- (ㄱ) AND
-- (ᄂ) !=
-- (ᄃ) NOT
-- (ᄅ) WHERE
-- (ᄆ) OR

-- 정답: ㄹㄴㄱㅁㄷ


/*
3.2 데이터 필터링 실습: 대학 DB
*/

-- Quiz: 대학 DB 만들기
-- university DB 생성 및 진입
CREATE DATABASE university;
USE university;

-- students 테이블 생성
-- 아이디(정수형 숫자)
-- 닉네임(문자형: 최대 50자)
-- 수학 성적(정수형 숫자)
-- 영어 성적(정수형 숫자)
-- 프로그래밍 성적(정수형 숫자)
-- 기본키 지정: id
CREATE TABLE students (
	id INTEGER,
  nickname VARCHAR(50),
  math INTEGER,
  english INTEGER,
  programming INTEGER,
  PRIMARY KEY(id)
  );

-- students 데이터 삽입
INSERT INTO students (id, nickname, math, english, programming)
VALUE
	(1, 'Sparkles', 98, 96, 93),
	(2, 'Soldier', 82, 66, 98),
	(3, 'Lapooheart', 84, 70, 82),
	(4, 'Slick', 87, 99, 98),
	(5, 'Smile', 75, 73, 70),
	(6, 'Jellyboo', 84, 82, 70),
	(7, 'Bagel', 97, 91, 87),
	(8, 'Queen', 99, 100, 88);

-- 확인
SELECT * FROM students;

-- 필터링 연습
-- 1. 모든 과목 성적이 90점 이상인 학생은?
SELECT * FROM students
WHERE math >= 90 AND english >= 90 AND programming >= 90;

-- 2. 75점 미만이 하나라도 있는 학생은?
SELECT * FROM students
WHERE math < 75 OR english < 75 OR programming < 75;

-- 3. 모든 학생의 총점은?
SELECT *, (math + english + programming) AS 총점 FROM students;

-- 4. 모든 학생의 평균은?
SELECT *, ((math + english + programming) / 3) AS 평균 FROM students;

-- 5. 총점이 270 이상인 학생의 닉네임, 총점, 평균은?
SELECT nickname AS 닉네임, (math + english + programming) AS 총점, ((math + english + programming) / 3) AS 평균 FROM students
WHERE (math + english + programming) >= 270;

-- 별칭 부여하기: AS 키워드
-- SELECT column AS nickname FROM table_name;

-- 별칭 사용 시 공백 또는 특수문자 등이 필요한 경우 => 별칭을 따옴표로 묶어주기

-- Quiz
-- 2. 다음 쿼리에 대한 설명으로 옳지 않은 것을 모두 고르면?
SELECT id, nickname, (math + english + programming) / 3 AS '중간고사 평균' 
FROM students
WHERE math > 80 AND programming > 80 OR English > 90;

-- ① students 테이블에서 데이터를 조회하고 있다.
-- ② math가 80보다 높은 학생은 반드시 조회된다.
-- ③ english가 90보다 높은 학생은 조회될 수 있다.
-- ④ 이 쿼리를 실행하면 그 결과로 칼럼 3개가 조회된다.
-- ⑤ SELECT 절의 '(math + english + programming) / 3' 수식에 괄호를 삭제하고 조회해도 정상적으로 중간고사 평균이 계산된다.

-- 정답: 2, 5