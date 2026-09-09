-- 1. PRODUCTS Table
-- Holds dark-store inventory, current pricing, and threshold caps
CREATE TABLE Products (
	product_id INT PRIMARY KEY IDENTITY(1,1),
	product_name VARCHAR(100) NOT NULL,
	category VARCHAR(50) NOT NULL,
	base_price DECIMAL(10,2) NOT NULL,
	current_price DECIMAL(10,2) NOT NULL,
	stock_quantity INT NOT NULL CHECK (stock_quantity >= 0),
	min_stock_threshold INT NOT NULL DEFAULT 10,
	created_at DATETIME DEFAULT GETDATE()
	);
GO

-- 2. ORDERS Table
-- Records incoming customer transactions
CREATE TABLE Orders (
	order_id INT PRIMARY KEY IDENTITY(1,1),
	product_id INT NOT NULL,
	quantity INT NOT NULL CHECK (quantity > 0),
	current_price DECIMAL(10,2) NOT NULL,
	sold_at_price DECIMAL(10,2) NOT NULL,
	order_timestamp DATETIME DEFAULT GETDATE(),
	FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE
	);
GO

-- PRICE AUDIT LOG Table
-- Captures automated surge/discount mutations for financial compliance
CREATE TABLE Price_Audit_Log (
	log_id INT PRIMARY KEY IDENTITY(1,1),
	product_id INT NOT NULL,
	old_price DECIMAL(10,2) NOT NULL,
	new_price DECIMAL(10,2) NOT NULL,
	change_reason VARCHAR(255) NOT NULL,
	changed_at DATETIME DEFAULT	GETDATE(),
	FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE
	);
GO