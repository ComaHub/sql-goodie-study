/*
6. 관계 만들기
6.1 관계란
*/

-- 무엇? 여러 테이블에 분산된 데이터가 어떻게 서로 연결돼 있는지를 나타내는 것
-- 테이블: 서로 관련 있는 데이터를 묶은 것
-- 관계: 쉽게 여러 테이블에 흩어져 있는 데이터 간 연결고리
-- 관계의 유형 3가지
-- - 일대일(1:1)
-- - 일대다(1:N)
-- - 다대다(N:M)

-- 1. 일대일 관계(1:1, one-to-one)
-- 하나의 데이터가 다른 한 데이터와만 연결된 관계
-- 예: 사용자-개인 설정, 나라-수도, 사람-주민등록증

-- 2. 일대다 관계(1:N, one-to-many)
-- 하나의 데이터가 여러 데이터와 연결된 관계
-- 포함 또는 소유의 관계
-- 예: 부모-자식, 사진-댓글, 회사-직원

-- 3. 다대다 관계(N:M, many-to-many)
-- 여러 데이터가 여러 데이터와 연결된 관계('연결 고리' 필요)
-- 예: 
-- 1) 학생-과목
-- 한 학생이 여러 과목 수강 가능
-- 한 과목은 여러 학생을 수용 가능
-- 2) 사용자-사진
-- 한 사용자가 여러 사진에 좋아요 가능
-- 한 사진은 여러 사용자로부터 좋아요 가능

-- 다대다(N:M)는 사실상 직접 표현할 수 없기 때문에, 두 개의 일대다 관계로 분해해서 처리
-- 학생(1)-(N)수강등록(M)-(1)과목
-- 사용자(1)-(N)좋아요(M)-(1)사진
-- 여기서 '수강등록', '좋아요'는 연결 고리(=중간 테이블)가 된다.


-- 테이블 간 관계는 어떻게 만들어질까?
-- 관계를 만드는 키가 존재
-- => 기본키와 외래키의 연결을 통해 만들어짐

-- 기본키(PK, Primary Key)
-- 테이블의 각 행을 고유하게 식별할 수 있는 컬럼
-- 레코드를 구분하는 컬럼 또는 컬럼의 조합을 말함
-- 예: 주민등록번호
-- 다음 4가지 특징을 만족해야 함
-- - 유일성: 유일한 값을 가져야 함(=UNIQUE 제약 조건)
-- - 비 널: NULL이 올 수 없고, 반드시 값을 가져야 함(=NOT NULL 제약 조건)
-- - 불변성: 한 번 정해진 값은 바뀔 수 없음
-- - 식별성: 레코드를 구분하는 명확한 기준 역할을 해야 함
-- 일반적으로 기본키는 id로 명명

-- (1)과 (2)는 내부적으로 같은 의미
-- 제약 효과는 같을 수 있지만 PK는 구조적, 의미적으로도 특별한 역할을 가지기 때문에 완전히 같은 건 아님
-- 예) PK는 테이블당 하나만 가능, FK 참조 시 PK가 우선 -> 되도록 PK를 쓰는 것이 명확하고 바람직함
CREATE TABLE example (
	-- (1) id INT,
  -- PRIMARY KEY (id)
  
  -- (2)
  id INT NOT NULL UNIQUE
);


-- 외래키(FK, Foreign Key)
-- 다른 테이블의 기본키를 가리키는 컬럼
-- 두 테이블을 연결하는 역할




-- 제약 조건이란?
-- 컬럼 생성 시 부여하는 특성
-- 저장할 수 있는 값에 제한이나 규칙을 설정
-- - AUTO_INCREMENT: 컬럼의 값을 1씩 자동 증가하여 저장(정수형에 붙일 수 있으며 기본키와 함께 사용됨)
-- - UNIQUE: 컬럼에 값이 고유하도록 강제(중복 값을 입력하면 에러), 지문에 비유
-- - NOT NULL: 컬럼에 반드시 값이 입력되어야 함(값을 입력하지 않으면 즉, NULL 값이 들어가면 에러)
-- - DEFAULT: 컬럼에 입력값이 없을 시, 기본값을 부여
-- - CHECK: 컬럼에 특정 조건을 부여, 반드시 만족하도록 강제(조건을 만족하지 않는 값 입력 시 에러), 예: 반드시 짝수
-- - UNSIGNED: 숫자형 컬럼에 음수 허용을 금지(양수값만 저장하도록 제한)

