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
WHERE delivery_fee < 3179.2453;

-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT name, delivery_fee, category
FROM stores
WHERE delivery_fee < (SELECT AVG(delivery_fee) FROM stores WHERE delivery_fee IS NOT NULL);

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
WHERE rating > 4.7 AND(category = '치킨');

-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT name, rating
FROM stores
WHERE rating > (SELECT AVG(rating) FROM stores WHERE category = '피자') AND(category = '치킨');

-- 문제10: 한식집들의 평균 배달비보다 저렴한 일식집들 (NULL 제외)
-- 1단계: 한식집들의 평균 배달비 구하기
SELECT AVG(delivery_fee) FROM stores WHERE category='한식' AND (category IS NOT NULL);

-- 2단계: 그보다 저렴한 배달비의 일식집들 찾기 (매장명, 배달비)
SELECT name, delivery_fee
FROM stores
WHERE delivery_fee < 3200 AND (category='일식');

-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT name, delivery_fee
FROM stores
WHERE delivery_fee<(SELECT AVG(delivery_fee) FROM stores WHERE category='한식' AND (category IS NOT NULL)) AND (category='일식');
-- ===========================================
-- 2. 다중행 서브쿼리 (MULTI ROW SUBQUERY) N 행 1열
-- IN / NOT IN, > ANY/ < ANY, > ALL/ < ALL, EXISTS / NOT EXISTS
-- 주요 연산자 : IN, NOT IN, ANY, ALL, EXISTS
-- ===========================================

-- 인기 메뉴가 있는 매장들 조회
-- 1단계 : 인기 메뉴가 있는 매장 ID 들 확인
SELECT distinct(store_id) FROM menus WHERE is_popular = TRUE;

-- 2단계 : 인기있는 매장에 해당하는 매장 정보 찾기
SELECT s.name, s.category, s.rating, s.id, m.store_id
FROM stores s, menus m
where s.id= m.store_id AND s.id IN(SELECT distinct(store_id) FROM menus WHERE is_popular = TRUE);

-- 인기 메뉴가 없는 매장 조회
-- 1단계 : 인기 메뉴가 있는 매장 ID 들 확인 
SELECT distinct(store_id) FROM menus WHERE is_popular = TRUE;

-- 2단계 : 인기없는 매장에 해당하는 매장 정보 찾기
SELECT name,category, rating
FROM stores
where id NOT IN(SELECT distinct(store_id) FROM menus WHERE is_popular = TRUE);

-- 치킨, 피자 카테고리 매장들만 조회
-- 1단계 : 치킨, 피자 카테고리 중복없이 확인
SELECT distinct(name), category, rating
FROM stores
WHERE category IN('치킨', '피자');

-- 20000 원 이상 메뉴를 파는 매장들 조회
-- 1단계 : 20000원 이상 메뉴를 가진 매장 id들 확인
SELECT distinct store_id FROM menus WHERE price >= 20000;

-- 2단계 : 1단계 결과를 조합하여 해당 매장들에 대한 정보 가져오기
SELECT name, category, rating
FROM stores
WHERE id IN (SELECT distinct store_id FROM menus WHERE price >= 20000)
ORDER BY name;

/**********************************************************
           다중행 서브쿼리 실습문제 (1 ~ 10 문제)
***********************************************************/
-- =============================================
-- IN 연산자 -  해당하는 내용을 포함할 때
-- =============================================
-- =============================================
--  NOT IN 연산자 - 해당하는 내용을 제외할 때
-- =============================================


-- 문제 1: 카테고리별 최고 평점 매장들 조회
-- 1단계: 카테고리별 최고 평점들 확인
SELECT MAX(rating), category FROM stores GROUP BY category;

SELECT id FROM stores WHERE rating IN(SELECT MAX(rating) FROM stores GROUP BY category);
-- 2단계: 1단계 결과를 조합하여 각 카테고리의 최고 평점 매장들 가져오기
SELECT category, name, rating
FROM stores
WHERE (category, rating) IN (SELECT category, MAX(rating) FROM stores GROUP BY category);


