-- 1. 연산자 확인 문제

-- 다음 문제를 풀며 연산자를 제대로 이해했는지 확인해 봅시다.

-- 문제 1
-- 다음 쿼리의 결과로 조회되는 데이터는 무엇입니까?

SELECT name, price
FROM products
WHERE price > 100000 AND price <= 500000;

-- ① 가격이 100,000원 초과 500,000원 이하인 제품
-- ② 가격이 100,000원 이상 500,000원 미만인 제품
-- ③ 가격이 100,000원 이하 500,000원 초과인 제품
-- ④ 가격이 100,000원 미만 500,000원 이하인 제품

-- 정답: 1


-- 문제 2
-- 다음 쿼리의 결과로 조회되는 데이터는 무엇입니까?

SELECT id, name
FROM products
WHERE stock != 0;

-- ① 재고(stock)가 0인 제품만 조회된다.
-- ② 재고(stock)가 0이 아닌 제품만 조회된다.
-- ③ 모든 제품이 조회된다.
-- ④ 재고(stock)가 NULL인 제품만 조회된다.

-- 정답: 2


-- 문제 3
-- 다음 쿼리를 실행했을 때 조회되는 데이터는 무엇입니까?

SELECT name, price, stock
FROM products
WHERE price < 20000 OR price > 50000 AND stock <= 20;

-- ① 가격이 50,000원을 초과하고 재고가 20개 이하인 제품
-- ② 가격이 20,000원을 초과하거나, 재고가 20개 이하인 제품
-- ③ 가격이 50,000원을 초과하고 재고가 20개 이하이거나, 가격이 20,000원 미만인 제품
-- ④ 가격이 50,000원을 초과하고 재고가 20개 초과인 제품

-- 정답: 3


-- 문제 4
-- 다음 쿼리의 결과를 올바르게 해석한 것은 무엇입니까?

SELECT name, category
FROM products
WHERE (category = '전자기기' OR category = '가구') AND price >= 50000;

-- ① 카테고리가 '전자기기' 또는 '가구'인 모든 제품
-- ② 카테고리가 '전자기기' 또는 '가구'이고, 가격이 50,000원 이상인 제품
-- ③ 가격이 50,000원 이상인 제품 중 카테고리가 '전자기기' 또는 '가구'가 아닌 제품
-- ④ 카테고리가 '전자기기' 또는 '가구'이거나, 가격이 50,000원 이상인 제품

-- 정답: 2


-- 문제 5
-- 다음 쿼리에서 WHERE 조건을 만족하는 데이터는 무엇입니까?

SELECT name, price, stock
FROM products
WHERE (price * 0.9 > 30000 OR stock <= 20) AND NOT (price < 10000);

-- ① 할인 후 가격(price * 0.9)이 30,000원 초과하거나 재고가 20개 이하이면서, 가격이 10,000원 미만인 제품
-- ② 할인 후 가격(price * 0.9)이 30,000원 초과하거나 재고가 20개 이하이면서, 가격이 10,000원 이상인 제품
-- ③ 할인 후 가격(price * 0.9)이 30,000원 이하이고, 재고가 20개 초과이며, 가격이 10,000원 미만인 제품
-- ④ 할인 후 가격(price * 0.9)이 30,000원 이하이고, 재고가 20개 초과하며, 가격이 10,000원 이상인 제품

-- 정답: 2


-- 2. 데이터 필터링 연습 문제

-- 다음 products 테이블 생성과 데이터 삽입 쿼리를 보고 문제에 답하세요.

-- products 테이블  생성
CREATE TABLE products (
	id INTEGER,           -- ID
	name VARCHAR(50),     -- 제품명
	category VARCHAR(30), -- 카테고리
	price INTEGER,        -- 가격
	stock INTEGER,        -- 재고
	PRIMARY KEY (id)
);

-- products 데이터  삽입
INSERT INTO products (id, name, category, price, stock)
VALUES
	(1, '노트북', '전자기기', 1200000, 10),
	(2, '스마트폰', '전자기기', 800000, 15),
	(3, '청소기', '생활용품', 150000, 8),
	(4, '텀블러', '생활용품', 12000, 50),
	(5, '초코바', '식품', 1500, 100),
	(6, '커피', '식품', 4500, 200),
	(7, '에어컨', '전자기기', 1200000, 5),
	(8, '책상', '가구', 50000, 20),
	(9, '의자', '가구', 40000, 25),
	(10, '모니터', '전자기기', 300000, 12);

-- 문제 1
-- 가격이 300,000원 이상인 제품명과 가격을 조회하세요.

-- 정답:
SELECT name, price FROM products
WHERE price >= 300000;


-- 문제 2
-- 카테고리가 '전자기기'이고 재고가 10개 이상인 제품명과 재고를 조회하세요.

-- 정답:
SELECT name, stock FROM products
WHERE category = '전자기기' AND stock >= 10;


-- 문제 3
-- 가격에 10% 세금을 적용한 최종 가격을 계산해 제품명과 함께 조회하세요.

-- 정답:
SELECT name, (price * 1.1) AS "최종 가격" FROM products;


-- 문제 4
-- 카테고리가 '전자기기'가 아닌 제품을 찾아 제품명과 카테고리를 조회하세요.

-- 정답:
SELECT name, category FROM products
WHERE NOT category = '전자기기';


-- 문제 5
-- 재고가 10개 이하인 제품 중 가격을 20% 할인해 제품명과 가격을 조회하세요.

-- 정답:
SELECT name, (price * 0.8) AS 할인가 FROM products
WHERE stock <= 10;


-- 문제 6
-- 카테고리가 '생활용품'이고 가격이 100,000원 이상이거나, 재고가 50개 이상인 제품의 제품명, 카테고리, 재고를 조회하세요.

-- 정답: 
SELECT name, category, stock FROM products
WHERE (category = '생활용품' AND price >= 100000) OR stock >= 50;


-- 문제 7
-- 카테고리가 '전자기기'인 제품 중 재고가 10개 이하 남은 제품을 30% 할인된 가격으로 판매하려고 합니다.
-- 해당 제품의 제품명, 재고, 할인된 가격을 조회하세요.

-- 정답:
SELECT name, stock, (price * 0.7) AS "할인된 가격" FROM products
WHERE category = '전자기기' AND stock <= 10;


-- 문제 8
-- 각 제품의 재고를 모두 소진했을 때 매출을 구해 제품명과 총판매액을 출력하세요.

-- 정답:
SELECT name, (price * stock) AS 총판매액 FROM products;