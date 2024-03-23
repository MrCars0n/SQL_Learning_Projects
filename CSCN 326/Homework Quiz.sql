create database AutoRentals
go

use AutoRentals
go

select CID, CName as [Customer Name]
from Customer
where Age >= 25 and Age <= 40
order by CName desc

select * from Rentals
select BirthPlace 
from Customer
group by BirthPlace
order by BirthPlace desc

-- Names, Ages, Makes, DailyCost
select * from Customer
select * from Rentals
select * from Rentcost

-- 3/1/23 Homework
select cust.CName, cust.Age, rent.Make, cost.Cost
from Customer cust
inner join Rentals rent
on cust.CID = rent.CID
inner join Rentcost cost
on rent.Make = cost.Make
order by cost.cost asc

-- 3-4-2024
select distinct cust.Cname, rent.Make
from Customer cust
left outer join Rentals rent
on cust.CID = rent.CID
order by cust.Cname, rent.Make asc