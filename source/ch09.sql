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


-- 2. FROM 절에서의 서브쿼리
-- N x M => 반환하는 행과 컬럼의 개수에 제한이 없음
-- 단, 서브쿼리에 별칭 지정 필수

-- 1회 주문 시 평균 상품 개수?
-- 주문별(order_id)로 그룹화 -> count 집계: SUM() -> 재집계: AVG()

-- 메인쿼리
SELECT AVG(total_count) "1회 주문 시 평균 상품 개수" FROM (
	-- 서브쿼리
	SELECT O.id, SUM(count) "total_count" FROM orders O -- 집계 함수 결과에도 별칭 필수 (컬럼명이 아니라 계산된 값을 반환하기 때문)
	INNER JOIN order_details OD ON O.id = OD.order_id
	GROUP BY order_id
) AS CFO; -- 별칭 필수

-- 3. JOIN 절에서의 서브쿼리
-- N x M => 반환하는 행과 컬럼의 개수에 제한이 없음
-- 단, 서브쿼리에 별칭 지정 필수

-- 상품별 주문 개수를 배송 완료, 장바구니에 상관없이 상품명, 주문개수로 조회
-- 메인쿼리: 상품별 주문 개수 집계
SELECT P.name "상품명", JOD.total_count "주문 개수" FROM products P
INNER JOIN (
	SELECT OD.product_id, SUM(OD.count) "total_count" FROM order_details OD
	GROUP BY OD.product_id
) AS JOD ON P.id = JOD.product_id;

-- (참고) 다른 방법: 일단 붙여놓고 그룹화 및 집계
SELECT P.name, SUM(OD.count) FROM order_details OD
INNER JOIN products P ON OD.product_id = P.id
GROUP BY P.name;

-- 4. WHERE 절에서의 서브쿼리
-- Nx1 반환하는 서브쿼리만 사용 가능
-- (필터링 조건으로 값 또는 값 목록을 사용하기 때문)

-- 평균 가격보다 비싼 상품 조회
SELECT * FROM products
WHERE price > (
	SELECT AVG(price) FROM products
);

-- 4. HAVING 절에서의 서브쿼리
-- Nx1 반환하는 서브쿼리만 사용 가능
-- (필터링 조건으로 값 또는 값 목록을 사용하기 때문)

-- 크림 치즈보다 매출이 높은 상품은?
SELECT P.name "상품명", SUM(P.price * OD.count) "매출" FROM products P
INNER JOIN order_details OD ON P.id = OD.product_id
GROUP BY P.name
HAVING SUM(P.price * OD.count) > (
	SELECT SUM(P.price * OD.count) FROM products P
	INNER JOIN order_details OD ON P.id = OD.product_id
  WHERE P.name = '크림 치즈'
);

-- Quiz
-- 2. 다음 설명이 맞으면 O, 틀리면 X를 표시하세요.
-- ① SELECT 절의 서브쿼리는 단일 값만 반환해야 한다. (  )
-- ② FROM 절과 J0IN 절의 서브쿼리는 별칭을 지정해야 한다. (  )
-- ③ WHERE 절과 HAVING 절의 서브쿼리는 단일 값 또는 다중 행의 단일 칼럼을 반환할 수 있다. (  )

-- 정답: O O O


/*
9.3 IN, ANY, ALL, EXISTS
*/
-- 주로 WHERE절에서의 서브쿼리와 함께 쓰임

-- 1. IN
-- 괄호 사이 목록에 포함되는 대상을 찾음
-- 형식: column IN (쉼표로 구분된 값 목록);
-- 또는 column IN (subquery); <= Nx1 반환값만 가능

-- IN 사용 예시: 값 목록 입력의 경우
-- 상품명이 '우유 식빵', '크림 치즈'인 대상의 id 목록은?
SELECT id FROM products
WHERE name IN ('우유 식빵', '크림 치즈');

-- IN 사용 예시: 서브쿼리 입력의 경우
-- '우유 식빵', '크림 치즈'를 포함하는 모든 주문의 상세 내역
SELECT * FROM order_details
WHERE product_id IN (
	SELECT id FROM products
	WHERE name IN ('우유 식빵', '크림 치즈')
);

-- IN 사용 예시: 조인과 IN 연산자
-- '우유 식빵', '크림 치즈'를 주문한 사용자의 아이디와 닉네임은?
SELECT DISTINCT U.id, U.nickname FROM users U
INNER JOIN orders O ON U.id = O.user_id
INNER JOIN order_details OD ON O.id = OD.order_id
INNER JOIN products P ON OD.product_id = P.id
WHERE OD.product_id IN (
	SELECT id FROM products
	WHERE name IN ('우유 식빵', '크림 치즈')
);

