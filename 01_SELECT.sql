/*
SELECT (조회)

작성법 - 1 : 원하는 데이터를 선택해서 조회
SELECT 컬럼명, 컬럼명,...
FROM 테이블명;

작성법 - 2 : 모든 데이터를 조회
SELECT *;
FROM 테이블명;
*/

-- EMPLOYEE 테이블에서 사번, 이름, 이메일 조회
SELECT emp_id, full_name, email
FROM employees;

SELECT emp_id, full_name, email FROM employees;

/*
SQL의 경우 예약어 기준으로 세로로 작성하는 경우가 많으며,
세로로 작성하다 작성을 마무리하는 마침표는 반드시; 로 작성
*/

# EMPLOYEE 테이블에서 이름(full_name), 입사일(hire_date) 조회
# ctrl + enter 한줄 코드만 출력
SELECT full_name, hire_date FROM employees;

SELECT * FROM employees;

# DEPARTMENTS 테이블의 모든 데이터 조회
SELECT * FROM departments;

# DEPARTMENTS 테이블에서 부서코드, 부서명 조회(dept_code, dept_name)
SELECT dept_code, dept_name FROM departments;

# EMPLOYEES 테이블에서(emp_id, full_name, salary) 사번, 이름 급여 조회
SELECT emp_id, full_name, salary FROM employees;

# Training_programs 테이블에서 모든 데이터 조회
SELECT * FROM training_programs;

# Training_programs 테이블에서(program_name, duration_hours) 프로그램명, 교육시간 조회
SELECT program_name, duration_hours FROM training_programs;


/******************************
산술 연산자 

-- 컬럼 값 : 행과 열이 교차되는 테이블의 한 칸에 작성된 값

SELECT 문 작성시 컬럼명에 산술 연산을 직접 작성하면
조회결과(RESULT SET)에 연산 결과가 반영되어 조회된다.
*******************************/

-- 1. EMPLOYEES 테이블에서 모든 사원의 이름, 급여, 급여+500만원 결과 조회
SELECT full_name, salary , salary+5000000
FROM employees;

-- 2. EMPLOYEES 테이블에서 모든 사원의 사번, 이름, 연봉(급여 * 12) 조회
SELECT emp_id, full_name, salary*12
FROM employees;

-- 3. Training_programs 테이블에서 프로그램명, 교육시간, 하루당 8시간 기준 교육일수 조회
SELECT program_name, duration_hours, duration_hours/8
FROM training_programs;


-- EMPLOYEES 테이블에서 이름, 급여, 급여 * 0.8(세후급여) 조회
SELECT full_name, salary , salary*0.8
FROM employees;

-- POSITIONS 테이블 전체 데이터 조회
SELECT * 
FROM positions;

-- POSITIONS 테이블에서 직급명, 최소 급여, 최대 급여, 급여차이(최대급여 - 최소급여) 조회
SELECT position_name, min_salary, max_salary, max_salary-min_salary 
FROM positions;

# DEPARTMENTS 테이블에서 부서명, 예산, 예산 * 1.1 조회
SELECT dept_name, budget, budget*1.1
FROM departments;

-- 모든 SQL에서는 DUAL 가상 테이블이 존재함, MySQL에서는 FROM 생략할 경우 자동으로 DUAL 가상테이블 사용
-- 가상 테이블(필요없음)
-- 현재 날짜 확인
SELECT NOW(), current_timestamp;

SELECT NOW(), current_timestamp
FROM DUAL;

CREATE DATABASE IF NOT EXISTS 네이버;
CREATE DATABASE IF NOT EXISTS 라인;
CREATE DATABASE IF NOT EXISTS 스노우;

USE 네이버;
USE 라인;
USE 스노우;

-- 날짜 데이터 연산하기 ( + , - 만 가능)
-- > +1 == 1일 추가
-- > -1 == 1일 감소

-- 내일, 어제 조회
SELECT NOW() + interval 1 DAY, NOW() - interval 1 DAY;

-- 어제, 현재 시간, 내일, 모레 조회
SELECT NOW() - interval 1 DAY, NOW(), NOW() + interval 1 DAY,NOW() + interval 2 DAY;

-- 날짜 연산 (시간, 분, 초 단위)
SELECT NOW(), 
		NOW() + interval 1 HOUR,
		NOW() + interval 1 MINUTE,
		NOW() + interval 1 SECOND;

SELECT '2025-09-15', str_to_date('2025-09-15', '%Y-%m-%d');

