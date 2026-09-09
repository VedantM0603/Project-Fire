CREATE TABLE Customers(
	customer_id INT IDENTITY(1,1) PRIMARY KEY,
	full_name VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL,
	created_at DATETIME DEFAULT GETDATE()
	);

IF OBJECT_ID('Order_Items', 'U') IS NOT NULL DROP TABLE Order_Items;
IF OBJECT_ID('Orders', 'U') IS NOT NULL DROP TABLE Orders;

CREATE TABLE Orders (
	order_id INT IDENTITY(1001,1) PRIMARY KEY,
	customer_id INT NOT NULL FOREIGN KEY REFERENCES Customers(customer_id),
	total_amount DECIMAL(10,2) NOT NULL DEFAULT 0.00,
	order_date DATETIME DEFAULT GETDATE()
	);

CREATE TABLE Order_Items (
	order_item_id INT IDENTITY(1,1) PRIMARY KEY,
	order_id INT NOT NULL FOREIGN KEY REFERENCES Orders(order_id) ON DELETE CASCADE,
	product_id INT NOT NULL FOREIGN KEY REFERENCES Products(product_id),
	quantity INT NOT NULL,
	unit_price DECIMAL(10,2) NOT NULL
	);