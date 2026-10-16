SELECT * FROM payment LIMIT 5; # rental_id
SELECT * FROM rental LIMIT 5; # rental_id, inventory_id
SELECT * FROM inventory LIMIT 5; # inventory_id, film_id
SELECT * FROM film_category LIMIT 5; # film_id, category_id
SELECT * FROM category LIMIT 5; # category_id

# 장르별 영화 수익이 얼만큼 났을까?
WITH genre_revenue AS (
	SELECT
		C.name genre, 
		SUM(amount) revenue
    FROM payment P 
    JOIN rental R ON R.rental_id = P.rental_id
    JOIN inventory I ON I.inventory_id = R.inventory_id
    JOIN film_category FC ON FC.film_id = I.film_id
    JOIN category C ON C.category_id = FC.category_id
    GROUP BY genre
)

-- SELECT 
-- 	genre,
--     revenue,
--     SUM(revenue) over (PARTITION BY genre ORDER BY revenue DESC
-- 						ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) cumulative_revenue
-- FROM genre_revenue
-- ORDER BY revenue DESC;
# 이렇게 해도 되 동일 파티션이 없어서 똑같음 어차피 같은 장르로 묶여잇어서
SELECT 
	genre,
    revenue,
    SUM(revenue) over (ORDER BY revenue DESC
						ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) cumulative_revenue,
	revenue / SUM(revenue) OVER () revenue_ratio
FROM genre_revenue
ORDER BY revenue DESC;
