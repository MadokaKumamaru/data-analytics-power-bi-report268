-- Question3: Which German store type had the highest revenue for 2022?
SELECT dim_store.store_type, 
       ROUND(SUM(orders.product_quantity * dim_product.sale_price)::numeric, 1) AS total_revenue
FROM orders INNER JOIN dim_product
ON orders.product_code = dim_product.product_code
INNER JOIN dim_store
ON orders.store_code = dim_store.store_code
WHERE dim_store.country_code = 'DE' AND EXTRACT(YEAR FROM orders.order_date::date) = 2022
GROUP BY dim_store.store_type
ORDER BY total_revenue DESC;