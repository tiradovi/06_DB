/*
LIBRARY_MEMBER 테이블을 생성하세요.

컬럼 정보:
- MEMBER_NO: 회원번호 (숫자, 기본키)
- MEMBER_NAME: 회원이름 (최대 20자, 필수입력)
- EMAIL: 이메일 (최대 50자, 중복불가)
- PHONE: 전화번호 (최대 15자)
- AGE: 나이 (숫자, 7세 이상 100세 이하만 가능)
- JOIN_DATE: 가입일 (날짜시간, 기본값은 현재시간)

제약조건명 규칙:
- PK: PK_테이블명_컬럼명
- UK: UK_테이블명_컬럼명  
- CK: CK_테이블명_컬럼명
*/
USE delivery_app;

CREATE TABLE LIBRARY_MEMBER(
-- 다른 DBMS 에서는 컬럼레벨로 제약조건 작성시 CONSTRAINT 를 이용해서
-- 제약조건의 명칭을 설정 가능하지만 
-- MYSQL은 제약조건 명칭을 MYSQL 자체에서 자동생성해주기 때문에 명칭 작성 컬럼레벨에서 불가
-- 컬럼 명칭      자료형(크기)    제약조건      제약조건 명칭                     제약조건 설정,
-- MEMBER_NO      INT             CONSTRAINT    PK_LIBRARY_MEMBER_MEMBER_NO        PRIMARY KEY
MEMBER_NO INT PRIMARY KEY,
MEMBER_NAME VARCHAR(20) NOT NULL,
EMAIL VARCHAR(5) UNIQUE,
PHONE VARCHAR(15),
AGE INT CONSTRAINT CH_LIBRARY_MEMBER_AGE CHECK(AGE>= 7 AND AGE <=100),
JOIN_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
/*
MEMBER_NO, EMAIL에는 제약조건 명칭 설정 불가하나
단순히 PK, UNIQUE, FK, NOT NULL 과 같이 한 단어로 키형태를 작성하는 경우 제약조건 명칭 설정 불가

AGE에는 가능한 이유
CHECK 처럼 상세한 경우 제약조건 명칭 설정 가능
즉 CHECK 만 제약조건 명칭 설정 가능
*/
-- 우리회사가 이메일을 최대 20글자 작성으로 제한해놓았으나 -> 21글자가 생기는 경우
INSERT INTO LIBRARY_MEMBER (MEMBER_NO, MEMBER_NAME, EMAIL, PHONE, AGE)
VALUES (1, '김독서', 'kim@email.com', '010-1234-5678', 25);

-- Error Code: 1406. Date too long for column 'EMAIL' at row 1 
-- 컬럼에서 넣을 수 있는 크기에 비해 데이터양이 많을 때 발생하는 문제

-- 방법 1: DROP 후 재생성 -> 기존 데이터 제거
DROP TABLE LIBRARY_MEMBER;
-- 방법 2: EMAIL 컬럼의 크기 변경
ALTER TABLE LIBRARY_MEMBER
MODIFY EMAIL VARCHAR(50) UNIQUE;
-- ALTER 로 컬럼 속성 변경시 컬럼 명칭에 해당하는 정보를 하나 더 만들어 놓은 후 해당 제약조건 동작
/*
ALTER로 컬럼에 해당하는 조건을 수정할 경우
Indexs에서 컬럼명_1, 컬럼명_2... 과 같은 방식으로 추가됨

Indexes
EMAIL
EMAIL_2와 같은 형태로 존재

EMAIL 의 경우 제약조건 VARCHAR(5) UNIQUE
EMAIL_2 의 경우 제약조건 VARCHAR(50) UNIQUE

컬럼이름  인덱스들
EMAIL      EMAIL, EMAIL_2 중 가장 최근 생성된 명칭으로 연결
		   하지만 새로 생성된 조건이 마음에 들지않아 되돌리고 싶을 때는
		   EMAIL과 같이 기존에 생성한 조건을 인덱스 명칭을 통해 되돌아 설정 가능
           인덱스 = 제약조건명칭과 동일
*/

-- 제약조건 위반 테스트 (에러가 발생해야 정상)
INSERT INTO LIBRARY_MEMBER VALUES (1, '박중복', 'park@email.com', '010-9999-8888', 30, DEFAULT); -- PK 중복
-- -	Error Code: 1062. Duplicate entry '1' for key 'library_member.PRIMARY'
INSERT INTO LIBRARY_MEMBER VALUES (6, '이나이', 'lee@email.com', '010-7777-6666', 5, DEFAULT); -- 나이 제한 위반
-- -Error Code: 3819. Check constraint 'CH_LIBRARY_MEMBER_AGE' is violated.	
INSERT INTO LIBRARY_MEMBER VALUES (NULL, '박중복', 'park@email.com', '010-9999-8888', 30, DEFAULT); -- AUTOINCREMENT 미설정
-- Error Code: 1048. Column 'MEMBER_NO' cannot be null	

/*
온라인 쇼핑몰의 PRODUCT(상품) 테이블과 ORDER_ITEM(주문상품) 테이블을 생성하세요.

1) PRODUCT 테이블:
- PRODUCT_ID: 상품코드 (문자 10자, 기본키)
- PRODUCT_NAME: 상품명 (문자 100자, 필수입력)
- PRICE: 가격 (숫자, 0보다 큰 값만 가능)
- STOCK: 재고수량 (숫자, 0 이상만 가능, 기본값 0)
- STATUS: 판매상태 ('판매중', '품절', '단종' 중 하나만 가능, 기본값 '판매중')

2) ORDER_ITEM 테이블:
- ORDER_NO: 주문번호 (문자 20자)  
- PRODUCT_ID: 상품코드 (문자 10자)
- QUANTITY: 주문수량 (숫자, 1 이상만 가능)
- ORDER_DATE: 주문일시 (날짜시간, 기본값은 현재시간)

주의사항:
- ORDER_ITEM의 PRODUCT_ID는 PRODUCT 테이블의 PRODUCT_ID를 참조해야 함
- ORDER_ITEM은 (주문번호 + 상품코드) 조합으로 기본키 설정 (복합키)

*/
CREATE TABLE PRODUCT(
PRODUCT_ID VARCHAR(10) PRIMARY KEY, -- AUTO_INCREMENT 정수만 가능
PRODUCT_NAME VARCHAR(100) NOT NULL,
PRICE INT CONSTRAINT CH_PRODUCT_PRICE CHECK(PRICE>0),
STOCK INT CONSTRAINT CH_PRODUCT_STOCK CHECK(STOCK>=0) DEFAULT 0, -- constraint 제약조건명칭은 선택
STATUS VARCHAR(20) DEFAULT '판매중' CONSTRAINT CK_PRODUCT_STATUS CHECK(STATUS IN ('판매중', '품절', '단종'))
);
CREATE TABLE ORDER_ITEM(
ORDER_NO VARCHAR(20),
PRODUCT_ID VARCHAR(10),
QUANTITY INT CONSTRAINT CH_ORDER_ITEM_QUANTITY CHECK(QUANTITY>=1) ,
ORDER_DATE DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO PRODUCT VALUES ('P001', '노트북', 1200000, 10, '판매중');
INSERT INTO PRODUCT VALUES ('P002', '마우스', 25000, 50, '판매중');
INSERT INTO PRODUCT VALUES ('P003', '키보드', 80000, 0, '품절');

-- 주문 데이터 입력
INSERT INTO ORDER_ITEM VALUES ('ORD001', 'P001', 2, DEFAULT);
INSERT INTO ORDER_ITEM VALUES ('ORD001', 'P002', 1, DEFAULT);
INSERT INTO ORDER_ITEM VALUES ('ORD002', 'P002', 3, '2024-03-06 14:30:00');
INSERT INTO ORDER_ITEM VALUES ('ORD003', 'P999', 1, DEFAULT);

-- 제품이 존재하고, 제품번호에 따른 주문 
-- CREATE TABLE 할 때 FK 미설정시 오류 미발생
--  Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`delivery_app`.`order_item`, CONSTRAINT `FK_PRODUCT_ID` FOREIGN KEY (`PRODUCT_ID`) REFERENCES `product` (`PRODUCT_ID`))	

-- 테이블 삭제 외래키로 연결시 자식테이블 먼저 삭제 필요
-- 배민 - 가게 - 상품 - 주문
-- Error Code: 3730. Cannot drop table 'product' referenced by a foreign key constraint 'FK_PRODUCT_ID' on table 'order_item'.	
DROP TABLE PRODUCT;
DROP TABLE ORDER_ITEM;

-- 메인이 되는 테이블
-- AUTO_INCREMENT 정수만 가능
-- constraint 제약조건명칭은 선택
CREATE TABLE PRODUCT(
PRODUCT_ID VARCHAR(10) PRIMARY KEY, 
PRODUCT_NAME VARCHAR(100) NOT NULL,
PRICE INT CONSTRAINT CH_PRODUCT_PRICE CHECK(PRICE>0),
STOCK INT CONSTRAINT CH_PRODUCT_STOCK CHECK(STOCK>=0) DEFAULT 0, 
STATUS VARCHAR(20) DEFAULT '판매중'  CHECK(STATUS IN ('판매중', '품절', '단종'))
);
-- 상품이 있어야 주문 가능
-- ORDER_ITEM 테이블 내에서 PRODUCT_ID 컬럼은 PRODUCT테이블의 PRODUCT_ID와 연결
-- 단순참조
-- PRODUCT_ID VARCHAR(10) REFERENCES PRODUCT(PRODUCT_ID), 
-- 외래키 작성시 반드시 FOREIGN KEY 라는 명칭이 필수로 컬럼 레벨이나 테이블레벨에 들어가야 함
-- MySQL에서 FOREIGN KEY 또한 테이블 컬럼 형태로 작성 필요
CREATE TABLE ORDER_ITEM(
ORDER_NO VARCHAR(20),
PRODUCT_ID VARCHAR(10) ,
QUANTITY INT CHECK(QUANTITY>=1) ,
ORDER_DATE DATETIME DEFAULT CURRENT_TIMESTAMP
);
-- CONSTRAINT FK_PRODUCT_ID FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(PRODUCT_ID),
-- CONSTRAINT PK_ORDER_ITEM PRIMARY KEY (ORDER_NO, PRODUCT_ID)

/*
CONSTRAINT FK_PRODUCT_ID FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(PRODUCT_ID),
CONSTRAINT PK_ORDER_ITEM PRIMARY KEY (ORDER_NO, PRODUCT_ID)
*/
INSERT INTO PRODUCT VALUES ('P001', '노트북', 1200000, 10, '판매중');
INSERT INTO PRODUCT VALUES ('P002', '마우스', 25000, 50, '판매중');
INSERT INTO PRODUCT VALUES ('P003', '키보드', 80000, 0, '품절');

-- 주문 데이터 입력
INSERT INTO ORDER_ITEM VALUES ('ORD001', 'P001', 2, DEFAULT);
INSERT INTO ORDER_ITEM VALUES ('ORD001', 'P002', 1, DEFAULT);
INSERT INTO ORDER_ITEM VALUES ('ORD002', 'P002', 3, '2024-03-06 14:30:00');

-- 제품이 존재하고, 제품번호에 따른 주문 
-- CREATE TABLE 할 때 FK 미설정시 오류 미발생
--  Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`delivery_app`.`order_item`, CONSTRAINT `FK_PRODUCT_ID` FOREIGN KEY (`PRODUCT_ID`) REFERENCES `product` (`PRODUCT_ID`))	
INSERT INTO ORDER_ITEM VALUES ('ORD003', 'P999', 1, DEFAULT);

