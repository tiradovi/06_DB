/*
함수 : 컬럼값 | 지정된 값을 읽어 연산한 결과를 변환하는  것
함수는 SELECT절, WHERE절, ORDER BY절, GROUP BY절, HAVING절에서 사용 가능
단일행 함수 : N개의 행의 컬럼값을 전달하여 N개의 결과를 반환
그룹 합수 : N개의 행의 컬럼값을 전달하여 1개의 결과가 반환
(그룹의 수가 늘어나면 그룹 수만큼 결과 반환)

*/
-- 단일행 함수
-- 문자함수

-- LENGTH (문자열|컬럼명) : 문자열 길이 반환
SELECT 'HELLO WORLD', length('HELLO WORLD');

SELECT full_name, email, length(email) as '이메일 총 길이'
FROM EMPLOYEES
WHERE length(email) > 12
ORDER BY '이메일 총 길이';

-- LOCATE(찾을문자열, 문자열, 시작위치(선택) )
-- ORACLE 에서는 INSTR() 함수
-- 찾을 문자열의 위치 반환 (1부터 시작해서 못찾으면 0 출력)

-- B의 위치 5번째부터 검색
SELECT 'AABAACAABBAA' , locate('B', 'AABAACAABBAA', 5);

-- B의 위치 검색
SELECT 'AABAACAABBAA' , locate('B', 'AABAACAABBAA');

-- '@'문자의 위치 찾기
SELECT email, locate('@', email)
FROM EMPLOYEES;

-- SUBSTRING (문자열, 시작위치 ,길이(선택))
-- ORACLE 에서는 SUBSTR() 함수
-- 문자열을 시작위치부터 지정된 길이만큼 잘라내서 반환

-- 시작위치, 자를 길이 지정
SELECT substring('ABCDEFG', 2, 3);

-- 시작위치, 자를 길이 미지정
SELECT substring('ABCDEFG', 4);

SELECT full_name AS '사원명(EMP_NAME)', 
substring(email, 1, locate('@', email)-1) AS '이메일 아이디',
substring(email, locate('@', email)) AS '이메일 도메인'
FROM EMPLOYEES
ORDER BY '이메일 아이디';

-- REPLACE(문자열, 찾을문자열, 바꿀문자열)
SELECT dept_name as '기존 부서 명칭', replace(dept_name, '부', '팀') as '변경된 부서 명칭'
FROM departments;

-- 숫자 관련 함수
-- MOD([숫자 | 컬럼명], 나눌 값) : 나머지
SELECT MOD(105,100);

-- ABS([숫자 | 컬럼명]) : 절대값
SELECT ABS(10), ABS(-10);

-- CEIL([숫자 | 컬럼명]) : 올림
-- FLOOR([숫자 | 컬럼명]) : 내림
SELECT CEIL(1.1), FLOOR(1.1);

-- ROUND([숫자 | 컬럼명], 소수점위치(선택)) : 반올림
-- 소수점 위치 미지정시 소수점 첫번째자리에서 반올림하여 정수표현
-- 1) 양수 : 지정된 위치의 소수점 자리까지 표현
-- 2) 음수 : 지정된 위치의 정수 자리까지 표현
SELECT 123.456,           -- 123.456
	   ROUND(123.456),    -- 123
       ROUND(123.456,1),  -- 123.5
       ROUND(123.456,2),  -- 123.46
       ROUND(123.456,-1), -- 120
       ROUND(123.456,-2); -- 100

/******************************
N 개의 행의 컬럼 값을 전달하여 1개의 결과가 반환
그룹의 수가 늘어나면 그룹의 수만큼 결과 반환

SUM(숫자가 기록된 컬럼) : 그룹의 합계를 반환
AVG(숫자만 기록된 컬럼) : 그룹의 평균
MIN(컬럼명) : 최대값
MAX(컬럼명) : 최소값

날짜비교 : 과거 < 미래
문자열비교 : 유니코드 순서

COUNT(* | [DISTINCT] 컬럼명) : 조회된 행의 개수 반환
COUNT(*) : 조회된 모든 행의 개수 반환
COUNT(컬럼명) : 지정된 컬럼 값이 NULL이 아닌 행의 개수 반환
COUNT(DISTINCT 컬럼명) : 지정된 컬럼에서 중복 값을 제외한 행의 개수 반환(NULL 미포함)
*****************************/

