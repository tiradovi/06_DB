-- DDL : 데이터 정의 언어
-- 개체를 만들고(CREATE), 수정하고(ALTER), 삭제하는(DROP)구문

-- ALTER(바꾸다, 변조하다)
-- 수정 가능한 것: 컬럼(추가/수정/삭제), 제약조건(추가/삭제)
--                 이름변경(테이블, 컬럼, 제약조건)

-- 테이블을 수정하는 경우
-- ALTER TABLE 테이블명 ADD|MODIFY|DROP 수정할 내용;

-- ================================================================
-- 1. 제약조건 추가 / 삭제
-- * 작성법 중 대괄호 : 생략 가능(선택항목)

-- MYSQL에서는 안되는 경우가 많음

-- 제약조건 추가 : ALTER TABLE 테이블명
--                 ADD [CONSTRAINT 제약조건명] 제약조건(컬럼명) [REFERENCES 테이블명[(컬럼명)]]; 

-- 제약조건 삭제 : ALTER TABLE 테이블명
--                 DROP CONSTRAINT 제약조건명;

-- ON UPDATE 조건 : 레코드 수정 시 기본값으로 컬럼 데이터 모두 수정
-- ON UPDATE CURRENT_TIMESTAMP : 특정 컬럼의 데이터가 수정될 경우 자동으로 시간 업데이트 설정
-- ================================================================

-- 번호 dept_no
CREATE TABLE department (
    dept_id VARCHAR(10),
    dept_title VARCHAR(35),
    location_id VARCHAR(10)
);

INSERT INTO department VALUES 
('D1', '인사관리부', 'L1'),
('D2', '회계관리부', 'L2'),  
('D3', '마케팅부', 'L3'),
('D4', '국내영업부', 'L4'),
('D5', '해외영업1부', 'L5');

CREATE TABLE employee (
    emp_id INT,
    emp_name VARCHAR(30),
    emp_no VARCHAR(14),
    email VARCHAR(30),
    phone VARCHAR(12),
    dept_code VARCHAR(10),
    job_code VARCHAR(10),
    sal_level VARCHAR(2),
    salary INT,
    bonus DECIMAL(2,1),
    manager_id INT,
    hire_date DATE,
    ent_date DATE,
    ent_yn CHAR(1) DEFAULT 'N'
);

CREATE TABLE location (
    local_code VARCHAR(10),
    local_name VARCHAR(40)
);

INSERT INTO location VALUES 
('L1', 'ASIA1'),
('L2', 'ASIA2'),
('L3', 'ASIA3'),
('L4', 'AMERICA'),
('L5', 'EUROPE');

CREATE TABLE job (
    job_code VARCHAR(10),
    job_name VARCHAR(35)
);

INSERT INTO job VALUES 
('J1', '대표'),
('J2', '부사장'),
('J3', '부장'),
('J4', '차장'),
('J5', '과장'),
('J6', '대리'),
('J7', '사원');

CREATE TABLE sal_grade (
    sal_level VARCHAR(2),
    min_sal INT,
    max_sal INT
);

INSERT INTO sal_grade VALUES 
('S1', 6000000, 10000000),
('S2', 5000000, 5999999),
('S3', 4000000, 4999999),
('S4', 3000000, 3999999),
('S5', 2000000, 2999999),
('S6', 1000000, 1999999);

-- DROP, CREATE, ALTER 모두 어떤 작업을 할 것인지 선택 후
-- 그 작업에 해당하는 명칭 설정

-- 1. 제약조건 추가
-- 부서 테이블에 PK 추가

-- 테이블에 제약조건만 추가
ALTER TABLE department ADD CONSTRAINT dept_pk PRIMARY KEY(dept_id);
-- 컬럼 자체를 전체적으로 수정, 데이터 타입 명시, 컬럼 속성과 제약조건을 동시에 변경시 사용
ALTER TABLE department MODIFY dept_id VARCHAR(10) PRIMARY KEY;

-- 제약조건만 단순히 추가시 ADD, 다시 세팅시 MODIFY

-- department 테이블에 UNIQUE 제약조건을 dept_title에 추가
ALTER TABLE department ADD UNIQUE(dept_title);

-- CHECK 제약조건 IN 활용하여 다수의 LOCATION_ID에 추가
ALTER TABLE department ADD CHECK(location_id IN('L1','L2','L3','L4','L5'));

-- employee 테이블에 외래키를 dept_code에 추가
-- department dept_id 참조
ALTER TABLE employee ADD FOREIGN KEY(dept_code) references department(dept_id);

-- employee 테이블에 NOT NULL 제약조건을 emp_name에 추가
ALTER TABLE employee MODIFY emp_name VARCHAR(30)  NOT NULL;
-- ADD로는 NOT NULL 제약조건 추가 불가
-- ADD로 제약조건 추가시 가능한 제약조건 : PK, FK, UNIQUE, CHECK 등
-- NOT NULL은 제약조건이 아니라 컬럼의 속성으로 취급, 컬럼 속성 변경시 MODIFY 사용

-- employee 테이블에 NOT NULL 제약조건을 emp_no에 추가
ALTER TABLE employee MODIFY emp_no VARCHAR(14) NOT NULL;
-- department 테이블에 mgr_id 컬럼을 INT 타입으로 추가
-- 새로운 컬럼 추가시 ADD COLUMN이라는 예약어 사용
ALTER TABLE department ADD COLUMN mgr_id INT;
-- ALTER TABLE department MODIFY mgr_id INT;
-- ERROR : 1054 MODIFY는 이미 존재하는 컬럼에서만 가능

-- department 테이블에 create_date 컬럼을 TIMESTAMP 타입으로 기본값 CURRENT_TIMESTAMP로 추가
ALTER TABLE department ADD create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- department 테이블에 create_date 컬럼 삭제
-- INSERT UPDATE DELETE : 컬럼 내부 데이터만
-- CREATE ALTER DROP 데이터 이상
ALTER TABLE department DROP COLUMN create_date;

-- 특정 컬럼의 명칭 변경 RENAME TO
ALTER TABLE department RENAME COLUMN dept_title TO dept_name;

-- 테이블 삭제
-- 다수의 SQL : DROP TABLE 테이블명 [CASCADE CONSTRAINTS];
-- MYSQL      :DROP TABLE 테이블명;
-- 외래키 활성화 비활성화 후 부모 테이블 삭제여부 결정

DROP TABLE BOOK;
-- Error Code: 3730. Cannot drop table 'book' referenced by a foreign key
-- 외래키에 의해 참조되고 있음
-- 방법 3가지 : 자식 -> 부모 순으로 삭제
--              외래키 제약조건만 삭제
--              외래키 체크 임시 비활성화를 통해 삭제

-- 방법 1번
DROP TABLE ORDER_DETAIL;
-- Error Code: 1051. Unknown table 'practice_db.order_daetail'	
-- 테이블 이름 오타

-- sys 삭제 금지








