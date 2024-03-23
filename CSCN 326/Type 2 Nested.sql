use CustomerData

select CustNo, CustFirstName + ' ' + CustLastName as Customer 
from Customer
where CustState = 'CO'
and not exists
(select CustNo from OrderTbl
where month(orddate) = 2 and year(orddate) = 2007
and Customer.CustNo = OrderTbl.CustNo)


--Using a Type II nested query, list the customer number and name of Colorado customers who
--have not placed orders in February 2007