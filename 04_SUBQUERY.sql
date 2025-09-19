/****************
SUBQUERT (서브쿼리)
하나의 SQL 문 안에 포함된 또다른 SQL 문
메인쿼리 (기존쿼리)를 위해 보조 역할을 하는 쿼리문
- SELECT, FROM, WHERE, HAVING 에서 사용가능

stores(가게 테이블)
가게번호, 가게명, 카테고리, 평점, 배달비
id      , name  , category, rating, delivery_fee

menus(메뉴 테이블)
메뉴번호, 가게번호, 메뉴명, 가격, 인기메뉴여부
id      , store_id, name  , price, is_popular
******************/
USE delivery_app;

SELECT * FROM stores;
SELECT * FROM menus;
-- ===========================================
-- 1. 기본 서브쿼리 (단일행)
-- ===========================================
-- 가장 비싼 메뉴 찾기
-- 1단계 : 최고 가격 찾기
SELECT max(price) FROM menus; -- 38900원

-- 2단계 : 그 가격인 메뉴 찾기
SELECT name, price
FROM menus
WHERE price = 38900;

SELECT max(price) FROM menus; 

-- 3단계 : 1, 2단계를 조합해서 한 번에 비싼 메뉴 찾기
SELECT name, price
FROM menus
WHERE price = (SELECT max(price) FROM menus);
-- ---------------------------------------------------
-- 1단계 : 평균 메뉴들의 가격 조회
SELECT AVG(price) FROM menus;

-- 2단계 : 그 가격보다 비싼 메뉴 조회
SELECT name, price
FROM menus
WHERE price > 15221.4286;

-- 3단계 : 1, 2단계를 조합하여 평균보다 비싼 메뉴만 가격 조회
SELECT name, price
FROM menus
WHERE price > (SELECT AVG(price) FROM menus);
-- ---------------------------------------------------
-- 1단계 : 최고 평점 조회
SELECT MAX(rating) FROM stores;

-- 2단계 : 최고 평점인 매장 조회
SELECT name, rating
FROM stores
WHERE rating = 4.9;

-- 3단계 : 1, 2단계를 조합하여 최고 평점인 매장 조회
SELECT name, rating
FROM stores
WHERE rating = (SELECT MAX(rating) FROM stores);
-- ---------------------------------------------------
-- 1단계 : 가게에서 가장 비싼 배달비 가격 조회
SELECT MAX(delivery_fee) FROM stores;

-- 2단계 : 가격이 최고로 비싼 배달비의 매장명칭, 배달비, 카테고리 조회
SELECT name, delivery_fee, category
FROM stores
WHERE delivery_fee =5500;

-- 3단계 : 1, 2단계를 조합하여 가격이 최고로 비싼 배달비의 매장명칭, 배달비, 카테고리 조회
SELECT name, delivery_fee, category
FROM stores
WHERE delivery_fee =(SELECT MAX(delivery_fee) FROM stores);

-- ===========================================
-- 2. 기본 서브쿼리 (단일행)
-- ===========================================


-- ===========================================
-- 3. 기본 서브쿼리 (단일행)
-- ===========================================


















