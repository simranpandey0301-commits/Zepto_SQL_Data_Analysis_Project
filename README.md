# 🛒 Zepto SQL Data Analysis Project

## 📌 Project Overview

This project is a **SQL-based data analysis project** using a Zepto-style product dataset. The objective is to explore product-level data, perform basic data cleaning, and answer business-oriented questions using **PostgreSQL SQL queries**.

The project demonstrates practical SQL skills that are commonly required for a **Data Analyst** role, including:

- Data exploration
- Data cleaning
- Aggregation and grouping
- Filtering and sorting
- Conditional logic using `CASE`
- Duplicate analysis
- Revenue estimation
- Inventory analysis
- Discount analysis
- Price-per-unit analysis

---

## 🎯 Project Objectives

The main objectives of this project are to:

1. Explore the structure and contents of the product dataset.
2. Identify missing and duplicate records.
3. Clean product pricing data.
4. Analyze discounts and product pricing.
5. Estimate potential revenue by category.
6. Analyze inventory quantity and weight.
7. Identify high-value and high-discount products.
8. Answer real-world business questions using SQL.

---

## 🗂️ Dataset Structure

The `zepto` table contains the following columns:

| Column | Data Type | Description |
|---|---|---|
| `sku_id` | SERIAL / Primary Key | Unique identifier for each SKU |
| `category` | VARCHAR | Product category |
| `name` | VARCHAR | Product name |
| `mrp` | NUMERIC | Maximum Retail Price |
| `discountPercent` | NUMERIC | Discount percentage |
| `availableQuantity` | INTEGER | Available inventory quantity |
| `discountedSellingPrice` | NUMERIC | Selling price after discount |
| `weightInGms` | INTEGER | Product weight in grams |
| `outOfStock` | BOOLEAN | Indicates whether the product is out of stock |
| `quantity` | INTEGER | Product quantity |

---

## 🛠️ Tools & Technologies

- **PostgreSQL**
- **SQL**
- GitHub

---

## 🔍 Project Workflow

### 1. Database & Table Creation

The project begins by creating the `zepto` table with appropriate data types, constraints, and a primary key.

```sql
CREATE TABLE zepto(
    sku_id SERIAL PRIMARY KEY,
    category VARCHAR(120),
    name VARCHAR(150) NOT NULL,
    mrp NUMERIC(8,2),
    discountPercent NUMERIC(5,2),
    availableQuantity INTEGER,
    discountedSellingPrice NUMERIC(8,2),
    weightInGms INTEGER,
    outOfStock BOOLEAN,
    quantity INTEGER
);
```

---

### 2. Data Exploration

The dataset is explored to understand its size, structure, categories, stock status, and potential data-quality issues.

Examples include:

- Counting total rows
- Viewing sample records
- Checking NULL values
- Finding distinct product categories
- Comparing in-stock and out-of-stock products
- Identifying products with multiple SKUs

---

### 3. Data Cleaning

The project includes checks for products where price values are zero.

The SQL script also converts price values from **paise to rupees**:

```sql
UPDATE zepto
SET mrp = mrp / 100.0,
    discountedSellingPrice = discountedSellingPrice / 100.0;
```

This ensures that subsequent price and revenue calculations use rupee values.

> **Note:** The cleaning query deletes records where `mrp = 0`. Always review such records before deleting them in a production environment.

---

## 📊 Business Questions Answered

### 1. Top 10 Products by Discount Percentage

Identifies products offering the highest discount percentages.

```sql
SELECT name, mrp, discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;
```

**Business use:** Helps identify products that may attract customers through aggressive discounts.

---

### 2. High-MRP Products That Are Out of Stock

Finds products with an MRP above ₹300 that are currently out of stock.

**Business use:** Helps identify potentially important products requiring inventory replenishment.

---

### 3. Estimated Revenue by Category

Calculates estimated revenue using:

**Discounted Selling Price × Available Quantity**

```sql
SELECT category,
       SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto
GROUP BY category
ORDER BY total_revenue;
```

**Business use:** Helps compare the revenue potential of different product categories.

---

### 4. Products With High MRP and Low Discount

Identifies products where:

- MRP > ₹500
- Discount < 10%

**Business use:** Useful for identifying relatively expensive products with limited promotional discounts.

---

### 5. Top 5 Categories by Average Discount

Calculates the average discount percentage for each category and identifies the five categories with the highest average discount.

**Business use:** Helps evaluate category-level promotional strategies.

---

### 6. Price per Gram Analysis

Calculates the price per gram for products weighing at least 100 grams.

Formula:

**Price per Gram = Discounted Selling Price ÷ Weight in Grams**

**Business use:** Helps identify products that provide better value based on their weight.

---

### 7. Product Weight Classification

Products are grouped into three weight categories:

| Weight | Classification |
|---|---|
| `< 1000 g` | LOW |
| `1000–4999 g` | MEDIUM |
| `≥ 5000 g` | BULK |

This analysis uses a SQL `CASE` statement.

---

### 8. Total Inventory Weight by Category

Calculates the total inventory weight available in each category.

Formula:

**Total Inventory Weight = Weight × Available Quantity**

**Business use:** Helps understand the physical inventory volume associated with each category.

---

## 💡 Key SQL Concepts Demonstrated

This project covers several important SQL concepts:

- `CREATE TABLE`
- `DROP TABLE`
- `SELECT`
- `WHERE`
- `DISTINCT`
- `COUNT()`
- `SUM()`
- `AVG()`
- `ROUND()`
- `GROUP BY`
- `HAVING`
- `ORDER BY`
- `LIMIT`
- `DELETE`
- `UPDATE`
- `CASE WHEN`
- Boolean filtering
- Aggregate functions
- Calculated columns
- Data cleaning
- Business-oriented SQL analysis

---

## 📁 Repository Structure

A simple GitHub repository structure can be:

```text
zepto-sql-data-analysis/
│
├── zepto_project_sql_query.sql
└── README.md
```

If you later add the dataset, you can extend it to:

```text
zepto-sql-data-analysis/
│
├── data/
│   └── zepto_dataset.csv
│
├── zepto_project_sql_query.sql
└── README.md
```

---

## 🚀 How to Run the Project

### Step 1: Install PostgreSQL

Install PostgreSQL and open a SQL environment such as **pgAdmin** or another PostgreSQL-compatible SQL client.

### Step 2: Create a Database

Create a new database for the project.

### Step 3: Run the SQL Script

Open:

```text
zepto_project_sql_query.sql
```

Run the script in your PostgreSQL environment.

### Step 4: Load the Dataset

Load the Zepto product data into the `zepto` table before running the analysis queries.

### Step 5: Execute the Queries

Run the exploration, cleaning, and business-analysis queries individually to understand the output of each step.

---

## 📈 Portfolio Skills Demonstrated

This project demonstrates the ability to transform raw product data into useful business insights using SQL.

### Data Analyst Skills

- Data cleaning
- Exploratory data analysis
- Business problem solving
- Inventory analysis
- Pricing analysis
- Revenue analysis
- Product performance analysis
- Category-level analysis
- SQL querying and aggregation

---

## 👩‍💻 Author

**Simran Kumari**

Aspiring Data Analyst | SQL | Excel | Python | Data Visualization

---

## ⭐ Project Purpose

This project was created as part of a **Data Analyst portfolio** to demonstrate practical SQL skills through a real-world e-commerce/product analytics scenario.

If you find this project useful, feel free to ⭐ the repository.