SELECT datediff('2025-09-15', '2025-09-14');

-- CURDATE() : 시간 정보를 제외한 년 월 일만 조회
-- 근무일 수 조회
SELECT full_name, hire_date, datediff(curdate(), hire_date)
FROM employees;

-- 컬럼명 별칭 지정하기
/*********************************
컬럼명 별칭 지정하기
1) 컬럼명 AS 별칭   : 문자 O, 띄어쓰기 X, 특수문자 X
2) 컬럼명 AS '별칭' : 문자 O, 띄어쓰기 O, 특수문자 O
3) 컬럼명 별칭      : 문자 O, 띄어쓰기 X, 특수문자 X
4) 컬럼명 '별칭'    : 문자 O, 띄어쓰기 O, 특수문자 O

`` , "" 사용 가능
대소문자 구분
**********************************/

-- 별칭 이용해서 근무일수로 컬럼명 설정 후 조회하기
SELECT full_name, hire_date, datediff(curdate(), hire_date) AS `근무일수`
FROM employees;

-- 1. employees 테이블에서 사번, 이름, 이메일로 해당 컬럼 데이터 조회 (as `` 미사용)
SELECT emp_code as 사번, full_name as 이름, email as 이메일
FROM employees;

-- 2. employees 테이블에서 이름, 급여, 연봉(급여*12)로 해당 컬럼 데이터 조회(as `` 사용)
SELECT full_name as `이름`, ceil(salary) as `급여`, ceil(salary*12) as `연봉(급여*12)`
FROM employees;

-- 3. positon 테이블에서 직급명, 최소급여, 최대급여, 급여차이로 데이터 조회  (as "" 사용)
SELECT position_name as "직급명", ceil(min_salary) as "최소급여", ceil(max_salary) as "최대급여", 
ceil(max_salary-min_salary) as "급여차이"
FROM positions;

-- training_programs 테이블에서 프로그램명, 교육시간, 교육일수(8시간) 기준 조회
SELECT program_name AS `교육프로그램`,
	   duration_hours AS 총교육시간,
      round(duration_hours/8)  AS "교육일수"
FROM training_programs;

/********************************
DISTINCT(별개의, 전혀 다른)
--> 중복 제거
-- 조회 결과 집합(RESULT SET) 에서
   지정된 컬럼의 값이 중복되는 경우
   이를 한번만 표시
*********************************/
-- step1 employees 테이블에서 모든 사원의 부서코드 조회
SELECT dept_id
FROM employees;
-- step2 employees 테이블에서 사원이 존재하는 부서코드만 조회
SELECT  *
FROM departments;

-- 조회결과가 0 에러아님
SELECT distinct manager_id
FROM employees;

-- employees 테이블에서 사원이 있는 부서 아이디만 중복 제거후 조회
SELECT distinct dept_id
FROM employees;

# error code 1046 : 어떤 DB를 사용할 것인지 지정 하지 않아 생기는 문제
-- employees 테이블에서 존재하는 position_id 코드의 종류 중복없이 조회
SELECT distinct position_id
FROM employees;

/************************************
              WHERE 절
테이블에서 조건을 충족하는 행을 조회할 때 사용
WHERE 절에는 조건식(true/false)만 작성


비교 연산자 : >, <, <=, >=, =, !=, <>
논리 연산자 : AND, OR, NOT 
***********************************/
-- employees 테이블에서 급여가 300만원 초과하는 사원의 
-- 사번, 이름, 급여, 부서코드 조회
SELECT emp_id, full_name, salary,dept_id
FROM employees
WHERE salary >3000000;

-- employees 테이블에서 연봉이 5천만원 이상인 사원의 사번 이름 연봉 조회
SELECT emp_id as `사번` , full_name as `이름`,  ceil(salary*12) as `연봉`
FROM employees
WHERE (salary*12) >= 5000000;

-- employees 테이블에서 부서코드가 2번이 아닌 사원의 이름 부서코드 전화번호 조회
SELECT dept_id as `부서코드`, full_name as `이름`,  phone as `전화번호`
FROM employees
WHERE dept_id!=2;

/* 연결 연산자 CONCAT() */
SELECT CONCAT(emp_id, full_name) as 사번이름연결
from employees;

/******************************
		   LIKE 절
*******************************/

-- EMPLOYEES 테이블에서 성이 '김' 씨인 사원의 사번, 이름 조회
SELECT emp_id, full_name
FROM employees
WHERE first_name LIKE "김%";

