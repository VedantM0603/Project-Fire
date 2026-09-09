import pyodbc
import random
import time
from datetime import datetime

# ==========================================
# 1. DATABASE CONNECTION CONFIGURATION
# ==========================================

SERVER_NAME = 'PLUTO'
DATABASE_NAME = 'Project Fire'

conn_str = (
    "DRIVER = {ODBC Driver 18 for SQL Server};"
    f"SERVER = {SERVER_NAME};"
    f"DATABASE = {DATABASE_NAME};"
    "Trusted_Connections=yes;"
    "TrustServerCertificate=yes;"
)

def connect_db():
    try:
        conn = pyodbc.connect(conn_str)
        print(f"[{datetime.now().strftime('%H:%M:%S')}] successfull connection to Database: {DATABASE_NAME}")
        return conn

    except Exception as e:
        print(f"Error connecting to the database: {e}")
        return None


# ==========================================
# 2. AUTO-RESTOCK TRIGGER
# ==========================================

def check_and_restock(cursor, product_id, current_stock, min_threshold=5, restock_qty=20):
    # Auto replenish stock when low and record in audit log.
    if current_stock < min_threshold:
        sql_restockproduct = """
            UPDATE Products SET stock_quantity = stock_quantity + ? WHERE product_id = ?"""
        cursor.execute(sql_restockproduct,restock_qty,product_id)

        sql_logstock = """
            INSERT INTO Inventory_Logs (product_id, action type, quantity_added)
            VALUES(?,?,?)"""
        cursor.execute(sql_logstock, product_id, "AUTO_RESTOCK", restock_qty)
        print(f"[RESTOCK ALERT] Product #{product_id} was low ({current_stock}). Auto replenished +{restock_qty} units.")


def generate_analytics(cursor):
    cursor.execute("""
        SELECT
            COUNT(order_id) AS Total_Orders,
            SUM(quantity) AS Total_Units_Sold,
            SUM(quantity * sold_at_price) AS Total Revenue
        FROM Orders
        """)
    summary = cursor.fetchone()

    cursor.execute("SELECT COUNT(*) FROM Price_Audit_Log")
    price_changes_count = cursor.fetchone()[0]

    print("\n"+ "="*45)
    print("SALES DASHBOARD")
    print("="*45)
    print(f" Total Orders Executed : {summary[0] or 0}")
    print(f" Total Units Sold      : {summary[1] or 0}")
    print(f"Total Gross Revenue   : ₹{summary[2] or 0.00:,.2f}")
    print(f" Total Price Audit Logs : {price_changes_count} changes recorded")
    print("="*45 +"\n")

def run_simulation(num_orders=20):
    conn = connect_db
    if not conn:
        return

    cursor = conn.cursor()
    print(f"[{datetime.now().strftime('%H:%M:%S')}] Started Day 3 Engine for {DATABASE_NAME}...\n")

    for i in range(1, num_orders+1):
        cursor.execute("SELECT product_id, current_price, stock_quantity FROM Products WHERE stock_quantity > 0")
        active_products = cursor.fetchall()

        if not active_products:
            print("No active prodcuts available!")
            break

        product_id, current_price, stock_qty = random.choice(active_products)
        order_qty = random.randint(1, min(3,stock_qty))

        try:
            sql_addinorder= """
                INSERT INTO Orders (product_id, quantity, curent_price, sold_at_price))
                VALUES(?,?,?,?)"""
            cursor.execute(sql_addinorder, (product_id, order_qty, current_price, current_price))

            sql_updatestock= """
                UPDATE Products SET stock_quantity = ? WHERE product_id = ?"""
            cursor.execute(sql_updatestock, stock_qty-order_qty, product_id)

            check_and_restock(cursor, product_id, stock_qty-order_qty)

            conn.commit()
            print(f"[{datetime.now().strftime('%H:%M:%S')}] Order #{i}: Purchased {order_qty}x (Product ID: {product_id}) @ ₹{current_price} each. | Remaining Stock: {stock_qty-order_qty}")

        except Exception as e:
            conn.rollback()
            print(f"Order #{i} Failed : {e}")

        time.sleep(1)

    generate_analytics(cursor)

    cursor.close()
    conn.close()

if __name__=="__main__":
    run_simulation(num_orders=10)