--QUESTIONS

-- Sales Analysis

-- What is the overall trend in sales over time?
SELECT SUM(Sales) as TotalSales, CAST([Order Date] AS datetime) AS Ord_Date
FROM Orders
GROUP BY CAST([Order Date] AS datetime)
ORDER BY Ord_Date;


-- Which product categories contribute the most to total sales?
SELECT SUM(Sales) AS TotalSales, Category
FROM Orders
GROUP BY Category
ORDER BY TotalSales DESC;


-- Is there a correlation between the quantity sold and total sales?
SELECT SUM(Sales) as TotalSales, Quantity
FROM Orders
GROUP BY Quantity
ORDER BY Quantity;


-- How do sales vary across different regions and customer segments?

SELECT SUM(Sales) as TotalSales, Region, Segment
FROM Orders
GROUP BY Region, Segment
ORDER BY TotalSales DESC;

-- How do sales vary across different regions?

SELECT SUM(Sales) as TotalSales, Region
FROM Orders
GROUP BY Region
ORDER BY TotalSales;

-- How do sales vary across different customer segments?

SELECT SUM(Sales) as TotalSales, Segment
FROM Orders
GROUP BY Segment
ORDER BY TotalSales DESC;


-- Profitability Analysis

-- What is the overall profitability of the company over time?

SELECT CAST([Order Date] AS datetime) AS Ord_Date, SUM(Profit) as Profit
FROM Orders
GROUP BY CAST([Order Date] AS datetime)
ORDER BY Ord_Date;

-- Are there specific product categories or sub-categories with higher profit margins?

SELECT Category, [Sub-Category], AVG(Profit) as Profit
FROM Orders
GROUP BY Category, [Sub-Category]
ORDER BY Profit DESC;


-- How does discounting impact profitability?
SELECT Discount, AVG(Profit) as Profit
FROM Orders
GROUP BY Discount
ORDER BY Profit DESC;

-- Which regions or customer segments are most profitable?

SELECT AVG(Profit) as Profit, Region, Segment
FROM Orders
GROUP BY Region, Segment
ORDER BY Profit DESC;


-- Customer Analysis

-- Who are the top customers in terms of total sales or profitability?
SELECT SUM(Sales) AS TotalSales, SUM(Profit) AS Profit, [Customer ID]
FROM Orders
GROUP BY [Customer ID]
ORDER BY TotalSales DESC;


-- What is the average order quantity and value per customer segment?
SELECT Segment, AVG(Quantity) as AvgQuantity, AVG(Sales) as AvgSales 
FROM Orders 
GROUP BY Segment;

-- Do certain customer segments have a higher tendency to apply discounts?

SELECT Segment, AVG(Discount) as AvgDiscount
FROM Orders
GROUP BY Segment
ORDER BY AvgDiscount;

-- How does shipping mode choice vary among different customer segments?

SELECT Segment, [Ship Mode], COUNT([Ship Mode]) AS Num
FROM Orders
GROUP BY Segment, [Ship Mode]
ORDER BY Segment, Num;

-- Product Performance

-- What are the best-selling products in terms of quantity and revenue?
SELECT [Product Name], SUM(Quantity) as TotalQuantity, SUM(Profit) as TotalProfit
FROM Orders
GROUP BY [Product Name]
ORDER BY TotalProfit DESC;

-- Are there any products with consistently high or low profit margins?
SELECT [Product Name], AVG(Profit) as AvgProfit
FROM Orders
GROUP BY [Product Name]
ORDER BY AvgProfit DESC;

-- How do discounts affect the sales of specific products?
SELECT [Product Name], SUM(Sales) as TotalSales, AVG(Discount) as AvgDiscount
FROM Orders
GROUP BY [Product Name]
ORDER BY TotalSales DESC;


-- What is the average sales quantity per product category?
SELECT Category, AVG(Sales) AS AvgSales
FROM Orders
GROUP BY Category;


-- Time Analysis

-- Are there specific months or seasons with higher sales or profits?
SELECT SUM(Sales) as TotalSales, SUM(Profit) as TotalProfit, MONTH([Order Date]) as OrderMonth
FROM Orders
GROUP BY MONTH([Order Date])
ORDER BY TotalSales;

SELECT SUM(Sales) as TotalSales, SUM(Profit) as TotalProfit, YEAR([Order Date]) as OrderYear
FROM Orders
GROUP BY Year([Order Date])
ORDER BY TotalSales;


-- Is there a correlation between order date and the likelihood of applying discounts?

SELECT [Order Date], AVG(Discount) as Discount
FROM Orders
GROUP BY [Order Date]
ORDER BY Discount;

-- Regional Analysis

-- Which regions have the highest and lowest sales and profit?
SELECT SUM(Sales) as TotalSales, SUM(Profit) as TotalProfit, Region
FROM Orders
GROUP BY Region;

-- Are there specific products or categories that perform better in certain regions?
SELECT SubQ1.Region, SubQ1.TotalSales, ProductName
FROM (
	SELECT Region, MAX(TotalSales) AS TotalSales
	FROM (
	SELECT Region, [Product Name], SUM(Sales) AS TotalSales
	FROM Orders
	GROUP BY Region, [Product Name]
	) as tbl
	GROUP BY Region
) SubQ1
JOIN (
	SELECT Region, [Product Name] as ProductName, SUM(Sales) AS TotalSales
	FROM Orders
	GROUP BY Region, [Product Name]
) SubQ2 ON SubQ1.Region = SubQ2.Region AND SubQ1.TotalSales = SubQ2.TotalSales
ORDER BY TotalSales;


-- How does the customer segment distribution vary across regions?

SELECT Region, Segment, COUNT(Segment) AS TotalSeg
FROM Orders
GROUP BY Region, Segment
ORDER BY Region, TotalSeg;
