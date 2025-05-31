create database Intern;
use intern;

ALTER TABLE e_commerce ADD COLUMN InvoiceDate_new DATETIME;
UPDATE e_commerce
SET InvoiceDate_new = STR_TO_DATE(InvoiceDate, '%m/%d/%Y %H:%i');
SELECT InvoiceDate, InvoiceDate_new FROM e_commerce LIMIT 10;
ALTER TABLE e_commerce DROP COLUMN InvoiceDate;
ALTER TABLE e_commerce CHANGE COLUMN InvoiceDate_new InvoiceDate DATETIME;

SELECT COUNT(*) FROM e_commerce;
-- total revenue
SELECT SUM(Quantity*Unitprice) as Total_revenue from e_commerce;
-- total item sold
select sum(Quantity) as TotalItesold from e_commerce;
--  Average Order Value
SELECT AVG(InvoiceTotal) AS AvgOrderValue
FROM (
    SELECT InvoiceNo, SUM(Quantity * UnitPrice) AS InvoiceTotal
    FROM e_commerce
    GROUP BY InvoiceNo
) AS Subquery;
-- top 10 customer
select CustomerID , sum(Quantity*UnitPrice) as TotalSpend from e_commerce 
group by CustomerID order by TotalSpend limit 10;
-- top selling product
select Description , sum(Quantity) as TotalSold from e_commerce 
group by Description order by TotalSold desc limit 10;
select Description , sum(Quantity*UnitPrice) as Revenue from e_commerce 
group by Description order by Revenue desc limit 10;
-- sales by country
select Country , SUM(Quantity*Unitprice) as revenue from e_commerce 
group by Country order by revenue desc;

-- Daily Sales Trend 
SELECT DATE(InvoiceDate) AS Date, 
       SUM(Quantity * UnitPrice) AS DailySales
FROM e_commerce GROUP BY Date ORDER BY Date;

-- Monthly Sales Trend
SELECT DATE_FORMAT(InvoiceDate, '%Y-%m') AS Month, 
       SUM(Quantity * UnitPrice) AS MonthlySales
FROM e_commerce GROUP BY Month ORDER BY Month;

-- Hourly Sales 
SELECT HOUR(InvoiceDate) AS Hour, 
       SUM(Quantity * UnitPrice) AS HourlySales
FROM e_commerce GROUP BY Hour ORDER BY Hour;


-- Revenue per Invoice
SELECT InvoiceNo, SUM(Quantity * UnitPrice) AS InvoiceTotal
FROM e_commerce GROUP BY InvoiceNo ORDER BY InvoiceTotal DESC;
-- Items per Invoice
SELECT InvoiceNo, SUM(Quantity) AS ItemsPerInvoice
FROM e_commerce GROUP BY InvoiceNo;
-- Repeat Customers
SELECT CustomerID, COUNT(DISTINCT InvoiceNo) AS NumberOfOrders
FROM e_commerce
GROUP BY CustomerID
HAVING NumberOfOrders > 1
ORDER BY NumberOfOrders DESC;
-- Frequently Purchased Items
SELECT Description, COUNT(*) AS PurchaseCount
FROM e_commerce
GROUP BY Description
ORDER BY PurchaseCount DESC
LIMIT 10;


-- High-Spending Customers
SELECT 
    CASE 
        WHEN OrderCount = 1 THEN 'One-time'
        ELSE 'Repeat'
    END AS CustomerType,
    COUNT(*) AS NumCustomers
FROM (
    SELECT CustomerID, COUNT(DISTINCT InvoiceNo) AS OrderCount
    FROM e_commerce
    GROUP BY CustomerID
) AS Subquery
GROUP BY CustomerType;



