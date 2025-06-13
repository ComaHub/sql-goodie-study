/*
7. 테이블 조인하기
7.1 조인이란?
*/

-- 두 테이블로 나뉜 여러 정보를 하나로 연결해 가져오는 명령
-- 테이블 간에 일치하는 속성을 기준으로 두 테이블을 하나로 합쳐서 보여줌

-- 조인 컬럼(기준이 되는 속성)
-- 두 테이블이 동시에 가지고 있는 컬럼으로 조인하기 위해 사용하는 속성
-- 보통 한 테이블의 FK와 다른 테이블의 PK를 사용

-- (참고) 외래키를 쓰지 않아도 조인은 가능
-- 그럼 외래키를 왜 쓰는걸까? => 데이터 무결성을 보장하기 위한 제약조건
-- 존재하지 않는 ID를 참조하지 못하게 막음
-- 부모 테이블 데이터 삭제 시 자식 처리 정의 가능
-- 실수로 잘못된 참조값을 넣는 것을 방지

-- 조인하기
-- 특정 사진에 달린 모든 댓글의 닉네임과 본문 조회
USE stargram;

-- 1번 사진 댓글 정보 조회
SELECT * FROM comments
WHERE photo_id = 1;

-- 테이블 조인 형식
-- SELECT column1, column2, ...
-- FROM tableA
-- JOIN tableB ON tableA.조인컬럼 = tableB.조인컬럼;
-- JOIN만 명시하면 기본적으로 INNER JOIN으로 해석

-- 댓글 본문과 사용자 닉네임을 합쳐서 가져오기
SELECT * FROM Comments
JOIN users ON comments.user_id = users.id;
-- JOIN users: 사용자 테이블을 붙일건데 
-- ON: 댓글 테이블의 외래키 = 사용자 테이블의 기본키와 같은 것끼리\

-- 1번 사진에 달린 모든 댓글 본문과 작성자 닉네임 가져오기
SELECT nickname, body From comments
JOIN users ON comments.user_id = users.id
WHERE photo_id = 1;

-- 조인의 특징 7가지
-- 1) 조인 컬럼이 필요
-- 두 테이블 연결을 위한 공통 컬럼
-- 보통 외래기, 기본키 기준 표현
SELECT * FROM Comments
JOIN users ON comments.user_id = users.id;

-- 2) 조인 컬럼은 서로 자료형이 일치
-- 숫자 1과 문자열 1은 서로 조인 안됨

-- 3) 조인 조건이 필요
-- ON과 함께 사용
-- 두 테이블을 어떻게 연결시킬 것인지 명시

-- 4) 연속 조인 가능
-- 예)
SELECT nickname, body, file_name FROM comments
JOIN users ON comments.user_id = users.id
JOIN photos ON comments.photo_id = photos.id;

-- 5) 중복 컬럼은 테이블명을 붙여 구분
-- 컬럼명이 같으면 어떤 테이블의 속성인지 명시해야 함 (안하면 에러)
-- 예)
SELECT comments.id, body, users.id, nickname FROM comments
JOIN users ON comments.user_id = users.id
WHERE photo_id = 2;

-- 6) 테이블명에 별칭 사용 가능
-- 간결한 쿼리 작성 및 가독성 향상에 도움
-- 예)
SELECT body, nickname FROM comments C
JOIN users U ON C.user_id = U.id;
-- 참고: 테이블에 별칭 붙일 때는 AS를 거의 생략함

-- 7) 다양한 조인 유형 사용 가능
-- 다양한 결과 테이블 생성에 도움
-- INNER JOIN
-- LEFT OUTER JOIN
-- RIGHT OUTER JOIN
-- FULL OUTER JOIN

-- Quiz
-- 1. 다음은 comments 테이블과 photos 테이블을 조인하는 쿼리이다.
-- 빈칸을 순서대로 채워 쿼리를 완성하시오. (예: aaa, bbb, ccc)

-- SELECT body, filename
-- FROM comments ① __________
-- ② __________ photos AS p ③ __________ c.photo_id = p.id;

-- 정답: AS c, JOIN, ON

