-- Ecommerce Sales Data Analysis SQL Project - Exploratory Data Analysis

SELECT *
FROM ecommerce_analysis_dataset_alternative2;

-- 1. Analyze the distribution of sales, profit, and discount across different categories

-- What are the average and total sales, profit, and discount amounts across different product categories?

SELECT 
	Category,
	AVG(sales) AS AverageSales,
    AVG(Profit) AS AverageProfit,
    AVG(Discount) AS AverageDiscount,
    SUM(sales) AS TotalSales,
    SUM(Profit) AS TotalProfit,
    SUM(Discount) AS TotalDiscount
FROM 
	ecommerce_analysis_dataset_alternative2
GROUP BY
	Category
ORDER BY
	2 DESC;
    
    
-- Which product category has the highest average discount, and does it impact its sales and profitability?

SELECT 
	Category,
    AVG(Discount) AS AverageDiscount,
    SUM(Sales) AS TotalSales,
    SUM(Profit) AS TotalProfit
FROM 
	ecommerce_analysis_dataset_alternative2
GROUP BY
	Category
ORDER BY
	3 DESC;
    
    
-- What are the percentage of orders that are profitable and nonprofitable?

SELECT 
    ROUND((SUM(CASE WHEN Profit > 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)),2) AS ProfitableOrderPercentage,
    ROUND((SUM(CASE WHEN Profit <= 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)),2) AS UnprofitableOrderPercentage
FROM 
    ecommerce_analysis_dataset_alternative2;


-- Among nonprofitable orders, what common patterns exist in terms of category and discount level?

SELECT 
    Category,
    AVG(Discount) AS AverageDiscount,
    COUNT(*) AS UnprofitableOrderCount
FROM 
    ecommerce_analysis_dataset_alternative2
WHERE 
    Profit <= 0
GROUP BY 
    Category
ORDER BY 
    UnprofitableOrderCount DESC;

-- In what region are profitable and nonprofitable orders more prevalent?

SELECT 
    Country,
    COUNT(CASE WHEN Profit > 0 THEN 1 END) AS ProfitableOrderCount,
    COUNT(CASE WHEN Profit <= 0 THEN 1 END) AS NonProfitableOrderCount
FROM 
    ecommerce_analysis_dataset_alternative2
GROUP BY 
    Country
ORDER BY 
    ProfitableOrderCount DESC, NonProfitableOrderCount DESC;
    
    
-- 2. Investigate how customer segments affect sales and profit.

-- How do sales and profit differ across customer segments?

SELECT 
	Segment,
	AVG(sales) AS AverageSales,
    AVG(Profit) AS AverageProfit
FROM 
	ecommerce_analysis_dataset_alternative2
GROUP BY
	Segment
ORDER BY
	2 DESC, 3 DESC;
    
-- Which customer segment brings in the highest sales and which one contributes the most to profit?

SELECT 
	Segment,
	SUM(sales) AS TotalSales,
    SUM(Profit) AS TotalProfit
FROM 
	ecommerce_analysis_dataset_alternative2
GROUP BY
	Segment
ORDER BY
	2 DESC, 3 DESC;

    
-- Do customer segments react differently to discounts, and if so, how does this affect profitability and order frequency?

SELECT 
	Segment,
	AVG(Discount) AS AverageDiscount,
    SUM(Profit) AS TotalProfit,
    COUNT(Order_ID) AS TotalOrders
FROM 
	ecommerce_analysis_dataset_alternative2
GROUP BY
	Segment
ORDER BY
	2 DESC, 3 DESC;
    

-- 3. Explore geographic patterns, including the impact of different regions and countries on sales performance.

-- How do sales and profit vary across different regions?

SELECT 
	Region,
	AVG(sales) AS AverageSales,
    SUM(Profit) AS TotalProfit
FROM 
	ecommerce_analysis_dataset_alternative2
GROUP BY
	Region
ORDER BY
	2 DESC, 3 DESC;
    
-- How do sales and profit vary across different market?

SELECT 
	Market,
	SUM(sales) AS TotalSales,
    SUM(Profit) AS TotalProfit
FROM 
	ecommerce_analysis_dataset_alternative2
GROUP BY
	Market
ORDER BY
	2 DESC, 3 DESC;
    
-- What is the top 5 Region with the Highest Profit Margin?

SELECT 
    Region,
    SUM(Profit) AS TotalProfit,
    SUM(Sales) AS TotalSales,
    (SUM(Profit) / SUM(Sales)) * 100 AS ProfitMargin 
FROM 
    ecommerce_analysis_dataset_alternative2
GROUP BY 
    Region
ORDER BY 
    ProfitMargin DESC
LIMIT 5;


-- How Do Sales, Profit, and Discount Rates Vary Across Different Countries?

SELECT 
    Country,
    SUM(Sales) AS TotalSales,
    SUM(Profit) AS TotalProfit,
    AVG(Discount) AS AverageDiscount
FROM 
    ecommerce_analysis_dataset_alternative2
GROUP BY 
    Country
ORDER BY 
    TotalSales DESC;
    
