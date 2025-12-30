--1
with manager_data as
(
	select 
   		 employee_id as mid
    	, concat_ws(' ', first_name, last_name) as m_name
    	, title as m_title
    	from employee
)
select
	employee_id
	, concat_ws(' ', first_name, last_name) as employee_full_name
	, title as employee_position
	, reports_to as manager_id
	, (select m_name from manager_data where mid = reports_to) as manager_full_name
	, (select concat_ws(',', m_name, m_title) from manager_data where mid = reports_to) as manager_name_title 
from employee
;

--2
select 
    invoice_id,
    invoice_date,
    cast(to_char(invoice_date, 'YYYYMM') as int) as monthkey,
    customer_id,
    total
from invoice
where total > (
    select avg(total) 
    from invoice 
    where extract(year from invoice_date) = 2023
)
;

--3
select 
    invoice_id
    , invoice_date
    , cast(to_char(invoice_date, 'YYYYMM') as int) as monthkey
    , customer_id
    , total
    , (select email from customer where customer.customer_id = invoice.customer_id) as email 
from invoice
where total > (
	select avg(total) 
    from invoice 
    where extract(year from invoice_date) = 2023
)
;

--4
select 
    invoice_id
    , invoice_date
    , cast(to_char(invoice_date, 'YYYYMM') as int) as monthkey
    , customer_id
    , total
    , (select email from customer where customer.customer_id = invoice.customer_id) as email 
from invoice
where total > (
	select avg(total) 
    from invoice 
    where extract(year from invoice_date) = 2023
)
and (select email from customer where customer.customer_id = invoice.customer_id) not like '%gmail%com'
;

--5
select
    invoice_id,
    total,
    round(
        (total * 100 / (select sum(total) from invoice where extract(year from invoice_date) = 2024))::numeric, 
        2
    ) as pct_of_revenue
from invoice
where extract(year from invoice_date) = 2024
; 

--6
select
    customer_id,
    total,
    round(
        (total * 100 / (select sum(total) from invoice where extract(year from invoice_date) = 2024))::numeric, 
        2
    ) as pct_of_revenue
from invoice
where extract(year from invoice_date) = 2024
;