-- 제약 조건 사용법
CREATE TABLE users (
	id INT AUTO_INCREMENT, -- 자동으로 1씩 증가하면서 들어감
  email VARCHAR(100) UNIQUE, -- 고유한 값만 들어갈 수 있음
  name VARCHAR(50) NOT NULL, -- Null 입력 금지
  status VARCHAR(10) DEFAULT 'active', -- 기본값을 'active'로
  balance INT UNSIGNED, -- 음수 금지
  age INT CHECK (age >= 18),
  PRIMARY KEY (id)
);


-- Quiz: 제약 조건 걸기
CREATE TABLE products (
  id INTEGER AUTO_INCREMENT,           -- 상품 ID(자동 증가)
  name VARCHAR(100) UNIQUE,    -- 상품명(고유한 값만 허용)
  category VARCHAR(50) NOT NULL, -- 상품 카테고리(NULL 불가)
  status VARCHAR(20) DEFAULT 'available',   -- 상품 상태(기본값: available)
  dc_rate INTEGER CHECK (dc_rate BETWEEN 0 AND 50),      -- 할인율(0~50% 제한)
  stock INTEGER UNSIGNED,        -- 재고 수량(음수 불가)
  PRIMARY KEY (id)                      -- 기본키 설정: id
);


-- Quiz
-- 1. 다음 빈칸에 들어갈 용어를 순서대로 고르세요. (예: ㄱㄴㄷㄹㅁ)
-- ① __________: 여러 테이블에 분산 저장된 데이터가 서로 어떻게 연결돼 있는지를 정의한 개념
-- ② __________: 테이블 내 모든 튜플을 유일하게 구분하는 칼럼 또는 칼럼의 조합
-- ③ __________: 한 번 설정된 값은 변경될 수 없다는 성질
-- ④ __________: 데이터가 존재하지 않는 상태
-- ⑤ __________: 다른 테이블의 기본키를 가리키는 칼럼으로 두 테이블 간 관계를 만드는 칼럼

-- (ㄱ) 불변성
-- (ㄴ) 관계
-- (ㄷ) 외래키(FK)
-- (ㄹ) NULL
-- (ㅁ) 기본키(PK)

-- 정답: ㄴㅁㄱㄹㄷ


/*
6.2 다양한 관계 만들기
*/
-- 외래키와 기본키를 연결해 일대일/일대다/다대다 관계 만들기

-- 1. 일대일 관계 만들기
-- A 테이블의 한 데이터가 B 테이블의 한 데이터와만 연결된 관계
-- 서로 긴밀한 연관성이 있거나, 하나의 테이블에서 분화된 경우
-- 외래키의 위치는 사용 빈도가 더 적은 쪽에 두는 것이 일반적

-- relation DB 생성 및 진입
CREATE DATABASE relation;
USE relation;

-- countries 테이블 생성
CREATE TABLE countries (
	id INT,
  name VARCHAR(255),
  
  PRIMARY KEY (id)
);

-- capitals 테이블 생성
CREATE TABLE capitals (
	id INT,
  name VARCHAR(255),
  country_id INT UNIQUE, 
  -- 타입을 국가 테이블과 동일하게 맞춤 + 고유한 값만 허용 (수도가 2개 이상이면 안됨) 
  -- => UNIQUE 지정 (일대일 관계를 만들기 위한 중요 조건)
  
  PRIMARY KEY (id),
  FOREIGN KEY (country_id) REFERENCES countries(id) -- 외래키 지정
);

-- countries 데이터 삽입
INSERT INTO countries (id, name)
VALUES
	(1, 'South Korea'),
	(2, 'United States'),
	(3, 'Japan');

-- capitals 데이터 삽입
INSERT INTO capitals (id, name, country_id)
VALUES
	(101, 'Seoul', 1),
	(102, 'Washington D.C.', 2),
	(103, 'Tokyo', 3);

-- 확인
SELECT * FROM countries;
SELECT * FROM capitals;


-- 2. 일대다 관계 만들기
-- A 테이블의 한 데이터가 B 테이블의 여러 데이터와 연결된 관계
-- 하나의 데이터에 여러 데이터가 포함되거나 소유되는 경우
-- 일대다 관계에서는 다쪽에 외래키 지정

-- teams 테이블 생성
CREATE TABLE teams (
	id INT,
  name VARCHAR(255),
  
  PRIMARY KEY (id)
);

