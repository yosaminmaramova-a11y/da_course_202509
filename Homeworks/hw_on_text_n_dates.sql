--Yosamin Maramova HOMEWORK 32


select*
from employee
;

--1
select
	min(invoice_date) as first_purchase
	, max(invoice_date) as last_purchase 
from invoice
;

--2
select
	round(avg(total), 2) as average_check_usa
from invoice
where 
	billing_country = 'USA'
; 

--3
select 
	city
	, customer_id as more_than_one_customer
from customer
where 
	customer_id > 1 
; 
 
--4
select
	phone
from customer
where 
	phone not like '%(%'
	and phone not like '%)%'
;

--5
select
	upper(left('lorem ipsum', 1))||lower(substring('lorem ipsum' from 2)) as Lorem_ipsum
;

--6
select*
from track
where
	name ilike '%run%'
;

--7
select*
from customer
where 
	email like '%gmail%'
;

--8
select
	name 
	, length(name)as length_track_name
from track
order by length_track_name desc
limit 1
;

--9 --10
select 
	extract(month from invoice_date) as month_id
	, to_char(invoice_date, 'month') as month_name
	, sum(total) as sales_sum
from invoice
where
	extract(year from invoice_date) = 2021
group by month_id, month_name
order by month_id

--11
select
	concat_ws(', ', first_name, last_name) as full_name
	, birth_date
	, extract(year from age(now(), birth_date))::int as age_now
from employee
order by birth_date
limit 3

--12
select
	avg(extract(year from age(now() + interval '40 months', birth_date)))
from employee

--13
select
	extract(year from invoice_date) as sales_year
	, billing_country
	, sum(total) as sales_sum
from invoice 
group by sales_year, billing_country
having sum(total) > 20
order by sales_year asc, sales_sum desc 