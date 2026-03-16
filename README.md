# 🍕 Pizza Sales Analytics & Data Warehousing

## 📌 Project Overview
An end-to-end Data Analytics and Warehousing pipeline designed to transform raw restaurant sales data into actionable business insights. This project processes over 21,000 orders (generating $817K+ in revenue) to optimize inventory management, understand customer behavior, and identify operational peak hours.

## 🛠️ Tech Stack & Tools
- **Data Extraction (ETL):** SQL Server Integration Services (SSIS)
- **Database & Data Modeling:** SQL Server (T-SQL)
- **Data Manipulation & Parsing:** Python (Pandas)
- **Data Visualization:** Power BI (DAX)

## 🏗️ Data Architecture & Workflow

### 1. Data Ingestion (SSIS)
- Extracted raw unstructured sales data from flat files.
- Built a reliable pipeline to load the data into a SQL Server database for further staging and processing.

### 2. Data Engineering & Modeling (SQL Server & Python)
- Designed a robust **Star Schema** to optimize query performance, separating the data into logical Fact and Dimension tables (`Fact_Sales`, `Dim_Pizza`, `Dim_Date`, `Dim_Time`).
- **Data Cleaning Challenge:** The raw dataset contained pizza ingredients as a single, comma-separated text string for each order. A custom **Python script** utilizing `Pandas` was engineered to parse these strings, calculate frequencies, and construct a relational bridge table (`Fact_Order_Ingredients` and `Dim_Ingredients`). This ensured strict data integrity and enabled deep-dive granular analysis.

### 3. Business Intelligence (Power BI)
- Connected Power BI directly to the SQL Server Data Warehouse.
- Developed a comprehensive 5-page interactive dashboard utilizing DAX measures to track KPIs, visualize trends, and answer critical operational questions.

## 📊 Key Business Insights
- **Operational Efficiency:** Friday is the busiest day, with a distinct peak hour at **12:00 PM**, providing clear data-driven guidance for staff scheduling and shift allocation.
- **Inventory Management:** **Garlic** is the most frequently consumed ingredient across the entire menu, serving as a vital metric for the supply chain team to prevent stockouts.
- **Consumer Preferences:** The **Large** size and **Classic** pizza category are the undeniable favorites, driving the majority of the 49,000+ total pizzas sold.

## 📂 Repository Structure
- `/SQL_Scripts` : Contains all T-SQL queries used for creating the Star Schema and tables.
- `/Python_Scripts` : Contains the Python script used for text parsing and building the ingredients bridge tables.
- `/PowerBI` : Contains the `.pbix` dashboard file.
- `/Dataset` : Contains the initial raw data files.

## 👨‍💻 Author
**Tariq**
*Senior Student, Faculty of Computers and Data Science - Alexandria University*
