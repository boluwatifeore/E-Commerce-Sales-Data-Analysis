# E-commerce Sales Data Analysis

## Table of Contents

- [Project Overview](#project-overview)
- [Dataset Overview](#dataset-overview)
- [Tools Used](#tools-used)
- [Data Analysis](#data-analysis)
- [Insights](#insights)
- [Recommendations](#recommendations)


## Project Overview

The analysis main focus is to assess the sales and profitability of various products across different regions, customer segments, and discount levels. The primary goals include to ;

- Identify the most profitable products and categories.
- Determine the effect of discounts on sales and profits.
- Analyze customer behavior based on segmentation
- Discover which regions or markets are the most profitable or underperforming.
- Investigate which countries have the highest sales volume

### Dataset Overview:

- Dataset Source: My internship company provided this dataset
- Data Variables: Row_ID, Order_ID, Order_Date, Customer_ID, Segment, City, State, Country, Country_latitude, Country_longitude, Region, Market, Subcategory, Category, Product, 
  Quantity, Sales, Discount, Profit, RowNumber.
- Timeframe: The data covers sales transactions from January 2021 to December 2023.


### Tools Used

- Microsoft Excel: This was used for initial exploration of the dataset.
- MySQL: This was used for querying the data and performing exploratory analysis to gain business insights on the E-commerce dataset.
- Tableau: Data visualization, helping to visually interpret the relationships and trends discovered through the analysis.

### Data Analysis

The analysis focused on answering key questions that are associated to the E-commerce dataset. A few of the these queries include:

- What are the average and total sales, profit, and discount amounts across different product categories?
- What is the difference in sales and profit across customer segments?
- Do customer segments react differently to discounts, and if so, how does this affect profitability and order frequency?
- What are the top 5 products in terms of sales, profit, and quantity sold?
- Are there seasonal trends in sales or profit like higher sales in certain quarters of the year?

```SELECT 
	SUBSTRING(order_date, 1,7) AS Month,
    SUM(Profit) AS TotalProfit,
    AVG(Discount) AS AverageDiscount
FROM 
    ecommerce_analysis_dataset_alternative2
GROUP BY 
    Month
ORDER BY 
    Month; 
```

```SELECT 
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
```

### Insights

- Most Profitable Products and Categories:

Top Products: "Herbal Essences Bio," "Rose Gold Petal Studs," and "Sterling Wave Earrings" are the highest profit-generating items, suggesting strong demand in both beauty and accessory segments.
Top Categories: "Body care" and "Make up" categories have the highest average profits and significant total sales. However, "Home and Accessories" category shows a loss in profit despite high sales, which I suggest may be due to certain discounting strategies or low margins.
  
- Effect of Discounts on Sales and Profits:

Higher discounts in categories like "Body care" (15.2%) lead to high total sales and profit, indicating discounts effectively drive sales in this segment.
However, "Home and Accessories" has high discounts but generates negative profits, suggesting that excessive discounting could be unsustainable for profitability.

- Customer Behavior by Segmentation:

Corporate Segment: Corporate customers generate the highest total and average profits, with a lower need for discounts, which indicates that premium products and loyalty avenues may work well with this segment.
Self-Employed Segment: This generates lower sales and profits per order, likely benefiting from targeted promotions to increase engagement.

- Regional and Market Profitability:

Top Regions: Southern Europe, Western US, and Eastern Asia regions have high average sales and positive profits, showcasing stable markets with a high potential for growth.
Underperforming Regions: Western Asia and Western Africa have negative profits, requiring adjustments in maybe product mix or pricing to improve profitability.


- Highest Sales Volume by Country:

The United States, Australia, and France are high-revenue countries, with discount levels that don’t significantly impact profits, suggesting effective pricing strategies.
However, countries like Turkey and Nigeria, despite large sales volumes, face profit losses, which may be due to high discounting, inflation, recession or other local market challenges.


### Recommendations

- There should be a highly focused marketing campaigns on high-performing regions (Southern Europe, Western US, Eastern Asia) and profitable customer segments (Corporate).
- Emphasize the "Body care" and "Make up" categories in promotions, as they yield high profits and respond well to moderate discounting.

- There might be a need to reassess discount levels in the "Home and Accessories" category to find a balance that attracts sales without negatively affecting profit margins.
- In countries with negative profits like Turkey and Nigeria, evaluate local market trends and competitors to set appropriate discount levels, potentially reducing them in favor of bundle offers or exclusive deals.

- There should be a focus on increasing product variety within profitable categories (e.g., "Body care" and "Make up") to increase their high demand.
- Adjust product mix in underperforming regions (Western Asia, Western Africa) to focus on products that offer a higher margin, such as premium or unique items that require less 
  discounting to sell.

- It may be really important to expand marketing and distribution avenues in top revenue countries (e.g., United States, Australia, France) where high sales volumes and discount rates maintain profit levels.
- Invest in rising markets within the Asia Pacific and Europe markets, as they show potential for increased sales with strategic targeting.


