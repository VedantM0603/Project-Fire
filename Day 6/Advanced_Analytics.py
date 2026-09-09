import pyodbc
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

def get_executive_kpi(cursor):
    cursor.execute("SELECT * FROM vw_Executive_KPIs")
    kpi = cursor.fetchone()

    print("\n" + "=" * 50)
    print("EXECUTIVE KPI DASHBOARD")
    print("=" * 50)
    if kpi and kpi[0] is not None:
        print(f"    Total Orders Placed     : {kpi[0]}") 
        print(f"    Unique Active Buyers    : {kpi[1]}") 
        print(f"    Total Units Sold        : {kpi[2]}") 
        print(f"    Total Gross Revenue     : ₹{kpi[3]:,.2f}") 
        print(f"    Overall Avg Order Value : ₹{kpi[4]:,.2f}")
    else:
        print("No Sales Data recorded yet.")
    print("=" * 50 + "\n")

def get_top_customer(cursor, top_n=5):
    cursor.execute(f"""
        SELECT TOP {top_n} full_name, total_orders, total_lifetime_spend, avg_order_value
        FROM vw_Customer_Value
        ORDER BY total_lifetime_spend DESC
    """)
    customers = cursor.fetchall() 

    print(f"TOP {top_n} CUSTOMERS BY LIFETIME SPEND (LTV)")
    print("-" * 55)
    print(f"{'Customer Name':<20} | {'Orders':<7} | {'Total Spend':<12} | {'AOV':<10}")
    print("-" * 55)
    for c in customers:
        print(f"{c[0]:<20} | {c[1]:<7} | ₹{c[2]:<10,.2f} | ₹{c[3]:<8,.2f}")
    print("-" * 55 + "\n")

def get_product_performance(cursor):
    cursor.execute("""
        SELECT product_id, stock_quantity, total_units_sold, total_gross_revenue
        FROM vw_Product_Performance
        ORDER BY total_gross_revenue DESC
    """)
    products = cursor.fetchall()

    print("PRODUCT PERFORMANCE SUMMARY")
    print("-" * 55)
    print(f"{'Product ID':<10} | {'Stock':<6} | {'Units Sold':<10} | {'Gross Revenue':<12}")
    print("-" * 55)
    for p in products:
        print(f"{p[0]:<10} | {p[1]:<6} | {p[2]:<10} | ₹{p[3]:<12,.2f}")
    print("-" * 55 + "\n")

def get_analytics():
    try:
        conn = pyodbc.connect(conn_str)
        cursor = conn.cursor()
        print(f"[{datetime.now().strftime('%H:%M:%S')}] Connected to {DATABASE_NAME} for Business Intelligence Report...\n")

        get_executive_kpi(cursor)
        get_top_customer(cursor, top_n=5)
        get_product_performance(cursor)

        cursor.close()
        conn.close()
    except Exception as e:
        print(f"Error executing the analytics: {e}")

if __name__ == "__main__":
    get_analytics()