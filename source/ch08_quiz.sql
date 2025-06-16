-- 1. 그룹화, 정렬, 조회 개수 제한 확인 문제

-- 문제 1
-- GROUP BY 절에 대한 설명으로 옳은 것은 무엇입니까?

-- ① 데이터를 특정 기준으로 묶어서 요약할 때 사용한다.
-- ② 데이터를 정렬하여 출력할 때 사용한다.
-- ③ 중복된 데이터를 제거할 때 사용한다.
-- ④ 데이터를 필터링하여 출력할 때 사용한다.

-- 정답: 1


-- 문제 2
-- 다음 쿼리의 결과로 얻을 수 있는 정보는 무엇입니까?

SELECT category, COUNT(*)
FROM products
GROUP BY category;

-- ① 모든 제품의 목록
-- ② 카테고리별 제품 수
-- ③ 카테고리별 제품의 평균 가격
-- ④ 제품별 판매 수량

-- 정답: 2


-- 문제 3
-- 다음 쿼리는 무엇을 수행합니까?

SELECT name, price
FROM products
ORDER BY price DESC;

-- ① 가격의 오름차순으로 정렬하여 제품명과 가격을 출력한다.
-- ② 가격의 내림차순으로 정렬하여 제품명과 가격을 출력한다.
-- ③ 제품명을 기준으로 가격을 출력한다.
-- ④ 제품명과 가격을 정렬 없이 출력한다.

-- 정답: 2


-- 문제 4
-- ORDER BY 절을 사용할 때 기본 정렬 순서는 무엇입니까?

-- 정답: ASC


-- 문제 5
-- 다음 쿼리는 어떤 결과를 반환합니까?

SELECT name
FROM employees
LIMIT 5;

-- ① 첫 5개의 이름을 반환한다.
-- ② 마지막 5개의 이름을 반환한다.
-- ③ 5개의 이름을 내림차순으로 정렬하여 반환한다.
-- ④ 모든 이름을 반환한다.

-- 정답: 1


-- 문제 6
-- 다음 쿼리는 무엇을 수행합니까?

SELECT *
FROM orders
ORDER BY order_date DESC
LIMIT 5 OFFSET 5;

-- ① 가장 오래된 주문 5개를 반환한다.
-- ② 가장 최근 주문 중 6번째부터 10번째까지를 반환한다.
-- ③ 최근 5개의 주문을 반환한다.
-- ④ 주문 데이터를 5개씩 나눈 첫 번째 페이지를 반환한다.

-- 정답: 2


-- 문제 7
-- HAVING 절을 사용하는 이유는 무엇입니까?

-- ① 데이터를 정렬하기 위해
-- ② 데이터를 결합하기 위해
-- ③ 특정 열의 값을 필터링하기 위해
-- ④ 그룹화된 데이터에 조건을 적용하기 위해

-- 정답: 4


-- 문제 8
-- 다음 쿼리에서 WHERE 절은 언제 실행됩니까?

SELECT department, AVG(salary)
FROM employees
WHERE salary > 3000
GROUP BY department;

-- ① 그룹화된 데이터에 적용된다.
-- ② 데이터가 그룹화되기 전에 적용된다.
-- ③ 데이터가 그룹화된 후 적용된다.
-- ④ 그룹화된 데이터는 필터링할 수 없다.

-- 정답: 2


-- 문제 9
-- 다음 쿼리는 무엇을 수행합니까?

SELECT name, sales
FROM sales_data
ORDER BY sales DESC
LIMIT 3;

-- ① 가장 높은 매출을 기록한 상위 3개의 데이터를 반환한다.
-- ② 가장 낮은 매출을 기록한 상위 3개의 데이터를 반환한다.
-- ③ 매출이 가장 높은 데이터만 반환한다.
-- ④ 매출 데이터를 내림차순으로 정렬하고 모든 데이터를 반환한다.

-- 정답: 1


-- 문제 10
-- ORDER BY 절과 GROUP BY 절의 주요 차이점은 무엇입니까?

-- ① ORDER BY 절은 데이터를 정렬하고, GROUP BY 절은 데이터를 그룹화한다.
-- ② ORDER BY 절은 데이터를 그룹화하고, GROUP BY 절은 데이터를 정렬한다.
-- ③ 둘 다 데이터를 정렬하지만 방식이 다르다.
-- ④ 둘 다 데이터를 그룹화하지만 방식이 다르다.

-- 정답: 1


-- 2. 그룹화 분석 연습 문제

-- 다음 도서관 데이터베이스를 보고 문제에 답하세요.

-- 회원 정보 테이블
CREATE TABLE members (
	id INTEGER AUTO_INCREMENT, -- id
	name VARCHAR(50) NOT NULL, -- 회원명
	join_date DATE NOT NULL, -- 가입 날짜
	PRIMARY KEY (id) -- 기본키 지정: id
);

