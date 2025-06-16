-- 1. 조인 확인 문제

-- 문제 1
-- 다음 중 조인의 정의로 가장 적절한 것은 무엇입니까?

-- ① 2개 이상 테이블의 모든 데이터를 결합
-- ② 2개 이상 테이블에서 관련된 데이터를 결합
-- ③ 두 테이블 간 조건 없이 모든 행을 결합
-- ④ 하나의 테이블에서 중복된 데이터 제거

-- 정답: 2


-- 문제 2
-- FULL JOIN에 대한 설명으로 옳지 않은 것은 무엇입니까?

-- ① 두 테이블 간 모든 튜플을 결합한다.
-- ② 두 테이블을 결합할 때 빈 칼럼은 NULL 값으로 채운다.
-- ③ MySQL에서는 지원하지 않는다.
-- ④ UNION ALL 연산자를 사용했을 때와 결과가 같다.

-- 정답: 4


-- 문제 3
-- 다음 중 UNION 연산자를 사용할 때 주의할 점으로 바른 것은 무엇입니까?

-- ① 두 테이블의 모든 칼럼이 동일한 값을 가져야 한다.
-- ② 결과 집합에 중복 데이터를 포함시키지 않으려면 UNION ALL을 사용해야 한다.
-- ③ 두 테이블의 결과 집합에 포함된 칼럼 수와 각 칼럼의 자료형이 동일해야 한다.
-- ④ UNION 연산자는 테이블 간의 관계를 기반으로 데이터를 결합한다.

-- 정답: 3


-- 문제 4
-- 조인을 사용하는 이유로 가장 적절한 것은 무엇입니까?

-- ① 모든 데이터를 결합해 하나의 테이블로 만들기 위해
-- ② 한 테이블에 있는 데이터만 필터링하기 위해
-- ③ 데이터의 중복을 제거하기 위해
-- ④ 여러 테이블 간의 관련 데이터를 결합해 의미 있는 정보를 추출하기 위해

-- 정답: 4


-- 문제 5
-- INNER JOIN의 기본 문법으로 옳은 것은 무엇입니까?

-- ① SELECT *
--   FROM 테이블1, 테이블2;
-- ② SELECT *
--   FROM 테이블1
--   INNER JOIN 테이블2;
-- ③ SELECT *
--   FROM 테이블1
--   INNER JOIN 테이블2 ON 테이블1.칼럼 = 테이블2.칼럼;
-- ④ SELECT *
--   FROM 테이블1 
--   LEFT JOIN 테이블2;

-- 정답: 3


-- 2. 조인 연습 문제

-- 다음 도서관 데이터베이스를 보고 문제에 답하세요.

-- members 테이블
CREATE TABLE members (
	id INTEGER AUTO_INCREMENT, -- ID(자동 증가)
	name VARCHAR(50) NOT NULL, -- 회원명(NULL 불가)
	email VARCHAR(100) UNIQUE, -- 이메일(고유 값)
	phone_number CHAR(15), -- 전화번호
	membership_status VARCHAR(20) DEFAULT 'active', -- 회원 상태(기본값: active)
	PRIMARY KEY (id) -- 기본키 지정: id
);

-- member_profiles 테이블
CREATE TABLE member_profiles (
	id INTEGER AUTO_INCREMENT, -- ID(자동 증가)
	date_of_birth DATE, -- 생년월일
	address TEXT, -- 주소
	member_id INTEGER UNIQUE, -- 회원_ID(고유 값)
	PRIMARY KEY (id), -- 기본키 지정: id
	FOREIGN KEY (member_id) REFERENCES members(id) -- 외래키 지정: member_id
);

-- books 테이블
CREATE TABLE books (
	id INTEGER AUTO_INCREMENT, -- ID(자동 증가)
	title VARCHAR(100) NOT NULL, -- 도서명(NULL 불가)
	author VARCHAR(100), -- 저자
	category VARCHAR(50), -- 카테고리
	stock INTEGER UNSIGNED DEFAULT 0, -- 재고(음수 불가, 기본값: 0)
	PRIMARY KEY (id) -- 기본키 지정: id
);

-- borrow_records 테이블
CREATE TABLE borrow_records (
	id INTEGER AUTO_INCREMENT, -- ID(자동 증가)
	borrow_date DATE NOT NULL, -- 대출 날짜(NULL 불가)
	return_date DATE, -- 반납 날짜
	member_id INTEGER NOT NULL, -- 회원_ID(NULL 불가)
	book_id INTEGER NOT NULL, -- 도서_ID(NULL 불가)
	PRIMARY KEY (id), -- 기본키 지정: id
	FOREIGN KEY (member_id) REFERENCES members(id), -- 외래키 지정: member_id
	FOREIGN KEY (book_id) REFERENCES books(id) -- 외래키 지정: book_id
);

-- library_staff 테이블
CREATE TABLE library_staff (
	id INTEGER AUTO_INCREMENT, -- ID(자동 증가)
	name VARCHAR(50) NOT NULL, -- 직원명(NULL 불가)
	role VARCHAR(50) DEFAULT 'staff', -- 역할(기본값: staff)
	employment_date DATE NOT NULL, -- 고용 날짜(NULL 불가)
	salary INTEGER UNSIGNED CHECK (salary >= 0), -- 급여(음수 불가)
	PRIMARY KEY (id) -- 기본키 지정: id
);

-- 문제 1
-- 모든 회원의 이름, 생년월일, 주소를 조회하세요.(회원 프로필이 없는 회원은 제외)

-- 정답:
SELECT M.name, P.date_of_birth, P.address FROM members M
INNER JOIN member_profiles P ON M.id = P.member_id;



-- 문제 2
-- 모든 회원의 이름, 생년월일, 주소를 조회하세요.(회원 프로필이 없는 경우 NULL로 출력)

-- 정답:
SELECT M.name, P.date_of_birth, P.address FROM members M
LEFT OUTER JOIN member_profiles P ON M.id = P.member_id;


-- 문제 3
-- 대출 기록을 보고 도서를 빌려 간 회원명과 대출한 도서명을 조회하세요.

-- 정답:
SELECT M.name, B.title FROM members M
INNER JOIN borrow_records R ON M.id = member.id
INNER JOIN books B ON R.book_id = B.id;



-- 문제 4
-- 모든 도서명과 대출 날짜를 조회하세요.(대출되지 않은 도서는 NULL로 출력)

-- 정답:
SELECT B.title, R.borrow_date FROM books B
LEFT OUTER JOIN borrow_records R ON B.id = R.book_id;



-- 문제 5
-- 회원과 같은 이름을 가진 직원의 이름과 역할을 조회하세요.

-- 정답:
SELECT L.name, L.role FROM library_staff L
INNER JOIN member M ON L.name = M.name;

-- 관계 설정 없이도 JOIN을 할 수 있음 (일반적으로는 관계있는 테이블끼리 JOIN을 수행)


-- 문제 6
-- 모든 회원과 직원을 대상으로 도서관에서 주최하는 기념 행사에 초대장을 보내려고 합니다. 
-- 모든 회원과 도서관 직원의 이름을 하나의 목록으로 출력하세요.(중복된 이름은 제거)

-- 정답:
SELECT name FROM members
UNION
SELECT name FROM library_staff;