-- 2. 다음 조인에 대한 설명으로 옳지 않은 것은?
-- ① 조인 칼럼은 자료형이 달라도 된다.
-- ② 조인 조건은 JOIN 절의 ON 키워드 다음에 작성한다.
-- ③ 중복 칼럼은 '테이블명.칼럼명'과 같이 테이블명을 붙여 구분한다.
-- ④ 조인 테이블에 별칭을 붙일 때는 AS 키워드를 사용한다.

-- 정답: 1


/*
7.2 조인의 유형
*/
-- 1. INNER 조인
-- 가장 기본이 되는 조인
-- 두 테이블에서 조인 조건을 만족하는(조인 컬럼이 같은) 데이터를 찾아 조인함
-- INNER 키워드 생략 가능

-- 형식:
-- SELECT 컬럼명1, 컬럼명2, ...
-- FROM 테이블A
-- INNER JOIN 테이블B ON 테이블A.조인_컬럼 = 테이블B.조인_컬럼;

-- photos 테이블과 users 테이블 INNER 조인
SELECT * FROM photos P
INNER JOIN users U ON P.user_id = U.id;


-- OUTER JOIN: 두 테이블 간의 조인 결과에 누락된 행을 포함시킬 수 있는 조인 방식, 종류는 크게 3가지
-- 2. LEFT 조인
-- 왼쪽 테이블(FROM 절 테이블)의 모든 데이터에 오른쪽 테이블(JOIN 절 테이블)을 조인함
-- 왼쪽 테이블은 모든 데이터를 가져오지만, 오른쪽 테이블은 조인 조건을 만족하는 것만 가져옴
-- 조인 조건을 만족하지 않는 경우, NULL 값으로 채움

-- 형식:
-- SELECT 컬럼명1, 컬럼명2, ...
-- FROM 테이블A
-- LEFT JOIN 테이블B ON 테이블A.조인_컬럼 = 테이블B.조인_컬럼;

-- photos 테이블과 users 테이블 LEFT 조인
SELECT * FROM photos P
LEFT OUTER JOIN users U ON P.user_id = U.id;


-- 3. RIGHT 조인
-- 오른쪽 테이블(JOIN 절 테이블)의 모든 데이터에 왼쪽 테이블(FROM 절 테이블)을 조인함
-- 오른쪽 테이블은 모든 데이터를 가져오지만, 왼쪽 테이블은 조인 조건을 만족하는 것만 가져옴
-- 조인 조건을 만족하지 않는 경우, NULL 값으로 채움
-- LEFT 조인에서 기준만 바뀌고 동일하기에 거의 사용되지 않음

-- 형식:
-- SELECT 컬럼명1, 컬럼명2, ...
-- FROM 테이블A
-- RIGHT JOIN 테이블B ON 테이블A.조인_컬럼 = 테이블B.조인_컬럼;

-- photos 테이블과 users 테이블 RIGHT 조인
SELECT * FROM photos P
RIGHT OUTER JOIN users U ON P.user_id = U.id;

-- 4. FULL 조인
-- 두 테이블의 모든 데이터를 결합하는 조인
-- 조인 불가능한 것은 NULL 값으로 채움
-- LEFT 조인 + RIGHT 조인의 결과에 중복을 제거한 것
-- (두 테이블에 조인 컬럼 값이 같은 데이터뿐만 아니라, 한쪽 테이블에 존재하는 데이터도 모두를 반환)

-- MySQL은 FULL 조인을 제공하지 않음
-- 형식:
-- SELECT 컬럼명1, 컬럼명2, ...
-- FROM 테이블A
-- FULL JOIN 테이블B ON 테이블A.조인_컬럼 = 테이블B.조인_컬럼;

-- 5. UNION 연산자
-- 두 쿼리의 결과를 하나의 테이블로 합치는 집합 연산자
-- SELECT 결과를 단순히 위아래로 붙이는 연산
-- UNION을 사용하려면 두 쿼리의 결과 테이블 내 컬럼 개수와 각 컬럼의 자료형이 일치해야 함

-- 중복 튜플 제거하고 합치기
-- (쿼리A)
-- UNION
-- (쿼리B);

-- 중복 튜플 그대로 둔 채 합치기
-- (쿼리A)
-- UNION ALL
-- (쿼리B);

-- UNION 연산을 활용하면 FULL 조인 결과를 생성할 수 있음

