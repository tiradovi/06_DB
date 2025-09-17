@ -0,0 +1,173 @@
USE chun_university;

-- 문제 1
-- CLASS 테이블에서 모든 과목의 과목번호, 과목명, 학과번호를 조회하시오.
SELECT CLASS_NO,CLASS_NAME,DEPARTMENT_NO
FROM CLASS;

-- 문제 2
-- GRADE 테이블의 모든 성적 데이터를 조회하시오.
SELECT *
FROM GRADE;

-- 문제 3
-- CLASS_PROFESSOR 테이블에서 과목번호와 교수번호를 조회하시오.
SELECT CLASS_NO, PROFESSOR_NO
FROM CLASS_PROFESSOR;

-- 문제 4
-- PROFESSOR 테이블에서 교수번호, 교수명, 학과번호를 조회하되, 
-- 컬럼명을 각각 '교수코드', '교수이름', '소속학과'로 별칭을 지정하시오.
SELECT PROFESSOR_NO AS '교수코드', PROFESSOR_NAME AS '교수이름',DEPARTMENT_NO AS'소속학과'
FROM PROFESSOR;

-- 문제 5
-- DEPARTMENT 테이블에서 학과명과 정원을 연결하여 '학과명(정원명)' 형태로 조회하시오.
SELECT CONCAT(DEPARTMENT_NAME,'(',CAPACITY,')') AS '학과명(정원명)'
FROM DEPARTMENT;
-- 문제 6
-- 현재 날짜에서 7일 후, 30일 후, 365일 후를 조회하시오.
SELECT NOW() AS '현재', 
NOW() + interval 7 day AS '7일후',  
NOW() + interval 30 day AS '30일후',
NOW() + interval 365 day AS '365일후';

-- 문제 7
-- STUDENT 테이블에서 학번 앞에 'STU-'를 붙여서 조회하시오.
SELECT CONCAT('STU-',STUDENT_NO)
FROM STUDENT;
-- 문제 8
-- PROFESSOR 테이블에서 교수명 앞에 '교수님'을 붙여서 조회하시오.
SELECT CONCAT(PROFESSOR_NAME, '교수님')
FROM PROFESSOR;

-- 문제 9
-- GRADE 테이블에서 성적에 0.5를 더한 값을 '조정성적'으로 조회하시오.
SELECT POINT +0.5 AS '조정성적'
FROM GRADE;

-- 문제 10
-- DEPARTMENT 테이블에서 정원에서 5명을 뺀 값을 '실제모집인원'으로 조회하시오.
SELECT CAPACITY -5 AS '실제모집인원'
FROM DEPARTMENT; 
-- 문제 11
-- CLASS 테이블에서 중복을 제거하고 학과번호만 조회하시오.
SELECT DISTINCT(DEPARTMENT_NO)
FROM CLASS;
-- 문제 12
-- PROFESSOR 테이블에서 중복을 제거하고 학과번호만 조회하시오.
SELECT DISTINCT(DEPARTMENT_NO)
FROM PROFESSOR;

-- 문제 13
-- GRADE 테이블에서 중복을 제거하고 과목번호만 조회하시오.
SELECT DISTINCT(CLASS_NO)
FROM GRADE;

-- 문제 14
-- STUDENT 테이블에서 학과번호가 '002'인 학생들의 모든 정보를 조회하시오.
SELECT *
FROM STUDENT
WHERE DEPARTMENT_NO = '002';

-- 문제 15
-- CLASS 테이블에서 과목유형이 '교양'인 과목들의 과목번호와 과목명을 조회하시오.
SELECT CLASS_NO, CLASS_NAME
FROM CLASS
WHERE CLASS_TYPE ='교양';

-- 문제 16
-- DEPARTMENT 테이블에서 개설여부(OPEN_YN)가 'Y'인 학과의 학과명과 분류를 조회하시오.
SELECT DEPARTMENT_NAME, CATEGORY
FROM DEPARTMENT
WHERE OPEN_YN = 'Y';

