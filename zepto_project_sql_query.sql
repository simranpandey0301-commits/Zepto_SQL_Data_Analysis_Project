drop table if exists zepto;

create table zepto(
sku_id SERIAL PRIMARY KEY,
category VARCHAR (120),
name VARCHAR (150) NOT NULL,
mrp NUMERIC(8,2),
discountPercent NUMERIC (5,2),
availableQuantity INTEGER,
discountedSellingPrice NUMERIC (8,2),
weightInGms INTEGER,
outOfStock BOOLEAN,
quantity INTEGER
);

--DATA EXPLORATION:

--count of rows

SELECT COUNT (*) FROM zepto;

--sample data

SELECT * FROM zepto 
LIMIT 10;

--null values

SELECT * FROM zepto
WHERE name IS NULL
OR
category IS NULL
OR
mrp IS NULL
OR
discountPercent IS NULL
OR
discountedSellingPrice IS NULL
OR
availableQuantity IS NULL
OR
weightInGms IS NULL
OR
outOfStock IS NULL
OR
quantity IS NULL;

--different product categories

SELECT DISTINCT category
FROM zepto
ORDER BY category;

--products in stock vs out of stock

SELECT outOfStock, COUNT(sku_id)
FROM zepto
GROUP BY outOfStock;

--product name present multiple times

SELECT name, COUNT(sku_id) as number_of_SKUs
FROM zepto
GROUP BY name
HAVING COUNT(sku_id) > 1
ORDER BY COUNT(sku_id)  DESC;

--DATA CLEANING:

--products with price = 0

SELECT * FROM zepto
WHERE mrp = 0 OR discountedSellingPrice = 0;

DELETE FROM zepto 
WHERE mrp = 0;

--convert paise to rupees

UPDATE zepto
SET mrp = mrp/100.0,
    discountedSellingPrice = discountedSellingPrice/100.0;

SELECT mrp, discountedSellingPrice 
FROM zepto;

SELECT * FROM zepto;

--data driven problems

--1. Find the top 10 best_value products based on the discount percentage

SELECT name, mrp, discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;

--2. What are the Products with High MRP but Out of Stock

SELECT DISTINCT name, mrp 
FROM zepto
WHERE outOfStock = TRUE AND mrp > 300
ORDER BY mrp DESC;

--3. Calculate Estimated Revenue for each category

SELECT category,
SUM(discountedSellingPrice*availableQuantity) as total_revenue
FROM zepto
GROUP BY category
ORDER BY total_revenue;

--4. Find all products where MRP is greater than Rs.500 and discount is
--   less than 10%

SELECT name, mrp, discountPercent
FROM zepto
WHERE mrp > 500 AND discountPercent < 10
ORDER BY mrp DESC, discountPercent DESC;

--5. Identify the top 5 categories offering the highest average discount
--   percentage

SELECT category,
ROUND(AVG(discountPercent),2) as Avg_discount
FROM zepto
GROUP BY category
ORDER BY Avg_discount DESC
LIMIT 5;

--6. Find the price per gram for products above 100g and sort by best
--   value

SELECT name, weightInGms, discountedSellingPrice,
ROUND(discountedSellingPrice/weightInGms,2) as price_per_grams
FROM zepto
WHERE weightInGms >= 100
ORDER BY price_per_grams;

--7. Group the products into categories like Low Medium, Bulk

SELECT name, weightInGms,
CASE WHEN weightInGms < 1000 THEN 'LOW'
     WHEN weightInGms < 5000 THEN 'MEDIUM'
	 ELSE 'BULK'
	 END as weight_category
FROM zepto;

--8. What is the total Inventory Weight Per Category
SELECT category,
SUM(weightInGms*availableQuantity) as total_weight
FROM zepto
GROUP BY category
ORDER BY total_weight;
