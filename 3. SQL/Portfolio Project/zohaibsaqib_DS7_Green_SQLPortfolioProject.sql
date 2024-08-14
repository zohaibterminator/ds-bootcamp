USE atomcamp;

# Creating Users table
CREATE TABLE users (
	user_id int,
	name varchar(255),
	email varchar(255),
	password varchar(20)
);

# Inserting data into Users table
INSERT INTO users (user_id, name, email, password) VALUES
(1, 'Nitish', 'nitish@gmail.com', 'p252h'),
(3, 'Vartika', 'vartika@gmail.com', '9hu7j'),
(4, 'Ankit', 'ankit@gmail.com', 'lkko3'),
(5, 'Neha', 'neha@gmail.com', '3i7qm'),
(6, 'Anupama', 'anupama@gmail.com', '46rdw2'),
(7, 'Rishabh', 'rishabh@gmail.com', '4sw123');

# Creating Restaurants table
CREATE TABLE restaurants (
	r_id int,
	r_name varchar(255),
	cuisine varchar(255)
);

# Inserting data into Restaurants table
INSERT INTO restaurants VALUES
(1,'dominos','Italian'),
(2,'kfc','American'),
(3,'box8','North Indian'),
(4,'Dosa Plaza','South Indian'),
(5,'China Town', 'Chinese');

# Creating Food table
CREATE TABLE food (
	f_id int,
	f_name varchar(255),
	type varchar(255)
);

# Inserting data into Food table
INSERT INTO food VALUES
(1, 'Non-veg Pizza','Non-veg'),
(2, 'Veg Pizza', 'Veg'),
(3, 'Choco Lava cake', 'Veg'),
(4, 'Chicken Wings', 'Non-veg'),
(5, 'Chicken Popcorn', 'Non-veg'),
(6, 'Rice Meal', 'Veg'),
(7, 'Roti meal', 'Veg'),
(8, 'Masala Dosa', 'Veg'),
(9, 'Rava Idli', 'Veg'),
(10,'Schezwan Noodles', 'Veg'),
(11,'Veg Manchurian','Veg');

# Creating Menu table
CREATE TABLE menu (
	menu_id int,
	r_id int,
	f_id int,
	price int
);

# Inserting data into Menu table
INSERT INTO menu (menu_id, r_id, f_id, price) VALUES
(1, 1, 1, 450),
(2, 1, 2, 400),
(3, 1, 3, 100),
(4, 2, 3, 115),
(5, 2, 4, 230),
(6, 2, 5, 300),
(7, 3, 3, 80),
(8, 3, 6, 160),
(9, 3, 7, 140),
(10, 4, 6, 230),
(11, 4, 8, 180),
(12, 4, 9, 120),
(13, 5, 6, 250),
(14, 5, 10, 220),
(15, 5, 11, 180);

# Creating Orders table
CREATE TABLE orders (
	order_id int,
	user_id int,
	r_id int,
	amount int,
	date date, 
	partner_id int,
	delivery_time int,
	delivery_rating int,
	restaurant_rating int
);

# Inserting data into Orders table
INSERT INTO orders (order_id, user_id, r_id, amount, date, partner_id, delivery_time, delivery_rating, restaurant_rating) VALUES
(1001, 1, 1, 550, '2022-05-10', 1, 25, 5, 3),
(1002, 1, 2, 415, '2022-05-26', 1, 19, 5, 2),
(1003, 1, 3, 240, '2022-06-15', 5, 29, 4, NULL),
(1004, 1, 3, 240, '2022-06-29', 4, 42, 3, 5),
(1005, 1, 3, 220, '2022-07-10', 1, 58, 1, 4),
(1006, 2, 1, 950, '2022-06-10', 2, 16, 5, NULL),
(1007, 2, 2, 530, '2022-06-23', 3, 60, 1, 5),
(1008, 2, 3, 240, '2022-07-07', 5, 33, 4, 5),
(1009, 2, 4, 300, '2022-07-17', 4, 41, 1, NULL),
(1010, 2, 5, 650, '2022-07-31', 1, 67, 1, 4),
(1011, 3, 1, 450, '2022-05-10', 2, 25, 3, 1),
(1012, 3, 4, 180, '2022-05-20', 5, 33, 4, 1),
(1013, 3, 2, 230, '2022-05-30', 4, 45, 3, NULL),
(1014, 3, 2, 230, '2022-06-11', 2, 55, 1, 2),
(1015, 3, 2, 230, '2022-06-22', 3, 21, 5, NULL),
(1016, 4, 4, 300, '2022-05-15', 3, 31, 5, 5),
(1017, 4, 4, 300, '2022-05-30', 1, 50, 1, NULL),
(1018, 4, 4, 400, '2022-06-15', 2, 40, 3, 5),
(1019, 4, 5, 400, '2022-06-30', 1, 70, 2, 4),
(1020, 4, 5, 400, '2022-07-15', 3, 26, 5, 3),
(1021, 5, 1, 550, '2022-07-01', 5, 22, 2, NULL),
(1022, 5, 1, 550, '2022-07-08', 1, 34, 5, 1),
(1023, 5, 2, 645, '2022-07-15', 4, 38, 5, 1),
(1024, 5, 2, 645, '2022-07-21', 2, 58, 2, 1),
(1025, 5, 2, 645, '2022-07-28', 2, 44, 4, NULL);

# Creating Delivery Partners table
CREATE TABLE delivery_partners (
  partner_id INT,
  partner_name VARCHAR(50)
);

# Inserting data into Delivery Partners table
INSERT INTO delivery_partners (partner_id, partner_name) VALUES
(1, 'Suresh'),
(2, 'Amit'),
(3, 'Lokesh'),
(4, 'Kartik'),
(5, 'Gyandeep');

