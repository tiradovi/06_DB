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

/***********************************
단일행 서브쿼리 실습문제
****************************/
-- 문제1: 가장 싼 메뉴 찾기
-- 1단계: 최저 가격 찾기
SELECT MIN(price) FROM menus;

-- 2단계: 그 가격인 메뉴 찾기 (메뉴명, 가격)
SELECT name, price 
FROM menus
WHERE price = 1500;

-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT name, price 
FROM menus
WHERE price = (SELECT MIN(price) FROM menus);

-- 문제2: 평점이 가장 낮은 매장 찾기 (NULL 제외)
-- 1단계: 최저 평점 찾기
SELECT MIN(rating) FROM stores WHERE rating IS NOT NULL;

-- 2단계: 그 평점인 매장 찾기 (매장명, 평점, 카테고리)
SELECT name, rating, category
FROM stores
WHERE rating = 4.2;

-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT name, rating, category
FROM stores
WHERE rating = (SELECT MIN(rating) FROM stores WHERE rating IS NOT NULL);

-- 문제3: 배달비가 가장 저렴한 매장 찾기 (NULL 제외)
-- 1단계: 최저 배달비 찾기
SELECT MIN(delivery_fee) FROM stores  WHERE delivery_fee IS NOT NULL;
-- 2단계: 그 배달비인 매장들 찾기 (매장명, 배달비, 주소)
SELECT name, delivery_fee, address
FROM stores
WHERE delivery_fee =2000;
-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT name, delivery_fee, address
FROM stores
WHERE delivery_fee =(SELECT MIN(delivery_fee) FROM stores  WHERE delivery_fee IS NOT NULL);

-- 문제4: 평균 평점보다 높은 매장들 찾기
-- 1단계: 전체 매장 평균 평점 구하기
SELECT AVG(rating) FROM stores;

-- 2단계: 평균보다 높은 평점의 매장들 찾기 (매장명, 평점, 카테고리)
SELECT name, rating, category
FROM stores
WHERE rating > 4.66545;

-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT name, rating, category
FROM stores
WHERE rating > (SELECT AVG(rating) FROM stores);

-- 문제5: 평균 배달비보다 저렴한 매장들 찾기 (NULL 제외)
-- 1단계: 전체 매장 평균 배달비 구하기
SELECT AVG(delivery_fee) FROM stores WHERE delivery_fee IS NOT NULL;
-- 2단계: 평균보다 저렴한 배달비의 매장들 찾기 (매장명, 배달비, 카테고리)
SELECT name, delivery_fee, category
FROM stores
WHERE delivery_fee > 3179.2453;

-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT name, delivery_fee, category
FROM stores
WHERE delivery_fee > (SELECT AVG(delivery_fee) FROM stores WHERE delivery_fee IS NOT NULL);

-- 문제6: 치킨집 중에서 평점이 가장 높은 곳
-- 1단계: 치킨집들의 최고 평점 찾기
SELECT MAX(rating)
FROM stores
WHERE category = '치킨';

-- 2단계: 치킨집 중 그 평점인 매장 찾기 (매장명, 평점, 주소)
SELECT name, rating, address
FROM stores
WHERE (rating = 4.9 ) AND(category = '치킨');

-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT name, rating, address
FROM stores
WHERE rating = (SELECT MAX(rating) FROM stores WHERE category = '치킨') AND (category = '치킨');

-- 문제7: 치킨집 중에서 배달비가 가장 저렴한 곳 (NULL 제외)
-- 1단계: 치킨집들의 최저 배달비 찾기
SELECT MIN(delivery_fee) FROM stores WHERE (category = '치킨') AND (delivery_fee IS NOT NULL);

-- 2단계: 치킨집 중 그 배달비인 매장 찾기 (매장명, 배달비)
SELECT name, delivery_fee
FROM stores
WHERE delivery_fee = 2000 AND (category = '치킨');

-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT name, delivery_fee
FROM stores
WHERE delivery_fee = (SELECT MIN(delivery_fee) FROM stores WHERE (category = '치킨') 
AND (delivery_fee IS NOT NULL)) 
AND (category = '치킨');

-- 문제8: 중식집 중에서 평점이 가장 높은 곳
-- 1단계: 중식집들의 최고 평점 찾기
SELECT MAX(rating) 
FROM stores
WHERE category = '중식';

-- 2단계: 중식집 중 그 평점인 매장 찾기 (매장명, 평점, 주소)
SELECT name, rating, address
FROM stores
WHERE rating= 4.7 AND(category = '중식');

-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT name, rating, address
FROM stores
WHERE rating= (SELECT MAX(rating) FROM stores WHERE category = '중식') AND(category = '중식');

-- 문제9: 피자집들의 평균 평점보다 높은 치킨집들
-- 1단계: 피자집들의 평균 평점 구하기
SELECT AVG(rating) 
FROM stores
WHERE category = '피자';
-- 2단계: 그보다 높은 평점의 치킨집들 찾기 (매장명, 평점)
SELECT name, rating
FROM stores
WHERE rating > 4.7 AND(category = '피자');

-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT name, rating
FROM stores
WHERE rating > (SELECT AVG(rating) FROM stores WHERE category = '피자') AND(category = '피자');

-- 문제10: 한식집들의 평균 배달비보다 저렴한 일식집들 (NULL 제외)
-- 1단계: 한식집들의 평균 배달비 구하기
SELECT AVG(delivery_fee) FROM stores WHERE category='한식' AND (category IS NOT NULL);

-- 2단계: 그보다 저렴한 배달비의 일식집들 찾기 (매장명, 배달비)
SELECT name, delivery_fee
FROM stores
WHERE delivery_fee<3200 AND (category='일식');

-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT name, delivery_fee
FROM stores
WHERE delivery_fee<(SELECT AVG(delivery_fee) FROM stores WHERE category='한식' AND (category IS NOT NULL)) AND (category='일식');
-- ===========================================
-- 2. 기본 서브쿼리 (단일행)
-- ===========================================


-- ===========================================
-- 3. 기본 서브쿼리 (단일행)
-- ===========================================


