-- 문제 2: 배달비가 가장 저렴한 매장들의 인기 메뉴들 조회
-- 1단계: 가장 저렴한 배달비 매장 ID들 확인
SELECT MIN(delivery_fee) FROM stores;

-- WHERE 의 특성 Error Code: 1111. Invalid use of group function
-- WHERE 절에는 MIN(), MAX(), AVG() 같은 함수 직접 사용 불가
-- WHERE 절은 테이블의 각 행을 하나씩 필터링 하는 단계
-- MIN() 함수는 where 절의 필터링이 끝난 다음에 데이터를 그룹화해서 최소값을 계산하는 함수
-- where 절이 실행되는 시점에는 아직 min(delivery_fee) 값을 알 수 없음
SELECT id
FROM stores
WHERE delivery_fee = MIN(delivery_fee);

SELECT id FROM stores WHERE delivery_fee =(SELECT MIN(delivery_fee) FROM stores);
-- 2단계: 1단계 결과를 조합하여 해당 매장들의 인기 메뉴들 가져오기
SELECT stores.name, menus.name, stores.delivery_fee, menus.is_popular
FROM stores, menus
WHERE stores.id IN (SELECT id FROM stores WHERE delivery_fee =(SELECT MIN(delivery_fee) FROM stores))
AND  stores.id = menus.store_id
AND menus.is_popular=TRUE;

-- 문제 3: 평점이 가장 높은 매장들의 모든 메뉴들 조회
-- 1단계: 가장 높은 평점 매장 ID들 확인
SELECT MAX(rating) FROM stores;

SELECT id FROM stores WHERE rating =(SELECT MAX(rating) FROM stores);
-- 2단계: 1단계 결과를 조합하여 해당 매장들의 모든 메뉴들 가져오기
SELECT  *
FROM stores, menus
WHERE stores.id IN( SELECT id FROM stores WHERE rating =(SELECT MAX(rating) FROM stores))
AND  stores.id = menus.store_id;

-- 문제 4: 15000원 이상 메뉴가 없는 매장들 조회
-- 1단계: 15000원 이상 메뉴를 가진 매장 ID들 확인
SELECT DISTINCT(store_id) FROM menus WHERE  price >= 15000;

-- 2단계: 1단계 결과에 해당하지 않는 매장들 가져오기
SELECT id, name
FROM  stores
WHERE id NOT IN(SELECT DISTINCT(store_id) FROM menus WHERE  price >= 15000);

-- 문제 5: 메뉴 설명이 있는 메뉴를 파는 매장들 조회
-- 1단계: 메뉴 설명이 있는 메뉴를 가진 매장 ID들 확인
SELECT DISTINCT(store_id) FROM menus WHERE description is NOT NULL;
-- 2단계: 1단계 결과를 조합하여 해당 매장들 정보 가져오기
SELECT id, name
FROM  stores
WHERE id IN(SELECT DISTINCT(store_id) FROM menus WHERE description is NOT NULL);

-- 문제 6: 메뉴 설명이 없는 메뉴만 있는 매장들 조회
-- 1단계: 메뉴 설명이 있는 메뉴를 가진 매장 ID들 확인
SELECT DISTINCT(store_id) FROM menus WHERE description is NOT NULL;
-- 2단계: 1단계 결과에 해당하지 않는 매장들 가져오기 (단, 메뉴가 있는 매장만)
SELECT DISTINCT(stores.id), stores.name
FROM  stores, menus
WHERE stores.id NOT IN(SELECT DISTINCT(store_id) FROM menus WHERE description is NOT NULL)
AND  stores.id = menus.store_id;

-- 문제 7: 치킨 카테고리 매장들의 메뉴들 조회
-- 1단계: 치킨 카테고리 매장 ID들 확인
SELECT id FROM stores WHERE category='치킨';
-- 2단계: 1단계 결과를 조합하여 해당 매장들의 메뉴들 가져오기
SELECT stores.name, menus.name
FROM  stores, menus
WHERE stores.id IN(SELECT id FROM stores WHERE category='치킨')
AND  stores.id = menus.store_id;