/*
대학교 성적 관리를 위한 테이블들을 생성하세요.

1) STUDENT 테이블:
- STUDENT_ID: 학번 (문자 10자, 기본키)
- STUDENT_NAME: 학생이름 (문자 30자, 필수입력)
- MAJOR: 전공 (문자 50자)
- YEAR: 학년 (숫자, 1~4학년만 가능)
- EMAIL: 이메일 (문자 100자, 중복불가)

2) SUBJECT 테이블:
- SUBJECT_ID: 과목코드 (문자 10자, 기본키)
- SUBJECT_NAME: 과목명 (문자 100자, 필수입력)
- CREDIT: 학점 (숫자, 1~4학점만 가능)

3) SCORE 테이블:
- STUDENT_ID: 학번 (문자 10자)
- SUBJECT_ID: 과목코드 (문자 10자)  
- SCORE: 점수 (숫자, 0~100점만 가능)
- SEMESTER: 학기 (문자 10자, 필수입력)
- SCORE_DATE: 성적입력일 (날짜시간, 기본값은 현재시간)

주의사항:
- SCORE 테이블의 STUDENT_ID는 STUDENT 테이블 참조(외래키 사용)
- SCORE 테이블의 SUBJECT_ID는 SUBJECT 테이블 참조(외래키 사용)  
- SCORE 테이블은 (학번 + 과목코드 + 학기) 조합으로 기본키 설정
- 같은 학생이 같은 과목을 같은 학기에 중복으로 수강할 수 없음
*/
-- YEAR 과 같은 예약어는 사용 지양
CREATE TABLE STUDENT(
STUDENT_ID VARCHAR(10) PRIMARY KEY,
STUDENT_NAME VARCHAR(30) NOT NULL,
MAJOR VARCHAR(50),
YEAR INT CHECK (YEAR IN(1,2,3,4)),
EMAIL VARCHAR(100) UNIQUE
);

