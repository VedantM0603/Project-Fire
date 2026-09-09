import pyodbc
import random
import time
from datetime import datetime

# ==========================================
# 1. DATABASE CONNECTION CONFIGURATION
# ==========================================

SERVER_NAME = 'PLUTO'
DATABASE_NAME = 'Project Fire'

# Connection string using Windows Authentication 
conn_str = (
    "DRIVER={ODBC Driver 18 for SQL Server};"
    f"SERVER={SERVER_NAME};"
    f"DATABASE={DATABASE_NAME};"
    "Trusted_Connection=yes;"
    "TrustServerCertificate=yes;"
)

def connect_db():
    try:
        conn = pyodbc.connect(conn_str)
        print(f"[{datetime.now().strftime('%H:%M:%S')}] successfull connected to SSMS database: {DATABASE_NAME}")
        return conn
    except Exception as e:
        print(f"Error connecting to database: {e}")
        return None
    

# ==========================================
# 2. ORDER SIMULATION ENGINE
# ==========================================
def run_order_simulation(num_orders = 20, delay_seconds = 1):
    conn = connect_db()
    if not conn:
        return

    cursor = conn.cursor()

    # Fetch all the existing records that are active
    cursor.execute("SELECT product_id, current_price, stock_quantity FROM Products WHERE stock_quantity > 0")
    active_products = cursor.fetchall()

    if not active_products:
        print("No active products available in database!")
        return

    for i in range(1, num_orders+1):
        # Picking a random product from the available inventory
        product_id, current_price, stock_quantity = random.choice(active_products)

        #Order quantity between 1 and 3 items
        order_qty = random.randint(1, min(3,stock_quantity))

        try:
            # Pass product_id, quantity, current_price, and sold_at_price
            insert_order_sql = """
                INSERT INTO Orders (product_id, quantity, current_price, sold_at_price)
                VALUES (?, ?, ?, ?)
            """
            cursor.execute(insert_order_sql, (product_id, order_qty, current_price, current_price))

            # Reduce stock in the Products table
            update_stock_sql = """
                UPDATE Products
                SET stock_quantity = stock_quantity - ?
                WHERE product_id = ?
            """
            cursor.execute(update_stock_sql, (order_qty, product_id))

            # Commit transaction
            conn.commit()
            print(f"[{datetime.now().strftime('%H:%M:%S')}] Order #{i}: Purchased {order_qty}x (Product ID: {product_id}) @ ₹{current_price} each.")

        except Exception as e:
            conn.rollback()
            print(f"Order #{i} failed! Transaction rolled back. Reason: {e}")

        # Pausing the execution to show real-time arrival
        time.sleep(delay_seconds)

    # Cleaning up
    cursor.close()
    conn.close()
    print("\n--- Simulation Complete. Connections closed cleanly. ---")

# ==========================================y
# 3. EXECUTION ENTRY POINT
# ==========================================

if __name__ == "__main__":
    # Simulates 15 orders arriving 1 second apart
    run_order_simulation(num_orders=15, delay_seconds=1)

    