-- Are There Any Countries with Exceptionally High or Low Profit Margins?

SELECT 
    Country,
    SUM(Profit) AS TotalProfit,
    SUM(Sales) AS TotalSales,
    (SUM(Profit) / SUM(Sales)) * 100 AS ProfitMargin
FROM 
    ecommerce_analysis_dataset_alternative2
GROUP BY 
    Country
ORDER BY 
    ProfitMargin;

-- What is the differnce in the level of discount by country, and what effect does that have on sales performance in each country?

SELECT 
    Country,
    AVG(Discount) AS AverageDiscount,
    SUM(Sales) AS TotalSales,
    SUM(Profit) AS TotalProfit
FROM 
    ecommerce_analysis_dataset_alternative2
GROUP BY 
    Country
ORDER BY 
    TotalSales DESC; 


-- 4. Analyze the relationship between product categories/subcategories and profitability.

-- Which categories are the most and least profitable?

SELECT 
    Subcategory,
    SUM(Sales) AS TotalSales,
    AVG(Profit) AS AverageProfit
FROM 
    ecommerce_analysis_dataset_alternative2
GROUP BY 
    Subcategory
ORDER BY 
    AverageProfit DESC; 
    
-- How does the quantity ordered affect profitability within each category?

SELECT 
    Category,
    SUM(Quantity) AS QuantityOrdered,
    AVG(Profit) AS AverageProfit
FROM 
    ecommerce_analysis_dataset_alternative2
GROUP BY 
    Category
ORDER BY 
    AverageProfit DESC; 
    
-- Are there subcategories that, while generating high sales, still yield low or negative profit?

SELECT 
    Subcategory,
    SUM(Sales) AS TotalSales,
    SUM(Profit) AS TotalProfit
FROM 
    ecommerce_analysis_dataset_alternative2
GROUP BY 
    Subcategory
HAVING 
    TotalProfit <= 0
ORDER BY 
    TotalProfit DESC; 

-- What are the top 5 products in terms of sales, profit, and quantity sold?

SELECT 
    Product,
    SUM(Quantity) AS QuantitySold,
    SUM(Sales) AS TotalSales,
    SUM(Profit) AS TotalProfit
FROM 
    ecommerce_analysis_dataset_alternative2
GROUP BY 
    Product
ORDER BY 
    TotalSales DESC
LIMIT 5; 

-- Which is the top 10 product that consistently have low profit margins?

SELECT 
    Product,
    SUM(Sales) AS TotalSales,
    SUM(Profit) AS TotalProfit,
    (SUM(Profit) / NULLIF(SUM(Sales), 0)) * 100 AS ProfitMargin 
FROM 
    ecommerce_analysis_dataset_alternative2
GROUP BY 
    Product
HAVING 
    ProfitMargin <= 0 
ORDER BY 
    ProfitMargin
LIMIT 10; 

-- 5. Identify trends over time, such as monthly or seasonal trends in order quantity, sales, and profit.

-- How do sales, order quantity, and profit change on a monthly timeframe?

SELECT 
    SUBSTRING(order_date, 1,7) AS Month,
    SUM(Sales) AS TotalSales,
    SUM(Quantity) AS TotalQuantity,
    SUM(Profit) AS TotalProfit
FROM 
    ecommerce_analysis_dataset_alternative2
GROUP BY 
    Month
ORDER BY 
    Month;

-- Are there seasonal trends in sales or profit like higher sales in certain quarters of the year?

SELECT 
    YEAR(Order_Date) AS Year,
    QUARTER(Order_Date) AS Quarter,
    SUM(Sales) AS TotalSales,
    SUM(Profit) AS TotalProfit
FROM 
    ecommerce_analysis_dataset_alternative2
WHERE 
    YEAR(Order_Date) BETWEEN 2020 AND 2023
GROUP BY 
    Year, Quarter
ORDER BY 
    Year, Quarter;

-- How do discounts change over the year, and what effect does this have on sales volume and profit?

SELECT 
   YEAR(Order_Date) AS Year,
    AVG(Discount) AS AverageDiscount,
    SUM(Sales) AS TotalSales,
    SUM(Profit) AS TotalProfit
FROM 
    ecommerce_analysis_dataset_alternative2
GROUP BY 
    Year
ORDER BY 
    Year; 
    
-- What is the difference in profitability different times of the year, and how does this relate to discount usage?

SELECT 
	SUBSTRING(order_date, 1,7) AS Month,
    SUM(Profit) AS TotalProfit,
    AVG(Discount) AS AverageDiscount
FROM 
    ecommerce_analysis_dataset_alternative2
GROUP BY 
    Month
ORDER BY 
    Month; 
    
-- Which time periods have the highest unprofitable orders, and what patterns are associated with them?

SELECT 
    SUBSTRING(order_date, 1,7) AS Month,
    COUNT(*) AS UnprofitableOrders
FROM 
    ecommerce_analysis_dataset_alternative2
WHERE 
    Profit < 0 
GROUP BY 
    Month
ORDER BY 
    UnprofitableOrders DESC; 




