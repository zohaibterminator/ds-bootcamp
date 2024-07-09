/* DS 7 
● Remaining: Full join, Self JOIN, Cross join 
● Subqueries
● CTE

a = {1,2,3, 4}
b = {4,5,6, 7}
a U b = {1,2,3,4,5,6,7}
*/

-- Full Join
-- Include all data from customers and purchase history


select c.*, ph.*
from customer c
left join purchase_history ph
on c.customer_id =ph.customer_id

union

select c.*, ph.*
from customer c
right join purchase_history ph
on c.customer_id = ph.customer_id;

 
-- Self join
-- contact numbers
-- 2 friends/ members having same phone/ contact number
-- duplicates 

select * from customer;
select c1.first_name as customer_1,
c2.first_name as customer_2,
c2.phone_number as customer_2_phone
from customer c1
join customer c2
on c1.phone_number = c2.phone_number
and c1.customer_id <> c2.customer_id;





-- Exercise 1: Find products within the same category
select * from products;
select p1.product_name As Product1_Name,
p2.product_name As Product2_Name,
p1.category
from products p1
Join products p2
on p1.category = p2.category
and p1.product_id <> p2.product_id;


-- Exercise 2: Which customers live in the same city?
select * from customer;
SELECT 
    c1.first_name AS customer_1,
    c2.first_name AS customer_2,
    c2.city AS city
FROM
    customer c1
        JOIN
    customer c2 ON c1.city = c2.city
        AND c1.customer_id <> c2.customer_id;


-- Exercise 3: Which products have similar prices?
SELECT 
    p1.product_id AS p1_ID,
    p1.product_name AS p1_Name,
    p2.product_id AS p2_ID,
    p2.product_name AS p2_Name,
    ABS(p1.price_per_unit - p2.price_per_unit) AS price_difference
FROM
    products p1
        JOIN
    products p2 ON p1.product_id < p2.product_id
WHERE
    ABS(p1.price_per_unit - p2.price_per_unit) < 3;







-- Cross Join
-- cartesion product
/*
subjects: maths , urdu , english
students: ahmad, usman, zia

maths ahmad
maths usman
maths zia
urdu ahmad
urdu usman
urdu zia
english ahmad
english usman
english zia
*/
-- Exercise: Pair each category with brand 
-- cross + self join
select * from products;
SELECT 
    p1.category, p2.brand
FROM
    products p1
        CROSS JOIN
    products p2;
    
    
    SELECT 
   distinct p1.category, p2.brand
FROM
    products p1
        CROSS JOIN
    products p2
    order by p1.category, p2.brand;



-- SUBQUERIES: Nested queries

SELECT avg(price_per_unit) FROM products;
-- '19.91466666666667'

-- list down products with price greater than average
select *
from products
where price_per_unit >  (SELECT avg(price_per_unit) FROM products);
-- price > 19.91466666666667  (single value / row)
-- where student is enrolled / exists in this column
-- student_id in column ( 1,2,5,9,10,15)   (multiple row subq qeury)
-- student_fee , student_result => column( paid/ upnaid, pass.fail) (multiple column subqeury)



/*
single- row subquery => Single value / row  average,sum, count or any aggregate fucntion
multiple- row subquery => multiple rows AND a single column
multiple-column subquery => multiple columns

we can use subquery in select statement, case statement, from , where 
*/

-- Single-row Subquery 
-- Returns only one row and one column, typically used with single-value comparisons.
-- Exercise: Display details of product which has the highest price?

select * from products;
-- Method-1
select max(price_per_unit) from products;
SELECT 
    *
FROM
    products
WHERE
    price_per_unit = 30;

-- Method 2
SELECT 
    *
FROM
    products
ORDER BY price_per_unit DESC
LIMIT 1;


-- Using Subquery
SELECT 
    *
FROM
    products
WHERE
    price_per_unit = (SELECT MAX(price_per_unit) FROM products);



-- Multi-Row Subquery:
-- Returns multiple rows but only one column, often used with operators like IN.
-- Exercise 1: Find the product details for products that have been purchased.

select *
 from products
 where product_id in ( select distinct product_id from purchase_history) ;



-- using joins
select distinct p.*
from products p 
inner join purchase_history ph
on ph.product_id = p.product_id;




-- Exercise 2: List the names of customers who have made purchases of a product with a specific product_id (e.g., product_id = 1).
SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT DISTINCT customer_id
    FROM purchase_history where product_id=1
);


-- Subqueries in SELECT:
-- Exercise: How many products are there in the database, and what is the total sales amount across all products?
select count(*) from products;
select sum(total_amount) from purchase_history;

SELECT 
    COUNT(*) as total_products,
    (select sum(total_amount) from purchase_history) as "Total sales"
FROM
    products;



-- Subqueries in Case Statement
-- Exercise: Label products as "Expensive" if price per unit is above the average , "Not Expensive" if below.

select avg(price_per_unit) from products;

SELECT 
    *,
    CASE
        WHEN price_per_unit > (select avg(price_per_unit) from products) THEN 'Expensive'
        ELSE 'Not expensive'
    END AS Price_Status
FROM
    products;