-- EMPLOYEES 테이블에서 full_name에 '민'을 포함하는 사원의 사번, 이름 조회
SELECT emp_id, full_name
FROM employees
WHERE full_name LIKE "%민%";

-- EMPLOYEES 테이블에서 전화번호가 02으로 시작하는 사원의 이름, 전화번호 조회
SELECT full_name, phone
FROM employees
WHERE phone LIKE "02%";

-- EMPLOYEES 테이블에서 EMAIL의 아이디가 3근자인 사원의 이름, 이메일 조회
SELECT full_name, email
FROM employees
WHERE email LIKE "___@%";

-- EMPLOYEES 테이블에서 사원코드가 EMP로 시작하고 EMP를 포함하여 총 6자리인 사원 조회
SELECT full_name, emp_code
FROM employees
WHERE emp_code LIKE "EMP___";

/*****************************
     AND OR BETWEEN IN
*****************************/
-- EMPLOYEES 테이블에서
-- 급여가 4000만 이상, 7000만 이하인 사원의 사번, 이름 급여 조회
SELECT emp_id , full_name, ceil(salary) 
FROM employees
WHERE salary >=40000000 AND salary<=70000000;

SELECT emp_id , full_name,ceil(salary) 
FROM employees
WHERE salary BETWEEN 40000000 AND 70000000;

-- EMPLOYEES 테이블에서
-- 급여가 4000만 미만, 8000만 초과인 사원의 사번, 이름 급여 조회
SELECT emp_id , full_name,ceil(salary) 
FROM employees
WHERE salary <40000000 OR salary>80000000;

SELECT emp_id , full_name,ceil(salary) 
FROM employees
WHERE salary NOT BETWEEN 40000000 AND 80000000;

-- BETWEEN 구문 이용해서
-- EMPLOYEES 테이블에서
-- 입사일(hire_date)가 2020-01-01 부터 2020-12-31 사이인 사원의 이름, 입사일 조회
SELECT full_name, hire_date
FROM employees
WHERE hire_date BETWEEN '2020-01-01' AND '2020-12-31';

-- BETWEEN 구문 이용해서
-- EMPLOYEES 테이블에서
-- 생년월일(date_of_birth)가 1980년대인 사원의 이름, 생년월일 조회
SELECT emp_id, full_name, date_of_birth
FROM employees
WHERE date_of_birth BETWEEN  '1980-01-01' AND '1989-12-31';

-- EMPLOYEES 테이블에서
-- 부서 id 가 4인 사원 중
-- 급여가 4000만 이상, 7000만 이하인 사원의 사번, 이름 급여 조회
SELECT emp_id , full_name, ceil(salary) ,dept_id
FROM employees
WHERE (salary BETWEEN 40000000 AND 70000000)
AND dept_id =4; 


-- ORDER 절 WHERE 응용 IN() 절  JOIN 문

-- EMPLOYEES 테이블에서
-- 부서코드가 2, 4, 5 인 사원의
-- 이름, 부서코드, 급여 조회
SELECT full_name, dept_id, salary
FROM  employees
WHERE dept_id = 2
OR    dept_id = 4
OR    dept_id = 5;

-- 컬럼의 값이 () 내 값과 일치하면 true
SELECT full_name, dept_id, salary
FROM  employees
WHERE dept_id IN (2, 4, 5);

-- EMPLOYEES 테이블에서
-- 부서코드가 2, 4, 5 인 사원을 제외하고
-- 이름, 부서코드, 급여 조회
SELECT full_name, dept_id, salary
FROM  employees
WHERE dept_id NOT IN (2, 4, 5);
-- -> dept_id 가 NULL 인 사람들 또한 제외된 후 조회

-- NULL 값을 가지면서, 부서코드가 2, 4, 5 를 제외한
-- 모든 사원들을 결과에 추가하는 구문
SELECT full_name, dept_id, salary
FROM  employees
WHERE dept_id NOT IN (2, 4, 5)
OR dept_id IS NULL;


SELECT *
FROM  employees;


/**************************
ORDER BY 절
- SELECT 문의 조회 결과(RESULT SET)를 정렬할 때 사용하는 구문

SELECT 구문에서 가장 마지막에 해석됨
[작성법]
3:SELECT 컬럼명 AS 별칭, 컬럼명, 컬럼명, ...
1:FROM 테이블명
2:WHERE 조건식
4:ORDER BY 컬럼명 | 별칭 | 컬럼 순서[오름/내림 차순]
	* 컬럼이 오름차순인지 내림차순인지 작성되지 않았을 때는 기본으로 오름차순 정렬
    * ASC  : 오름차순(=ascending)
    * DESC : 내림차순(=descending) 
*************************/

