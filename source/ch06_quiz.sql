-- 1. 관계 확인 문제

-- '관계의 개념'과 '관계 맺는 법'을 잘 이해했는지 문제를 풀며 확인해 봅시다.

-- 문제 1
-- 다음 중 일대다 관계에 해당하는 예는 무엇입니까?

-- ① 국가와 수도
-- ② 부모와 자식
-- ③ 학생과 수강 과목
-- ④ 책과 ISBN 번호

-- 정답: 2


-- 문제 2
-- AUTO_INCREMENT 제약 조건에 대한 설명으로 옳은 무엇입니까?

-- ① 특정 칼럼의 값이 항상 고유해야 함을 보장한다.
-- ② 특정 컬럼의 값이 NULL을 허용하지 않도록 제한한다.
-- ③ 새 행이 삽입될 때마다 값을 1씩 자동으로 증가한다.
-- ④ 칼럼 값이 음수를 허용하지 않도록 제한한다.

-- 정답: 3


-- 문제 3
-- 다음 중 CHECK 제약 조건이 설정된 칼럼에 대해 위배되는 입력값을 고르세요.

-- discount_rate INTEGER CHECK (discount_rate >= 0 AND discount_rate <= 50)

-- ① -5
-- ② 0
-- ③ 25
-- ④ 50

-- 정답: 1


-- 문제 4
-- 다음 중 UNIQUE 제약 조건을 사용하는 이유로 가장 적합한 것은 무엇입니까?

-- ① 특정 칼럼의 기본값을 설정하기 위해
-- ② 특정 칼럼에 NULL 값을 허용하지 않기 위해
-- ③ 특정 칼럼 값이 중복되지 않도록 보장하기 위해
-- ④ 칼럼 값이 자동으로 증가하도록 설정하기 위해

-- 정답: 3


-- 2. 관계 만들기 연습 문제

-- 도서관 데이터베이스는 members(회원), member_profiles(회원 프로필), books(도서), borrow_records(대출 기록), library_staff(도서관 직원)의 5개 테이블로 구성됩니다.
-- 주석을 보고 제약 조건 및 관계 설정에 대한 미완성 코드를 채운 뒤 문제에 답하세요.

-- 5개의 테이블은 다음과 같은 관계를 가짐
-- • 일대일 관계: members - member_profiles
-- • 다대다 관계: members - borrow_records - books

-- members 테이블
CREATE TABLE members (
	id INT AUTO_INCREMENT, -- ID(자동 증가)
	name VARCHAR(50) NOT NULL, -- 회원명(NULL 불가)
	email VARCHAR(100) UNIQUE, -- 이메일(고유 값)
	phone_number CHAR(15), -- 전화번호
	membership_status VARCHAR(20) DEFAULT 'active', -- 회원 상태(기본값: active)
	 -- 기본키 지정: id
	PRIMARY KEY (id)
);

-- member_profiles 테이블
CREATE TABLE member_profiles (
	id INTEGER AUTO_INCREMENT, -- ID(자동 증가)
	date_of_birth DATE, -- 생년월일
	address TEXT, -- 주소
	member_id INTEGER UNIQUE, -- 회원_ID(고유 값)
	-- 기본키 지정: id
	-- 외래키 지정: member_id
  PRIMARY KEY (id),
  FOREIGN KEY (member_id) REFERENCES members(id)
);

-- books 테이블
CREATE TABLE books (
	id INTEGER AUTO_INCREMENT, -- ID(자동 증가)
	title VARCHAR(100) NOT NULL, -- 도서명(NULL 불가)
	author VARCHAR(100), -- 저자
	category VARCHAR(50), -- 카테고리
	stock INTEGER UNSIGNED DEFAULT 0, -- 재고(음수 불가, 기본값: 0)
	 -- 기본키 지정: id
	PRIMARY KEY (id)
);

