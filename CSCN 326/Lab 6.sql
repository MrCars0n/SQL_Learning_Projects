use hourglass

insert regions
select * from Regions

insert countries
select * from countries

insert offices
select * from offices

DELETE FROM employees
insert employees
select * from tmpEmployees
select * from employees

insert clients
select * from clients

insert contracttypes
select * from ContractTypes

delete from contracts
insert contracts
select * from tmpcontracts	

delete from projects
insert projects
select * from tmpprojects
select * from projects

DELETE FROM EmployeeProjectAssignments
insert EmployeeProjectAssignments
select * from tmpEmployeeProjectAssignments

alter table tmpEmployeeProjectAssignments
drop column F5, F6, F7, F8, F9, F10, F11, F12, F13, F14

delete from workhours
insert WorkHours
select * from tmpWorkHours

Select * from Workhours

update Countries
set CountryName = 'Great Britain' where CountryName = 'United Kingdom'
select * from Countries

update Employees
set Salary *= 1.1
select * from employees

select * from ContractTypes

select ContractTypeID from contracttypes
where ContractTypeName = 'Fixed Price'

select ContractTypeID from contracttypes
where ContractTypeName = 'Time and Materials'
update Contracts
set ContractTypeID = (select ContractTypeID from contracttypes where ContractTypeName = 'Fixed Price')
where ContractTypeID = (select ContractTypeID from contracttypes where ContractTypeName = 'Time and Materials')
select * from Contracts





Select * from employees where firstname = 'Paul' and lastname = 'Davis' -- EmpID = 8
Select * from employees where firstname = 'Matthew' and lastname = 'Smith' -- EmpID = 1

delete from employees where firstname = 'Paul' and lastname = 'Davis'
select * from employees





select * from employees
update Employees
set OfficeID = (select OfficeID from offices where OfficeName = 'Denver')
where OfficeID = (select OfficeID from offices where OfficeName = 'Cambridge')
select * from employees



select OfficeID from offices
where OfficeName = 'Denver'
select * from projects


update EmployeeProjectAssignments
set EmpID = (select EmpID from Employees where firstname = 'Matthew' and lastname = 'Smith')
where EmpID = (select EmpID from Employees where firstname = 'Paul' and lastname = 'Davis')
select * from EmployeeProjectAssignments

update projects
set ManagerID = (select EmpID from Employees where firstname = 'Matthew' and lastname = 'Smith')
where ManagerID = (select EmpID from Employees where firstname = 'Paul' and lastname = 'Davis')
select * from projects





select * from WorkHours
delete from WorkHours where EmpID = (select EmpID from Employees where firstname = 'Paul' and lastname = 'Davis')
select * from WorkHours

select EmpID from Employees where firstname = 'Mark' and lastname = 'Jones'

select ProjectID from projects
where ProjectName = 'DT Work Order - Customization'


update EmployeeProjectAssignments
set EndDate = convert(smalldatetime, '08/01/2017')
where ProjectID = (select ProjectID from projects where ProjectName = 'DT Work Order - Customization')
and EmpID = (select EmpID from Employees where firstname = 'Mark' and lastname = 'Jones')
select * from EmployeeProjectAssignments

select * from ContractTypes
delete from ContractTypes where ContractTypeName = 'Time and Materials'
select * from ContractTypes

select * from countries
delete from Countries 
where not (CountryID in (select CountryID from clients) 
or CountryID in (select CountryID from offices))
select * from Countries




select CountryID from clients
select CountryID from offices