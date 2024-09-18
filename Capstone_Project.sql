create database amazon;
use amazon;
select * from amazon;


alter table amazon
add column time_of_day varchar(50);

update amazon
set time_of_day = CASE
   when hour(amazon.Time) >=0 and hour (amazon.Time) < 12 then  'Morning'
   when hour(amazon.Time) >12 and hour (amazon.Time) < 18 then  'Afternoon'
   else 'Evening'
END;   
   
alter table amazon
add column month_name varchar(50);
alter table amazon
rename column month_name to month;

update amazon
set month = date_format(amazon.date, '%b');

select * from amazon;


#What is the count of distinct cities in the dataset?
SELECT COUNT(DISTINCT city) AS distinct_city_count
FROM Amazon;
# 3 distinct cities are there in the dataset
 
 #For each branch, what is the corresponding city?
 Select branch, city from Amazon
 group by branch, city;
 #Here for branch A city is Yanogon, B branch city is Mandalay, C branch city is Naypyitaw
 
 
 
 #Which payment method occurs most frequently?
 SELECT payment, COUNT(payment) AS most_fre_method
FROM Amazon
GROUP BY payment
ORDER BY most_fre_method DESC
LIMIT 1;
#Here Ewallet is the most frequent payment method


#Which product line has the highest sales?
SELECT 
    product_line, COUNT(invoice_id) AS sales_count
FROM
    amazon
GROUP BY product_line
ORDER BY sales_count DESC
LIMIT 1;
#Here Fashion accessories has highest sales-178

#Which product line generated the highest revenue?

select product_line,sum(unit_price*Quantity) as highest_revenue from amazon
group by product_line
order by highest_revenue
limit 1;
#Here Health and beauty has highest revenue

#In which city was the highest revenue recorded?
select city,sum(unit_price*Quantity) as highest_revenue from amazon
group by city
order by highest_revenue
limit 1;
#Here Mandalay has highest revenue
   
#Identify the branch that exceeded the average number of products sold
Select branch, sum(Quantity) as total_quantity
from amazon
group by branch
having sum(Quantity) > (select avg(Quantity)
from amazon);
#Here A exceeds 1859, B exceeds 1831, C exceeds 1820


#Which product line is most frequently associated with each gender?

select gender,product_line, count(*) as frequency
from amazon
group by product_line,gender
having count(*) = (
              select max(sub.frequency)
              from (
                    select gender, product_line, count(*) as frequency
               from amazon
              group by gender, product_line
              ) as sub
		where sub.gender = amazon.gender
        group by sub.gender
        )
	 order by gender;
#Here Females most freuency is Fashion accessories and Male is Health and beauty
   
#Calculate the average rating for each product line.

Select product_line, avg(Rating) as avg_rating
from amazon
group by product_line;
#Data insights in output

#Identify the customer type contributing the highest revenue.

Select customer_type, sum(quantity*unit_price) as customer_type_revenue
from amazon
group by customer_type
order by customer_type_revenue desc;
#Member and Normal customer type contributing highest revenue


#What is the count of distinct customer types in the dataset?
Select count(distinct customer_type) as distinct_customer_type 
from amazon;
#count of distinct customer type is 2


#What is the count of distinct payment methods in the dataset?
Select count(distinct Payment) as distinct_Payment_method 
from amazon;
#count of distinct payment methods is 3

#Which customer type occurs most frequently?
SELECT customer_type, COUNT(customer_type) AS most_fre_method
FROM Amazon
GROUP BY customer_type
ORDER BY most_fre_method DESC
LIMIT 1;
#Member customer type occurs most frequently


#Identify the customer type with the highest purchase frequency
select customer_type,count(*) as purchase_frequency
from amazon
group by customer_type
order by purchase_frequency desc
limit 1;
#Member customer type has highest purchase frequency

#Determine the predominant gender among customers.

Select gender, count(*) as gender_count
from amazon
group by gender
order by gender_count desc
limit 1;
#Female is predominant gender

#Examine the distribution of genders within each branch
select branch, gender, count(*) as dist_of_gender
from amazon
group by branch, gender
order by branch, dist_of_gender desc;
#Insights in output

#Identify the time of day when customers provide the most ratings.

select time_of_day, count(rating) as rating_count
from amazon
group by time_of_day
order by rating_count desc
limit 1;
#In Afternoon time most ratings are given

#Determine the time of day with the highest customer ratings for each branch.
select branch, time_of_day, avg(rating) as avg_rating
from amazon
group by branch, time_of_day
order by avg_rating desc;
#Insights in output

