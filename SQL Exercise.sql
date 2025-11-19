SELECT *
FROM northwind.categories;

USE northwind;

SELECT * 
FROM northwind.categories;
-- We can activate and set default schema
USE northwind;

SELECT * 
FROM categories;
select *
from products;

select *
from orders;

select * from suppliers;

SELECT CustomerName, City, Country 
FROM Customers;

SELECT ProductID, ProductName 
FROM Products;

-- Show all countries.
select country from customers;

-- Show all countries that are distinct.
SELECT DISTINCT Country 
FROM Customers;

-- What are the cities?
SELECT DISTINCT City 
FROM Customers;

-- How many cities are there?
SELECT COUNT(distinct city)
from customers;

-- How many countries are there?
SELECT COUNT(country)
from customers;

-- Any string object except keywords must be contained within quotations '' or ""
select *
from customers
where country= 'mexico';

select *
from customers
where country = "UK";

select * from products
 where price > 100;
 
 -- dates are the exception to this rule ^
 select * from orders
 where orderdate > '1996-07-30';
 
select customername
from customers
where city <> 'madrid';
 
 -- (Show all customers from london)
 select *
 from customers
 where city = 'london';
 
 -- (Show the number of customers from the USA)
select count(*) from customers
where country = 'usa';
 
 -- (Show all customer ID's with 15 or higher)
select *
from customers
where CustomerID >= 15;

-- The AND and OR rules.
select * from customers
where country = 'germany' AND city = 'berlin';
 
select * from customers
where city = 'Lille' OR city = 'berlin';
 
-- What about showing everything except a specific value?
select * from suppliers
where not city= 'london';
-- These show the same result, one has "not" and the other !=.
select * from suppliers
where city != 'london';

-- Show all customers within the UK and London
select * from customers
where country = 'UK' and city= 'london';

-- Show all customers from portland or kirkland
select * from customers
where city = 'portland' or city='kirkland';

-- Show orders placed before 27th Aug 1996 and after 21st Feb 1997
select * from orders
where orderdate <'1996-08-27' OR orderdate >'1997-02-21';

-- What about finding a partial match? Eg Customers name beginning with H?
select * from customers
where customername like 'H%';
-- The % symbol will filter 0 or more characters.
select * from customers
where customername like '%h%';
-- This will show all results containing a 'h'.
-- An underscore is similar to the % however this will show 1 character.
select * from customers
where customername like '%h_';

-- Show all countries that contain the word 'land'.
select * from customers
where country like '%land%';

-- Show all employees that have 'n' as the 2nd character.
select * from employees
where firstname like '_n%';

-- Can we specify multiple OR conditions shorter?
select * from customers
where country IN ('Germany', 'France', 'UK');

select * from customers
where country NOT IN ('Germany', 'France', 'UK');

select * from orders
where ShipperID = 1 OR ShipperID =3;

select * from orders
where customerID <=1;

-- What about finding a range of values?
select * from products
where price BETWEEN 10 AND 20;

SELECT * FROM Products
WHERE Price NOT BETWEEN 10 AND 20;

-- This function will show values in alphabetical order
select * from products
where productname BETWEEN 'chais' and 'chocolade';

-- Is there a way we can sort the data?
select * from products
order by price;

-- And the inverse?
select * from products
order by price DESC;

-- We can also sort within sorting. This below will sort by country descending
-- but within this, the cities will be alphabetical.
select * from customers
ORDER BY country DESC, city, customerID DESC;

-- What about if the data set is too large and we just want the top results?
select * from order_details
ORDER BY quantity DESC
limit 5;
-- ORDER BY is used here otherwise the first 5 rows will be shown (unsorted).

select MAX(price)
from products;

select MIN(price)
from products;
-- MIN and MAX can be used with both integer and string values.
select MAX(productname)
from products;

select MIN(orderdate)
from orders;
-- Can we find the average price of products?
select avg(price)
from products;
-- Total price of all combined products?
select sum(price)
from products;

-- Can we rename using the as function? This shows the data clearly.
select customerID as ID, customername as Customers
from customers;

select customerID as ID, contactname as 'Contact Person'
from customers;
-- We can also combine values as shown below.
-- Concat is formatted by the separator first followed by the values.
SELECT CustomerName, CONCAT_WS(', ', Address, PostalCode, City, Country) AS Address
FROM Customers;

Select * from products 
Where CategoryID =1 OR CategoryID =2
ORDER BY ProductName;

-- How do we join tables? (Reverse Engineer to show diagram with joins) -- Table name followed by column name.
select *
from orders
inner join customers
on orders.customerid = customers.customerid;

-- Then we can change the select to only include what we need from the combined tables.
select CustomerName, Address, OrderID
from orders
inner join customers
on orders.customerid = customers.customerid;

-- 5 Types of JOIN, Inner, Left, Right, Full and Cross.
-- Inner is most useful and will match
-- Left and Right will retrieve full tables without matches from either side.
-- Full brings both (this can result in large data sets)
-- Cross will concat each value (a1,a2,a3,b1,b2,b3)

select CustomerName, Address, OrderID
from orders
right join customers
on orders.customerid = customers.customerid;

select CustomerName, Address, OrderID
from orders
left join customers
on orders.customerid = customers.customerid;

-- How would we find the amount of orders for a specific product?
-- Group by = Show us the count of orders but group the count by product.
-- 1) Combine the tables
-- 2) Group by
-- 3) Count number of orders

select count(orderid), quantity
from products
join order_details
group by products;


-- Write a query to list each product category
-- and the total quantity of products sold in that category.
select categoryname, sum(quantity) as totalquantity
from categories as c
join products as p
on c.categoryid = p.categoryid
join order_details as od
on od.productid = p.productid
group by categoryname;

-- Which suppliers manufacture each product?
select productname as product, suppliername as supplier
from suppliers
join products
on products.supplierid = suppliers.supplierid;

-- What product is in each category?
select CategoryName, ProductName
from products
join categories
on categories.categoryid = products.categoryid;

-- The food department wants to view all items in the Meat/Poultry category. 
select categoryname, productname
from categories
join products
on categories.categoryid = products.categoryid
where categoryname = 'Meat/Poultry';

-- The business team wants to see a detailed order list with customer and employee information.
select OrderID, Customername, Firstname as Employee
from orders
join employees
on employees.employeeid = orders.employeeid
join customers
on orders.customerid = customers.customerid;

-- Your manager wants to see the product name, its category, and the name of its supplier all in one report. 
select productname, categoryname, suppliername
from products
join categories
on categories.categoryid = products.categoryid
join suppliers
on suppliers.supplierid = products.supplierid;

-- The team is auditing customer orders made in 1996.
select customername, orderdate
from orders
join customers
on customers.customerid = orders.customerid
where orderdate BETWEEN '1996-01-31' AND '1996-12-31';

-- The product team wants to know how many products exist under each category.
select count(productid), categoryname
from products
join categories
on categories.categoryid = products.categoryid
group by categoryname;

-- The sales department wants to analyze how much of each product was ordered and at what price.
select sum(quantity), min(price), productname
from products
join order_details
on order_details.productid = products.productid
group by productname;
