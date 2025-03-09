USE AdventureWorksDW2020

-----------------------------------------------------------------------------------
--Q1. Query 1: Total Sales by Product
SELECT EnglishProductName, SUM(OrderQuantity*UnitPrice) AS Total_Sales
FROM FactResellerSales Sales
JOIN DimProduct        Products
ON Sales.ProductKey = Products.ProductKey
GROUP BY EnglishProductName
ORDER BY Total_Sales DESC
------------------------------------------------------------------------------------
--Query 2: Total Sales by Customer
-------------------------------------------------------------------------------------
SELECT TOP(3)
c.FirstName + ' ' + c.LastName AS CustomerName,
SUM(soh.SalesAmount) AS TotalSales
FROM
FactInternetSales AS soh
JOIN
DimCustomer AS c
ON soh.CustomerKey = c.CustomerKey
GROUP BY
c.FirstName, c.LastName
ORDER BY
TotalSales DESC;

SELECT TOP(3)
    dc.FirstName + ' ' + dc.LastName AS CustomerName,
    SUM(fis.SalesAmount) AS TotalSales
FROM FactInternetSales fis
JOIN DimCustomer dc 
ON fis.CustomerKey = dc.CustomerKey
GROUP BY dc.FirstName, dc.LastName
ORDER BY TotalSales DESC;

SELECT TOP(3) * FROM FactInternetSales

---------------------------------------------------------------------------------------
---Query 3: Monthly Sales Trend
--This query calculates the total sales for each month, showing trends over time
---------------------------------------------------------------------------------------
SELECT  TOP(3)
    FORMAT(frs.OrderDate, 'yyyy-MM') AS MonthYear,
    SUM(frs.SalesAmount) AS TotalSales
FROM FactResellerSales frs
GROUP BY FORMAT(frs.OrderDate, 'yyyy-MM')
ORDER BY MonthYear DESC;
-------------------------------------------------------------------------------------------
SELECT TOP(3)
YEAR(soh.OrderDate) AS Year,
MONTH(soh.OrderDate) AS Month,
SUM(soh.SalesAmount) AS TotalSales
FROM
FactResellerSales AS soh
GROUP BY
YEAR(soh.OrderDate), MONTH(soh.OrderDate)
ORDER BY
Year DESC, Month DESC;

------------------------------------------------------------------------------------------
--Query 4: Sales by Region
--This query calculates total sales for each region based on SalesTerritory:
------------------------------------------------------------------------------------------
SELECT st.SalesTerritoryRegion, SUM(SalesAmount) AS Total_Sales
FROM FactResellerSales Sales
JOIN DimSalesTerritory st
ON sales.SalesTerritoryKey = st.SalesTerritoryKey
GROUP BY SalesTerritoryRegion
ORDER BY Total_Sales

