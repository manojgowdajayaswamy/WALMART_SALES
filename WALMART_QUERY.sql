create database if not exists WalmartSalesData;

-- Create table
CREATE TABLE IF NOT EXISTS sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2, 1)
);




select 
	time,
	(case
		when `time` between "00:00:00" and "12:00:00" then "Morning"
		when `time` between "12:01:00" and "16:00:00" then "Afternoon"
        else "Evening"
	end
    ) as time_of_date
from sales;

alter table sales add column time_of_day varchar(30); 

update sales
set time_of_day = (
case
		when `time` between "00:00:00" and "12:00:00" then "Morning"
		when `time` between "12:01:00" and "16:00:00" then "Afternoon"
        else "Evening"
	end
);


----- day name

select date,
dayname(date)
 from sales;

alter table sales add column day_name varchar(30);

update sales
set day_name = dayname(date);
-- monthname
select date,
monthname(date)
from sales;

alter table sales add column month_name varchar(20);
update sales
set month_name = monthname(date);

-- ---------- PRODUCT ANALYSIS---------------------

-- --- How many cities does the data have?

select distinct(city)
from sales;

select distinct(branch)
from sales;

-- branch and city
select distinct city, branch
from sales;

 -- unique product line
 
select count(distinct product_line)
from sales;

-- most common payment method

select payment, count( payment) as cnt
from sales
group by payment
order by cnt desc;

-- most selling porduct line

select product_line, count(product_line) as mstsll
from sales
group by product_line
order by mstsll desc;

-- total revenue by month
select month_name as mnt, sum(total)
from sales
group by mnt
order by mnt desc;

-- largest cogs month

select sum(cogs) as cg, month_name
from sales
group by month_name
order by cg desc;


-- largest revenue product line

select product_line, sum(total) as total_revenue
from sales
group by product_line
order by total_revenue desc;

-- city with largest revenue


select city, sum(total) as total_revenue
from sales
group by city
order by total_revenue desc;

-- product line with largest vat

select product_line, avg(tax_pct) as total_vat
from sales
group by product_line
order by total_vat desc;

-- avg product sold
select branch, sum(quantity) as avg_qua
from sales
group by branch
order by avg_qua desc;

-- most common product line by gender

select gender, product_line, count(gender) as gen
from sales
group by gender, product_line
order by  gen  desc; 
-- avg rating of product line

select avg(rating), product_line
from sales
group by product_line
order by avg(rating) desc;


-- --------- SALES--------------------
-- sales done during weekday based on time period
select  count(time_of_day) as total_sales, time_of_day
from sales
where day_name="Tuesday"
group by time_of_day
order by total_sales desc;

--
-- customer who brings the most revenue

select customer_type, sum(total) as total_revenue
from sales
group by customer_type
order by total_revenue desc;
-- city with the largest tax or vat

select city, avg(tax_pct) as lgst_tax
from sales
group by city
order by lgst_tax desc;

-- select city, count(city)
-- from sales
-- group by city;

-- most tax by customer type

select customer_type, avg(tax_pct) as cust_tax
from sales
group by customer_type
order by cust_tax  desc;

-- cutomer-------------------------------------------------------------

-- data containing unique customer type
select distinct(customer_type)
from sales;

-- data containing unique payment type
select distinct(payment)
from sales;

-- most common customer types

select customer_type, count(customer_type) as most_common
from sales
group by customer_type
order by most_common desc;