-- 모든 사원의 급여 합 조회
SELECT SUM(salary)
FROM employees;

-- 모든 활성 사원의 급여 합 조회
SELECT SUM(salary), employment_status
FROM employees
WHERE employment_status = 'Active';

-- 2020 년 이후(2020년 포함) 입사자들의 급여 합 조회
SELECT SUM(salary) ,hire_date
FROM employees
WHERE YEAR(hire_date) >=2020
group by hire_date;

-- 모든 사원의 평균 급여 조회
SELECT AVG(salary)
FROM employees;

-- 모든 활성 사원의 급여 평균 조회
SELECT FLOOR( AVG(salary))
FROM employees
WHERE employment_status = 'Active';

-- as 급여 합계 , as 평균 급여를 이용해서 둘다 조회
SELECT SUM(salary) as `급여 합계`, AVG(salary)as `평균 급여`
FROM employees;

-- 모든 사원 중 가장 빠른 입사일, 최근입사일
-- 이름 오름차순에서 제일 먼저 작성되는 이름
SELECT MIN(hire_date) as `최초 입사일`, 
	   MAX(hire_date) as `최근 입사일`,
       MIN(full_name) as `가나다 순 첫번째`, 
       MAX(full_name) as `가나다 순 마지막`
FROM employees
WHERE employment_status = 'Active';


-- employees 테이블 전체 활성 사원 수
SELECT COUNT(*)
FROM employees
WHERE employment_status = 'Active';

-- employees 테이블에서 부서코드가 DEV인 사원수
SELECT count(*)
FROM employees E
JOIN departments D ON E.dept_id= D.dept_id
WHERE D.dept_code='DEV';

SELECT  count(*)
FROM employees E, departments D
WHERE (E.dept_id= D.dept_id) AND D.dept_code='DEV' ;

-- 전화번호가 있는 사원 수
SELECT COUNT(phone)
FROM employees;

-- 전화번호가 있는 사원수(NULL이 아닌 행 수만)
SELECT COUNT(phone)
FROM employees
WHERE phone is not null;

-- 테이블에 존재하는 부서코드의 수를 조회, dept_code 중복없이 조회
SELECT COUNT(distinct(D.dept_code))
FROM employees E
JOIN departments D ON E.dept_id= D.dept_id;

SELECT COUNT(distinct(D.dept_code))
FROM employees E,departments D
WHERE E.dept_id= D.dept_id;

-- EMPLOYEES 테이블에 존재하는 남자 사원의 수
SELECT COUNT(*)
FROM employees 
WHERE gender ='M';

-- ^ 문자열 시작
-- 결과 : Hi World
SELECT regexp_replace('Hello World', '^Hello', 'Hi');

-- 결과 : Hi Hello(첫 번째 Hello만 Hi로 변경)
SELECT regexp_replace('Hello Hello', '^Hello', 'Hi'); 

-- $ 문자열 끝
-- 결과 : Hello MySQL
SELECT regexp_replace('Hello World', 'World$', 'MySQL');

-- 결과 : World Hello MySQL(마지막 World만 MySQL로 변경)
SELECT regexp_replace('World Hello World', 'World$', 'MySQL');

-- 결과 : Hello World! 
SELECT concat('Hello', 'World', '!');

-- 결과 : Hello-World-! 
SELECT concat_ws('-','Hello', 'World', '!');

-- 결과 : HELLO WORLD
SELECT upper('Hello World');

-- 결과 : hello world
SELECT lower('Hello World');

-- 결과 : 'Hello World'
SELECT trim('     Hello World     ');

-- 결과 : 'Hello World'
SELECT trim('x' FROM 'xxxxxHello Worldxxxxx');

-- 결과 : 'Hello World    '
SELECT ltrim('     Hello World     ');

-- 결과 : '     Hello World'
SELECT rtrim('     Hello World     ');