-- players 테이블 생성
CREATE TABLE players (
	id INT,
  name VARCHAR(255),
  team_id INT, -- 일대다 관계에서는 UNIQUE X
  
  PRIMARY KEY (id),
  FOREIGN KEY (team_id) REFERENCES teams(id) -- 선수와 소속팀을 연결
);

-- teams 데이터 등록
INSERT INTO teams (id, name)
VALUES
	(1, 'FC Awesome'),
	(2, 'Winners United');

-- players 데이터 등록
INSERT INTO players (id, name, team_id)
VALUES
	(1, 'John Doe', 1),
	(2, 'Jane Smith', 1),
	(3, 'Max Payne', 2),
	(4, 'Alex Johnson', 2),
	(5, 'Sara Connor', 2);

-- 확인
SELECT * FROM teams;
SELECT * FROM players;

-- 3. 다대다 관계 만들기
-- A와 B 테이블 서로가 다수의 데이터와 연결
-- 중간 테이블을 경유해 A와 B가 연결
-- 다대다 관계에서는 중간 테이블을 만들어 연결

-- doctors 테이블 생성
CREATE TABLE doctors (
	id INT,
  name VARCHAR(255),
  
  PRIMARY KEY (id)
);

-- patients 테이블 생성
CREATE TABLE patients (
	id INT,
  name VARCHAR(255),
  
  PRIMARY KEY (id)
);

-- appointments 테이블 생성
CREATE TABLE appointments (
	id INT,
  doctor_id INT,
  patient_id INT,
  date DATE,
  
  PRIMARY KEY (id),
  FOREIGN KEY (doctor_id) REFERENCES doctors(id),
  FOREIGN KEY (patient_id) REFERENCES patients(id)
);

-- doctors 데이터 삽입
INSERT INTO doctors (id, name)
VALUES
	(1, '김 닥터'),
	(2, '이 닥터'),
	(3, '최 닥터');

-- patients 데이터 삽입
INSERT INTO patients (id, name)
VALUES
	(1, '환자 A'),
	(2, '환자 B'),
	(3, '환자 C');

-- appointments 데이터 삽입
INSERT INTO appointments (id, doctor_id, patient_id, date)
VALUES
	(1, 1, 1, '2025-01-01'),
	(2, 1, 2, '2025-01-02'),
	(3, 2, 2, '2025-01-03'),
	(4, 2, 3, '2025-01-04'),
	(5, 3, 3, '2025-01-05'),
	(6, 3, 1, '2025-01-06');

-- 확인
SELECT * FROM doctors;
SELECT * FROM patients;
SELECT * FROM appointments;


-- Quiz: 관계 맺기
-- 1. 사람과 여권 (한 사람은 1개의 여권, 한 여권은 한 사람에게만)
-- 사람 테이블
CREATE TABLE persons (
	id INT,
  name VARCHAR(50),
  
  PRIMARY KEY (id)
);

-- 여권 테이블
CREATE TABLE passports (
	id INT,
  passport_number VARCHAR(20),
  owner_id INT UNIQUE,
  
  PRIMARY KEY (id),
  FOREIGN KEY (owner_id) REFERENCES persons(id)
);

-- 2. 회사와 직원 (한 회사는 여러 직원 고용, 한 직원은 하나의 회사에 소속)
-- 회사 테이블
CREATE TABLE companies (
  id INTEGER,       -- ID
  name VARCHAR(50), -- 회사명
  
  PRIMARY KEY (id)
);

-- 직원 테이블
CREATE TABLE employees (
  id INTEGER,             -- ID
  name VARCHAR(50),       -- 직원명
  company_id INTEGER,     -- 회사_ID
  
  PRIMARY KEY (id),
  FOREIGN KEY (company_id) REFERENCES companies(id)
);

-- 3. 학생과 과목(한 학생은 여러 과목을 수강하고, 한 과목은 여러 학생이 수강할 수 있음)
-- 학생 테이블
CREATE TABLE students (
  id INTEGER,          -- ID
  name VARCHAR(50),    -- 학생명
  
  PRIMARY KEY (id)
);

-- 과목 테이블
CREATE TABLE subjects (
  id INTEGER,        -- ID
  title VARCHAR(50), -- 과목명
  
  PRIMARY KEY (id)
);