# Creating Order Details table
CREATE TABLE order_details (
  id INT,
  order_id INT,
  f_id INT
);

# Inserting data into Order Details table
INSERT INTO order_details (id, order_id, f_id) VALUES
(1, 1001, 1),
(2, 1001, 3),
(3, 1002, 4),
(4, 1002, 3),
(5, 1003, 6),
(6, 1003, 3),
(7, 1004, 6),
(8, 1004, 3),
(9, 1005, 7),
(10, 1005, 3),
(11, 1006, 1),
(12, 1006, 2),
(13, 1006, 3),
(14, 1007, 4),
(15, 1007, 3),
(16, 1008, 6),
(17, 1008, 3),
(18, 1009, 8),
(19, 1009, 9),
(20, 1010, 10),
(21, 1010, 11),
(22, 1010, 6),
(23, 1011, 1),
(24, 1012, 8),
(25, 1013, 4),
(26, 1014, 4),
(27, 1015, 4),
(28, 1016, 8),
(29, 1016, 9),
(30, 1017, 8),
(31, 1017, 9),
(32, 1018, 10),
(33, 1018, 11),
(34, 1019, 10),
(35, 1019, 11),
(36, 1020, 10),
(37, 1020, 11),
(38, 1021, 1),
(39, 1021, 3),
(40, 1022, 1),
(41, 1022, 3),
(42, 1023, 3),
(43, 1023, 4),
(44, 1023, 5),
(45, 1024, 3),
(46, 1024, 4),
(47, 1024, 5),
(48, 1025, 3),
(49, 1025, 4),
(50, 1025, 5);


-- 1. Find customers who have never ordered
SELECT user_id, name
FROM users
WHERE user_id NOT IN (
	SELECT user_id
	FROM orders
);

-- 2. Average Price/dish
SELECT r.r_id, r.r_name, ROUND(AVG(m.price), 2) AS "Average Price"
FROM restaurants r
INNER JOIN menu m ON r.r_id=m.r_id
GROUP BY r.r_id, r.r_name;

-- 3. Find the top restaurant in terms of the number of orders for a given month (I am picking June)

set global sql_mode='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
set session sql_mode='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

SELECT o.r_id, r.r_name, COUNT(o.order_id), MONTH(o.date)
FROM orders o
INNER JOIN restaurants r ON o.r_id=r.r_id
WHERE MONTH(o.date) = 6
GROUP BY o.r_id, MONTH(o.date)
ORDER BY COUNT(o.order_id) desc
LIMIT 1;

-- 4. Restaurants with monthly sales greater than 1000
SELECT o.r_id, r.r_name, SUM(o.amount)
FROM orders o
INNER JOIN restaurants r ON o.r_id=r.r_id
GROUP BY o.r_id, MONTH(o.date)
HAVING SUM(o.amount) > 1000;

-- 5. Show all orders with order details for a customer with customer ID 1 between the dates 2022-05-05 and 2022-06-16
SELECT u.user_id, u.name, o.order_id, f.f_name
FROM users u
INNER JOIN orders o ON u.user_id=o.user_id
INNER JOIN order_details od ON o.order_id=od.order_id
INNER JOIN food f ON od.f_id=f.f_id
WHERE o.date BETWEEN '2022-05-05' AND '2022-06-16' AND u.user_id=1
ORDER BY o.order_id asc;

-- 6. Find restaurants with max repeated customers
SELECT o.r_id, r.r_name, COUNT(o.user_id)
FROM orders o
INNER JOIN restaurants r ON o.r_id=r.r_id
GROUP BY o.r_id
ORDER BY COUNT(o.user_id) desc
LIMIT 1;

-- 7. Month over month revenue growth of Swiggy
SELECT SUM(amount), MONTH(date)
FROM orders
GROUP BY MONTH(date)
ORDER BY MONTH(date) asc;

-- 8. Customer — favourite food
SELECT u.user_id, u.name, f.f_name, COUNT(od.f_id) AS order_count
FROM users u
JOIN orders o ON u.user_id = o.user_id
JOIN order_details od ON o.order_id = od.order_id
JOIN food f ON od.f_id = f.f_id
GROUP BY u.user_id, u.name, f.f_name
ORDER BY u.user_id, order_count DESC;

-- 9. Find the most loyal customers for all restaurants
SELECT r.r_name, u.user_id, u.name, COUNT(o.order_id) AS order_count
FROM orders o
JOIN users u ON o.user_id = u.user_id
JOIN restaurants r ON o.r_id = r.r_id
GROUP BY r.r_name, u.user_id, u.name
ORDER BY r.r_name, order_count DESC;

-- 10. Month-over-month revenue growth of a restaurant
WITH RestaurantMonthlyRevenue AS (
    SELECT r.r_id, r.r_name, EXTRACT(YEAR FROM o.date) AS year, EXTRACT(MONTH FROM o.date) AS month, SUM(o.amount) AS revenue
    FROM orders o
    JOIN restaurants r ON o.r_id = r.r_id
    GROUP BY r.r_id, r.r_name, EXTRACT(YEAR FROM o.date), EXTRACT(MONTH FROM o.date)
),
RestaurantMonthlyGrowth AS (
    SELECT r_id, r_name, year, month, revenue,
           LAG(revenue) OVER (PARTITION BY r_id ORDER BY year, month) AS prev_revenue
    FROM RestaurantMonthlyRevenue
)
SELECT r_id, r_name, year, month, revenue,
       (revenue - prev_revenue) / prev_revenue * 100 AS revenue_growth
FROM RestaurantMonthlyGrowth
WHERE prev_revenue IS NOT NULL;
