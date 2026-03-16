/* Project: Pizza Sales Data Warehouse
   Goal: Transforming Raw Data into a Star Schema for optimized Power BI reporting.
*/

USE PizzaSalesDB;
GO

-----------------------------------------------------------------------
-- 1. Create Pizza Dimension (Dim_Pizza)
-- Purpose: Storing unique pizza configurations (Name, Category, Size).
-----------------------------------------------------------------------
-- Note: You already ran this with IDENTITY(1,1), which provides a unique Surrogate Key.
CREATE TABLE Dim_Pizza (
    Pizza_ID_PK INT IDENTITY(1,1) PRIMARY KEY, 
	pizza_id NVARCHAR(50),
    pizza_name NVARCHAR(255),
    pizza_category NVARCHAR(255),
    pizza_size NVARCHAR(50)
);

INSERT INTO Dim_Pizza (pizza_id, pizza_name, pizza_category, pizza_size)
SELECT DISTINCT 
	pizza_id,
    pizza_name, 
    pizza_category, 
    pizza_size
FROM [Pizza_Sales_Data];


-----------------------------------------------------------------------
-- 2. Create Date Dimension (Dim_Date)
-- Purpose: Enabling Time-series analysis (Yearly, Monthly, Weekly trends).
-----------------------------------------------------------------------
SELECT DISTINCT 
    order_date,
    DATEPART(YEAR, order_date) AS OrderYear,
    DATEPART(MONTH, order_date) AS OrderMonth,
    DATENAME(MONTH, order_date) AS MonthName,
    DATENAME(WEEKDAY, order_date) AS DayName
INTO Dim_Date
FROM [Pizza_Sales_Data];

-- Defining the Primary Key for Date Relationship
ALTER TABLE Dim_Date ALTER COLUMN order_date DATE NOT NULL;
ALTER TABLE Dim_Date ADD CONSTRAINT PK_Dim_Date PRIMARY KEY (order_date);

-----------------------------------------------------------------------
-- 3. Create Time Dimension (Dim_Time)
-- Purpose: Analyzing Peak Hours and categorizing sales into shifts (Lunch, Dinner, etc.).
-----------------------------------------------------------------------
SELECT DISTINCT 
    order_time,
    DATEPART(HOUR, order_time) AS [Hour],
    CASE 
        WHEN DATEPART(HOUR, order_time) BETWEEN 11 AND 15 THEN 'Lunch'
        WHEN DATEPART(HOUR, order_time) BETWEEN 16 AND 20 THEN 'Afternoon'
        WHEN DATEPART(HOUR, order_time) BETWEEN 21 AND 23 THEN 'Dinner'
        ELSE 'Late Night'
    END AS [Time_Of_Day]
INTO Dim_Time
FROM [Pizza_Sales_Data];

-- Defining the Primary Key for Time Relationship
ALTER TABLE Dim_Time ALTER COLUMN order_time TIME NOT NULL;
ALTER TABLE Dim_Time ADD CONSTRAINT PK_Dim_Time PRIMARY KEY (order_time);

-----------------------------------------------------------------------
-- 4. Create Fact Table (Fact_Sales)
-- Purpose: Centralizing numerical metrics (Quantity, Price) and Foreign Keys.
-----------------------------------------------------------------------
SELECT 
    order_details_id,
    order_id,
    pizza_id,        -- Links to Dim_Pizza
    quantity,
    order_date,      -- Links to Dim_Date
    order_time,      -- Links to Dim_Time
    unit_price,
    total_price
INTO Fact_Sales
FROM [Pizza_Sales_Data];

-- Defining the Primary Key for Fact Table (Granular Level: Order Detail)
ALTER TABLE Fact_Sales ALTER COLUMN order_details_id INT NOT NULL;
ALTER TABLE Fact_Sales ADD CONSTRAINT PK_Fact_Sales PRIMARY KEY (order_details_id);