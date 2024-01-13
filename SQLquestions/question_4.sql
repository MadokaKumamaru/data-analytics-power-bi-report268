/* Create a view where the rows are the store types and the columns are the total sales, 
percentage of total sales and the count of orders */
CREATE VIEW store_type_summary AS
SELECT store_type, ROUND(SUM(orders.product_quantity * dim_product.sale_price)::numeric, 1)
       AS total_sales,
       COUNT(*) / (SELECT COUNT(*) FROM orders) AS percentage_total_sales,
       COUNT(*) AS count_of_orders
FROM orders
INNER JOIN dim_product
ON orders.product_code = dim_product.product_code
INNER JOIN dim_store
ON orders.store_code = dim_store.store_code
GROUP BY store_type;