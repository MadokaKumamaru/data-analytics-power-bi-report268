-- Question 2: Which month in 2022 has had the highest revenue?
SELECT EXTRACT(MONTH FROM orders.order_date::date) AS month,
       ROUND(SUM(orders.product_quantity*dim_product.sale_price)::numeric, 1) AS monthly_revenue
FROM orders
JOIN dim_product on dim_product.product_code = orders.product_code
WHERE EXTRACT(YEAR FROM orders.order_date::date) = 2022
GROUP BY EXTRACT(MONTH FROM orders.order_date::date)
ORDER BY monthly_revenue DESC;