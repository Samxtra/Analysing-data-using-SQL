create database Project;
create table sales (
SALES_ID INT,
PRODUCT_ID int,
CUSTOMER_NAME CHAR(65),
LOCATION char(56),
SALESPERSON VARCHAR(65),
CUSTOMER_TYPE varchar(65),
DOV date,
QUANTITY int,
VALUE_IN_RUPIAH DECIMAL (18, 2))
;
select*from sales;
describe sales;
insert into sales(SALES_ID,PRODUCT_ID,CUSTOMER_NAME,LOCATION,SALESPERSON,
CUSTOMER_TYPE,DOV,QUANTITY,VALUE_IN_RUPIAH)
values
(1,100,"Holiday Inn","Bendung","Gates","Hotel","2019-10-01",25,50000000.00),
(2,200,"Mckinsey","Jakarta","Kristi","Corporate","2019-11-01",300,35000000.00),
(3,300,"Ritz Carlton","Jakarta","Oprah","Hotel","2019-12-01",40,65000000.00),
(4,100,"McD","Makassar","Mark","Restaurant","2018-10-01",60,85000000.00),
(5,200,"Sate 
Senayan","Bali","Mercy","Restaurant","2018-11-01",220,29000000.00),
(6,300,"Hypermart","Medan","Frans","Retail","2018-12-01",20,22000000.00),
(7,100,"Holiday Inn","Jakarta","Gates","Hotel","2016-10-01",29,58000000.00),
(8,200,"McD","Jakarta","Mark","Restaurant","2016-11-01",100,200000000.00),
(9,300,"Sate Senayan","Jakarta","Mercy","Restaurant","2016-12-01",150,19000000.00),
(10,100,"Grand Hayat","Jakarta","Merry","Hotel","2017-10-01",33,58000000.00),
(11,200,"Microsoft","Jakarta","Kristi","Corporate","2017-11-01",22,40000000.00),
(12,300,"Google","Jakarta","William","Corporate","2017-12-01",150,18000000.00);
select*from sales;
create table Product (
PRODUCT_ID INT,
PRODUCT_NAME varchar(65),
BRAND char(56),
UOM varchar(65));
select*from product;
describe product;
insert into product(PRODUCT_ID,PRODUCT_NAME,BRAND,UOM)
values
(100,"llly Ground 250 Gr","illy","Kg"),
(200,"Viktory Ground 500 Gr","Viktory","Kg"),
(300,"San Pellegrino Spankling 500 Ml","Water","Bottle"),
(400,"Mango Puree Sorbetto","Ice Cream","Kg");
select*from product;
select*from sales

-- Q1--
/*Suppose you work for a company and your manager says 
you should get the Sales report where the value is greater
than or equal to 30,000,000 and rank them from largest to smallest value*/
 
where VALUE_IN_RUPIAH >=30000000
order by VALUE_IN_RUPIAH desc;

-- Q2--
/*Get only the customer name, customer type, date, value, 
from the sales table and sort them by date (newest to oldest)*/

select customer_name,
customer_type,dov,value_in_rupiah
from sales 
order by dov desc;

-- Q3--
/*From the above query(maintaining the arrangement), 
you are asked to change customer _type to channel temporarily*/

select customer_name,
customer_type as Channel, dov,value_in_rupiah
from sales 
order by dov desc;

-- Q4--
/*Your manager wants to know who is the 
big contributor based on Customer type*/

select customer_type, 
sum(value_in_rupiah)
as total_contribution
from sales
group by CUSTOMER_TYPE
order by total_contribution desc;

-- Q5--
/*Your manager wants you to join the sales 
and product table in order to get more details about 
the products that have been sold*/

select * from sales Join product
on
sales.PRODUCT_ID=product.PRODUCT_ID;

-- Q6--
/*Using the query above, a sales person named 
Kristi asked you to extract her records from 
2017 to 2019 sorted from largest to smallest*/

select *from sales join product 
on sales.PRODUCT_ID = product.PRODUCT_ID
where SALESPERSON = "Kristi" 
AND extract(year from DOV)
between 2017 and 2019
order by VALUE_IN_RUPIAH desc;

-- Q7--
/*Get all the products and their corresponding sales information, if any*/
select * from product
left join sales
on product.PRODUCT_ID = sales.PRODUCT_ID;


-- Q8--
/*Do data aggregation or summarization 
of the table and get the
(a) total sales (b) average sales
(c) minimum sales (d) maximum sales*/

select sum(VALUE_IN_RUPIAH) as total_sales,
avg(VALUE_IN_RUPIAH) as average_sales,
min(VALUE_IN_RUPIAH) as Minimum_sales,
max(VALUE_IN_RUPIAH) as maximum_sales
from sales;

-- Q9--
/*Helping us gain a deeper understanding of the data
Get the total quantity, total sales and total price sold 
for each product in the database table*/

select product.PRODUCT_ID, 
product.PRODUCT_NAME,
sum(QUANTITY) as Total_quantity,
sum(VALUE_IN_RUPIAH) as Total_sales,
sum(VALUE_IN_RUPIAH) as Total_Price_Sold
from product join sales
on product.PRODUCT_ID=sales.PRODUCT_ID
group by product.PRODUCT_ID,product.PRODUCT_NAME;

-- Q10--
/*Your Manager wants the report on a yearly basis:
Summarize the data to sales report or trends on a yearly basis*/

select year(DOV) as sales_year,
sum(QUANTITY) as Total_quantity,
sum(VALUE_IN_RUPIAH) as Total_sales,
sum(VALUE_IN_RUPIAH) as Total_Price_Sold
from sales 
group by(DOV);




