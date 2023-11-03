The attached file contains SQL queries to analyze Walmart sales data. The queries are designed to answer various questions related to the sales data, such as the most common payment method, the largest revenue product line, and the customer who brings the most revenue. The queries are divided into different sections, such as creating a table, adding columns for time of day, day name, and month name, and analyzing the product data.
Here is a breakdown of the different sections and queries included in the code:
Creating a Table
Create database if not exists WalmartSalesData;
Create table if not exists sales
Adding Columns for Time of Day, Day Name, and Month Name
Select time, (case when time between "00:00:00" and "12:00:00" then "Morning" when time between "12:01:00" and "16:00:00" then "Afternoon" else "Evening" end ) as time_of_date from sales;
Alter table sales add column time_of_day varchar(30);
Update sales set time_of_day = ( case when time between "00:00:00" and "12:00:00" then "Morning" when time between "12:01:00" and "16:00:00" then "Afternoon" else "Evening" end );
Select date, dayname(date) from sales;
Alter table sales add column day_name varchar(30);
Update sales set day_name = dayname(date);
Select date, monthname(date) from sales;
Alter table sales add column month_name varchar(20);
Update sales set month_name = monthname(date);
Analyzing Product Data
Select distinct(city) from sales;
Select distinct(branch) from sales;
Select distinct city, branch from sales;
Select count(distinct product_line) from sales;
Select payment, count( payment) as cnt from sales group by payment order by cnt desc;
Select product_line, count(product_line) as mstsll from sales group by product_line order by mstsll desc;
Select month_name as mnt, sum(total) from sales group by mnt order by mnt desc;
Select sum(cogs) as cg, month_name from sales group by month_name order by cg desc;
Select product_line, sum(total) as total_revenue from sales group by product_line order by total_revenue desc;
Select city, sum(total) as total_revenue from sales group by city order by total_revenue desc;
Select product_line, avg(tax_pct) as total_vat from sales group by product_line order by total_vat desc;
Select branch, sum(quantity) as avg_qua from sales group by branch order by avg_qua desc;
Select gender, product_line, count(gender) as gen from sales group by gender, product_line order by gen desc;
Select avg(rating), product_line from sales group by product_line order by avg(rating) desc;
Sales Data
Select count(time_of_day) as total_sales, time_of_day from sales where day_name="Tuesday" group by time_of_day order by total_sales desc;
Select customer_type, sum(total) as total_revenue from sales group by customer_type order by total_revenue desc;
Select city, avg(tax_pct) as lgst_tax from sales group by city order by lgst_tax desc;
Select customer_type, avg(tax_pct) as cust_tax from sales group by customer_type order by cust_tax desc;
Select distinct(customer_type) from sales;
Select distinct(payment) from sales;
Select customer_type, count(customer_type) as most_common from sales group by customer_type order by most_common desc;
To run the queries, you can copy and paste them into a SQL editor or command line interface and execute them. The queries are designed to be self-explanatory and provide answers to various questions related to the sales data.