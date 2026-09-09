# Project Fire: Business Intelligence & Automated Inventory System

Project Fire is an end-to-end relational database and automation framework built using SQL Server (T-SQL) and Python. It features transactional integrity, automated stock management, and real-time executive analytics reporting.

---

## Key Features

* Relational Schema Design: Built with primary and foreign key integrity across Customers, Products, Orders, and Order_Items tables.
* Transactional Stock Management: Custom stored procedures (`sp_AddOrderItemAndDeductStock`) enforce atomic order placement and prevent negative stock levels via guard clauses.
* Database Views for Analytics: Pre-built analytical views (`vw_Executive_KPIs`, `vw_Customer_LTV`, `vw_Product_Performance`) for zero-latency executive reporting.
* Python Simulation Engine: Python-driven order simulator using `pyodbc` to execute orders and monitor transactional output.
* Automated Executive Dashboard: Terminal-based BI report displaying gross revenue, average order value (AOV), top customer LTV, and product performance.

---

## Tech Stack & Prerequisites

* Database: Microsoft SQL Server
* Database Driver: ODBC Driver 18 for SQL Server
* Language: Python 3.10+
* Python Libraries: `pyodbc`

---

## Repository Structure

```text
├── database/
│   ├── schema_and_views.sql    # DDL for Tables, Indexes, and Analytics Views
│   └── stored_procedures.sql  # Stored Procedure for order execution and stock deduction
├── python/
│   ├── simulate_orders.py      # Order simulation engine using stored procedures
│   └── bi_dashboard.py         # Executive BI Analytics Dashboard
└── README.md