-- UNION을 활용한 photos 테이블과 users 테이블 FULL OUTER 조인
SELECT * FROM photos P
LEFT OUTER JOIN users U ON P.user_id = U.id
UNION -- 두 쿼리의 결과 테이블을 하나로 합침 (중복은 제거됨)
SELECT * FROM photos P
RIGHT OUTER JOIN users U ON P.user_id = U.id;

-- Quiz
-- 3. 다음 빈칸에 들어갈 용어를 차례대로 쓰시오. (예: ㄱㄴㄷㄹㅁ)
-- ① __________: 가장 기본적인 조인 유형으로, 두 테이블에서 조인 조건을 만족하는 튜플을 찾아 조인
-- ② __________: 왼쪽 테이블의 모든 튜플에 대해 조인 조건을 만족하는 오른쪽 테이블의 튜플을 조인하고, 조인할 수 없는 경우 NULL 값으로 채움
-- ③ __________: 오른쪽 테이블의 모든 튜플에 대해 조인 조건을 만족하는 왼쪽 테이블의 튜플을 조인하고, 조인할 수 없는 경우 NULL 값으로 채움
-- ④ __________: 두 테이블 사이에서 조인이 가능한 튜플뿐만 아니라 조인 불가능한 튜플도 모두 가져오고 빈 칼럼은 NULL 값으로 채움
-- ⑤ __________: 두 쿼리의 결과 테이블을 하나로 합침

-- (ㄱ) FULL JOIN
-- (ㄴ) INNER JOIN
-- (ㄷ) UNION
-- (ㄹ) RIGHT JOIN
-- (ㅁ) LEFT JOIN

-- 정답: ㄴㅁㄹㄱㄷ


/*
7.3 조인 실습: 별그램 DB
*/
-- 가장 많이 사용되는 INNER 조인과 LEFT 조인을 연습!

-- 1. 특정 사용자가 올린 사진 목록 출력하기
-- 예: 홍팍이 업로드한 모든 사진의 파일명은?
SELECT U.nickname "게시자", P.file_name "파일명" FROM photos P
INNER JOIN users U ON P.user_id = U.id
WHERE U.nickname = '홍팍';

-- (참고) 필터링을 조인과 동시에 가능
SELECT U.nickname "게시자", P.file_name "파일명" FROM photos P
INNER JOIN users U ON P.user_id = U.id AND U.nickname = '홍팍';

-- 2. 특정 사용자가 올린 사진의 좋아요 개수
-- 예: 홍팍이 올린 모든 사진의 좋아요 개수는?
SELECT COUNT(*) "홍팍이 올린 모든 사진의 좋아요 개수" FROM users U
INNER JOIN photos P ON U.id = P.user_id
INNER JOIN likes L ON P.id = L.photo_id
WHERE U.nickname = '홍팍';


-- 3. 특정 사용자가 쓴 댓글 개수
-- 예: 해삼이가 작성한 모든 댓글의 개수는?
SELECT COUNT(*) "해삼이가 작성한 모든 댓글의 개수" FROM users U
INNER JOIN comments C ON U.id = C.user_id AND U.nickname = '해삼';


-- 4. 모든 댓글 본문과 해당 댓글의 달린 사진의 파일명
-- 예: 모든 댓글 본문과 함께 그 댓글이 달린 사진의 파일명을 함께 조회하려면?
SELECT C.body "댓글", P.file_name "파일명" FROM comments C
LEFT OUTER JOIN photos P ON C.photo_id = P.id;

-- Quiz
-- 4. 다음 설명이 맞으면 O, 틀리면 X를 순서대로 표시하시오. (예: O, X, O, X)
-- ① INNER 조인은 INNER 키워드를 생략할 수 있다. (  )
-- ② INNER 조인은 조인이 불가능한 튜플도 가져와 연결한다. (  )
-- ③ LEFT 조인은 왼쪽 테이블의 모든 데이터에 대해 오른쪽 테이블에 조인 조건을 만족하는 데이터를 가져와 연결하고 
--   오른쪽 테이블에 해당하는 데이터가 없으면 NULL 값으로 채운다. (  )
-- ④ 조인 조건에 AND 연산자를 사용하면 조인과 동시에 데이터 필터링을 할 수 있다. (  )

-- 정답: O X O O