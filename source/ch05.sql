/*
5. 다양한 자료형 활용하기
5.1 자료형이란?
*/

-- 데이터의 형태(Data Type)
-- 관리하고 싶은 데이터에 맞게 자료형을 지정해야 함
-- 잘못 지정할 경우 메모리 공간이 낭비되고 연산에 제약이 생길 수 있음

-- DB의 자료형은 크게 숫자형, 문자형, 날짜 및 시간형이 있음 (+ 논리형)

-- 선행학습
-- 컴퓨터의 저장 단위와 자료형의 크기
-- 단위            | 크기        | 저장 예
-- 비트(Bit)         1Bit         True 또는 false 저장(0 또는 1을 저장)
-- 바이트(Byte)       8bit         알파벳 한 개 저장
-- 킬로바이트(KB)      1,024Byte    몇 개의 문단 저장
-- 메가바이트(MB)      1,024KB      1분 길이의 MP3 파일 저장
-- 기가바이트(GB)      1,024MB      30분 가량의 HD 영화 저장
-- 테라바이트(TB)      1,024GB      약 200편의 FHD 영화 저장

-- 자료형의 종류
-- 1. 숫자형
-- 숫자를 저장하기 위한 데이터 타입
-- 크게 정수형, 실수형으로 나뉨

-- 1) 정수형
-- 소수점이 없는 수 저장: -2, -1, 0, 1, 2, ...
-- 세부 타입이 존재: 차지하는 메모리 크기에 따른 분류
-- 종류: TINYINT, SMALLINT, MEDIUMINT, INTEGER(또는 INT), BIGINT

-- UNSIGNED(언사인드) 제약 조건 부여 가능: 음수 값을 허용하지 않고 그만큼 양수의 저장량을 늘림
-- CREATE TABLE table_name ( column data_type UNSIGNED );
-- 유효성 보장: 나이는 0 ~ 255의 유효한 값만 저장
CREATE TABLE users ( age TINYINT UNSIGNED );
-- 안전성 보장: 재고는 음수가 될 수 없다
CREATE TABLE products (
	stock INTEGER UNSIGNED
);

-- 2) 실수형
-- 소수점을 포함하는 수 저장: 3.14, -9.81, ...
-- 부동 소수점(floating-point): 가수부와 지수부를 통해 소수점 위치를 변경(FLOAT, DOUBLE)
-- 고정 소수점(fixed-point): 자릿수가 고정된 실수를 저장(DECIMAL)

-- 부동 소수점 vs 고정 소수점
-- 부동: 넓은 범위 표현 가능, 숫자 계산에 오차 발생 (2진수 기반)
-- FLOAT, DOUBLE 타입은 0.1을 정확히 저장하지 않고 근사값으로 저장함 (2진수로 변환 시 순환소수가 됨)
-- FLOAT: 약 8자리 정확도
-- DOUBLE: 약 16자리 정확도

-- 고정: 특정 범위 안에서 정확한 연산 수행 (10진수 기반)
-- DECIMAL 타입은 0.1을 근사값이 아닌 정확한 수로 저장
-- 정확한 소수값이 필요하면 DECIMAL 사용

-- 실습: 숫자형 사용하기
-- 학생 기록(student_records) 테이블을 만들어 다음 데이터를 저장한다면?
-- (학년은 초등학교 1학년부터 고등학교 3학년까지를 숫자 1~12로 표현할 것)

-- 아이디 | 학년 | 평균 점수 | 수업료
-- ----------------------------------
-- 1     | 3   | 88.75   | 50000.00
-- 2     | 6   | 92.5    | 100000.00

-- data_type DB 생성 및 진입
CREATE DATABASE data_type;
USE data_type;
SELECT DATABASE(); -- 확인

CREATE TABLE student_records (
	id INTEGER,
  grade TINYINT UNSIGNED, -- 0 ~ 255
  average_score FLOAT, -- 부동 소수점 방식
  tuition_fee DECIMAL(10, 2), -- 고정 소수점 방식 (금전 계산은 정확해야 함)
  PRIMARY KEY (id)
);

-- 학생 기록 데이터 삽입
INSERT INTO student_records
VALUE
	(1, 3, 88.75, 50000.00),
	(2, 6, 92.5, 100000.00);
  
-- 데이터 조회
SELECT * FROM student_records;

-- 자료형 범위를 벗어난 값 입력 -> 에러 발생
INSERT INTO student_records
VALUE (3, -2, 66.5, 20.00);

