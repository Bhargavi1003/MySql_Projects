create database products_orders_management;
use products_orders_management;
-- PRODUCT TABLE 
create table product(
product_id int primary key auto_increment,
product_name varchar(250) not null,
product_category varchar(250) not null,
product_price decimal(10,2) not null,
product_quantity_instock int not null,
product_added_instock timestamp default current_timestamp
);

-- CUSTOMER TABLE
create table customer(
customer_id int primary key auto_increment,
customer_firstname varchar(250) not null,
customer_lastname varchar(250) not null,
customer_email varchar(250) unique not null,
customer_phonenumber varchar(15),
customer_address text not null,
customer_register_date timestamp default current_timestamp
);

-- ORDERS TABLE
create table orders(
order_id int primary key auto_increment,
customer_id int,
foreign key(customer_id) references customer(customer_id),
order_date datetime default current_timestamp,
total_amount decimal(10,2) not null,
order_status varchar(50) not  null
);

-- ORDERITEMS TABLE
create table orderitems(
orderitem_id int primary key auto_increment,
order_id int,
foreign key(order_id) references orders(order_id),
product_id int,
foreign key(product_id) references product(product_id),
quantity_ordered int not null,
unit_price_item decimal(10,2) not null,
subtotal_ordereditem decimal(10,2) not null
);

desc product;
desc customer;
desc orders;
desc orderitems;

-- INSERT RECORDS INTO  EACH TABLE
-- 1. INSERT RECORDS INTO PRODUCT TABLE
insert into product(product_name, product_category, product_price, product_quantity_instock, product_added_instock) 
values("Wireledd Mouse", "Electronics", 500.67, 140, now()),
("Bluetooth Speaker", "Electronics", 200.45, 100, now()),
("Running Shoes", "Footwear", 1200, 50, now()),
("Yoga Mat", "Fitness", 500.78, 10, now()),
("Digital Camera", "Electronics", 25000.45, 35, now()),
("Rolex watch", "Electronics", 2000, 10, now()),
("Basketball", "Sports", 700, 50, now()),
("Backpack", "Accessories", 300.22, 200, now());

select * from product;

-- 2. INSERT RECORDS INTO CUSTOMER TABLE
insert into customer(customer_firstname, customer_lastname, customer_email, customer_phonenumber, customer_address, customer_register_date)
values("Bhargavi", "Chigurupati", "bhargavi.chigurupati@gmail.com", "9948643756", "Pragathi Nagar", now()),
("Hemalatha", "Mannem", "hema.mannem@gmaiil.com", "8745631280", "Kukkatpally", now()),
("Priyanka", "Manuri", "priyanka.manuri@gmail.com", "9087358742", "KHPB", now()),
("Keerthana", "Komma", "keerthana.komma@gmail.com", "9567234589", "Vasanth Nagar", now()),
("Geethika", "Komma", "geethika.gomma@gmail.com", "7652458970", "JNTU", now()),
("Varun", "Bolnedu", "varun.bolnedu@gmail.com", "9123456708", "Madhapur", now()),
("Kalyan", "narra", "kalyan.narra@gmail.com", "8901234567", "Chandhanagar", now()),
("Mukundhan" , "penninti", "mukundhan.penninti", "9763481736", "Miyapur", now());

select * from customer;

-- 3. INSERT RECORDS INTO ORDERS TABLE
insert into orders(customer_id, order_date, total_amount, order_status) values(2, "2024-08-19 14:35:00", "200.45", "Delivered"),
(1, "2024-08-15 09:20:00", 2000, "Shipped"),
(8, "2024-08-16 11:15:00", 500.67, "Delivered"),
(4, "2024-08-17 13:45:00", 25000.45, "Delivered"),
(5, "2024-08-17 16:30:00", 500.78, "Pending"),
(6, "2024-08-18 10:00:00", 1200, "Shipped"),
(7, "2024-08-18 15:00:00", 300.22, "Cancelled"),
(8, "2024-08-19 08:30:00", 700, "Shipped"),
(1, "2024-08-19 12:45:00", 200.45, "Delivered"),
(3, "2024-08-20 09:00:00", 500.78, "Pending"),
(2, "2024-08-10 08:45:00", 25000.45, "Delivered"),
(1, "2024-08-12 03:25:00", 500.67, "Shipped"),
(5, "2024-08-07 12:30:00", 300.22, "Delivered"),
(6, "2024-08-20 01:00:00", 1200, "Pending");

