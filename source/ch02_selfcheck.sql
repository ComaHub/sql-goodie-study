-- 셀프체크
-- 다음 데이터를 coffees(커피) 테이블에 담아 관리하려고 합니다.

-- coffees
-- id  | name      | price
-- ------------------------
-- 1     아메리카노     3800
-- 2     카페라떼      4000
-- 3     콜드브루      3500
-- 4     카페모카      4500
-- 5     카푸치노      5000

-- id: 각 커피의 아이디로 기본키이며 정수로 작성
-- name: 커피 이름을 나타내며 최대 20자의 문자로 작성
-- price: 커피 가격을 나타내며 정수로 작성

-- 각 칼럼에 대한 설명을 참고해 다음 1~7 을 수행하는 쿼리를 작성하세요.

-- 1 starbuuks DB를 생성하고 진입하세요.
CREATE DATABASE starbuuks;
USE starbuuks;

-- 2 coffees 테이블을 만드세요.
CREATE TABLE coffees (
	id INTEGER,
  name VARCHAR(20),
  price INTEGER,
  PRIMARY KEY(id)
  );

-- 3 coffees 테이블에 아메리카노부터 카푸치노까지 모든 데이터를 삽입하세요.
INSERT INTO coffees (id, name, price)
VALUE
	(1, "아메리카노", 3800),
  (2, "카페라떼", 4000),
  (3, "콜드브루", 3500),
  (4, "카페모카", 4500),
  (5, "카푸치노", 5000);
  
-- 4 coffees 테이블의 모든 커피 이름을 조회하세요.
SELECT name FROM coffees;

-- 5 카푸치노의 가격을 200원 인상하세요.(연산식 사용 가능)
UPDATE coffees SET price = price + 200
WHERE id = 5;

-- 6 콜드브루를 삭제하세요.
DELETE FROM coffees
WHERE id = 3;

-- 7 모든 커피 데이터를 조회하세요.
SELECT * FROM coffees;