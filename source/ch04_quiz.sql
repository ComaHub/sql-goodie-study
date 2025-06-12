-- 1. 집계 함수 확인 문제

-- 다음 문제를 풀며 집계 함수를 제대로 이해했는지 확인해 봅시다.

-- 문제 1
-- 다음 쿼리의 결과로 올바르게 반환되는 값은 무엇입니까?

SELECT MAX(price) AS highest_price
FROM products
WHERE category = '전자기기';

-- ① 모든 제품의 가장 높은 가격
-- ② 전자기기 카테고리에서 가장 높은 가격
-- ③ 전자기기 카테고리에서 가장 낮은 가격
-- ④ 모든 제품의 가장 낮은 가격

-- 정답: 2


-- 문제 2
-- COUNT() 함수에 대한 설명 중 옳지 않은 것은?

-- ① COUNT(*)는 NULL 값을 포함한 전체 튜플의 수를 센다.
-- ② COUNT(category)는 NULL 값을 포함한 카테고리의 수를 센다.
-- ③ COUNT(DISTINCT category)는 중복을 제외한 카테고리의 수를 센다.
-- ④ 모든 카테고리 값이 다르다면, COUNT(DISTINCT category)로 조회하던 COUNT(category) 조회하던 결과는 같다.
--   (NULL 값은 없다고 가정한다)

-- 정답: 2


-- 문제 3
-- 다음 쿼리의 결과를 올바르게 해석한 것은 무엇입니까?

SELECT SUM(stock) AS total_stock
FROM products
WHERE NOT (price > 10000);

-- ① 가격이 10,000원을 초과하는 제품의 재고
-- ② 가격이 10,000원을 초과하는 제품의 재고 총합
-- ③ 가격이 10,000원 이하인 제품의 재고
-- ④ 가격이 10,000원 이하인 제품의 재고 총합

-- 정답: 4


-- 문제 4
-- 다음 쿼리의 실행 결과는 무엇입니까?

SELECT AVG(price) AS average_price
FROM products
WHERE category IN ('전자기기', '생활용품');

-- ① 전자기기와 생활용품 카테고리의 평균 가격
-- ② 모든 제품의 평균 가격
-- ③ 전자기기 또는 생활용품 카테고리의 최대 가격
-- ④ 전자기기 또는 생활용품 카테고리의 가격 합계

-- 정답: 1


-- 문제 5
-- 다음 쿼리의 결과는 무엇을 나타냅니까?

SELECT MIN(stock) AS minimum_stock
FROM products
WHERE price >= 20000 AND price <= 100000;

-- ① 모든 제품의 최소 재고
-- ② 가격이 20,000원 이상 100,000원 이하인 제품의 최소 재고
-- ③ 가격이 20,000원 이상인 제품의 최소 재고
-- ④ 가격이 100,000원 이하인 제품의 최소 재고

-- 정답: 2


-- 문제 6
-- 다음 쿼리의 결과로 반환되는 데이터는 무엇입니까?

SELECT COUNT(*) AS total_products FROM products
WHERE rating IN (4.0, 4.5);

-- ① 모든 제품의 개수
-- ② 평점(rating)이 4.0 또는 4.5인 제품의 개수
-- ③ 평점(rating)이 4.0부터 4.5인 제품의 개수
-- ④ 평점(rating)이 4.0과 4.5가 아닌 제품의 개수

-- 정답: 2


-- 문제 7
-- 다음 쿼리의 조건을 올바르게 해석하세요.

SELECT MAX(price) AS highest_price
FROM products
WHERE stock >= 10 AND category IN ('식품', '전자기기');

-- ① 모든 제품의 최대 가격
-- ② 식품 또는 전자기기의 최대 가격
-- ③ 재고가 10 이상인 식품과 전자기기의 최대 가격
-- ④ 재고가 10 미만인 식품과 전자기기의 최대 가격

-- 정답: 3


-- 2. 집계 함수 연습 문제

-- 다음 orders(주문) 테이블을 보고 문제에 답하세요.

-- orders 테이블 생성
CREATE TABLE orders (
	id INTEGER,                -- ID
	customer_name VARCHAR(50), -- 고객명
	product VARCHAR(50),       -- 제품명
	quantity INTEGER,          -- 주문 수량
	price DECIMAL(10, 2),      -- 단가
	order_date DATE,           -- 주문 날짜
	region VARCHAR(20),        -- 고객이 사는 지역
	PRIMARY KEY (id)
);

-- orders 데이터 삽입
INSERT INTO orders (id, customer_name, product, quantity, price, order_date, region)
VALUES
	(1, '김철수', '노트북', 2, 1500000, '2023-11-01', '서울'),
	(2, '박영희', '스마트폰', 1, 900000, '2023-11-02', '부산'),
	(3, '이민호', '청소기', 1, 250000, '2023-11-03', '서울'),
	(4, '최수진', '냉장고', 1, 1200000, '2023-11-04', '대구'),
	(5, '정하늘', '노트북', 1, 1500000, '2023-11-05', '부산'),
	(6, '홍길동', '스마트폰', 3, 900000, '2023-11-06', '서울'),
	(7, '오준수', '에어컨', 2, 800000, '2023-11-07', '대구'),
	(8, '서지우', '청소기', 1, 250000, '2023-11-08', '서울'),
	(9, '이은지', '냉장고', 2, 1200000, '2023-11-09', '부산'),
	(10, '안현준', '스마트폰', 1, 900000, '2023-11-10', '대구');

-- 문제 1
-- 모든 주문의 총 매출액을 계산하세요.

-- 정답:
SELECT SUM(quantity * price) AS "총 매출액" FROM orders;


-- 문제 2
-- 단가가 1,000,000원 이상인 제품의 주문 건수를 계산하세요.

-- 정답:
SELECT COUNT(*) AS "100만원 이상인 제품의 주문 건수" FROM orders
WHERE price >= 1000000;


-- 문제 3
-- 주문 수량이 2개 이상이면서 단가가 1,000,000원 이하인 제품의 총 매출액을 계산하세요.

-- 정답:
SELECT SUM(quantity * price) AS "총 매출액" FROM orders
WHERE quantity >= 2 AND price <= 1000000;


-- 문제 4
-- 고객이 사는 지역(region)의 개수를 출력하세요.

-- 정답:
SELECT COUNT(DISTINCT region) AS "고객 지역 개수" FROM orders;


-- 문제 5
-- 주문 날짜가 2023-11-01과 2023-11-05 사이에 해당하는 주문의 총 수량을 계산하세요.

-- 정답:
SELECT SUM(quantity) AS "주문의 총 수량" FROM orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-05';
-- DATE 타입이라 날짜로 변환되어 비교함
-- 문자열 비교여도 문제는 없음


-- 문제 6
-- 고객 이름이 '김철수'이거나 '대구'에 사는 고객이 주문한 제품명을 중복 없이 조회하세요.

-- 정답:
SELECT product FROM orders
WHERE customer_name = '김철수' OR region = '대구';


-- 문제 7
-- '스마트폰'이 총 몇 대 팔렸는지 조회하세요.

-- 정답:
SELECT SUM(quantity) FROM orders
WHERE product = '스마트폰';