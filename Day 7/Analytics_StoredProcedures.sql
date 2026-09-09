-- ==========================================
-- 1. INDEX OPTIMIZATION FOR ANALYTICS & JOINS
-- ==========================================

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Orders_CustomerID')
	CREATE NONCLUSTERED INDEX IX_Orders_CustomerID ON Orders(customer_id);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_OrderItems_OrderID')
	CREATE NONCLUSTERED INDEX IX_OrderItems_OrderID ON Order_Items(order_id);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_OrderItems_ProductID')
    CREATE NONCLUSTERED INDEX IX_OrderItems_ProductID ON Order_Items(product_id);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_PriceAudit_ProductID')
    CREATE NONCLUSTERED INDEX IX_PriceAudit_ProductID ON Price_Audit_Log(product_id);
GO

-- ==========================================
-- 2. STORED PROCEDURES FOR MULTI ITEM ORDER
-- ==========================================

CREATE OR ALTER PROCEDURE sp_PlaceOrderHeader
	@CustomerID INT,
	@NewOrderID INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO ORDERS (customer_id, total_amount)
	VALUES (@CustomerID, 0.00)

	SET @NewOrderID = SCOPE_IDENTITY();
END;
GO

CREATE OR ALTER PROCEDURE sp_AddOrderItemAndDeductStock
	@OrderID INT,
	@ProductID INT,
	@Quantity INT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRANSACTION;

	BEGIN TRY
		DECLARE @UnitPrice DECIMAL(10,2);
		DECLARE @CurrentStock INT;

		SELECT @UnitPrice = current_price, @CurrentStock = stock_quantity
		FROM Products WHERE product_id = @ProductID;

		IF @CurrentStock < @Quantity
		BEGIN 
			RAISERROR('Insufficient stock quantity available.',16,1);
			ROLLBACK TRANSACTION;
			RETURN;
		END;

		INSERT INTO Order_Items (order_id, product_id, quantity, unit_price)
		VALUES (@OrderID, @ProductID, @Quantity, @UnitPrice);

		UPDATE Products
		SET stock_quantity = stock_quantity - @Quantity
		WHERE product_id = @ProductID

		UPDATE Orders
		SET total_amount = total_amount + (@Quantity*@UnitPrice)
		WHERE order_id = @OrderID;

		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END;
GO