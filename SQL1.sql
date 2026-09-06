CREATE DATABASE CustomerShopping
GO

USE CustomerShopping
GO

--Initial Data Validation
SELECT TOP 10 *
FROM Cust;

SELECT COUNT(*)
FROM Cust;


--Customer Overview Analysis

--Q1: Which age group and gender gives the maximum revenue?

SELECT age_group, gender, 
	SUM(purchase_amount_usd) AS total_revenue,
	COUNT(*) AS no_of_customers, 
	AVG(purchase_amount_usd) AS avg_revenue_per_cust
FROM Cust
GROUP BY age_group, gender
ORDER BY AVG(purchase_amount_usd) DESC;



--Q2: What are the Top 10 Age group and gender combination who are among the subscribing customers?
-- NOTE: 0 of 1,248 female customers are subscribers in this dataset (100% of subscribers are male).

SELECT TOP 10 age_group, gender, 
	SUM(purchase_amount_usd) AS total_revenue, 
	COUNT(*) AS no_of_customers, 
	ROUND(AVG(CAST(purchase_amount_usd AS FLOAT)),2) AS avg_revenue_per_cust
FROM Cust
WHERE subscription_status = 'Yes'
GROUP BY age_group, gender
ORDER BY ROUND(AVG(CAST(purchase_amount_usd AS FLOAT)),2) DESC;



--Q3: What is the Average Frequency of purchase among both subscribers and non-subscribers?

SELECT subscription_status, AVG(purchase_frequency_days) AS avg_purchase_frequency
FROM Cust
GROUP BY subscription_status;



--Product Category Analysis

--Q4: What is the highest selling and least selling product category (By Volume) in each season?

WITH 
season_rank AS 
(SELECT season, category, COUNT(customer_id) AS sales_volume, 
RANK() OVER(PARTITION BY season ORDER BY COUNT(customer_id) DESC) AS sales_ranking
FROM Cust
GROUP BY season, category),

max_rank AS
(SELECT *, MAX(sales_ranking) OVER(PARTITION BY season) AS least_rank
FROM season_rank)

SELECT * 
FROM max_rank
WHERE sales_ranking = 1 OR
	sales_ranking = least_rank;



--Q5: Which is the Top selling item (by Sales Revenue) from each category.

WITH category_ranking AS
(SELECT category, item_purchased, SUM(purchase_amount_usd) AS total_sales, 
RANK() OVER(PARTITION BY category ORDER BY SUM(purchase_amount_usd) DESC) AS sales_rank
FROM Cust
GROUP BY category, item_purchased)

SELECT *
FROM category_ranking
WHERE sales_rank=1;



--Q6: Which Product Category has average review rating below 3.75?

SELECT category, CAST(AVG(review_rating) AS decimal(10,2)) AS avg_rating

FROM Cust
GROUP BY category
HAVING AVG(review_rating) < 3.75;



--Marketing and Promotion Analysis

--Q7: What is the percentage share of promo code usage, for each payment method?

SELECT payment_method, 
	CAST((SUM(CASE WHEN promo_code_used='Yes' THEN 1 ELSE 0 END)*100.00/COUNT(customer_id)) AS decimal(10,2)) AS pct_of_promo_code_used
FROM Cust
GROUP BY payment_method
ORDER BY pct_of_promo_code_used DESC;



--Q8: What is the No. of High Spending customers(Above Avg.) who used promo code?

SELECT COUNT(customer_id) AS high_spending_cust
FROM Cust
WHERE purchase_amount_usd > (SELECT AVG(purchase_amount_usd) FROM Cust) 
AND promo_code_used = 'Yes';



--Q9: Is there a relation between customers who used promo code and their Review Rating?

SELECT promo_code_used, CAST(AVG(review_rating) AS decimal(10,2)) AS avg_rating
FROM Cust
GROUP BY promo_code_used;



--Customer Loyalty and repeat behaviour

--Q10: Which age group and gender combinations account for the top 70% of total repeat purchases?

WITH grouped_sales_count AS
	(SELECT age_group, gender, SUM(repeat_purchase_count) AS sales_count
	FROM Cust
	GROUP BY age_group, gender),

cumulative_group_sales AS
	(SELECT *,
		SUM(sales_count) OVER (ORDER BY sales_count DESC) AS cumulative_sales
	FROM grouped_sales_count)

SELECT *
FROM cumulative_group_sales
WHERE cumulative_sales < (SELECT (SUM(repeat_purchase_count))*70.0/100 FROM Cust);



--Q11: Which age groups have an average repeat purchase count above the overall average?

SELECT age_group, AVG(repeat_purchase_count) AS avg_sales
FROM Cust
GROUP BY age_group
HAVING AVG(repeat_purchase_count)>(SELECT AVG(repeat_purchase_count) FROM Cust);