-- employees 테이블에서 모든 사원의 이름, 급여 조회
-- 단, 급여 오름차순으로 정렬
/*2*/SELECT full_name, salary
/*1*/FROM employees
/*3*/ORDER BY salary; -- ASC 기본값

/*2*/SELECT full_name, salary
/*1*/FROM employees
/*3*/ORDER BY salary ASC;

SELECT full_name, salary
FROM employees
ORDER BY salary DESC;

-- employees 테이블에서 
-- 급여가 4000만원 이상, 10000만원 이하인 사람의
-- 사번, 이름, 급여를 이름 내림차순으로 조회
SELECT emp_id, full_name, salary
FROM employees
WHERE salary BETWEEN 40000000 AND 100000000
ORDER BY full_name DESC;

SELECT emp_id, full_name, salary
FROM employees
WHERE salary BETWEEN 40000000 AND 100000000
ORDER BY 2 DESC; -- 2번째 컬럼(full_name)으로 정렬

/*ODER BY 절 수식 적용 해서 정렬 가능 */
-- EMPLOYEES 테이블에서 이름, 연봉을 연봉 내림차순으로 조회

SELECT full_name, salary * 12
FROM EMPLOYEES
ORDER BY salary * 12 DESC;

SELECT full_name, salary * 12 AS 연봉
FROM EMPLOYEES
ORDER BY 연봉 DESC;

SELECT full_name, salary * 12 AS 연봉
FROM EMPLOYEES
ORDER BY salary * 12 DESC;

/* NULL 값 정렬 처리 */
-- 기본적으로 NULL 값은 가장 작은 값으로 처리됨
-- ASC : NULL 최상위 존재
-- DESC : NULL 최하위 존재

/*3*/SELECT full_name, dept_id AS 부서코드
/*1*/FROM employees
/*2*/WHERE dept_id = 4
/*4*/ORDER BY 부서코드 DESC;

-- 모든 사원의 이름 전화번호를 phone 기준으로 오름차순 조회


-- employees 테이블에서
-- 이름, 부서ID, 급여 를
-- 급여 내림차순 정렬


/***************************
JOIN

INNER JOIN : 두 테이블에서 조건을 만족하는 행만 반환
          - 모든 고객과 그들의 최근 주문 번호
          - 주문이 있는 상품만 주문과 주문상품 조회
          - 로그인한 사용자의 권한 정보
          - 결제 완료된 주문 내역

LEFT JOIN  : 두 테이블에서 왼쪽 테이블의 모든 행과 오른쪽 테이블의 일치하는 행을 반환
RIGHT JOIN : 두 테이블에서 오른쪽 테이블의 모든 행과 왼쪽 테이블의 일치하는 행을 반환
		  - 모든 상품과 리뷰개수 (리뷰 없이도 상품 표시)
          - 모든 고객과 그들의 최근 주문 번호 (주문이 없어도 모든 고객 표시)
          - 직원과 교육 이수 현황(교육 안 받은 직원도 포함해서 표시)

FULL OUTER JOIN : MYSQL 지원하지 않으나, UNION 예약어를 통해 구현가능
			   - UNION : 중복 제거 후 조회
               - UNION ALL: 중복 포함 후 조회
               - 두 테이블의 모든 데이터를 보고싶을 때 사용
               
SELF JOIN : 같은 테이블의 자기 자신과 조인
          - 계층 구조나 같은 테이블 내 관계 조회
          - 게시글 - 답글 관계
          - 추천인 - 피 추천인 관계
CROSS JOIN : 두 테이블의 모든 행 조합 후 반환
		  - 모든 조합을 만들어야 할 때
          - 월별 실적 테이블 초기화
          - 모든 사용자에게 기본 권한 부여
****************************/      
USE EMPLOYEE_MANAGEMENT;    

-- JOIN 방식
SELECT employees.dept_id, employees.full_name, departments.dept_name
FROM employees 
INNER JOIN departments ON employees.dept_id= departments.dept_id;

SELECT E.dept_id, E.full_name, D.dept_name
FROM employees E
INNER JOIN departments D ON E.dept_id= D.dept_id;

SELECT  E.dept_id, E.full_name, D.dept_name
FROM employees E, departments D
WHERE E.dept_id= D.dept_id ;
	









