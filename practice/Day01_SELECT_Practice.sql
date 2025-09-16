-- 문제 1
-- chun_university 데이터베이스의 STUDENT 테이블에서 
-- 모든 학생의 학번(STUDENT_NO), 이름(STUDENT_NAME), 주소(STUDENT_ADDRESS)를 조회하시오.
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS
FROM student;

-- 문제 2
-- PROFESSOR 테이블의 모든 데이터를 조회하시오.
SELECT *
FROM PROFESSOR;

-- 문제 3
-- DEPARTMENT 테이블에서 학과번호(DEPARTMENT_NO)와 학과명(DEPARTMENT_NAME)을 조회하시오.
SELECT DEPARTMENT_NO,  DEPARTMENT_NAME
FROM DEPARTMENT;

-- 문제 4
-- STUDENT 테이블에서 모든 학생의 이름, 입학일, 입학일로부터 현재까지의 일수를 조회하시오.
-- (컬럼명은 각각 '학생이름', '입학일', '재학일수'로 별칭 지정)
SELECT STUDENT_NAME as '학생이름', ENTRANCE_DATE as '입학일', datediff(curdate(), ENTRANCE_DATE) as '재학일수'
FROM student;

-- 문제 5
-- 현재 시간과 어제, 내일을 조회하시오.
-- (컬럼명은 각각 '현재시간', '어제', '내일'로 별칭 지정)
SELECT NOW() as '현재시간', NOW()-interval 1 DAY as '어제',NOW()+interval 1 DAY as '내일';

-- 문제 6
-- STUDENT 테이블에서 학번과 이름을 연결하여 하나의 컬럼으로 조회하시오.
-- (컬럼명은 '학번_이름'으로 별칭 지정)
SELECT concat(STUDENT_NO, STUDENT_NAME) as '학번_이름'
FROM student;

-- 문제 7
-- STUDENT 테이블에서 존재하는 학과번호의 종류만 중복 없이 조회하시오.
SELECT distinct(DEPARTMENT_NO)
FROM student;


-- 문제 8
-- GRADE 테이블에서 중복 없이 존재하는 학기번호(TERM_NO) 종류를 조회하시오.
SELECT distinct(TERM_NO)
FROM GRADE;

-- 문제 9
-- STUDENT 테이블에서 휴학여부(ABSENCE_YN)가 'Y'인 학생의 
-- 학번, 이름, 학과번호를 조회하시오.
SELECT STUDENT_NO, STUDENT_NAME,DEPARTMENT_NO
FROM student
Where ABSENCE_YN ='Y';

-- 문제 10
-- DEPARTMENT 테이블에서 정원(CAPACITY)이 25명 이상인 학과의 
-- 학과명, 분류, 정원을 조회하시오.
SELECT DEPARTMENT_NAME, CATEGORY, CAPACITY
FROM DEPARTMENT
WHERE CAPACITY >=25;

-- 문제 11
-- STUDENT 테이블에서 학과번호가 '001'이 아닌 학생의 
-- 이름, 학과번호, 주소를 조회하시오.
SELECT  STUDENT_NAME,DEPARTMENT_NO,STUDENT_ADDRESS
FROM student
Where DEPARTMENT_NO !='001';

-- 문제 12
-- GRADE 테이블에서 성적(POINT)이 4.0 이상인 성적 데이터의 
-- 학기번호, 과목번호, 학번, 성적을 조회하시오.
SELECT TERM_NO, CLASS_NO, STUDENT_NO, POINT
FROM GRADE
WHERE POINT >=4.0;


-- 문제 13
-- STUDENT 테이블에서 2005년에 입학한 학생의 
-- 학번, 이름, 입학일을 조회하시오.
SELECT STUDENT_NO, STUDENT_NAME, ENTRANCE_DATE
FROM student
Where ENTRANCE_DATE LIKE '2005%';

-- 문제 14
-- PROFESSOR 테이블에서 소속 학과번호(DEPARTMENT_NO)가 NULL이 아닌 교수의 
-- 교수번호, 이름, 학과번호를 조회하시오.
SELECT PROFESSOR_NO, PROFESSOR_NAME, DEPARTMENT_NO
FROM PROFESSOR
WHERE DEPARTMENT_NO is not null;

-- 문제 15
-- CLASS 테이블에서 과목유형(CLASS_TYPE)이 '전공필수'인 과목의 
-- 과목번호, 과목명, 과목유형을 조회하시오.
SELECT CLASS_NO, CLASS_NAME, CLASS_TYPE
FROM class
WHERE CLASS_TYPE ='전공필수';

-- 문제 16
-- STUDENT 테이블에서 주소가 '서울시'로 시작하는 학생의 
-- 이름, 주소, 입학일을 조회하시오.
SELECT STUDENT_NAME, STUDENT_ADDRESS, ENTRANCE_DATE
FROM STUDENT 
WHERE STUDENT_ADDRESS LIKE '서울시%';

-- 문제 17
-- GRADE 테이블에서 성적이 3.0 이상 4.0 미만인 성적 데이터의 
-- 학번, 과목번호, 성적을 조회하시오.
SELECT STUDENT_NO, CLASS_NO, POINT
FROM GRADE
WHERE POINT >= 3.0 and POINT <4.0;

-- 문제 18
-- STUDENT 테이블에서 지도교수번호(COACH_PROFESSOR_NO)가 'P001'인 학생의 
-- 학번, 이름, 학과번호를 조회하시오.
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NO
FROM STUDENT
WHERE COACH_PROFESSOR_NO = 'P001';

-- 문제 19
-- DEPARTMENT 테이블에서 분류(CATEGORY)가 '인문사회'인 학과의 
-- 학과명, 분류, 개설여부를 조회하시오.
SELECT DEPARTMENT_NO, CATEGORY, OPEN_YN
FROM DEPARTMENT 
WHERE CATEGORY = '인문사회';

-- 문제 20
-- STUDENT 테이블에서 학번에 'A'가 포함된 학생의 
-- 학번, 이름, 입학일을 조회하시오.
SELECT STUDENT_NO, STUDENT_NAME, ENTRANCE_DATE
FROM STUDENT
WHERE STUDENT_NO LIKE '%A%';
