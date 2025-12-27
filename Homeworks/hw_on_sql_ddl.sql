--1
create schema if not exists store
;

set search_path to store
;

--2
create table if not exists customers
(
	customer_id serial primary key
	, customer_name varchar(50) not null
	, email varchar(260) check(position('@'in email) != 0)
	, address text 
)
;

--3
insert into customers(customer_id, customer_name, email, address)
select
	customer_id
	, concat_ws (' ', first_name, last_name)
	, email
	, concat_ws (' ', country, state, city, address)
from public.customer 
;

--4
create table if not exists products
( 
	product_id serial primary key
	, product_name varchar(100) 
	, price numeric not null  
)
;

--5
insert into products(product_id, product_name, price)
values 
		(1, 'Ноутбук Lenovo Thinkpad', 12000)
		, (2, 'Мышь для компьютера', 90)
		, (3, 'Подставка для ноутбука', 300)
		, (4, 'Шнур электрический для ПК', 160)
; 

--6
create table if not exists sales
(
	sale_id serial primary key
	, sale_timestamp timestamp not null default localtimestamp
	, customer_id int not null
	, product_id int not null
	, quantity integer not null default 1
	, foreign key(customer_id) references customers(customer_id)
	, foreign key(product_id) references products(product_id)
)
;

--7
insert into sales(customer_id, product_id, quantity)
values 
		(3,	4,	1)
		, (56,	2,	3)
		, (11,	2,	1)
		, (31,	2,	1)
		, (24,	2,	3)
		, (27,	2,	1)
		, (37,	3,	2)
		, (35,	1,	2)
		, (21,	1,	2)
		, (31,	2,	2)
		, (15,	1,	1)
		, (29,	2,	1)
		, (12,	2,	1)
;

--8
alter table sales 
add column discount numeric default 0 

update sales
set discount = 0.2 
where product_id = 1 
;

--9
create view v_usa_customers as 
select*
from customers
where 
	address like '%USA%'
;

select*
from v_usa_customers