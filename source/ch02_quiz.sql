-- 1. 데이터 CRUD 연습 문제

-- 문제 1
-- 다음 데이터를 저장하는 employees 테이블을 만드세요. 
-- id(아이디), salary(급여) 칼럼은 정수형, 
-- name(직원명), department(부서), position(직책)은 최대 50자를 저장하는 문자형
-- 기본키는 id로 지정합니다.

-- 정답:
CREATE TABLE employees (
	id INTEGER,
  name VARCHAR(50),
  department VARCHAR(50),
  position VARCHAR(50),
  salary INTEGER,
  PRIMARY KEY(id)
  );


-- 문제 2
-- employees 테이블에 모든 직원 정보를 삽입하세요.

-- 정답:
INSERT INTO employees (id, name, department, position, salary)
VALUE
	(1, '김철수', '개발', '사원', 3500000),
	(2, '박영희', '개발', '대리', 4200000),
	(3, '이민호', '기획', '팀장', 5500000),
	(4, '최수진', '기획', '사원', 3300000),
	(5, '정하늘', '영업', '사원', 3100000),
	(6, '오준수', '영업', '대리', 4000000),
	(7, '서지우', '마케팅', '팀장', 6000000),
	(8, '이은지', '마케팅', '사원', 3200000),
	(9, '안현준', '개발', '팀장', 5800000),
	(10, '홍길동', '영업', '사원', 3000000);


-- 문제 3
-- 새로운 직원 '장미희'를 '기획' 부서의 '사원'으로 추가하세요. 급여는 3,400,000원입니다.

-- 정답:
INSERT INTO employees (id, name, department, position, salary)
VALUE (11, '장미희', '기획', '사원', 3400000);


-- 문제 4
-- '개발' 부서 직원의 이름과 급여를 조회하세요.

-- 정답:
SELECT name, salary FROM employees WHERE department = '개발';


-- 문제 5
-- '팀장' 직책을 가진 직원의 이름과 부서를 조회하세요.

-- 정답:
SELECT name, department FROM employees
WHERE position = '팀장';


-- ※ 이후 문제 6 ~ 7번은 안전모드를 해제하고 실행한 후 다시 안전모드를 활성하세요.
SET SQL_SAFE_UPDATES = 0;

-- 문제 6
-- '영업' 부서의 모든 직원 급여를 300,000원씩 인상하세요.

-- 정답:
UPDATE employees SET salary = salary + 300000
WHERE department = '영업';


-- 문제 7
-- 급여가 3,200,000원 이하인 직원을 삭제하세요.

-- 정답:
DELETE FROM employees
WHERE salary <= 3200000;

SET SQL_SAFE_UPDATES = 1;