-- 수강 테이블(중간 테이블)
CREATE TABLE enrollments (
  id INTEGER,          -- ID
  student_id INTEGER,  -- 학생_ID
  subject_id INTEGER,  -- 과목_ID

  PRIMARY KEY (id),
  FOREIGN KEY (student_id) REFERENCES students(id),
  FOREIGN KEY (subject_id) REFERENCES subjects(id)
);

-- Quiz
-- 2. 다음 세 테이블에 대한 설명으로 맞으면 O, 틀리면 X를 표시하시오.

-- doctors
-- id | name
-- ------------
-- 1  | 김 닥터
-- 2  | 이 닥터
-- 3  | 최 닥터

-- patients
-- id | name
-- ------------
-- 1  | 환자 A
-- 2  | 환자 B
-- 3  | 환자 C

-- appointments
-- id | doctor_id  | patient_id  | date
-- -------------------------------------------
-- 1  | 1          | 1           | 2025-01-01
-- 2  | 1          | 2           | 2025-01-02
-- 3  | 2          | 2           | 2025-01-03
-- 4  | 2          | 3           | 2025-01-04
-- 5  | 3          | 3           | 2025-01-05
-- 6  | 3          | 1           | 2025-01-06

-- ① '김 닥터'는 '환자 A'를 진료했다. (  )
-- ② '이 닥터'는 3회의 진료 기록이 있다. (  )
-- ③ '환자 C'는 '최 닥터'에게 진료를 받았다. (  )

-- 정답: O X O

-- 3. 다음 설명이 맞으면 O, 틀리면 X를 표시하시오.
-- ① 두 테이블 간 일대일 관계는 어느 쪽에 외래키를 지정해도 무방하나 대게 테이블의 사용 빈도가 적은 쪽에 지정한다. 
-- 또한 외래키 칼럼을 선언할 때 UNIQUE 제약 조건을 설정한다. (  )
-- ② 두 테이블 간 일대다 관계는 '일' 쪽 테이블에 외래키를 지정한다. (  )
-- ③ 두 테이블 간 다대다 관계는 중간 테이블을 만들어 두 테이블의 기본키를 참조하도록 외래키를 지정한다. (  )

-- 정답: O X O

/*
6.3 관계 만들기 실습: 별그램 DB
*/
-- 사진 공유 SNS, 별그램 DB를 만들며 다양한 관계 생성 훈련!

-- 별그램 DB의 테이블 개요
-- • users(사용자): 사용자의 '아이디', '닉네임, '이메일'을 저장합니다.
-- • photos(사진): 사진의 '아이디', '파일명', '게시자 아이디'를 저장합니다.
-- • comments(댓글): 댓글의 '아이디', '본문', 작성자 아이디', '댓글이 달린 사진 아이디'를 저장합니다.
-- • settings(개인 설정): 사용자 개인 설정의 '아이디, '계정 공개 여부', '계정 추천 여부', '사용자 아이디'를 저장합니다.
-- • likes(좋아요): 좋아요의 '아이디', '좋아요를 누른 사용자 아이디', '좋아요를 받은 사진 아이디'를 저장합니다.

-- 5개의 테이블은 다음과 같은 관계를 가짐
-- • 일대일 관계: '사용자'는 개인별로 하나의 '개인 설정' 값만 가질 수 있습니다.
-- • 일대다 관계: '사용자'는 여러 장의 '사진'을 게시할 수 있습니다.
-- • 다대다 관계:
-- - '사용자'는 여러 '사진'에 댓글을 작성할 수 있고, '사진' 또한 여러 '사용자'로부터 댓글을 받을 수 있습니다.
-- - '사용자'는 여러 '사진'에 좋아요를 누를 수 있고, '사진' 또한 여러 '사용자'로부터 좋아요를 받을 수 있습니다.

-- stargram DB 생성 및 진입
CREATE DATABASE stargram;
USE stargram;

-- 1. 사용자 테이블 만들기
CREATE TABLE users (
	id INT AUTO_INCREMENT,
  nickname VARCHAR(30),
  email VARCHAR(255) UNIQUE,
  
  PRIMARY KEY (id)
);

-- 사용자 데이터 삽입
INSERT INTO users (nickname, email)
VALUE
	('홍팍', 'sehongpark@cloudstudying.kr'),
	('길벗', 'gilbut@cloudstudying.kr'),
	('해삼', 'haesamq@cloudstudying.kr');
  
-- 데이터 조회
SELECT * FROM users;

