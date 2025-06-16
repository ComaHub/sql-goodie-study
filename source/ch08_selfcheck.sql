-- 셀프체크
-- 8장에서 만든 market DB의 상품 중 가격이 낮은 하위 4개의 누적 매출을 다음과 같이 조회하고 싶습니다.
-- 이를 위한 쿼리를 작성하세요.
-- (ch08_09_market_db.png 참고)

-- ----------------------------------
-- 상품명        | 가격     | 누적 매출
-- ----------------------------------
-- 플레인 베이글  | 1300    | 6500
-- 우유 900ml    | 1970    | 9850
-- 크림 치즈      | 2180    | 8720
-- 우유 식빵      | 2900    | 8700

USE market;

SELECT P.name "상품명", P.price "가격", SUM(P.price * OD.count) "누적 매출" FROM products P
INNER JOIN order_details OD ON P.id = OD.product_id
INNER JOIN orders O ON OD.order_id = O.id
WHERE O.status = '배송 완료'
GROUP BY P.name, P.price
ORDER BY P.price
LIMIT 4;