-- ANY
-- 지정된 집합의 모든 요소와 비교해 하나라도 만족하는 대상을 찾음
-- 형식: column {>|=|<} ANY (subquery); <= Nx1 반환 쿼리

-- '우유 식빵'이나 '플레인 베이글'보다 저렴한 상품 목록은?
-- 메인쿼리
SELECT * FROM products
WHERE price < ANY (
	-- 서브쿼리: 우유 식빵과 플레인 베이글의 가격
  SELECT price FROM products
  WHERE name IN ('우유 식빵', '플레인 베이글') -- 2900, 1300 => 2900보다 작거나 1300보다 작은 모든 상품 조회 => 2900보다 작으면 다 나옴
);

-- 3. ALL
-- 지정된 집합의 모든 요소와 비교 연산을 수행하여 모두를 만족하는 대상을 찾음
-- 형식: column {>|=|<} ALL (subquery); <= Nx1 반환 쿼리

-- '우유 식빵'과 '플레인 베이글'보다 비싼 상품 목록은?
-- 메인쿼리
SELECT name AS 이름, price AS 가격
FROM products
WHERE price > ALL (
	-- 서브쿼리: 우유 식빵과 플레인 베이글의 가격 조회
    SELECT price
    FROM products
    WHERE name IN ('우유 식빵', '플레인 베이글') -- 2900, 1300
); -- 결과적으로 2900원 보다 큰 모든 상품 조회

-- 4. EXISTS
-- 입력받은 서브쿼리가 하나 이상의 행을 반환하면 TRUE / 아니면 FALSE
-- 형식: SELECT column1, column2 ... FROM table_name WHERE EXISTS (subquery);

-- 적어도 1번 이상 주문한 사용자 조회
-- 메인쿼리
SELECT * FROM users
WHERE EXISTS (
	-- 서브쿼리: 주문자 아이디가 사용자 테이블에 있다면 1 반환
	SELECT 1 FROM orders -- 굳이 모든 컬럼을 다 가져오는 것보다 1만 써주는 게 효율적
  WHERE orders.user_id = users.id -- 이렇게 서브쿼리가 메인쿼리의 특정 값을 참조하는 쿼리를 '상관 쿼리'라고 함
);

-- (참고) 상관 쿼리의 동작 원리
-- users 테이블 1번 사용자의 주문이 있는지 orders 테이블을 반복하며 확인
-- 같은 방식으로 2, 3번 사용자도 확인
-- EXISTS는 결과가 하나라도 존재하면 TRUE가 되기 때문에 매칭되는 레코드를 찾으면 더 안 찾아봄

-- (참고) 상관 쿼리의 특징
-- 1) 의존성: 서브쿼리는 메인쿼리의 값을 참조해 데이터 필터링을 수행
-- 2) 반복 실행: 서브쿼리는 메인쿼리의 각 행에 대해 반복적으로 실행됨
-- 3) 성능 저하: 메인쿼리의 각 행마다 서브쿼리를 실행하므로 쿼리 전체의 성능이 저하될 수 있음(특히 데이터 양이 많을 경우)

-- NOT EXISTS
-- 'COCOA PAY'로 결제하지 않은 사용자 조회


SELECT * FROM users U
WHERE NOT EXISTS (
	SELECT 1 FROM payments P
	INNER JOIN orders O ON P.order_id = O.id
	WHERE P.payment_type = 'COCOA PAY' AND O.user_id = U.id
);
-- 의미: 주문과 결제 테이블에서 COCOA PAY를 사용한 사용자가 있다면 그 놈을 제외한 사용자를 뽑아줘

-- Quiz
-- 3. 다음 빈칸에 들어갈 용어를 고르세요.
-- ① __________: 지정된 집합에 포함되는 대상을 찾음
-- ② __________: 별칭을 지정하는 키워드로, 생략하고 사용할 수 있음
-- ③ __________: 지정된 집합의 모든 요소와 비교 연산을 수행해 하나라도 만족하는 대상을 찾음
-- ④ __________: 지정된 집합의 모든 요소와 비교 연산을 수행해 모두를 만족하는 대상을 찾음
-- ⑤ __________: 서브쿼리를 입력받아 서브쿼리가 하나 이상의 행을 반환할 경우 TRUE, 그렇지 않으면 FALSE 반환

-- (ㄱ) AS
-- (ㄴ) ANY
-- (ㄷ) IN
-- (ㄹ) ALL
-- (ㅁ) EXISTS

-- 정답: ㄷㄱㄴㄹㅁ