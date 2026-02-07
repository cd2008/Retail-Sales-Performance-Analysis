/*
File: 02_calculate_kpis.sql
Purpose:
- Calculate KPIs like Total Revenue, Quantity Sold
- Analyze sales by category, payment method, and channel
*/

Select * from Retail_Sale;

Select Sum(new_total) as total_revenue
from Retail_Sale
where new_total IS NOT NULL;

Select COUNT(transaction_id) as total_transction
From Retail_Sale;

Select AVG(new_total) as avg_transaction
From Retail_Sale
WHERE new_total IS NOT NULL;

Select SUM(quantity) as Total_quantity_sold
FROM Retail_Sale
WHERE quantity IS NOT NULL;

Select category,SUM(new_total) as revenue_by_category
FROM Retail_Sale
Group by category;

Select item,Sum(quantity) as Total_quantity_sold
From Retail_Sale
Group By item 
ORDER BY Total_quantity_sold DESC
LIMIT 10;

Select item,SUM(new_total) as low_perform_items
From Retail_Sale
Group By item
ORDER BY low_perform_items ASC
LIMIT 10;

Select payment_method,SUM(new_total) as revenue_by_pay_method
From Retail_Sale
Group By payment_method;

SELECT AVG(CASE WHEN discount_applied = TRUE THEN 1 ELSE 0 END) * 100 AS discount_percentage
FROM retail_sale;

SELECT location,SUM(new_total) as revenue_by_location
FROM Retail_Sale
Group By location
ORDER BY revenue_by_location DESC;