-- 도서 정보 테이블
CREATE TABLE books (
	id INTEGER AUTO_INCREMENT, -- id
	title VARCHAR(100) NOT NULL, -- 도서명
	author VARCHAR(50), -- 저자
	category VARCHAR(50), -- 카테고리
	stock INTEGER DEFAULT 0, -- 재고
	PRIMARY KEY (id) -- 기본키 지정: id
);

-- 대출 기록 테이블
CREATE TABLE borrow_records (
	id INTEGER AUTO_INCREMENT, -- id
	borrow_date DATE NOT NULL, -- 대출 날짜
	return_date DATE, -- 반납 날짜
	member_id INTEGER NOT NULL, -- 회원 id
	book_id INTEGER NOT NULL, -- 도서 id
	PRIMARY KEY (id), -- 기본키 지정: id
	FOREIGN KEY (member_id) REFERENCES members(id), -- 외래키 지정: member_id
	FOREIGN KEY (book_id) REFERENCES books(id) -- 외래키 지정: book_id
);

-- 문제 1
-- 다음 쿼리의 결과로 얻을 수 있는 정보는 무엇입니까?

SELECT category, COUNT(*) AS total_books
FROM books
GROUP BY category;

-- ① 도서별 총 재고
-- ② 카테고리별 도서 수
-- ③ 도서별 대출 횟수
-- ④ 카테고리별 대출 횟수

-- 정답: 2


-- 문제 2
-- 다음 쿼리의 결과로 대출량이 많은 순서로 도서를 정렬하려면 어떤 절을 추가해야 합니까?

SELECT title, COUNT(borrow_records.id) AS borrow_count
FROM books
JOIN borrow_records ON books.id = borrow_records.book_id
GROUP BY title;

-- ① ORDER BY title;
-- ② ORDER BY borrow_date DESC;
-- ③ ORDER BY borrow_count DESC;
-- ④ ORDER BY COUNT(borrow_records.id) ASC;

-- 정답: 3


-- 문제 3
-- 다음 쿼리의 결과로 상위 5개 도서만 조회하려면 어떤 절을 추가해야 합니까?

SELECT title, COUNT(*) AS borrow_count
FROM books
JOIN borrow_records ON books.id = borrow_records.book_id
GROUP BY title
ORDER BY borrow_count DESC;

-- ① LIMIT 5;
-- ② OFFSET 5;
-- ③ GROUP BY category;
-- ④ HAVING borrow_count > 5;

-- 정답: 1


-- 문제 4
-- 다음 쿼리의 결과로 얻을 수 있는 정보는 무엇입니까?

SELECT name, COUNT(borrow_records.id) AS total_borrowed
FROM members
JOIN borrow_records ON members.id = borrow_records.member_id
GROUP BY name
ORDER BY total_borrowed DESC;

-- ① 도서별 총 대출량
-- ② 도서별 대출 회원 수
-- ③ 회원별 총 대출 금액
-- ④ 회원별 총 대출 도서 수

-- 정답: 4


-- 문제 5
-- 다음 쿼리는 무엇을 수행합니까?

SELECT category, SUM(stock) AS total_stock
FROM books
GROUP BY category
HAVING total_stock <= 10;

-- ① 총 재고가 10 이하인 도서를 조회한다.
-- ② 총 재고가 10 이하인 카테고리를 조회한다.
-- ③ 재고가 10 이하인 도서를 카테고리별로 그룹화한다.
-- ④ 재고가 부족한 카테고리별 총 재고를 조회한다.

-- 정답: 2

-- DBMS는 실제로 SELECT의 별칭을 HAVING에서 예외적으로 허용
-- 논리적 실행 순서와는 별개로 별칭을 인식


-- 문제 6
-- 다음 쿼리는 어떤 정보를 반환합니까?

SELECT YEAR(join_date) AS join_year, COUNT(*) AS new_members
FROM members
GROUP BY join_year
ORDER BY new_members DESC;

-- ① 연도별 회원 가입 수를 오름차순으로 정렬
-- ② 연도별 회원 가입 수를 내림차순으로 정렬
-- ③ 연도별 총 대출 수를 내림차순으로 정렬
-- ④ 연도별 총 대출 금액을 오름차순으로 정렬

-- 정답: 2

-- (정리) SELECT 별칭의 사용 가능 여부
-- WHERE: 절대 불가 (SELECT보다 먼저 실행되므로 별칭을 알 수 없음)
-- GROUP BY: 대부분의 DBMS에서 편의상 허용, 표준은 아님 (표준 SQL은 식 자체 그대로 사용을 권장)
-- HAVING: 예외적으로 허용(논리적 실행 순서와 별개)
-- ORDER BY: 정식으로 허용(SELECT 이후에 실행되므로 별칭을 알 수 있음)