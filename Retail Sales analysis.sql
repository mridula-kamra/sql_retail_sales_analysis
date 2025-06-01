-- SQL Retail Sales analysis - project 1
-- To see the complete data
select * from retail_sales;
-- To check the total number of records in our data
select count(*) from retail_sales;
-- Data Cleaning
-- To check if there is any null values in the data
select * from retail_sales
where transactions_id is null
or sale_date is null
or sale_time is null
or customer_id is null
or gender is null
or age is null
or category is null
or quantiy is null
or price_per_unit is null
or cogs is null
or total_sale is null;

-- To delete the null values present in data
delete from retail_sales
where transactions_id is null
or sale_date is null
or sale_time is null
or customer_id is null
or gender is null
or age is null
or category is null
or quantiy is null
or price_per_unit is null
or cogs is null
or total_sale is null;

-- Data Analysis and Business Key Problems
-- Q1 Write a SQL query to retrieve all columns for sales made on '2022-01-05
select * from retail_sales
where sale_date = '2022-01-05';

/* Q2 Write a SQL query to retrieve all transactions where the category is 'Beauty'
and  the quantity sold is more than 3 in the month of Nov-2022 */
select * from retail_sales
where category = 'Beauty'
and quantiy > 3
and year(sale_date)=2022
and month(sale_date)=11;

/* Q3 Write a SQL query to calculate the total sales (total_sales) 
for each category */
select category, sum(total_sale) as total_sales from retail_sales
group by category;

/* Q4 Write a SQL query to find the average age of customers 
who purchased items from the 'Beauty' category */
select category, avg(age) from retail_sales
where category = 'Beauty';

/* Q5 Write a SQL query to find all transactions 
where the total_sale is greater than 1000 */
select * from retail_sales
where total_sale >1000;

/* Q6 Write a SQL query to find the total number of transactions (transaction_id) 
made by each gender in each category */
select category, gender, count(transactions_id) from retail_sales
group by category, gender;

/* Q7 Write a SQL query to calculate the average sale for each month.
Find out best selling month in each year */
-- For average sale for each month
select year(sale_date) as sale_year,
month(sale_date) as sale_month,
avg(total_sale) as average_sale from retail_sales 
group by sale_year, sale_month
order by sale_year, average_sale DESC;
-- Best selling month in each year
select year(sale_date) as sale_year,
month(sale_date) as sale_month,
sum(total_sale) as total_monthly_sale,
rank() over( partition by year(sale_date)
order by sum(total_sale) DESC ) as sales_rank
from retail_sales
group by year(sale_date), month(sale_date)
having sales_rank =1
order by sale_year, sale_month;

/* Q8 Write a SQL query to find the top 5 customers based on the highest total sales */
select customer_id, sum(total_sale) as total_sales
from retail_sales
group by customer_id
order by total_sales DESC
limit 5;

/* Q9 Write a SQL query to find the number of unique customers 
who purchased items from each category */
select  count(distinct customer_id) as unique_customer_id, category
from retail_sales
group by category;

/* Q10 Write a SQL query to create each shift and number of orders */
select
case when hour(sale_time) between 6 and 11 then 'Morning'
when hour(sale_time) between 12 and 17 then 'Afternoon'
when hour(sale_time) between 18 and 22 then 'Evening'
else 'Night'
end as shift,
count(*) as number_of_orders
from retail_sales
group by shift
order by number_of_orders DESC;