INSERT INTO student_records
VALUE (4, 256, 66.5, 20.00);


-- 2. 문자형
-- 한글, 영어, 기호 등의 문자 저장을 위한 타입
-- 다양한 세부 타입이 존재
-- 종류: CHAR, VARCHAR, TEXT, BLOB, ENUM 등

-- 1) CHAR vs VARCHAR
-- CHAR: 고정 길이(최대 255자)
-- VARCHAR: 가변 길이(최대 65,535자)
-- CHAR와 VARCHAR 자료형의 사용 예
CREATE TABLE addresses (
	potal_code CHAR(5), -- 고정 길이 문자: 5자, 주로 고정된 길이의 코드값(국가코드, 우편번호 등)
  -- 문자를 3개만 넣으면 자동으로 space 문자로 채워넣음(예: 'abc  ')
  street_address VARCHAR(100) -- 가변 길이 문자: 최대 100자
  -- 최대 100글자 저장가능, 하지만 실제 사용하는 메모리는 입력된 문자만큼 사용함
  -- (참고) UTF-8 기준 한글은 VARCHAR(65535)는 현실적으로 불가능하고 VARCHAR(16383) 정도가 안전 범위의 최대치
);

-- 2) TEXT
-- 긴 문자열 저장을 위한 타입 (참조형)
-- CHAR/VARCHAR로는 감당하기 어려운 매우 긴 텍스트 데이터를 저장하기 위해 존재
-- 예: VARCHAR는 최대 약 65KB 정도까지만 저장 가능(이마저도 문자셋에 따라 줄어듦)
-- => 그 이상을 저장하려면 TEXT가 필요
-- 세부 타입 종류: TINYTEXT, TEXT, MEDIUMTEXT, LONGTEXT
-- TEXT 자료형의 사용 예
CREATE TABLE articles (
	title VARCHAR(200),
  short_description TINYTEXT, -- 최대 255B
  comments TEXT, -- 최대 64KB
  content MEDIUMTEXT, -- 최대 16MB
  additional_info LONGTEXT -- 최대 4GB
);

-- 3) BLOB
-- 크기가 큰 파일 저장을 위한 타입
-- 이미지, 오디오, 비디오 등의 저장에 사용
-- 세부 타입 종류: TINYBLOB, BLOB, MEDIUMBLOB, LONGBLOB
-- BLOB 자료형의 사용 예
CREATE TABLE files (
	file_name VARCHAR(200),
  small_thumbnail TINYBLOB, -- 최대 255B
  document BLOB, -- 최대 64KB
  video MEDIUMBLOB, -- 최대 16MB
  large_data LONGBLOB -- 최대 4GB
);

-- (참고)
-- 자바 웹 개발을 포함한 대부분의 애플리케이션은 이미지나 동영상 등의 대용량 파일을 DB에 직접 저장하지 않고
-- 클라우드 스토리지 또는 파일 서버에 저장한 후 그 경로나 URL만을 DB에 저장하는 방식이 사실상 표준이 되었음
-- DB에 직접 저장하지 않는 이유: DB 부하가 증가, 성능 저하, 백업 및 복구가 어려워짐


-- 4) ENUM
-- 주어진 목록 중 하나만 선택할 수 있는 타입
-- 입력 가능한 목록을 제한하여, 잘못된 입력을 예방
-- ENUM 자료형의 사용 예
CREATE TABLE memberships (
	name VARCHAR(100),
  level ENUM('Bronze', 'Silver', 'Gold') -- 목록 중 하나를 택해야 함
);

-- 실습: 문자형 사용하기
-- 다음 데이터를 사용자 프로필(user_profiles) 테이블로 만들어 저장하려면?

-- 아이디 | 이메일               | 전화번호       | 자기소개       | 프로필사진| 성별
-- -------------------------------------------------------------------------------
-- 1     | geoblo@naver.com      | 012-3456-7890  | 안녕하십니까!  | NULL      | 남
-- 2     | hongsoon@example.com  | 098-7654-3210  | 반갑습니다요!  | NULL      | 여

CREATE TABLE user_profiles (
	id INTEGER,
  email VARCHAR(255),
  phone CHAR(13),
  introduce TEXT,
  profile_icon MEDIUMBLOB,
  gender ENUM('Male', 'Female'),
  PRIMARY KEY (id)
);

