-- 2/14/24
use CustomerData
select * 
from customer
where custlastname like 'T%'

select CustFirstName, CustLastName, CustBal as oldbalance, custbal * .9 as newBal
from customer
where custbal > 0 and custstate = 'WA'

select custstate, custcity, count(custbal)
from customer
where custbal > 0
group by custstate, custcity
order by custstate

select * 
from customer, ordertbl
where customer.custno = ordertbl.CustNo

-- Inner / Outer Join
select *
from customer c
inner join ordertbl ot on c.CustNo = ot.CustNo
full outer join employee e on e.empno = ot.empno

select * from ordline
insert customer
select 'C12345', 'Melesa' , 'Poole', '1336 Thompson Lane', 'Forest', 'VA', '24551', 0

select c.custno, ot.ordno, orddate, p.prodno, ProdName
from ordertbl ot
inner join customer c on c.CustNo = ot.CustNo
inner join employee e on e.empno = ot.empno
inner join ordLine ol on ol.OrdNo = ot.OrdNo
inner join product p on p.ProdNo = ol.ProdNo

select datediff(month, '2/13/2003', getdate())

select dateadd(day, 30, getdate())

-- 2-19-24
select * from OrderTbl
where orddate >= '1/1/2007' and orddate <= '1/31/2007'

select * from OrderTbl
where orddate between '1/1/2007' and '1/31/2007'

select * from OrderTbl
where orddate >= '2/1/2007' and orddate <= '2/28/2007'
-- Same as above
select * from OrderTbl
where month(orddate) = 2 and year(orddate) = 2007

select convert(smalldatetime, '2/28/2007')

select e.EmpFirstName + ' ' + e.EmpLastName as Employee, 
concat(s.EmpFirstName, ' ', s.EmpLastName) as Supervisor
from employee e -- Table alias
left outer join employee s on e.SupEmpNo = s.EmpNo

select * from ordertbl ot
inner join OrdLine ol on ot.OrdNo = ol.OrdNo
inner join product p on ol.ProdNo = p.ProdNo
inner join customer c on c.custno = ot.custno
full outer join employee e on e.empno = ot.empno
where ot.OrdNo is null -- Which employee has not taken an order yet
order by ot.OrdNo desc, p.ProdNo asc -- ascending automatic, descending not

select * from customer where custno not in('C2388597', 'C3340959', 'C9403348')
select * from customer where custno not in(select custno from customer where custstate = 'WA') -- Nested query


select empfirstname + ' ' + emplastname
from employee
union
select custfirstname + ' ' + custlastname
from customer