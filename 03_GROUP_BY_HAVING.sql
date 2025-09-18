/*
SELECT 문 해석 순서

5 SELECT   컬럼명 AS 별칭, 계산식, 함수식
1 FROM     참조할 테이블명
2 WHERE    컬럼명 | 함수식 비교연산자 비교값
3 GROUP BY 그룹을 묶을 컬럼명
4 HAVING   그룹함수식 비교연산자 비교값
6 ORDER BY 컬럼명 | 별칭 | 컬럼순번 정렬방식[NULLS FIRST | LAST];
*/

-- employees 테이블에서 부서별 사원 수 조회
SELECT dept_id, COUNT(*)
FROM employees
GROUP BY dept_id;

-- employees 테이블에서 부서별로 
-- 보너스를 받는(급여가 60000000이상인 사원) 사원 수 조회
SELECT dept_id, COUNT(*)
FROM employees
WHERE salary >= 60000000
GROUP BY dept_id;

-- employees 테이블에서 
-- 부서ID, 부서별 급여 합계 as 급여 합계, 
-- 부서별 급여 평균(정수) as 급여 평균, 인원수 조회 as 인원수
SELECT dept_id, 
       SUM(salary) as `급여 합계`, 
       FLOOR(AVG(salary))as `급여 평균`, 
       COUNT(*) as `인원수`
FROM employees
GROUP BY dept_id
ORDER BY dept_id;

-- employees 테이블에서 
-- 부서ID가 4,5인 부서별 급여 평균(정수) as 급여 평균
SELECT dept_id, FLOOR(AVG(salary))as `급여 평균`
FROM employees
WHERE dept_id IN(4,5)
GROUP BY dept_id;

-- employees 테이블에서 
-- 직급별 2020 년도 이후 입사자들의 급여 합
SELECT position_id, SUM(salary) as `급여 합계`
FROM employees
WHERE YEAR(hire_date) >=2020
group by position_id;

/*
GROUP BY 사용시 주의 사항
SELECT 문에 GROUP BY 절을 사용할 경우
SELECT 절에 명시한 조회하려는 컬럼 중
그룹함수가 적용되지 않은 컬럼은
모두 GROUP BY 절에 작성해야함

*/

/*
 Error Code: 1055. 
 Expression #1 of ORDER BY clause is not in GROUP BY clause and contains 
 nonaggregated column 'employee_management.employees.dept_id' which is not functionally dependent 
 on columns in GROUP BY clause; 
 this is incompatible with sql_mode=only_full_group_by	0.000 sec
*/

-- employees 테이블에서 부서 별로 같은 직급인 사원의 급여 합계
SELECT position_id, SUM(salary) as `급여 합계`
FROM employees
group by position_id
ORDER BY dept_id;

-- employees 테이블에서 부서 별로 같은 직급인 사원의 수
SELECT  dept_id,position_id, COUNT(*)
FROM employees
group by  dept_id,position_id
ORDER BY dept_id, position_id;
/*
group by dept_id, position_id 를 기준으로 데이터를 묶는다.
부서 10, 직위 1
부서 10, 직위 2
부서 20, 직위 1
이 있는 경우 각 조합마다 COUNT(*)로 몇명의 직원이 존재하는지 계산하겠다.
*/
-- 부서별 평균 급여 조회
-- 부서 ID별 오름차순
SELECT dept_id, AVG(salary) as `급여 평균`
FROM employees
group by dept_id
ORDER BY dept_id;



