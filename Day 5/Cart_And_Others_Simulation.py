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
    "DRIVER={ODBC Driver 18 for SQL Server};"
    f"SERVER={SERVER_NAME};"
    f"DATABASE={DATABASE_NAME};"
    "Trusted_Connection=yes;"
    "TrustServerCertificate=yes;"
)

def connect_db():
    try:
        conn = pyodbc.connect(conn_str)
        print(f"[{datetime.now().strftime('%H:%M:%S')}] Successfully connected to Database: {DATABASE_NAME}")
        return conn

    except Exception as e:
        print(f"Error connecting to the database: {e}")
        return None


# ==========================================
# 2. AUTO-RESTOCK TRIGGER
# ==========================================

def check_and_restock(cursor, product_id, current_stock, min_threshold=5, restock_qty=20):
    if current_stock < min_threshold:
        sql_restockproduct = """
            UPDATE Products SET stock_quantity = stock_quantity + ? WHERE product_id = ?"""
        cursor.execute(sql_restockproduct, (restock_qty, product_id))

        sql_logstock = """
            INSERT INTO Inventory_Logs (product_id, action_type, quantity_added)
            VALUES(?,?,?)"""
        cursor.execute(sql_logstock, (product_id, "AUTO_RESTOCK", restock_qty))
        print(f"[RESTOCK ALERT] Product #{product_id} was low ({current_stock}). Auto replenished +{restock_qty} units.")


def generate_analytics(cursor):
    cursor.execute("""
        SELECT
            COUNT(DISTINCT o.order_id) AS Total_Orders,
            ISNULL(SUM(oi.quantity), 0) AS Total_Units_Sold,
            ISNULL(SUM(o.total_amount), 0.00) AS Total_Revenue
        FROM Orders o
        LEFT JOIN Order_Items oi ON o.order_id = oi.order_id
    """)
    summary = cursor.fetchone()

    cursor.execute("SELECT COUNT(*) FROM Price_Audit_Log")
    price_changes_count = cursor.fetchone()[0]

    print("\n" + "="*45)
    print("SALES DASHBOARD")
    print("="*45)
    print(f" Total Orders Executed   : {summary[0] or 0}")
    print(f" Total Units Sold       : {summary[1] or 0}")
    print(f" Total Gross Revenue    : ₹{summary[2] or 0.00:,.2f}")
    print(f" Total Price Audit Logs : {price_changes_count} changes recorded")
    print("="*45 + "\n")

# ==========================================
# 3. DYNAMIC PRICING & LOGGING
# ==========================================

def dynamic_pricing(cursor, product_id, current_price, current_stock):
    new_price = current_price
    reason = None

    if current_stock <= 6:
        new_price = round(float(current_price) * 1.15, 2)
        reason = 'HIGH_DEMAND_SURGE'

    elif current_stock >= 35:
        new_price = round(float(current_price) * 0.90, 2)
        reason = 'OVERSTOCK_CLEARANCE'

    if reason and new_price != current_price:
        cursor.execute("""
            UPDATE Products SET current_price = ? WHERE product_id = ?""",
            (new_price, product_id))

        cursor.execute("""
            INSERT INTO Price_Audit_Log (product_id, old_price, new_price, change_reason)
            VALUES(?,?,?,?)""",
            (product_id, current_price, new_price, reason))

        print(f"[{reason}] Product #{product_id}: ₹{current_price} -> ₹{new_price}")
        return new_price
    return current_price

# ==========================================
# 4. MULTI-ITEM ORDER ENGINE
# ==========================================

def run_simulation(num_orders=500):
    conn = connect_db()
    if not conn:
        return

    cursor = conn.cursor()
    print(f"[{datetime.now().strftime('%H:%M:%S')}] Started Engine for {DATABASE_NAME}...\n")

    cursor.execute("SELECT customer_id, full_name FROM Customers")
    customers = cursor.fetchall()

    if not customers:
        print("No customers found in database!")
        conn.close()
        return

    for i in range(1, num_orders + 1):
        customer_id, customer_name = random.choice(customers)

        cursor.execute("SELECT product_id, current_price, stock_quantity FROM Products WHERE stock_quantity > 0")
        active_products = cursor.fetchall()

        if not active_products:
            print("No active products available!")
            break

        cart_size = random.randint(1, min(3, len(active_products)))
        cart_items = random.sample(active_products, cart_size)

        try:
            cursor.execute(
                "INSERT INTO Orders (customer_id, total_amount) OUTPUT INSERTED.order_id VALUES (?, ?)",
                (customer_id, 0.00)
            )
            order_id = cursor.fetchone()[0]

            total_order_amount = 0.0

            for p_id, curr_price, stock_qty in cart_items:
                item_qty = random.randint(1, min(3, stock_qty))
                rem_stock = stock_qty - item_qty

                active_price = dynamic_pricing(cursor, p_id, curr_price, rem_stock)
                line_total = round(float(active_price) * item_qty, 2)
                total_order_amount += line_total

                cursor.execute("""
                    INSERT INTO Order_Items (order_id, product_id, quantity, unit_price)
                    VALUES (?, ?, ?, ?)
                """, (order_id, p_id, item_qty, active_price))

                cursor.execute("UPDATE Products SET stock_quantity = ? WHERE product_id = ?", (rem_stock, p_id))

                check_and_restock(cursor, p_id, rem_stock)

            cursor.execute("UPDATE Orders SET total_amount = ? WHERE order_id = ?", (total_order_amount, order_id))

            conn.commit()
            print(f"[{datetime.now().strftime('%H:%M:%S')}] Order #{order_id} placed by {customer_name}: {cart_size} item(s) | Total: ₹{total_order_amount:,.2f}")


        except Exception as e:
            conn.rollback()
            print(f"Order #{i} Failed : {e}")

        time.sleep(1)

    generate_analytics(cursor)

    cursor.close()
    conn.close()

if __name__ == "__main__":
    run_simulation(num_orders=500)