-- 사용자 프로필(user_profiles) 데이터 삽입
INSERT INTO user_profiles (id, email, phone, introduce, profile_icon, gender)
VALUES
	(1, 'geoblo@naver.com', '012-3456-7890', '안녕하십니까!', NULL, 'Male'),
	(2, 'hongsoon@example.com', '098-7654-3210', '반갑습니다요!', NULL, 'Female');
    
-- 데이터 조회
SELECT * FROM user_profiles;


-- 3. 날짜 및 시간형
-- 날짜와 시간 값 저장을 위한 타입
-- 종류: DATE, TIME, DATETIME, YEAR 등

-- 1) DATE
-- 날짜 저장을 위한 타입
-- YYYY-MM-DD 형식으로 저장
-- 예: '1919-03-01', '2025-12-25'
-- 유효 범위: '1000-01-01' ~ '9999-12-31'

-- 2) TIME
-- 시간 저장을 위한 타입
-- hh:mm:ss 형식으로 저장
-- 예: '08:50:25', '22:07:02'
-- 유효 범위: '-838:59:59' ~ '838:59:59' (<- 시간을 표현할 뿐만 아니라 두 시점 간 시간 차이도 표현하기 때문)
-- 추가 옵션: 밀리초 또는 마이크로초까지 저장 가능

-- 3) DATETIME
-- 날짜와 시간을 함께 저장하는 타입
-- YYYY-MM-DD hh:mm:ss 형식으로 저장
-- 예: '2025-05-31 19:30:00'
-- 유효 범위: '1000-01-01 00:00:00' ~ '9999-12-31 23:59:59'
-- 추가 옵션: 밀리초 또는 마이크로초까지 저장 가능

-- (번외) TIMESTAMP
-- 날짜 + 시간
-- YYYY-MM-DD hh:mm:ss
-- 1970-01-01 00:00:01 UTC ~ 2038-01-19 03:14:07 UTC 
-- 타임존 정보를 가짐(세션 타임존에 따라 자동 변환됨)
-- 장점: 자동 생성 및 업데이트 기능 제공

-- 4) YEAR
-- 4자리 연도 저장을 위한 타입
-- YYYY 형식으로 저장
-- 예: '2002'
-- 유효 범위: '1901' ~ '2155', '0000'(비표준) -> 미정을 표현하고 싶다면: NULL을 사용

-- 실습: 날짜 및 시간형 사용하기
-- 다음 데이터 이벤트(events)를 테이블로 저장하려면?

-- 아이디| 이벤트명        | 이벤트 일자 | 이벤트시간 | 이벤트 등록 일시     | 이벤트 연도
-- -------------------------------------------------------------------------------------
-- 111   | Music Festival  | 2024-10-04  | 17:55:00   | 2024-09-04 10:25:30  | 2024
-- 222   | Art Exhibition  | 2024-11-15  | 12:00:00   | 2024-09-05 11:30:00  | 2024

-- 이벤트(events) 테이블 생성
CREATE TABLE events (
  id INTEGER, 				-- 아이디(표준 정수)
	event_name VARCHAR(100), 	-- 이벤트명(가변 길이 문자: 최대 100자)
	event_date DATE, 			-- 이벤트 일자(YYYY-MM-DD)
	start_time TIME, 			-- 이벤트 시간(hh:mm:ss)
	created_at DATETIME, 		-- 이벤트 등록 일시(YYYY-MM-DD hh:mm:ss)
	event_year YEAR, 			-- 이벤트 연도(YYYY)
	PRIMARY KEY (id) 			-- 기본키 지정: id
);

-- 이벤트(events) 데이터 삽입
INSERT INTO events (id, event_name, event_date, start_time, created_at, event_year)
VALUES
	(111, 'Music Festival', '2024-10-04', '17:55:00', '2024-09-04 10:25:30', '2024'),
	(222, 'Art Exhibition', '2024-11-15', '12:00:00', '2024-09-05 11:30:00', '2024');
    
-- 데이터 조회
SELECT * FROM events;

-- Quiz
-- 1. 다음은 orders(주문)테이블을 생성하는 쿼리이다. 바르게 설명한 것을 모두 고르세요.

CREATE TABLE orders (
	id INTEGER,              -- 아이디
	name VARCHAR (255), 	 -- 상품명
	price DECIMAL(10, 2),    -- 가격
	quantity INTEGER,        -- 주문 수량
	customer_name CHAR(100), -- 고객명
	shipping_address TEXT,   -- 배송 주소
	created_at DATETIME,     -- 주문 일시
	PRIMARY KEY (id)
);

