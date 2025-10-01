-- 12_DCL
/*
DCL (Data Control Language)
데이터베이스의 접근 권한을 제어하는 SQL 명령어
주로 사용자 권한 관리와 보안 설정에 사용됨

GRANT - 권한 부여
사용자에게 특정 권한을 부여할 때 사용

-- 기본 문법
GRANT 권한종류 ON 데이터베이스명칭.테이블 TO '사용자'@'호스트';

REVOKE - 권한 회수

-- 기본 문법
REVOKE 권한종류 ON 데이터베이스명칭.테이블 FROM '사용자'@'호스트';
*/

CREATE USER 'john'@'localhost' IDENTIFIED BY 'mypassword123';
CREATE USER 'remote_user'@'%' IDENTIFIED BY 'remotepass456';
CREATE USER 'office_user'@'192.168.1.100' IDENTIFIED BY 'officepass';
CREATE USER 'network_user'@'192.168.1.%' IDENTIFIED BY 'networkpass';
CREATE USER 'guest'@'localhost';

-- 5.7 이하 버전은 아래 명령어가 가능
-- 8.0 버전부터는 아래 명령어가 불가능
GRANT SELECT ON tje.employees TO 'guest'; -- Error Code: 1410. You are not allowed to create a user with GRANT	

-- guest에게 SELECT 권한 부여
-- DATABASE tje에서 employees 테이블만 select

GRANT SELECT ON tje.employees TO 'guest'@'localhost';
-- 권한 회수
REVOKE SELECT ON tje.employees FROM 'guest'@'localhost';

-- network_user에게  SELECT INSERT UPDATE 부여
GRANT SELECT ON tje.employees TO 'network_user'@'192.168.1.%';                 -- SELECT
GRANT SELECT, INSERT, UPDATE ON tje.employees TO 'network_user'@'192.168.1.%'; -- INSERT, UPDATE
-- 권한 회수
REVOKE SELECT, INSERT, UPDATE ON tje.employees FROM 'network_user'@'192.168.1.%';

-- office_user 에게 SELECT INSERT UPDATE 동시 부여
-- tje 데이터베이스에서 모든 테이블에 접근 권한이 있는 유저
GRANT SELECT, INSERT, UPDATE ON tje.* TO 'office_user'@'192.168.1.100';
-- 권한 회수
REVOKE SELECT, INSERT, UPDATE ON tje.* FROM 'office_user'@'192.168.1.100';


-- remote_user 모든 권한 부여
-- 모든 데이터베이스에서 모든 테이블에 접근 권한이 있는 유저
-- 조회 수정 저장 삭제까지 모든게 가능한 유저
GRANT ALL privileges ON *.* TO 'remote_user'@'%';
-- 권한 회수

REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'remote_user'@'%';

-- 모든 권한을 준 후 권한 적용 안하면 GRANT로 부여한 권한이 의미가 없어짐
FLUSH privileges;








