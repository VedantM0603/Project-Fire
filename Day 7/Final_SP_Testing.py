import pyodbc
import random
import time
from datetime import datetime

SERVER_NAME = 'PLUTO'
DATABASE_NAME = 'Project Fire'

conn_str = (
    "DRIVER={ODBC Driver 18 for SQL Server};"
    f"SERVER={SERVER_NAME};"
    f"DATABASE={DATABASE_NAME};"
    "Trusted_Connection=yes;"
    "TrustServerCertificate=yes;"
)

def stored_procedure_simulation(num_order=200):
    try:
        conn = pyodbc.connect(conn_str)
        cursor = conn.cursor()
        print(f"[{datetime.now().strftime('%H:%M:%S')}] Connected to {DATABASE_NAME} - Running Stored Procedure Engine...\n")

        cursor.execute("SELECT customer_id FROM Customers")
        customer_ids = [row[0] for row in cursor.fetchall()]

        cursor.execute("SELECT product_id, stock_quantity FROM Products WHERE stock_quantity > 0")
        active_products = cursor.fetchall()

        if not customer_ids or not active_products:
            print("Missing customer or product data!")
            return

        for i in range(1,num_order+1):
            customer_id = random.choice(customer_ids)

            cursor.execute("""
                DECLARE @OrderID INT;
                EXEC sp_PlaceOrderHeader @CustomerID = ?, @NewOrderID = @OrderID OUTPUT;
                SELECT @OrderID;
                """,(customer_id,))

            order_id = cursor.fetchone()[0]

            cart_items = random.sample(active_products, min(2, len(active_products)))

            for product_id, stock_qty in cart_items:
                if stock_qty > 0:
                    buy_qty = random.randint(1, min(2, stock_qty))
                    cursor.execute("EXEC sp_AddOrderItemAndDeductStock @OrderID = ?, @ProductID = ?, @Quantity = ?",
                                   (order_id, product_id, buy_qty))

            conn.commit()

            cursor.execute("SELECT total_amount FROM Orders WHERE order_id = ?", (order_id,))
            total_amt = cursor.fetchone()[0]

            print(f"[{datetime.now().strftime('%H:%M:%S')}] Stored Proc Executed -> Order #{order_id} created for Customer #{customer_id} | Total: ₹{total_amt:,.2f}")
            time.sleep(1)

        cursor.close()
        conn.close()
        print("\n---Simulation Complete. All Stored Procedures Executed Successfully. ---")

    except Exception as e:
        print(f"Error executing : {e}")

if __name__=="__main__":
    stored_procedure_simulation(num_order=200)