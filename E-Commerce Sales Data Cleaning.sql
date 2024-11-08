-- Ecommerce Sales Data Analysis SQL Project - Data Cleaning 


SELECT *
FROM ecommerce_analysis_dataset;

-- 1. Remove Duplicates if there are any
-- 2. Handle Missing Values if there are any
-- 3. Standardize the data
-- 4. Convert date formats




-- i will create an alternative table from the raw data where all the cleaning will be done and keep the raw data incase of unforeseen situations. 

CREATE TABLE ecommerce_analysis_dataset_alternative
LIKE ecommerce_analysis_dataset;

SELECT *
FROM ecommerce_analysis_dataset_alternative;

INSERT ecommerce_analysis_dataset_alternative
SELECT *
FROM ecommerce_analysis_dataset;


-- Checking for and Removing Duplicates 

SELECT *,
ROW_NUMBER() OVER(
PARTITION BY Row_ID, Order_ID, Order_Date, Customer_ID, Segment, City, State, Country, Country_latitude, Country_longitude, 
Region, Market, Subcategory, Category, Product, Quantity, Sales, Discount,Profit) AS RowNumber
FROM ecommerce_analysis_dataset_alternative;

-- looks like there are a couple of duplicates in each row


-- I will check a unique rowid to confirm accuracy

SELECT *
FROM ecommerce_analysis_dataset_alternative
WHERE Row_ID = 1;

-- looks good and the ones where RowNumber is greater than 1 are the ones to delete


-- Signify the rows that are greater than one and needs to be deleted

WITH DuplicateCTE AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY Row_ID, Order_ID, Order_Date, Customer_ID, 
Segment, City, State, Country, Country_latitude, Country_longitude, 
Region, Market, Subcategory, Category, Product, Quantity, Sales, Discount,Profit) AS RowNumber
FROM ecommerce_analysis_dataset_alternative
)
SELECT *
FROM DuplicateCTE
WHERE RowNumber > 1;


-- i will create a new table and add a new column with those row numbers in it, then delete where row numbers are over 1, then delete that column

CREATE TABLE `ecommerce_analysis_dataset_alternative2` (
  `Row_ID` int DEFAULT NULL,
  `Order_ID` text,
  `Order_Date` text,
  `Customer_ID` text,
  `Segment` text,
  `City` text,
  `State` text,
  `Country` text,
  `Country_latitude` double DEFAULT NULL,
  `Country_longitude` double DEFAULT NULL,
  `Region` text,
  `Market` text,
  `Subcategory` text,
  `Category` text,
  `Product` text,
  `Quantity` int DEFAULT NULL,
  `Sales` int DEFAULT NULL,
  `Discount` double DEFAULT NULL,
  `Profit` double DEFAULT NULL,
  `RowNumber` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


SELECT *
FROM ecommerce_analysis_dataset_alternative2;


INSERT INTO ecommerce_analysis_dataset_alternative2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY Row_ID, Order_ID, Order_Date, Customer_ID, Segment, City, State, Country, Country_latitude, Country_longitude, 
Region, Market, Subcategory, Category, Product, Quantity, Sales, Discount,Profit) AS RowNumber
FROM ecommerce_analysis_dataset_alternative;

SELECT *
FROM ecommerce_analysis_dataset_alternative2;

DELETE
FROM ecommerce_analysis_dataset_alternative2
WHERE RowNumber > 1;

-- rows greater than one have been deleted and duplicates have therefore been removed


ALTER TABLE ecommerce_analysis_dataset_alternative2
DROP COLUMN RowNumber;

-- the column 'rownumber' has also been dropped in the table


-- Standardizing Data

SELECT DISTINCT(Customer_ID)
FROM ecommerce_analysis_dataset_alternative2
ORDER BY 1;

SELECT DISTINCT(Segment)
FROM ecommerce_analysis_dataset_alternative2
ORDER BY 1;

SELECT DISTINCT(City)
FROM ecommerce_analysis_dataset_alternative2
ORDER BY 1;

SELECT DISTINCT(State)
FROM ecommerce_analysis_dataset_alternative2
ORDER BY 1;

SELECT DISTINCT(Country)
FROM ecommerce_analysis_dataset_alternative2
ORDER BY 1;

SELECT DISTINCT(Region)
FROM ecommerce_analysis_dataset_alternative2
ORDER BY 1;

SELECT DISTINCT(Market)
FROM ecommerce_analysis_dataset_alternative2
ORDER BY 1;

SELECT DISTINCT(Subcategory)
FROM ecommerce_analysis_dataset_alternative2
ORDER BY 1;

SELECT DISTINCT(Category)
FROM ecommerce_analysis_dataset_alternative2
ORDER BY 1;

SELECT DISTINCT(Product)
FROM ecommerce_analysis_dataset_alternative2
ORDER BY 1;

-- there are no inconsistenciesin the standardization of each column so everything looks good there


-- Convert Date Format

SELECT Order_Date
FROM ecommerce_analysis_dataset_alternative2;

UPDATE ecommerce_analysis_dataset_alternative2
SET Order_Date = STR_TO_DATE(Order_Date, '%m/%d/%Y');



-- After thorough and careful cleaning of the e-commerce sales dataset, I happened to find at least one duplicate in each row in the dataset
-- which I ensured was removed to ensure further accurate analysis. 

-- I also made sure to check for missing values in the dataset in order to avoid incomplete information which may lead to further inaccurate
-- analysis but after carefully checking, I didn't find any missing values in the dataset.

-- I also checked for standardization in each column of the dataset by ensuring consistent capitalization, spacing, and spellings 
-- across the columns to avoid issues during proper analysis and after carefully checking, everything looks good and I didn't have to standardize.

-- I converted the date column in order to ensure consistency in time-based analyses and also allow for easier extraction of components 
-- (like month or year) for trend analysis.



-- Data has been thoroughly and carefully cleaned and is ready for further analysis.