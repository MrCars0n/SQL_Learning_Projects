-- 2-21-24
use customerdata
select * from customer

insert customer
select 'C98765', 'John', 'Doe', '123 Oak Ln.', 'Lynchburg', 'VA', '24515', 0

insert into customer (custno, CustFirstName, CustLastName)
values ('C33333', 'Jane', 'Doe')

update customer
set CustCity = 'Forest', CustZip = '24551'
where custno = 'C33333'

delete customer
where custno = 'C98765'

select * from customer
select * from ordertbl

select ot.* 
from customer c
inner join ordertbl ot on c.CustNo = ot.CustNo
where c.CustState = 'CO'

select * from customer where custstate = 'CO'
--type 1
--independent
select * from ordertbl
where custno in (select custno from customer where custstate = 'CO')

--type 2
--correlated
select * from ordertbl
where exists (select * from customer where ordertbl.custno = customer.custno and custstate = 'CO')

--2/26/2024

select ot.ordno, sum(prodprice * quantity) as total
from ordertbl ot
inner join ordline ol on ot.ordno = ol.ordno
inner join product p on p.prodno = ol.prodno
group by ot.ordno
having sum(prodprice * quantity) > 200

--CUSTOMERDATA
select * from customer
select * from product
select * from ordertbl
select * from ordline