-- Activites 1: Creating DB / table

CREATE DATABASE Harini_Activities;
CREATE TABLE salesman (salesman_id int primary key, name varchar(20), city varchar(20), commission int);
DESCRIBE salesman;

-- --------------------------------------------------------------------

-- Activites 2: Inserting values

INSERT INTO salesman VALUES (5001, 'James Hoog', 'New York', 15);
INSERT INTO salesman VALUES (5002, 'Nail Knite', 'Paris', 13);
INSERT INTO salesman VALUES (5003, 'Pit Alex', 'London', 11);
INSERT INTO salesman VALUES (5006, 'McLyon', 'Paris', 14);
INSERT INTO salesman VALUES (5007, 'Paul Adam', 'Rome', 13);
INSERT INTO salesman VALUES (5005, 'Lauson Hen', 'San Jose', 12);

-- --------------------------------------------------------------------

-- Activites 3: Viewing the DB

SELECT * FROM salesman;
SELECT salesman_id, city FROM salesman;
SELECT * FROM salesman WHERE city = 'Paris';
SELECT salesman_id, commission FROM salesman WHERE name='Paul Adam';

-- --------------------------------------------------------------------

-- Activites 4 & 5: Update / Alter

-- Add the grade column
ALTER TABLE salesman ADD grade int;

-- Update the values in the grade column
UPDATE salesman SET grade = 100;

-- Display data
SELECT * FROM salesman;

-- Update the grade score of salesmen from Rome to 200.
UPDATE salesman SET grade=200 WHERE city='Rome';

-- Update the grade score of James Hoog to 300.
UPDATE salesman SET grade=300 WHERE name='James Hoog';

-- Update the name McLyon to Pierre.
UPDATE salesman SET name='Pierre' where name='McLyon';

-- --------------------------------------------------------------------

-- Activity 6: Filtering & Sorting

CREATE TABLE orders(order_no int primary key, purchase_amount float, order_date date, customer_id int, salesman_id int);
INSERT INTO orders VALUES (70001, 150.5, '2012-10-05', 3005, 5002), (70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001), (70004, 110.5, '2012-08-17', 3009, 5003),
(70007, 948.5, '2012-09-10', 3005, 5002), (70005, 2400.6, '2012-07-27', 3007, 5001),
(70008, 5760, '2012-08-15', 3002, 5001), (70010, 1983.43, '2012-10-10', 3004, 5006),
(70003, 2480.4, '2012-10-10', 3009, 5003), (70012, 250.45, '2012-06-27', 3008, 5002),
(70011, 75.29, '2012-08-17', 3003, 5007), (70013, 3045.6, '2012-04-25', 3002, 5001);

-- Get all salesman ids without any repeated values
SELECT DISTINCT salesman_id FROM orders;

-- Display the order number ordered by date in ascending order
SELECT order_no, order_date FROM orders ORDER BY order_date ASC;

-- Display the order number ordered by purchase amount in descending order
SELECT order_no, purchase_amount FROM orders ORDER BY purchase_amount DESC;

-- Display the full data of orders that have purchase amount less than 500.
SELECT * FROM orders WHERE purchase_amount < 500;

-- Display the full data of orders that have purchase amount between 1000 and 2000.
SELECT * FROM orders WHERE purchase_amount BETWEEN 1000 AND 2000;

-- --------------------------------------------------------------------

-- Activity 7: Aggregation

-- Write an SQL statement to find the total purchase amount of all orders.
SELECT SUM(purchase_amount) TotalPurchaseAmount FROM orders;

-- Write an SQL statement to find the average purchase amount of all orders.
SELECT AVG(purchase_amount) AS "AveragePurchaseAmount" FROM orders;

-- Write an SQL statement to get the maximum purchase amount of all the orders.
SELECT MAX(purchase_amount) AS "MaximumPurchaseAmount" FROM orders;

-- Write an SQL statement to get the minimum purchase amount of all the orders.
SELECT MIN(purchase_amount) AS "MinimumPurchaseAmount" FROM orders;

-- Write an SQL statement to find the number of salesmen listed in the table.
SELECT COUNT(DISTINCT salesman_id) NumberOfSalesmen FROM orders;

