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

-- 제약조건 위반 테스트 (에러가 발생해야 정상)
INSERT INTO LIBRARY_MEMBER VALUES (1, '박중복', 'park@email.com', '010-9999-8888', 30, DEFAULT); -- PK 중복
INSERT INTO LIBRARY_MEMBER VALUES (6, '이나이', 'lee@email.com', '010-7777-6666', 5, DEFAULT); -- 나이 제한 위반





























