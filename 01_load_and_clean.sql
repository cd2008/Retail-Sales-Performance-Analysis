/*
File: 01_load_and_clean.sql
Purpose:
- Import retail sales CSV data
- Clean missing values
- Standardize columns
- Remove duplicates
*/



Create Table Retail_Sale
(
Transaction_ID Serial Primary key,
Customer_ID Varchar(10),
Category varchar(50),
Item varchar(100),
Price_Per_Unit Numeric,
Quantity int,
New_Total Numeric,
Payment_Method varchar(20),
Location varchar(20),
Transaction_Date Date,	
Discount_Applied Boolean 

);

select * from Retail_Sale;

ALTER TABLE Retail_Sale
ALTER COLUMN Price_Per_Unit TYPE NUMERIC(10,2);

SET datestyle = 'DMY';

ALTER TABLE Retail_Sale
ALTER COLUMN New_Total TYPE NUMERIC(12,2);

ALTER TABLE Retail_Sale
DROP COLUMN Transaction_ID;

ALTER TABLE Retail_Sale
ADD COLUMN Transaction_ID VARCHAR(20) PRIMARY KEY;

select * from Retail_Sale limit 5;

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'retail_sale'
ORDER BY ordinal_position;

SET datestyle = 'DMY';

COPY retail_sale (
transaction_id,
customer_id,
category,
item,
price_per_unit,
quantity,
new_total,
payment_method,
location,
transaction_date,
discount_applied
)
FROM 'C:/Program Files/PostgreSQL/17/data/retail_store_sales_cleaned.csv'
DELIMITER ','
CSV HEADER;


copy Retail_Sale(Customer_ID, Category, Item, Price_Per_Unit, Quantity, New_Total, Payment_Method, Location, Transaction_Date, Discount_Applied)
FROM 'C:\Program Files\PostgreSQL\17\data\retail_store_sales_cleaned.csv'
DELIMITER ','
CSV HEADER;
