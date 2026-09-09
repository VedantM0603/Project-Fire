CREATE OR ALTER VIEW vw_Product_Price_Analytics AS
SELECT
	T0.product_id,
	T0.current_price AS latest_price,
	T0.stock_quantity AS remaining_stock,
	COUNT(T1.log_id) AS total_price_adjustment,
	MIN(T1.old_price) AS lowest_historical_price,
	MAX(T1.new_price) AS highest_historical_price
FROM Products T0
LEFT JOIN Price_Audit_Log T1 ON T0.product_id = T1.product_id
GROUP BY T0.product_id, T0.current_price, T0.stock_quantity;
GO