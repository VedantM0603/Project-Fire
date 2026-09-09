CREATE OR ALTER VIEW vw_Customer_Value AS
SELECT 
	T0.customer_id,
	T0.full_name,
	T0.email,
	COUNT(DISTINCT T1.order_id) AS total_orders,
	ISNULL(SUM(T1.total_amount),0.00) total_lifetime_spend,
	ISNULL(AVG(T1.total_amount),0.00) AS avg_order_value,
	MAX(T1.order_date) AS last_order_date
FROM Customers T0
LEFT JOIN Orders T1 ON T0.customer_id = T1.customer_id
GROUP BY T0.customer_id, T0.full_name, T0.email;
GO

CREATE OR ALTER VIEW vw_Product_Performance AS
SELECT
	T0.product_id,
	T0.current_price,
	T0.stock_quantity,
	ISNULL(SUM(T1.quantity),0) AS total_units_sold,
	ISNULL(SUM(T1.quantity*T1.unit_price),0.00) AS total_gross_revenue
FROM Products T0
LEFT JOIN Order_Items T1 ON T0.product_id = T1.product_id
GROUP BY T0.product_id, T0.current_price, T0.stock_quantity;
GO

CREATE OR ALTER VIEW vw_Executive_KPIs AS
SELECT
	COUNT(DISTINCT T0.order_id) AS total_orders_placed,
	COUNT(DISTINCT T0.customer_id) AS unique_active_buyers,
	SUM(T1.quantity) AS total_items_sold,
	SUM(T0.total_amount) AS total_gross_revenue,
	AVG(T0.total_amount) AS overall_avg_order_value
FROM Orders T0
INNER JOIN Order_Items T1 ON T0.order_id = T1.order_id;
GO