-- 문제 8: 피자 매장이 아닌 곳의 메뉴들만 조회
-- 1단계: 피자 매장 ID들 확인
SELECT id FROM stores WHERE category='피자';
-- 2단계: 1단계 결과에 해당하지 않는 매장들의 메뉴들 가져오기
SELECT menus.name
FROM  stores, menus
WHERE stores.id NOT IN(SELECT id FROM stores WHERE category='피자')
AND  stores.id = menus.store_id;

-- 문제 9: 평균 가격보다 비싼 메뉴를 파는 매장들 조회
-- 1단계: 평균 가격보다 비싼 메뉴를 가진 매장 ID들 확인
SELECT AVG(price) FROM menus;

SELECT store_id FROM menus WHERE price >(SELECT AVG(price) FROM menus); 
-- 2단계: 1단계 결과를 조합하여 해당 매장들 정보 가져오기
SELECT DISTINCT(stores.name) 
FROM  stores, menus
WHERE stores.id IN(SELECT store_id FROM menus WHERE price >(SELECT AVG(price) FROM menus))
AND  stores.id = menus.store_id;

-- 문제 10: 가장 비싼 메뉴를 파는 매장들 조회
-- 1단계: 가장 비싼 메뉴를 가진 매장 ID들 확인
SELECT max(price) FROM menus;

SELECT store_id FROM menus WHERE price =(SELECT max(price) FROM menus);
-- 2단계: 1단계 결과를 조합하여 해당 매장과 메뉴 정보 가져오기
SELECT s.id, s.name, m.name, m.price
FROM menus m
JOIN stores s ON m.store_id = s.id
WHERE m.price = (SELECT MAX(price) FROM menus);


-- =============================================
-- ANY 연산자 - 하나라도 조건을 만족하면 참
-- 여러 값 중 하나라도 만족하면 TRUE
-- 치킨 카테고리에서 배달비가 어떤 기준보다 작으면 만족 어떤 기준보다 크면 만족 
-- =============================================
-- 치킨집 중 배댈비가 저렴한 매장들 확인
-- 1단계 : 치킨집들의 배달비 확인
SELECT delivery_fee
FROM stores
WHERE category ='치킨'
AND delivery_fee IS NOT NULL;

-- 2단계 : 배달비가 3000원 이하인 매장 조회
SELECT *
FROM stores
WHERE delivery_fee <= 3000
AND delivery_fee IS NOT NULL;

-- 3단계 ANY 로 조합하여 치킨 카테고리에서 배달비 중 최저값보다 작은 매장을 만족하는 가게들의 이름, 카테고리 배달비 조회
SELECT name, category, delivery_fee
FROM stores
WHERE delivery_fee < ANY(SELECT delivery_fee FROM stores
WHERE category ='치킨' AND delivery_fee IS NOT NULL)
AND delivery_fee IS NOT NULL
ORDER BY delivery_fee;

-- 한식집들 중 어떤 매장보다 평점이 높은 매장을 찾기
SELECT rating FROM stores WHERE category='한식' AND rating IS NOT NULL;
SELECT * FROM stores WHERE rating > 4.2 AND rating IS NOT NULL;
SELECT * FROM stores WHERE rating > ANY(SELECT rating FROM stores WHERE category='한식') 
AND rating IS NOT NULL
AND category NOT IN ('한식');

-- 일식집들의 어떤 매장보다 배달비가 낮은 매장을 찾기
SELECT delivery_fee FROM stores WHERE category='일식'AND delivery_fee IS NOT NULL;
SELECT * FROM stores WHERE delivery_fee < 4000 AND delivery_fee IS NOT NULL;
SELECT * FROM stores WHERE delivery_fee < ANY(SELECT delivery_fee FROM stores WHERE category='일식')  AND delivery_fee IS NOT NULL;

-- =============================================
--  ALL 연산자 - 모든 조건을 만족해야 함
-- =============================================



-- =============================================
--  EXISTS 연산자 - 존재하는 것을 찾기
-- =============================================

-- =============================================
--  NOT EXISTS 연산자 - 존재하지 않는 것을 찾기
-- =============================================


-- ===========================================
-- 3. 기본 서브쿼리 (단일행)
-- ===========================================


