-- --------------------------------------------------------------------

-- Activity 8: Grouping

-- Write an SQL statement to find the highest purchase amount ordered by the each customer with their ID and highest purchase amount.
SELECT customer_id, MAX(purchase_amount) MaxPurchaseAmount FROM orders GROUP BY customer_id;

-- Write an SQL statement to find the highest purchase amount on '2012-08-17' for each salesman with their ID.
SELECT salesman_id, order_date, MAX(purchase_amount) MaxPurchaseAmount FROM orders WHERE order_date = '2012-08-17' GROUP BY salesman_id;

-- Write an SQL statement to find the highest purchase amount with their ID and order date, for only those customers who have a higher purchase amount within the list 2030, 3450, 5760, and 6000.
SELECT customer_id, order_date, MAX(purchase_amount) MaxPurchaseAmount FROM orders GROUP BY customer_id, order_date HAVING MAX(purchase_amount) IN(2030, 3450, 5760, 6000);

-- --------------------------------------------------------------------

-- Understanding JOINs

CREATE TABLE myorders(order_no int primary key, purchase_amount float, order_date date, customer_id int, salesman_id int);
INSERT INTO myorders VALUES (70009, 270.65, '2012-09-10', 3001, 5005),
(70004, 110.5, '2012-08-17', 3009, 5003),
(70007, 948.5, '2012-09-10', 3005, 5002),
(70010, 1983.43, '2012-10-10', 3004, 5006),
(70003, 2480.4, '2012-10-10', 3009, 5003), (70012, 250.45, '2012-06-27', 3008, 5002),
(70011, 75.29, '2012-08-17', 3003, 5007);

CREATE TABLE mysalesman (salesman_id int primary key, name varchar(20), city varchar(20), commission int);
INSERT INTO mysalesman VALUES (5001, 'James Hoog', 'New York', 15);
INSERT INTO mysalesman VALUES (5002, 'Nail Knite', 'Paris', 13);
INSERT INTO mysalesman VALUES (5003, 'Pit Alex', 'London', 11);
INSERT INTO mysalesman VALUES (5006, 'McLyon', 'Paris', 14);
INSERT INTO mysalesman VALUES (5007, 'Paul Adam', 'Rome', 13);
-- INSERT INTO mysalesman VALUES (5005, 'Lauson Hen', 'San Jose', 12);

SELECT s.salesman_id, s.name, o.order_no FROM mysalesman s INNER JOIN myorders o ON s.salesman_id = o.salesman_id;
-- SELECT salesman.salesman_id, salesman.name, orders.order_no FROM salesman INNER JOIN orders ON salesman.salesman_id = orders.salesman_id;

SELECT s.salesman_id, s.name, o.order_no FROM mysalesman s LEFT JOIN myorders o ON s.salesman_id = o.salesman_id;
SELECT s.salesman_id, s.name, o.order_no FROM myorders o LEFT JOIN mysalesman s ON o.salesman_id = s.salesman_id;

SELECT s.salesman_id, s.name, o.order_no FROM mysalesman s RIGHT JOIN myorders o ON s.salesman_id = o.salesman_id;
SELECT s.salesman_id, s.name, o.order_no FROM myorders o RIGHT JOIN mysalesman s ON o.salesman_id = s.salesman_id;

-- SELECT s.salesman_id, s.name, o.order_no FROM salesman s FULL JOIN orders o ON s.salesman_id = o.salesman_id WHERE s.salesman_ID = 5003;
-- SELECT s.salesman_id, s.name, o.order_no FROM orders o FULL OUTER JOIN salesman s ON o.salesman_id = s.salesman_id;

select set1.id,set2.name from set1
left join set2 on set1.id=set2.id
union 
select set1.id,set1.name from set1
right join set2 on set1.id=set2.id;

SELECT m1.salesman_id, m2.salesman_id, m1.name FROM mysalesman m1, mysalesman m2;

-- --------------------------------------------------------------------

-- Activity 9: Joins

-- Create the customers table
create table customers (customer_id int primary key, customer_name varchar(32), city varchar(20), grade int, salesman_id int);