-- borrow_records 테이블
CREATE TABLE borrow_records (
	id INTEGER AUTO_INCREMENT, -- ID(자동 증가)
	borrow_date DATE NOT NULL, -- 대출 날짜(NULL 불가)
	return_date DATE, -- 반납 날짜
	member_id INTEGER NOT NULL, -- 회원_ID(NULL 불가)
	book_id INTEGER NOT NULL, -- 도서_ID(NULL 불가)
	 -- 기본키 지정: id
	 -- 외래키 지정: member_id
	 -- 외래키 지정: book_id
	PRIMARY KEY (id),
  FOREIGN KEY (member_id) REFERENCES members(id),
  FOREIGN KEY (book_id) REFERENCES books(id)
);

-- library_staff 테이블
CREATE TABLE library_staff (
	id INTEGER AUTO_INCREMENT, -- ID(자동 증가)
	name VARCHAR(50) NOT NULL, -- 직원명(NULL 불가)
	role VARCHAR(50) DEFAULT 'staff', -- 역할(기본값: staff)
	employment_date DATE NOT NULL, -- 고용 날짜(NULL 불가)
	salary INTEGER CHECK (salary >= 0), -- 급여(음수 불가, CHECK 제약 조건 사용)
	 -- 기본키 지정: id
	PRIMARY KEY (id)
);


-- 문제 1
-- members 테이블에서 email 칼럼에 적용된 제약 조건으로 올바른 것은 무엇입니까?

-- ① AUTO_INCREMENT
-- ② UNIQUE
-- ③ NOT NULL
-- ④ DEFAULT

-- 정답: 2


-- 문제 2
-- member_profiles 테이블에서 member_id 칼럼의 역할은 무엇입니까?

-- ① 모든 회원 프로필을 구분하기 위한 기본키
-- ② members 테이블의 기본키를 참조하는 외래키
-- ③ 회원의 생년월일을 저장하는 칼럼
-- ④ 회원의 이메일을 저장하는 칼럼

-- 정답: 2


-- 문제 3
-- books 테이블의 stock 칼럼에서 허용되지 않는 값은 무엇입니까?

-- ① 100
-- ② 0
-- ③ -10
-- ④ NULL

-- 정답: 3


-- 문제 4
-- borrow_records 테이블에서 book_id와 연결된 테이블은 무엇입니까?

-- ① books 테이블
-- ② members 테이블
-- ③ member_profiles 테이블
-- ④ library_staff 테이블

-- 정답: 1


-- 문제 5
-- library_staff 테이블의 salary 칼럼에 대해 CHECK 제약 조건으로 허용되지 않는 값은 무엇입니까?

-- ① 0
-- ② 100000
-- ③ -5000
-- ④ 5000

-- 정답: 3


-- 문제 6
-- 다음 중 AUTO_INCREMENT 제약 조건에 대한 설명으로 옳은 것은 무엇입니까?

-- ① NULL 값을 허용하지 않음
-- ② 행 삽입 시 값이 자동으로 1씩 증가
-- ③ 다른 테이블의 값을 참조
-- ④ 칼럼 값이 항상 고유하도록 설정

-- 정답: 2


-- 문제 7
-- borrow_records 테이블의 기본키는 무엇입니까?

-- ① member_id
-- ② book_id
-- ③ id
-- ④ borrow_date

-- 정답: 3


-- 문제 8
-- member_profiles 테이블의 member_id 칼럼에 UNIQUE 제약 조건을 적용한 이유는 무엇입니까?

-- ① 회원이 여러 개의 프로필을 가질 수 있도록 허용하기 위해
-- ② 회원 ID가 중복 입력되는 것을 허용하기 위해
-- ③ 회원 프로필과 도서 대출 기록을 연결하기 위해
-- ④ 회원 테이블과의 1:1 관계를 유지하기 위해

-- 정답: 4


-- 문제 9
-- library_staff 테이블의 role 칼럼의 기본값은 무엇입니까?

-- ① NULL
-- ② 관리자
-- ③ 직원
-- ④ staff

-- 정답: 4


-- 문제 10
-- borrow_records 테이블은 어떤 관계를 표현합니까?

-- ① 회원과 도서 간의 일대일 관계
-- ② 회원과 도서 간의 일대다 관계
-- ③ 회원과 도서 간의 다대다 관계
-- ④ 도서와 직원 간의 관계

-- 정답: 3

