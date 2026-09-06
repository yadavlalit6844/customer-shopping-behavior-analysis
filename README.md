# Customer Shopping Behaviour Analysis

An end-to-end data analytics project exploring customer segments, product performance, and loyalty patterns using **Python, SQL Server, and Power BI**.

## 📌 Project Overview

This project analyzes transactional data from 3,900 customer purchases to uncover insights into customer demographics, product preferences, and shopping loyalty. The goal was to identify actionable opportunities to grow revenue and improve customer retention through a complete data pipeline — from raw data cleaning to an interactive business dashboard.

## 🗂️ Dataset

- **Rows:** 3,900
- **Columns:** 18
- **Key Features:**
  - Customer demographics (age, gender, location, subscription status)
  - Purchase details (item purchased, category, purchase amount, season, size, color)
  - Shopping behavior (discount applied, promo code used, previous purchases, frequency of purchases, review rating, shipping type)

## 🛠️ Tech Stack

| Stage | Tool |
|---|---|
| Data Cleaning & Feature Engineering | Python (pandas) |
| Data Analysis | SQL Server (T-SQL) |
| Data Visualization | Power BI |

## 🔄 Project Workflow

### 1. Data Cleaning (Python)
- Imported and explored the raw dataset using pandas (`.describe()`, `.info()`)
- Checked column cardinality to distinguish categorical vs. continuous fields
- Handled 37 missing values in `review_rating` by imputing the mean rating
- Removed the redundant `discount_applied` column (confirmed zero mismatches with `promo_code_used`)
- Engineered new features: `purchase_frequency_days`, `age_group` (binned), and renamed `previous_purchases` to `repeat_purchase_count`
- Standardized all column headers to snake_case
- Exported the cleaned dataset for SQL analysis

📁 See: [`customer_shopping_behaviour_analysis.ipynb`](./customer_shopping_behaviour_analysis.ipynb)

### 2. Data Analysis (SQL Server)
Analyzed the cleaned dataset across four business areas:

- **Customer Overview Analysis** – top revenue-generating age/gender segments, subscriber vs. non-subscriber purchase frequency
- **Product Analysis** – best/worst selling categories by season, top-selling items, low-rated categories
- **Marketing & Promotion Analysis** – promo code usage by payment method, usage among high-value customers, impact on review ratings
- **Customer Loyalty & Repeat Behaviour** – Pareto analysis (top revenue-contributing segments), repeat purchase patterns by age group

📁 See: [`SQL1.sql`](./SQL1.sql)

### 3. Dashboard (Power BI)
Built a 3-page interactive dashboard:

- **Page 1 – Customer Overview Analysis:** KPIs (customers, average purchase amount, purchase frequency), average purchase by age group, revenue by season, shipping preferences, and subscription patterns by gender
- **Page 2 – Product Analysis:** Revenue and rating breakdowns by category, sales volume by season, and top-earning items per category
- **Page 3 – Marketing & Repeat Behavior Analysis:** Promo code impact on review ratings, promo usage by payment method, and Pareto ranking of repeat purchases by age group

Design details: a locked, semantically consistent color palette across all pages, synchronized slicers (Gender, Subscription Status, Season, Category), Edit Interactions for controlled cross-filtering, and custom DAX measures (RANKX, cumulative percentage, SELECTEDVALUE-based matrix logic) powering the Pareto analysis.

📁 See: [`Dashboard.pbix`](./Dashboard.pbix)

## 📊 Key Insights

- **0% of female customers** are subscribed or have used a promo code — the entire subscription and promo base is male, despite females making up ⅓ of total customers and revenue
- A small set of age-gender segments cumulatively drive the majority of both total and repeat revenue (Pareto pattern)
- **Clothing (44.7%)** and **Accessories** together account for nearly 75% of total revenue
- Promo code usage has **negligible effect** on review ratings (only a 0.02 difference)
- Purchase frequency is nearly identical between subscribers and non-subscribers (difference of only 0.16)
- Nearly 20% of Outerwear revenue comes from orders with free shipping

## 💡 Business Recommendations

- Introduce targeted discounts, promo codes, and subscription campaigns for female customers to close the current gender gap
- Expand focus on the female customer base as a clear growth opportunity
- Prioritize free shipping for Outerwear to capitalize on existing customer preference
- Review underperforming products (e.g., Jeans) for potential shipping or pricing issues
- Incentivize online payments to reduce reliance on Cash on Delivery and improve cash flow
- Continue prioritizing Clothing and Accessories as the strongest-performing categories

## 📁 Repository Structure
├──Business Problem Statement.pdf\
├── customer_shopping_behaviour_analysis.ipynb # Python data cleaning & feature engineering\
├── SQL1sql # SQL queries across 4 analysis areas\
├── Dashboard.pbix # Power BI dashboard file\
├── Customer Shopping Behavior Analysis.pdf # Final written analysis report\
├──Customer-Shopping-Behaviour-Analysis.pptx # Final Presentation of the project work\
└── README.md\