-- 문제 17
-- PROFESSOR 테이블에서 학과번호가 '003'인 교수들의 교수번호와 이름을 조회하시오.
SELECT PROFESSOR_NO, PROFESSOR_NAME
FROM PROFESSOR
WHERE DEPARTMENT_NO = '003';

-- 문제 18
-- GRADE 테이블에서 성적이 3.0 미만인 성적 데이터를 조회하시오.
SELECT *
FROM GRADE
WHERE POINT < 3.0;

-- 문제 19
-- STUDENT 테이블에서 2003년에 입학한 학생들의 학번과 이름을 조회하시오.
SELECT STUDENT_NO, STUDENT_NAME
FROM STUDENT
WHERE ENTRANCE_DATE LIKE '2003%';

-- 문제 20
-- DEPARTMENT 테이블에서 정원이 30명 이하인 학과의 학과명과 정원을 조회하시오.
SELECT DEPARTMENT_NAME, CAPACITY
FROM DEPARTMENT
WHERE CAPACITY <=30;

-- 문제 21
-- STUDENT 테이블에서 이름이 '박'으로 시작하는 학생들의 학번과 이름을 조회하시오.
SELECT STUDENT_NO, STUDENT_NAME 
FROM STUDENT
WHERE STUDENT_NAME LIKE '박%';

-- 문제 22
-- CLASS 테이블에서 과목명에 '론'이 포함된 과목들의 과목번호와 과목명을 조회하시오.
SELECT CLASS_NO, CLASS_NAME
FROM CLASS 
WHERE CLASS_NAME LIKE '%론%';

-- 문제 23
-- STUDENT 테이블에서 주소에 '경기도'가 포함된 학생들의 이름과 주소를 조회하시오.
SELECT STUDENT_NAME, STUDENT_ADDRESS
FROM STUDENT
WHERE STUDENT_ADDRESS LIKE '%경기도%';

-- 문제 24
-- PROFESSOR 테이블에서 이름이 '교수'로 끝나는 교수들의 교수번호와 이름을 조회하시오.
SELECT PROFESSOR_NO, PROFESSOR_NAME
FROM PROFESSOR 
WHERE PROFESSOR_NAME LIKE '%교수';

-- 문제 25
-- GRADE 테이블에서 성적이 2.5 이상 3.5 이하인 성적 데이터를 성적 오름차순으로 정렬하여 조회하시오.
SELECT *
FROM GRADE
WHERE POINT BETWEEN 2.5 AND 3.5
ORDER BY POINT ASC;

-- 문제 26
-- STUDENT 테이블에서 학과번호가 '004', '005', '006'인 학생들의 정보를 학과번호 순으로 정렬하여 조회하시오.
SELECT *
FROM STUDENT
WHERE DEPARTMENT_NO IN ('004', '005', '006')
ORDER BY DEPARTMENT_NO;

-- 문제 27
-- CLASS 테이블에서 과목유형이 '전공선택'인 과목들을 과목명 내림차순으로 정렬하여 조회하시오.
SELECT *
FROM CLASS
WHERE CLASS_TYPE = '전공선택'
order by CLASS_NAME DESC;

-- 문제 28
-- PROFESSOR 테이블에서 소속 학과가 있는 교수들을 교수명 오름차순으로 정렬하여 조회하시오.
SELECT *
FROM PROFESSOR 
WHERE DEPARTMENT_NO IS NOT NULL
ORDER BY PROFESSOR_NAME ASC;

-- 문제 29
-- STUDENT 테이블에서 휴학하지 않은 학생들을 입학일 내림차순으로 정렬하여 조회하시오.
SELECT *
FROM STUDENT 
WHERE ABSENCE_YN = 'N'
ORDER BY ENTRANCE_DATE DESC;

-- 문제 30
-- GRADE 테이블에서 '200501' 학기가 아닌 성적 데이터를 학기번호 오름차순, 성적 내림차순으로 정렬하여 조회하시오.
SELECT *
FROM GRADE
WHERE TERM_NO != '200501'
ORDER BY TERM_NO ASC, POINT DESC;