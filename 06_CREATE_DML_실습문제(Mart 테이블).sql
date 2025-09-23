USE delivery_app;

-- 1. MART 테이블 생성 문제
-- 다음 조건에 맞는 MART 테이블을 생성하세요.
-- - mart_id: 자동증가 기본키
-- - mart_name: 마트명 (100자, NULL 불가)
-- - location: 위치 (255자, NULL 불가)
-- - phone: 전화번호 (20자)
-- - open_time: 개점시간 (TIME 타입)
-- - close_time: 폐점시간 (TIME 타입)
-- - is_24hour: 24시간 운영여부 (BOOLEAN, 기본값 FALSE)
-- - created_at: 등록일시 (TIMESTAMP, 기본값 현재시간)
-- - updated_at: 수정일시 (TIMESTAMP, 기본값 현재시간, 수정시 자동 업데이트)
CREATE TABLE MART (
    mart_id INT AUTO_INCREMENT PRIMARY KEY,
    mart_name VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    name VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    birth_date DATE,
    gender ENUM('M', 'F', 'Other'),
    address TEXT,
    join_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('ACTIVE', 'INACTIVE', 'SUSPENDED') DEFAULT 'ACTIVE'
);

-- 2. INSERT 문제
-- 다음 마트 정보를 INSERT하세요.

-- 문제 2-1: 모든 컬럼값을 지정하여 삽입
-- 이마트 강남점, 서울시 강남구 테헤란로 123, 02-123-4567, 08:00, 24:00, 24시간 운영 아님
-- (TIMESTAMP 컬럼은 DEFAULT 사용)


-- 문제 2-2: 컬럼명을 명시하여 삽입 (24시간 운영 정보와 TIMESTAMP 없이)
-- 롯데마트 잠실점, 서울시 송파구 올림픽로 456, 02-456-7890, 09:00, 23:00


-- 문제 2-3: DEFAULT 값 활용하여 삽입
-- CU 편의점 역삼점, 서울시 강남구 역삼로 789, 02-789-0123, 24시간 운영


-- 삽입된 데이터 확인
SELECT * FROM mart;

-- 3. UPDATE 문제
-- 문제 3-1: 이마트 강남점의 전화번호를 '02-111-1111'로 변경하세요.


-- 문제 3-2: 24시간 운영이 아닌 마트들의 폐점시간을 22:00으로 일괄 변경하세요.


-- 문제 3-3: CU 편의점 역삼점의 개점시간과 폐점시간을 각각 00:00, 23:59로 변경하세요.


-- 업데이트 결과 확인 (created_at과 updated_at 시간 차이 확인)
SELECT mart_name, created_at, updated_at FROM mart;

-- 4. DELETE 문제
INSERT INTO mart (mart_name, location, phone, open_time, close_time, is_24hour)
VALUES
('세븐일레븐 논현점', '서울시 강남구 논현로 111', '02-111-2222', NULL, NULL, TRUE),
('GS25 삼성점', '서울시 강남구 삼성로 222', NULL, '06:00:00', '24:00:00', FALSE);

-- 삽입 확인
SELECT * FROM mart;

-- 문제 4-1: 전화번호가 NULL인 마트를 삭제하세요.


-- 문제 4-2: 24시간 운영이 아니고 폐점시간이 22:00인 마트를 삭제하세요.


-- 문제 4-3: 마트명에 '편의점'이 포함된 마트를 삭제하세요.

-- 삭제 결과 확인
SELECT * FROM mart;


-- 최종 확인
SELECT * FROM mart;
DESCRIBE mart;