CREATE TABLE SUBJECT(
SUBJECT_ID VARCHAR(10) PRIMARY KEY,
SUBJECT_NAME VARCHAR(100) NOT NULL,
CREDIT INT CHECK (CREDIT IN(1,2,3,4))
);

CREATE TABLE SCORE(
STUDENT_ID VARCHAR(10),
SUBJECT_ID VARCHAR(10),
SCORE  INT CHECK (SCORE >=0  AND SCORE<= 100),
SEMESTER VARCHAR(10) NOT NULL,
SCORE_DATE DATETIME DEFAULT CURRENT_TIMESTAMP,

CONSTRAINT FK_SCORE_STUDENT_ID FOREIGN KEY (STUDENT_ID) REFERENCES STUDENT(STUDENT_ID) ON DELETE CASCADE ,
CONSTRAINT FK_SCORE_SUBJECT_ID FOREIGN KEY (SUBJECT_ID) REFERENCES SUBJECT(SUBJECT_ID) ON DELETE SET NULL,
CONSTRAINT PK PRIMARY KEY (STUDENT_ID, SUBJECT_ID, SEMESTER)
);
-- Error Code: 3813. Column check constraint 'subject_chk_1' references other column.	
-- 컬렴명 제약조건에서 관련없는 명칭 작성시
INSERT INTO STUDENT VALUES ('2024001', '김대학', '컴퓨터공학과', 2, 'kim2024@univ.ac.kr');
INSERT INTO STUDENT VALUES ('2024002', '이공부', '경영학과', 1, 'lee2024@univ.ac.kr');

