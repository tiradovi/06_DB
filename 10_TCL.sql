-- 10. TCL
-- ==========================================
-- TCL(Transaction Control Language)
-- 트랜잭선 제어 언어
-- Transaction : 업무, 처리
--               데이터베이스의 논리적 연산 단위
-- Oracle은 기본적으로 Auto Commit 비활성화되어있어 COMMIT 명시적 실행 필요
-- MySQL은 기본적으로 Auto Commit이 활성화되어있어 각 DML 구문이 실행될 때마다 자동 커밋
-- 자동 저장이 아닌 개발자가 제어하는 저장을 하고 싶다면
-- START TRANSACTION; 또는 SET autocommit =0;을 먼저실행
-- 자동저장 끄기
/*
COMMIT : 메모리 버퍼(트랜잭션)에 임시 저장된 데이터 변경 사항을 DB에 반영
         메모장이나, 포토샵에서 이미지나 글자를 저장하기 전 단계
         COMMIT은 메모장이나, 포토샵에 작성한 이미지나 글자 데이터를 DB에 저장하는 역할
         
ROLLBACK : 메모리 버퍼(트랜잭션)에 임시 저장된 데이터 변경 사항을 삭제하고 마지막 COMMIT 상태로 돌아감
           기존 작업한 데이터를 지우고 마지막에 저장한 상태로 되돌아가기
           
SAVEPOINT : 트랜잭션 내에 저장 지점을 정의하며, ROLLBACK 수행 시 전체 작업을 삭제하는 것이 아닌
            지정한 SAVEPOINT 까지만 일부 되돌아가기 (임시저장상태로 돌아가기)
			SAVEPOINT 포인트이름1;
            ...
            SAVEPOINT 포인트이름2;
            ...
            SAVEPOINT 포인트이름3;
            ...
            ROLLBACK TO SAVEPOINT 포인트이름2; -- 포인트2지점까지 데이터 변경사항 삭제
            포인트이름3에 저장된 내역 또한 사라짐
            
사용 예시
계좌 이체
     1번 A의 계좌에서 5만원 차감 (UPDATE)
     2번 B의 계좌에서 5만원 추가 (UPDATE)
     성공 시나리오 : 1번과 2번 작업이 모두 성공적으로 끝나면, 이 거래 확정 --> COMMIT
     실패 시나리오 : 1번이 성공했으나 시스템 오류로 인해 2번 작업 실패 (은행 점검)
                     이 때, COMMIT이 아닌 ROLLBACK 하면 1번 작업이 취소되어 A계좌의 돈이 사라지는
                     현상을 막고 마치 계좌이체가 없던 일처럼 돌리는 것
                     
온라인 쇼핑 주문 : 재고 감소 + 주문 내역생성 +포인트 적립
항공권 / 숙소 예약 : 좌석 예약 + 결제 정보 기록 + 예약자 정보 생성

복잡하고 긴 작업 중 일부만 되돌리고 싶을 때 SAVEPOINT 사용
*/
-- ==========================================

CREATE TABLE events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    event_name VARCHAR(100) NOT NULL,
    total_seats INT NOT NULL,
    available_seats INT NOT NULL 
);

CREATE TABLE attendees (
    attendee_id INT PRIMARY KEY AUTO_INCREMENT,
    attendee_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    event_id INT NOT NULL,
    attendee_id INT NOT NULL,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (event_id) REFERENCES events(event_id),
    FOREIGN KEY (attendee_id) REFERENCES attendees(attendee_id)
);

INSERT INTO events (event_name, total_seats, available_seats) 
VALUES ('SQL 마스터 클래스', 100, 2); 

START TRANSACTION;
INSERT INTO attendees
VALUES(1, '김철수','culsoo@gmail.com');

-- SQL 마스터 글래스 이벤트의 남은 좌석 1개 줄이기
UPDATE events
SET available_seats = available_seats -1
WHERE event_id = 1;

-- 주의 : select 에서 데이터가 보여도 자동커밋이 아닌 경우 commit 이 완성된 것이 아님
-- java에서 불러올 때 저장되지 않은 데이터가 불러와질 수 있음
-- 지금 database자체가 아닌 database에 데이터를 명시하는 schemas 명세상태
-- java는 schemas가 아니라 database랑 소통
INSERT INTO bookings (event_id, attendee_id)
VALUES(1,1);

COMMIT; -- 김철수 씨의 예약을 모두 확정하는 단계

SELECT * FROM attendees;
SELECT * FROM events;
SELECT * FROM bookings;

-- 박영희씨가 클래스 예약을 시도했지만 좌석이 없어서 실패한 시나리오
-- ROLLBACK;
START TRANSACTION; -- COMMIT 전까지 유효 
INSERT INTO attendees
VALUES(2, '박영희','heepark@gmail.com');













