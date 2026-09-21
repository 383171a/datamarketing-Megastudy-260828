# bestproducts > Gmarket에서 베스트 랭킹 상품을 크롤링 > sql DB 저장

DESC items; # item_code
DESC ranking; # item_code

SELECT * FROM items LIMIT 10;
SELECT COUNT(*) FROM ranking; # 11902등

SELECT *
FROM items I
JOIN ranking R ON R.item_code = I.item_code;

# 마케터 입장으로 생각해보자
# 내가 Gmarket 마케터 | MD야
# 쇼핑몰 매출이 나한테는 KPI
# 잘되고 잇는 것을 더 잘되게 하자!
# 11000등 이내에 최대한 많은 상품을 랭크 시켜놓은 업체(바이어)를 잘 관리해야하지 않을까?

# 100개 이상의 상품을 랭크시켜놓은 판매업체만 조회! 


# 1)100개 이상의 상품을 랭크시켜놓은 판매업메만 조회
SELECT provider FROM items;

# 전체 조회
SELECT 
	provider, 
	COUNT(*) provider_count 
FROM items 
GROUP BY provider;

# 100건 이상 등록한 업체
SELECT 
	provider, 
	COUNT(*) provider_count 
FROM items 
GROUP BY provider
HAVING provider_count >= 100;

# 내림차순
SELECT 
	provider, 
	COUNT(*) provider_count 
FROM items 
GROUP BY provider
HAVING provider_count >= 100
ORDER BY provider_count DESC;

# 빈문자(기타) 가 아닌것만 찾아와
SELECT 
	provider, 
	COUNT(*) provider_count 
FROM items 
WHERE provider != ""
GROUP BY provider
HAVING provider_count >= 100
ORDER BY provider_count DESC;


# WHERE 와 HAVING 교체
SELECT 
	provider, 
	COUNT(*) provider_count 
FROM items 
-- WHERE provider != ""
GROUP BY provider
HAVING provider_count >= 100 AND provider != ""
ORDER BY provider_count DESC;