-- Insert values into it
insert into customers values 
(3002, 'Nick Rimando', 'New York', 100, 5001), (3007, 'Brad Davis', 'New York', 200, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002), (3008, 'Julian Green', 'London', 300, 5002),
(3004, 'Fabian Johnson', 'Paris', 300, 5006), (3009, 'Geoff Cameron', 'Berlin', 100, 5003),
(3003, 'Jozy Altidor', 'Moscow', 200, 5007), (3001, 'Brad Guzan', 'London', 300, 5005);

-- Write an SQL statement to know which salesman are working for which customer

SELECT c.customer_id, c.customer_name, s.salesman_id, s.name AS "Salesman" FROM customers c INNER JOIN salesman s WHERE c.salesman_id=s.salesman_id;

-- Make a list in ascending order for the customer who holds a grade less than 300 and works either through a salesman

SELECT a.customer_name, a.city, a.grade, b.name AS "Salesman", b.city FROM customers a LEFT OUTER JOIN salesman b ON a.salesman_id=b.salesman_id WHERE a.grade<300 ORDER BY a.customer_id;

-- find the list of customers who appointed a salesman for their jobs who gets a commission from the company is more than 12%

SELECT c.customer_name, s.name AS 'Salesman', s.salesman_id, s.commission FROM customers c INNER JOIN salesman s ON c.salesman_ID=s.salesman_id WHERE s.commission>12;

-- find the details of a order i.e. order number, order date, amount of order, which customer gives the order and which salesman works for that customer and commission rate he gets for an order

SELECT o.order_no, o.order_date, o.purchase_amount, c.customer_name, s.name AS "salesman_name", s.commission FROM orders o 
INNER JOIN customers c ON o.salesman_id=c.salesman_id 
INNER JOIN salesman s ON o.salesman_id=s.salesman_id;

-- --------------------------------------------------------------------

-- Activity 10: Subquery

-- find all the orders issued against the salesman who may works for customer whose id is 3007

SELECT order_no FROM orders WHERE salesman_id = (SELECT DISTINCT salesman_id FROM orders WHERE customer_id = 3007);

-- find all orders attributed to a salesman in New York

SELECT o.order_no FROM orders o WHERE o.salesman_id IN (SELECT s.salesman_id FROM salesman s WHERE s.city='New York');

-- count the customers with grades above New York's average

SELECT COUNT(*) FROM customers WHERE grade > (SELECT AVG(grade) FROM customers WHERE city='New York');
SELECT grade, COUNT(*) FROM customers
GROUP BY grade HAVING grade>(SELECT AVG(grade) FROM customers WHERE city='New York');

-- extract the data from the orders table for those salesman who earned the maximum commission

SELECT * FROM orders WHERE salesman_id = 
(SELECT salesman_id FROM salesman WHERE commission = 
(SELECT MAX(commission) FROM salesman));

-- --------------------------------------------------------------------

-- Activity 11: Subquery

-- query that produces the name and number of each salesman and each customer with more than one current order. Put the results in alphabetical order

SELECT customer_id, customer_name FROM customers a
WHERE 1<(SELECT COUNT(*) FROM orders b WHERE a.customer_id = b.customer_id)
UNION
SELECT salesman_id, name FROM salesman a
WHERE 1<(SELECT COUNT(*) FROM orders b WHERE a.salesman_id = b.salesman_id)
ORDER BY customer_name;

-- query to make a report of which salesman produce the largest and smallest orders on each date. Also add a column that shows "highest on" and "lowest on" values

SELECT a.salesman_id, name, order_no, 'highest on', order_date FROM salesman a, orders b
WHERE a.salesman_id=b.salesman_id
AND b.purchase_amount=(SELECT MAX(purchase_amount) FROM orders c WHERE c.order_date = b.order_date)
UNION
SELECT a.salesman_id, name, order_no, 'lowest on', order_date FROM salesman a, orders b
WHERE a.salesman_id=b.salesman_id
AND b.purchase_amount=(SELECT MIN(purchase_amount) FROM orders c WHERE c.order_date = b.order_date);