-- ① id는 기본키로 선언됐다.
-- ② name은 최대 255자까지 저장할 수 있다.
-- ③ price에 저장할 수 있는 최댓값은 9,999,999,999이다.
-- ④ customer_name이 100자보다 짧으면, 고객명을 저장하고 남은 만큼의 메모리 공간이 절약된다.
-- ⑤ create_at에는 날짜와 시간 값을 모두 저장할 수 있다.

-- 정답: 1 2 5


/*
5.2 자료형에 따른 필터링 실습: 상점 DB
*/
-- 데이터 타입 별 필터링 훈련

-- store DB 생성 및 진입
CREATE DATABASE store;
USE store;

-- orders 테이블 생성
CREATE TABLE orders (
	id INTEGER, 			-- 아이디(표준 정수)
	name VARCHAR(255), 		-- 상품명(가변 길이 문자: 최대 255자)
	price DECIMAL(10, 2), 	-- 가격(고정 소수점 방식 실수)
	quantity INTEGER, 		-- 주문 수량(표준 정수)
	created_at DATETIME, 	-- 주문 일시(날짜 및 시간형)
	PRIMARY KEY (id) 		-- 기본키 지정: id
);

-- orders 데이터 삽입
INSERT INTO orders (id, name, price, quantity, created_at)
VALUES
	(1, '생돌김 50매', 5387.75, 1, '2024-10-24 01:19:44'),
	(2, '그릭 요거트 400g, 2개', 7182.25, 2, '2024-10-24 01:19:44'),
	(3, '냉장 닭다리살 500g', 6174.50, 1, '2024-10-24 01:19:44'),
	(4, '냉장 고추장 제육 1kg', 9765.00, 1, '2024-10-24 01:19:44'),
	(5, '결명자차 8g * 18티백', 4092.25, 1, '2024-10-24 01:19:44'),
	(6, '올리브 오일 1l', 17990.00, 1, '2024-11-06 22:52:33'),
	(7, '두유 950ml, 20개', 35900.12, 1, '2024-11-06 22:52:33'),
	(8, '카카오 닙스 1kg', 12674.50, 1, '2024-11-06 22:52:33'),
	(9, '손질 삼치살 600g', 9324.75, 1, '2024-11-16 14:55:23'),
	(10, '자숙 바지락 260g', 6282.00, 1, '2024-11-16 14:55:23'),
	(11, '크리스피 핫도그 400g', 7787.50, 2, '2024-11-16 14:55:23'),
	(12, '우유 900ml', 4360.00, 2, '2024-11-16 14:55:23'),
	(13, '모둠 해물 800g', 4770.15, 1, '2024-11-28 11:12:09'),
	(14, '토마토 케첩 800g', 3120.33, 3, '2024-11-28 11:12:09'),
	(15, '계란 30구', 8490.00, 2, '2024-12-11 12:34:56'),
	(16, '해물 모듬 5팩 묶음 400g', 9800.50, 4, '2024-12-11 12:34:56'),
	(17, '칵테일 새우 900g', 22240.20, 1, '2024-12-11 12:34:56'),
	(18, '토마토 케첩 1.43kg', 7680.25, 1, '2024-12-11 12:34:56'),
	(19, '국내산 양파 3kg', 5192.00, 1, '2024-12-11 12:34:56'),
	(20, '국내산 깐마늘 1kg', 9520.25, 1, '2024-12-11 12:34:56');

-- 데이터 조회
SELECT * FROM orders;

-- 1. 문자열 필터링
-- 상품명에 '케첩'이 포함된 주문을 조회

-- LIKE 연산자
-- 레코드에서 특정 패턴과 일치하는 대상(문자열)을 찾는 필터링을 수행
-- SELECT * FROM table_name WHERE column LIKE pattern;

-- Wildcard
-- LIKE와 함께 사용해 특정 패턴을 찾는 연산자
-- %(퍼센트): 0개 또는 그 이상의 임의의 문자
-- _(언더스코어): 임의의 하나의 문자

-- ex)
-- LIKE '케첩%': '케첩'으로 시작하는 임의의 문자 => 케첩 소스 
-- LIKE '%케첩': '케첩'으로 끝나는 임의의 문자 => 토마토 케첩 
-- LIKE '%케첩%': '케첩'을 포함하는 임의의 문자 => 토마토 케첩 소스

