.open restuarant.db
.mode box
.header on

-- CREATE TABLE
DROP TABLE employees;
CREATE TABLE IF NOT EXISTS employees (
  employee_id INT PRIMARY KEY,
  firstname TEXT,
  lastname TEXT,
  position TEXT,
  salary REAL,
  phone TEXT
);

DROP TABLE menus;
CREATE TABLE IF NOT EXISTS menus (
  menu_id INT PRIMARY KEY ,
  menu_name TEXT,
  menu_price REAL
);

DROP TABLE types;
CREATE TABLE IF NOT EXISTS types (
  type_id INT PRIMARY KEY ,
  type_name TEXT
);


DROP TABLE customers;
CREATE TABLE IF NOT EXISTS  customers (
  customer_id INT PRIMARY KEY,
  firstname TEXT,
  lastname TEXT,
  state TEXT,
  phone TEXT
);
DROP TABLE orders;
CREATE TABLE IF NOT EXISTS orders (
	order_id INT PRIMARY KEY,
  customer_id INT,
  type_id  INT,
	menu_id INT, 
	quantity INT, 
	unit_price REAL
);
DROP TABLE invoices; 
CREATE TABLE IF NOT EXISTS invoices (
  invoice_id INT PRIMARY KEY,
  order_id INT ,
  invoice_date DATE,
  pay_type TEXT,
  total REAL
);

-- INSERT INTO
INSERT INTO employees VALUES
  (1, 'Joe', 'Gizly' , 'Owner', 150000, '089-545-6528'),
  (2, 'Max', 'Powell',  'Manager', 85000, '095-676-7879'),
  (3, 'Oloy', 'Joie', 'Chef', 60000, '084-748-4888'),
  (4, 'Lewy', 'Gisa', 'Chef', 60000, '048-748-4498'),
  (5, 'Yenu', 'Nowas' , 'Chef', 60000, '054-819-7758'),
  (6, 'Yanus', 'Sear', 'Receptionist', 40000, '094-558-5894'),
  (7, 'Vase', 'Desa','Receptionist', 40000, '084-159-4718'),
  (8, 'Yell', 'Romio','Waiter', 40000, '014-819-3758'),
  (9, 'Napu', 'Fazio', 'Waiter', 40000, '036-842-1548'),
  (10, 'Esper', 'Mazax', 'Waiter', 40000, '058-811-1158'); 
 
INSERT INTO menus VALUES
  (1, 'Tom Yum Kung', 250),
  (2, 'Pad Kra Pao Moo', 100),
  (3, 'Kao Pad Kung', 150),
  (4, 'Tom Yum Poe Tak', 180),
  (5, 'Tod Mun Kung', 120),
  (6, 'Rice', 50),
  (7, 'French Fries', 80),
  (8, 'Drinking water', 30),
  (9, 'Mineral water', 60),
  (10, 'Coke', 40),
  (11, 'Coke Zero', 40),
  (12, 'Buffet', 500);

INSERT INTO types VALUES
  (1, 'A la carte'),
  (2, 'Buffet');

INSERT INTO customers VALUES
  (1001, 'Sam', 'Cowel', 'Thong Lor', '084-589-1587'),
  (1002, 'Teerapong', 'Louksombud', 'On Nut', '092-526-4875'),
  (1003, 'Tony', 'Jack', 'Thong Lor', '081-589-8797'),
  (1004, 'Samuel', 'Thosma', 'Bang Sue', '088-559-4787'),
  (1005, 'Kamel', 'Jispa', 'Bang Po', '048-589-1687'),
  (1006, 'Dobunaka', 'Olio', 'Pha Kanong', '047-589-1457'),
  (1007, 'Joel', 'Longbtc', 'Promt Pong', '085-479-6457'),
  (1008, 'MAX', 'Osana', 'Tao Poon', '079-629-9872');


INSERT INTO orders VALUES
  (20001, 1001, 1, 1, 1, 250),
  (20002, 1002, 1, 9, 2, 60),
  (20003, 1003, 2, 12, 1, 500),
  (20004, 1004, 1, 2, 2, 100),
  (20005, 1005, 1, 7, 5, 80),
  (20006, 1006, 2, 12, 1, 500),
  (20007, 1007, 2, 12, 1, 500),
  (20008, 1008, 1, 5, 1, 120);
  


INSERT INTO invoices VALUES
  (45001, 20001, '2022-12-25', 'CASH', 250),
  (45002, 20002, '2022-12-25', 'CASH', 120),
  (45003, 20003, '2022-12-26', 'CASH', 500),
  (45004, 20004, '2022-12-31', 'CASH', 200),
  (45005, 20005, '2022-12-31', 'Credit card', 400),
  (45006, 20006, '2022-12-31', 'Credit card', 500),
  (45007, 20007, '2023-01-01', 'CASH', 500),
  (45008, 20008, '2023-01-01', 'CASH', 500);

-- QUERY 1 หาลูกค้าที่ใช้จ่ายสูงด้วยเงินสด 5 อันดับแรก
.print 'QUERY 1 หาลูกค้าที่ใช้จ่ายสูงด้วยเงินสด 5 อันดับแรก'
SELECT name,pay_type,total FROM (
	SELECT 
	  I.invoice_id,
    C.firstname || ' ' || C.lastname AS name,
    I.pay_type ,
    I.total    
  FROM invoices AS I
  JOIN orders AS O
  ON I.order_id = O.order_id
  JOIN customers AS C
  ON O.customer_id = C.customer_id )
WHERE pay_type = 'CASH'
ORDER BY total DESC
LIMIT 5;

-- QUERY 2 หาเมนูที่ลูกค้าสั่งเยอะที่สุด 3 อันดับแรก
.print 'QUERY 2 หาเมนูที่ลูกค้าสั่งเยอะที่สุด 3 อันดับแรก'
WITH sub AS (
	SELECT * FROM orders AS O
	JOIN menus AS M
	ON O.menu_id = M.menu_id
  	JOIN customers AS C 
  	ON O.customer_id = C.customer_id ) 
SELECT 
	firstname, 
	menu_name ,
	quantity
FROM sub 
GROUP BY 2
ORDER BY 3 DESC
LIMIT 3;


-- QUERY 3 หาพนักงานที่ได้เงินเดือนเยอะที่สุด
.print 'QUERY 3 หาพนักงานที่ได้เงินเดือนเยอะที่สุด'
SELECT 
  firstname ||' ' || lastname AS  Fullname,
  position,
  salary,
  phone
FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees 
                WHERE position IS NOT 'Owner');



-- QUERY 4 หาเมนูที่ลูกค้าสั่งช่วงวันคริสมาสและวันปีใหม่
.print 'QUERY 4 หาเมนูที่ลูกค้าสั่งช่วงวันคริสมาสและวันปีใหม่'
select 
	  I.invoice_date as date,
    M.menu_name ,
    M.menu_price
FROM invoices as I
JOIN orders AS O
ON O.order_id = I.order_id
JOIN menus AS M 
ON o.menu_id= M.menu_id
WHERE invoice_date BETWEEN '2022-12-25' AND '2022-12-31' ;