select * from orders;

-- 4. INSERT RECORDS INTO ORDERITEMS
insert into orderitems(order_id, product_id, quantity_ordered, unit_price_item, subtotal_ordereditem) 
values(1, 3, 4, 1200, 4800),
(1, 2, 1, 200.45, 200.45),
(8, 5, 5, 25000.45, 125002.25),
(3, 6, 2, 2000, 4000),
(4, 4, 4, 500.78, 2003.12),
(7, 3, 1, 1200, 1200),
(1, 5, 1, 25000.45, 25000.45),
(1, 2, 1, 200.45, 200.45),
(2, 8, 2, 300.22, 600.66),
(5, 1, 4, 500.67, 2002.68);

select * from orderitems;

-- EXECUTION OF 10 CHALLENGES THAT TESTS INTERMEDAITE LEVEL KOWLEDGE ON SQL 
-- QUERY-1: RETRIEVE ALL PRODUCTS WITH LOW STACK (PRODUCT_QUANTITY_INSTOCK <50) 
select * from product 
where product_quantity_instock <50;

-- QUERY-2: CALCULATE TOTAL REVENUE GENERATED BY ALL ORDERS
select sum(total_amount) as total_revenue from orders;
select sum(total_amount) as total_revenue from orders
where customer_id=1;

-- QUERY-3: FIND BEST PRODUCT BASED ON THEIR TOTAL QUANTITY SOLD
select product.product_name, sum(orderitems.quantity_ordered) as total_quantity_sold
from orderitems 
join product 
on orderitems.product_id = product.product_id
group by orderitems.product_id
order by total_quantity_sold desc 
limit 1;

-- QUERY-4: LIST  ALL ORDERS AND NUMBER OF ITEMS IN EACH ORDER
select orders.order_id, count(orderitems.orderitem_id)
from orders
join orderitems
on orders.order_id = orderitems.order_id
group by orders.order_id;

-- QUERY-5: IDENTIFY CUSTOMERS WHO HAVE PLACED MORE THAN ONE ORDER
select customer.customer_id,  customer.customer_firstname, customer_lastname, count(orders.order_id) as no_of_orders
from customer
join orders
on customer.customer_id = orders.customer_id
group by customer.customer_id
having count(no_of_orders)>1
order by no_of_orders;

select * from orders;

-- QUERY-6: AVERAGE OF ORDER VALUE ACROSS ALL CUSTOMERS
select avg(total_amount) as AverageOrderValue from orders;

-- QUERY-7: LIST ALL PRODUCTS ORDERED BY A SPECIFIC CUSTOMER
select product.product_name, orderitems.quantity_ordered from orderitems
join orders on orders.order_id = orderitems.order_id
join product on product.product_id = orderitems.product_id
where orders.customer_id =1;

-- QUERY-8: FIND TOTAL NUMBER OF ORDERS PLACED IN LAST 30 DAYS
select count(order_id)  as TotalOrdersLast30Days
from orders
where order_date >=date_sub(curdate(),interval 30 day);

-- QUERY-9: REVENUE GENERATED BY EACH PRODUCT
select product.product_name, sum(orderitems.subtotal_ordereditem) as revenue
from orderitems
join product on orderitems.product_id = product.product_id
group by orderitems.product_id
order by revenue desc;

-- QUERY-10: IDENTIFY MOST RECENT ORDERS FROM EACH CUSTOMER
select customer.customer_id, customer.customer_firstname, customer.customer_lastname, max(orders.order_date) as recentorders
from customer
join orders on orders.customer_id = customer.customer_id
group by customer.customer_id;

