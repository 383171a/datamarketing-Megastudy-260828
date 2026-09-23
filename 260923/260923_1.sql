USE bestproducts; 

SHOW TABLES;

DESC items;
-- item_code, title, ori_price, dis_price, discount_percent , provider

DESC ranking; # 5개 컬럼
-- num, main_category, sub_category, item_ranking, item_code # 이름이 같지만 JOIN 하지 못할 수도 // 이름이 같은건 사람이 식별하기 쉽게만 하는거 // 이름이 달라도 JOIN가능

SELECT item_code FROM items LIMIT 5;
SELECT item_code FROM ranking LIMIT 5; -- 비슷하다는 결론 

SELECT title
FROM items I
INNER JOIN ranking R ON R.item_code = I.item_code
WHERE R.main_category = "ALL";

-- SELECT *
-- FROM items I
-- INNER JOIN ranking R USING(item_code); # 이렇기 때문에 이름을 같게 해놓는게 좋아

SELECT 
	I.provider,# item 안에 있어서 I를 씀 만약 둘다(ranking/item) 있을 경우 에러남
    COUNT(*) provider_count
FROM items I
INNER JOIN ranking R ON R.item_code = I.item_code
WHERE R.main_category = "ALL"
GROUP BY I.provider
ORDER BY provider_count DESC
LIMIT 5; 

# 메인 카테고리가 "패션의류"인 판매자 중 판매하고 있는 상품 갯수가 5개 이상인 판매자만 조회. 단 상위 5위 안에 판매자만 조회
SELECT 
	I.provider,
    COUNT(*) provider_count
FROM items I
INNER JOIN ranking R ON R.item_code = I.item_code
WHERE R.main_category = "패션의류"
GROUP BY I.provider
HAVING provider_count >= 5
ORDER BY provider_count DESC
LIMIT 5; 

 # 메인카테고리가 "화장품/헤어"인 조건 하에 조회된 데이터 중 최대 할인 가격, 최소 할인 가격, 평균 할인 가격만 조회
 # AVG(), MAX(), MIN(), dis_price 
 # 위 값을 조회할 때, 소수점 2번째 자리까지만 조회할 수 있도록 ROUND()
 

 SELECT 
	ROUND(AVG(dis_price), 2),
    MAX(dis_price), 
	MIN(dis_price)
FROM items I
INNER JOIN ranking R ON R.item_code = I.item_code
WHERE R.main_category = "화장품/헤어";


USE sakila;

SHOW TABLES; # customer, address 
SELECT * FROM customer LIMIT 5;
SELECT * FROM address LIMIT 5;

SELECT *
FROM customer C
LEFT OUTER JOIN address A
ON C.address_id = A.address_id
WHERE A.district IS NULL;

SELECT *
FROM customer C
RIGHT OUTER JOIN address A
ON C.address_id = A.address_id
WHERE A.customer_id IS NULL;
# customer > address 
# 미용실일 경우 매장에서 회원가입할 때 필수와 비필수 값이 존재하므로 -> crm 마케팅할 때 필요