-- LIKE '케첩_': '케첩'으로 시작하는 3글자 문자 => 케첩통 
-- LIKE '_케첩': '케첩'으로 끝나는 3글자 문자 => 빅케첩

-- 상품명이 '케첩'인 대상 찾기
SELECT * FROM orders
WHERE name LIKE '케첩';

-- 상품명에 '케첩'이 포함된 대상 찾기
SELECT * FROM orders
WHERE name LIKE '%케첩%';

-- 2. 날짜 필터링하기
-- 11월에 주문받은 상품 개수의 합을 구하려면?

-- 날짜 함수
-- 입력받은 날짜에서 연도, 월, 일 추출
-- YEAR(날짜): 입력 날짜의 연도 추출, 예) YEAR('2024-04-15') => 2024 
-- MONTH(날짜): 입력 날짜의 월 추출, 예) YEAR('2024-04-15') => 4 
-- DAY(날짜): 입력 날짜의 일 추출, 예) YEAR('2024-04-15') => 15 
-- EXTRACT(필드 FROM 날짜): 입력 날짜에서 특정 필드 추출 => 예) EXTRACT(YEAR FROM '2024-04-15')

-- 11월에 주문받은 상품 조회
SELECT * FROM orders
WHERE MONTH(created_at) = 11;

-- 11월에 주문받은 상품의 개수 총합
SELECT SUM(quantity) FROM orders
WHERE MONTH(created_at) = 11;


-- 3. 시간 필터링하기
-- 입력받은 시간에서 시, 분, 초 추출
-- HOUR(시간): 입력 시간의 '시' 추출, 예) HOUR('2024-10-04 08:30:45') => 8
-- MINUTE(시간): 입력 시간의 '분' 추출, 예) ('2024-10-04 08:30:45') => 30
-- SECOND(시간): 입력 시간의 '초' 추출, 예) ('2024-10-04 08:30:45') => 45
-- TIME_TO_SEC(시간): 입력 시간을 초 단위로 환산, 예) TIME_TO_SEC('08:30:45') => 30645

-- 오전에 주문받은 모든 상품 조회
SELECT * FROM orders
WHERE HOUR(created_at) < 12;

-- 오전에 주문받은 모든 상품 매출의 합계 조회
SELECT SUM(quantity * price) FROM orders
WHERE HOUR(created_at) < 12;


-- 4. 특정 범위 필터링하기
-- 상품 가격이 10,000 ~ 20,000원 사이에 있는 주문은?
-- 주문 시각이 2024-11-15 부터 2024-12-15 사이에 있는 주문은?
-- 상품명이 'ㄱ'으로 시작하는 모든 주문 내역은?

-- BETWEEN 연산자
-- 두 값 사이에 속하는지 확인할 때 사용하는 연산자(두 값을 포함하여 찾음)
-- SELECT columns FROM table_name WHERE column BETWEEN start AND end;

-- 두 가격 사이 범위의 모든 주문을 조회
-- price가 10000~20000 사이의 주문 조회
SELECT * FROM orders
WHERE price BETWEEN 10000 AND 20000;


-- 두 시각 사이 범위의 모든 주문의 개수 조회
-- 2024-11-15~2024-12-15 사이의 주문 개수의 합계
SELECT COUNT(*) FROM orders
WHERE created_at BETWEEN '2024-11-15' AND '2024-12-15';

-- 상품명의 첫 글자가 'ㄱ'으로 시작하는 주문 조회
SELECT * FROM orders
WHERE name BETWEEN 'ㄱ' AND '깋';

-- Quiz
-- 2. 다음 빈칸에 들어갈 용어를 순서대로 고르면? (예: ㄱㄴㄷㄹㅁ)
-- ① __________: 문자열이 특정 패턴과 완전히 혹은 일부와 일치하는지 확인하는 연산자
-- ② __________: 입력 날짜의 연도를 반환하는 함수
-- ③ __________: 입력받은 날짜 데이터에서 특정 필드를 추출하는 함수
-- ④ __________: 시작 값과 마지막 값을 포함해 두 값 사이의 범위에 속하는지 확인하는 연산자
-- ⑤ __________: 입력 시간의 시, 분, 초를 '초'로 환산하는 함수

-- (ㄱ) BETWEEN
-- (ㄴ) LIKE
-- (ㄷ) YEAR()
-- (ㄹ) EXTRACT()
-- (ㅁ) TIME_TO_SEC()

-- 정답: ㄴㄷㄹㄱㅁ