INSERT INTO SUBJECT VALUES ('CS101', '프로그래밍기초', 3);
INSERT INTO SUBJECT VALUES ('BM201', '경영학원론', 3);
INSERT INTO SUBJECT VALUES ('EN101', '대학영어', 2);

INSERT INTO SCORE VALUES ('2024001', 'CS101', 95, '2024-1학기', DEFAULT);
INSERT INTO SCORE VALUES ('2024001', 'EN101', 88, '2024-1학기', DEFAULT);
-- Error Code: 1062. Duplicate entry '2024001' for key 'SCORE.PRIMARY'
INSERT INTO SCORE VALUES ('2024002', 'BM201', 92, '2024-1학기', DEFAULT);

-- 제약조건 위반 테스트
INSERT INTO STUDENT VALUES ('2024003', '박중복', '수학과', 2, 'kim2024@univ.ac.kr');
-- Error Code: 1062. Duplicate entry 'kim2024@univ.ac.kr' for key 'student.EMAIL'
-- 이메일 중복
INSERT INTO SCORE VALUES ('2024001', 'CS101', 150, '2024-1학기', DEFAULT);
-- Error Code: 3819. Check constraint 'score_chk_1' is violated.
-- 제약조건 위배
INSERT INTO SCORE VALUES ('2024001', 'CS101', 90, '2024-1학기', DEFAULT);
-- Error Code: 1062. Duplicate entry '2024001-CS101-2024-1학기' for key 'score.PRIMARY'
-- 기본키 중복

-- 이메일을 중복 불가, 빈칸 허용 금지, 자료형 100까지 제한
ALTER TABLE STUDENT MODIFY EMAIL VARCHAR(100) UNIQUE NOT NULL;

DELETE FROM STUDENT WHERE EMAIL = 'kim2024@univ.ac.kr';
-- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails 	
-- SCORE 테이블에 외래키 참조하여 삭제 불가

-- 해결방법1 
-- 삭제하고자 하는 데이터의 하위 데이터에 존재하는 데이터 먼저 삭제

-- 해결방법2 
-- 외래키 제약조간 잠시 종료하고 삭제(비추천)
-- 무결성 조건에 해제됨
SET FOREIGN_KEY_CHECKS=0;

-- 해결방법3
-- ON DELETE CASCADE 
-- 부모테이블 데이터 삭제시 자식 테이블 또한 자동적으로 삭제될 수 있도록 설정