-- 2. 사진 테이블 만들기
CREATE TABLE photos (
	id INT AUTO_INCREMENT,
  file_name VARCHAR(255) NOT NULL,
  user_id INT,
  
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- photos 데이터 삽입
INSERT INTO photos (file_name, user_id)
VALUES
	-- 1번 사용자가 게시한 사진
	('길고양이.jpg', 1),
	('일몰.jpg', 1),
	('은하계.jpg', 1),
	-- 2번 사용자가 게시한 사진
	('백호.jpg', 2),
	('검은 고양이 네로.jpg', 2),
	-- 사용자가 등록되지 않은 사진
	('삭제된 이미지.jpg', NULL),
	('제한된 이미지.jpg', NULL);

-- 데이터 조회
SELECT * FROM photos;

-- 3. 댓글 테이블 만들기
CREATE TABLE comments (
	id INT AUTO_INCREMENT,
  body VARCHAR(1000),
  user_id INT,
  photo_id INT,
  
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (photo_id) REFERENCES photos(id)
);

-- comments 데이터 삽입
INSERT INTO comments (body, user_id, photo_id)
VALUES
	-- 1번 사진에 달린 댓글
	('미야옹~', 1, 1),
	('냐옹!', 2, 1),
	('냥냥~', 3, 1),
	-- 2번 사진에 달린 댓글
	('일몰이 멋지네요', 1, 2),
	('해가 바다로 스윽~', 2, 2),
	-- 3번 사진에 달린 댓글
	('안드로메다 성운인가?', 1, 3),
	('성운이 아니라 은하임', 3, 3),
	-- 대상 사진이 없는 댓글
	('와우~', 3, NULL),
	('오우야~', 3, NULL);

-- 데이터 조회
SELECT * FROM comments;

-- 4. 개인 설정 테이블 만들기
CREATE TABLE settings (
	id INT AUTO_INCREMENT,
  private BOOLEAN NOT NULL,
  account_suggestions BOOLEAN NOT NULL,
  user_id INT UNIQUE,
  
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES users(id)
);

-- settings 데이터 삽입
INSERT INTO settings (private, account_suggestions, user_id)
VALUES
	(FALSE, FALSE, 1), 	-- 1번 사용자(비공개 계정, 계정 추천 불가)
	(FALSE, TRUE, 2), 	-- 2번 사용자(비공개 계정, 계정 추천 허용)
	(TRUE, TRUE, 3); 	-- 3번 사용자(공개 계정, 계정 추천 허용)

-- 데이터 조회
SELECT * FROM settings;

-- 5. 좋아요 테이블 만들기
CREATE TABLE likes (
	id INT AUTO_INCREMENT,
  user_id INT,
  photo_id INT,
  
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (photo_id) REFERENCES photos(id)
);

-- likes 데이터 삽입
INSERT INTO likes (user_id, photo_id)
VALUES
	-- 1번 사진에 달린 좋아요: 1, 2번 사용자가 누름
	(1, 1),
	(2, 1),
	-- 2번 사진에 달린 좋아요: 1, 2, 3번 사용자가 누름
	(1, 2),
	(2, 2),
	(3, 2),
	-- 3번 사진에 달린 좋아요: 1, 3번 사용자가 누름
	(1, 3),
	(3, 3),
	-- 6번 사진에 달린 좋아요, 사용자 미등록(탈퇴?, 영정?)
	(NULL, 6),
	-- 7번 사진에 달린 좋아요: 사용자 미등록
	(NULL, 7);

-- 데이터 조회
SELECT * FROM likes;

-- Quiz
-- 4. 다음 빈칸에 들어갈 용어를 고르시오. (예: ㄱㄴㄷㄹㅁ)
-- ① __________: 칼럼 값이 1씩 증가하며 자동으로 입력되도록 하는 제약 조건
-- ② __________: 칼럼에 값이 반드시 입력되도록 강제하는 제약 조건
-- ③ __________: 두 테이블 간에 다대다 관계를 맺기 위해 필요한 테이블
-- ④ __________: 참 또는 거짓을 저장하기 위한 자료형
-- ⑤ __________: 칼럼의 값이 중복되지 않고 고유한 값만 가지게 하는 제약 조건

-- (ㄱ) BOOLEAN
-- (ㄴ) NOT NULL
-- (ㄷ) 중간 테이블
-- (ㄹ) UNIQUE
-- (ㅁ) AUTO_INCREMENT

-- 정답: ㅁㄴㄷㄱㄹ