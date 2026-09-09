CREATE TABLE Inventory_Logs (
	log_id INT IDENTITY(1,1) PRIMARY KEY,
	product_id INT NOT NULL,
	action_type VARCHAR(50) NOT NULL,
	quantity_added INT NOT NULL,
	created_at DATETIME DEFAULT GETDATE()
	);