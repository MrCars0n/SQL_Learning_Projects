--Suppliers (SupplierID (int), Name (varchar20))
create table Suppliers 
(SupplierID int, 
Name varchar(50), 
constraint pk_Suppliers primary key (SupplierID))
insert Suppliers
select 1, 'Supplies Unlimited'
insert Suppliers
select 2, 'C&M Supplies'
insert Suppliers
select 3, 'Pooles Medical Supplies, Inc'

--SuppliesAndEquipment (SuppliesAndEquipmentID (int), IsDirect (bool), Name (varchar20))
create table SuppliesAndEquipment
(SuppliesAndEquipmentID int,
isDirect bit,
name varchar(20),
constraint pk_SuppliesAndEquipment primary key (SuppliesAndEquipmentID))
insert SuppliesAndEquipment
select 1, 1, 'syringe'
insert SuppliesAndEquipment
select 2, 1, 'gauze'
insert SuppliesAndEquipment
select 3, 1, 'alcohol wipes'

--Purchases (OrderID (int), SupplierID (int), Date (smalldatetime), QntPurchased (int), Cost (float), SuppliesAndEquipmentID)
create table Purchases 
(OrderID int, 
Date smalldatetime,
QntPurchased int,
Cost float,
SupplierID int not null,
SuppliesAndEquipmentID int not null,
constraint pk_Purchases primary key (OrderID),
constraint fk_Purchases_Suppliers foreign key (SupplierID) references Suppliers (SupplierID),
constraint fk_Purchases_SuppliesAndEquipment foreign key (SuppliesAndEquipmentID) references SuppliesAndEquipment (SuppliesAndEquipmentID))
insert Purchases
select 1, convert(date, '1/1/2000'), 1, 10, 1, 1
insert Purchases
select 2, convert(date, '2/1/2000'), 1, 10, 1, 1
insert Purchases
select 3, convert(date, '3/1/2000'), 1, 10, 1, 1

--Patients (PatientID (int), FirstName (varchar20), LastName (varchar20), DOB(date), Street(varchar20), City(varchar20), State(varchar20), ZipCode(varchar10), Gender(varchar6))
create table Patients
(PatientID int, 
FirstName varchar(20), 
LastName varchar(20), 
DOB date, 
Street varchar(20), 
City varchar(20), 
State varchar(20), 
ZipCode varchar(10), 
Gender varchar(6),
constraint pk_Patients primary key (PatientID))

insert Patients
select 1, 'John', 'Doe', convert(date, '03/02/1997'), '123 Oak Ln.', 'Lynchburg', 'VA', '24515', 'Male'
insert Patients
select 2, 'Jane', 'Smith', convert(date, '01/22/1991'), '141 Briggs Ln.', 'Lynchburg', 'VA', '24515', 'Female'
insert Patients
select 3, 'Bob', 'Connelly', convert(date, '06/06/1974'), '175 Mayburry Dr.', 'Lynchburg', 'VA', '24515', 'Male'

--Doctors (DoctorID (int), FirstName (varchar20), LastName(varchar20), Phone (varchar20), Email (varchar20), Location (varchar20), Specialty (varchar20))
create table Doctors
(DoctorID int, 
FirstName varchar(20), 
LastName varchar(20), 
Phone varchar(20), 
Email varchar(50), 
Location varchar(20), 
Specialty varchar(20),
constraint pk_Doctors primary key (DoctorID))

insert Doctors
select 1, 'Doug', 'Smith', '123-456-7890', 'john.doe@gmail.com', 'Lynchburg General', 'Surgeon'
insert Doctors
select 2, 'Ellie', 'Blanchard', '325-465-7540', 'ellie.blanchard54@gmail.com', 'St. Judes', 'Physicals'
insert Doctors
select 3, 'Bob', 'Buchanan', '142-853-1923', 'bbuchanan@gmail.com', 'Richmond General', 'Physical Therapy'

--Referrals (ReferralID, DoctorID, PatientID, Description, ReferralDate)
create table Referrals (
    ReferralID int,
    Description varchar (50),
    ReferralDate date,
    DoctorID int not null,
    PatientID int not null,

    constraint pk_Referrals primary key(ReferralID),
    constraint fk_Referrals_Doctors foreign key (DoctorID) references Doctors(DoctorID),
    constraint fk_Referrals_Patients foreign key (PatientID) references Patients(PatientID)
	)

insert Referrals
select 1, 'Orthopedic Consultation', '2022-01-15', 1, 1
insert Referrals
select 2, 'Cardiology Evaluation', '2022-02-02', 2, 2
insert Referrals
select 3, 'Physical Therapy Referral', '2022-03-10', 3, 3
--Insurance (InsuranceID, Phone, Name, Street, City, State, ZipCode)
create table Insurance (
    InsuranceID int,
    Phone varchar(20),  
    Name varchar (20),
    Street varchar (20),
    City varchar (20),
    State varchar (20),
    ZipCode varchar (10),  

    constraint pk_Insurance primary key (InsuranceID)
)
insert Insurance
select 1, '555-123-4567', 'Insurance1', '123 Main St', 'City1', 'Pennsylvania', '12345'
insert Insurance
select 2, '555-234-5678', 'Insurance2', '456 Oak St', 'City2', 'California', '67890'
insert Insurance
select 3, '555-345-6789', 'Insurance3', '789 Pine St', 'City3', 'New York', '98765'

--Contracts (ContractID (int), NumberOfVisits (tinyint), startDate(date), EndDate (date), MaxVisits(tinyint)) 
create table Contracts 
(ContractID int, 
NumberOfVisits tinyint, 
StartDate date, 
EndDate date, 
MaxVisits tinyint,
constraint pk_Contracts primary key (ContractID)
)
insert Contracts
select 1, 3, convert(date, '03/02/2023'), convert(date, '08/02/2024'), 10
insert Contracts
select 2, 5, convert(date, '02/19/2020'), convert(date, '08/15/2020'), 12
insert Contracts
select 3, 4, convert(date, '05/12/2024'), convert(date, '11/03/2024'), 15


--PaymentHelp (InsuranceID, ContractID)
create table PaymentHelp (
    InsuranceID int,
    ContractID int,
    constraint pk_PaymentHelp primary key (InsuranceID, ContractID),
    constraint fk_PaymentHelp_Insurance foreign key (InsuranceID) references Insurance(InsuranceID),
    constraint fk_PaymentHelp_Contract foreign key (ContractID) references Contracts(ContractID)
)

insert PaymentHelp
select 1, 1
insert PaymentHelp
select 2, 2
insert PaymentHelp
select 3, 3

--Services (ServiceID (int), Name (varchar20)) 
create table Services 
(ServiceID int,
Name varchar(20),
constraint pk_Services primary key (ServiceID)
) 
insert Services
select 1, 'Bathing'
insert Services
select 2, 'Cleaning'
insert Services
select 3, 'Cooking'

--ContractServices (ContractID (int), ServiceID (int)) 
create table ContractServices (
    ContractID int,
    ServiceID int,
    constraint pk_ContractServices primary key (ContractID, ServiceID),
    constraint fk_ContractServices_Contracts foreign key (ContractID) references Contracts(ContractID),
    constraint fk_ContractServices_Services foreign key (ServiceID) references Services(ServiceID)

)
insert ContractServices
select 1, 1
insert ContractServices
select 2, 2
insert ContractServices
select 3, 3

--ProvisionAgreement (ContractID (int), ServiceID (int), SuppliesAndEquipmentID (int)) 
create table ProvisionAgreement 
(ContractID int, 
ServiceID int, 
SuppliesAndEquipmentID int,
constraint pk_ProvisionAgreement primary key (ContractID, ServiceID, SuppliesAndEquipmentID),
constraint fk_ProvisionAgreement_ContractServices foreign key (ContractID, ServiceID) 
	references ContractServices(ContractID, ServiceID),
constraint fk_ProvisionAgreement_SuppliesAndEquipment foreign key (SuppliesAndEquipmentID) 
	references SuppliesAndEquipment(SuppliesAndEquipmentID)
)
insert ProvisionAgreement
select 1, 1, 1
insert ProvisionAgreement
select 2, 2, 2
insert ProvisionAgreement
select 3, 3, 3

--ReferralResources (ReferralID (int), ServiceID (int)) 
create table ReferralResources (
    ReferralID int,
    ServiceID int,

    constraint pk_ReferralResources primary key (ReferralID, ServiceID),
    constraint fk_ReferralResources_Referrals foreign key (ReferralID) references Referrals(ReferralID),
    constraint fk_ReferralResources_Services foreign key (ServiceID) references
Services(ServiceID)
)
insert ReferralResources
select 1, 1
insert ReferralResources
select 2, 2
insert ReferralResources
select 3, 3


--SEReferred (ReferralID (int), ServiceID (int), SuppliesAndEquipmentID (int)) 
create table SEReferred (
    ReferralID int,
    ServiceID int,
    SuppliesAndEquipmentID int,

    constraint pk_SEReferred primary key (ReferralID, ServiceID, SuppliesAndEquipmentID),
    constraint fk_SEReferred_Referrals foreign key (ReferralID) references Referrals(ReferralID),
    constraint fk_SEReferred_Services foreign key (ServiceID) references Services(ServiceID),
    constraint fk_SEReferred_SuppliesAndEquipment foreign key (SuppliesAndEquipmentID) references SuppliesAndEquipment(SuppliesAndEquipmentID)
)
insert SEReferred
select 1, 1, 1
insert SEReferred
select 2, 2, 2
insert SEReferred
select 3, 3, 3


--Employees (EmployeeID (int), City (varchar20), FirstName (varchar20), Street (varchar20), ZipCode (varchar10), DateOfBirth (date), LastName (varchar20), HourlyWage (float), Salary (float), State (varchar20)) 
create table Employees
(EmployeeID int, 
FirstName varchar(20), 
LastName varchar(20),
Street varchar(20), 
City varchar(20), 
State varchar(20),
ZipCode varchar(10), 
DOB date,  
HourlyWage float, 
Salary float,
constraint pk_Employees primary key (EmployeeID))

insert Employees
select 1, 'Carson', 'Kramer', '4 Mayberry Ln.', 'Lynchburg', 'VA', '24515', '2004-05-12', null, 70000
insert Employees
select 2, 'Bob', 'McCorrmick', '2 Lounge Ln.', 'Lynchburg', 'VA', '24515', '1992-03-04', 20, null
insert Employees
select 3, 'Christina', 'Blanchard', '7 Kings Ct.', 'Lynchburg', 'VA', '24515', '1997-09-10', null, 60000

--Visits (VisitID (int), EmployeeID (int), ContractID (int), Date (date), TimeIN (time), TimeOUT (time), Stipend (float)) 
create table Visits 
(VisitID int,
Date date, 
TimeIN time, 
TimeOUT time, 
Stipend float,
EmployeeID int not null, 
ContractID int not null, 
constraint pk_Visits primary key (VisitID),
constraint fk_Visits_Employees foreign key (EmployeeID) references Employees(EmployeeID),
constraint fk_Visits_Contracts foreign key (ContractID) references Contracts(ContractID)
)
insert Visits
select 1, convert(date, '03/02/2023'), '12:34:56', '15:04:36', 300, 1, 1
insert Visits
select 2, convert(date, '08/05/2023'), '09:04:00', '13:50:42', 400, 2, 2
insert Visits
select 3, convert(date, '05/23/2024'), '08:40:23', '11:41:23', 300, 3, 3

--ServiceLog (ServiceLogID (int), VisitID (int), ServiceID (int)) 
create table ServiceLog 
(ServiceLogID int, 
VisitID int not null, 
ServiceID int not null,
constraint pk_ServiceLog primary key (ServiceLogID),
constraint fk_ServiceLog_Visits foreign key (VisitID) 
	references Visits(VisitID),
constraint fk_ServiceLog_Services foreign key (ServiceID) 
	references Services(ServiceID)
)

insert ServiceLog
select 1, 1, 1
insert ServiceLog
select 2, 2, 2
insert ServiceLog
select 3, 3, 3

--SEUsed (SuppliesAndEquipmentID (int), ServiceLogID (int), Quantity (int)) 
create table SEUsed 
(SuppliesAndEquipmentID int, 
ServiceLogID int, 
Quantity int,
constraint pk_SEUsed primary key (SuppliesAndEquipmentID, ServiceLogID),
constraint fk_SEUsed_ServiceLog foreign key (ServiceLogID) 
	references ServiceLog(ServiceLogID),
constraint fk_SEUsed_SuppliesAndEquipment foreign key (SuppliesAndEquipmentID) 
	references SuppliesAndEquipment(SuppliesAndEquipmentID)
) 
insert SEUsed
select 1, 1, 1
insert SEUsed
select 2, 2, 2
insert SEUsed
select 3, 3, 3

--EmployeeType (EmployeeTypeID (int), TypeName (varchar20)) 
create table EmployeeType 
(EmployeeTypeID int, 
TypeName varchar(20),
constraint pk_EmployeeType primary key (EmployeeTypeID))
insert EmployeeType
select 1, 'Admin'
insert EmployeeType
select 2, 'Nurse'
insert EmployeeType
select 3, 'Aide'

--PaymentType (PaymentID (int), Name (varchar20))
create table PaymentType
(PaymentID int, 
Name varchar(20),
constraint pk_PaymentType primary key (PaymentID)
)
insert PaymentType
select 1, 'Medicare'
insert PaymentType
select 2, 'Medicaid'
insert PaymentType
select 3, 'Private Insurance'
insert PaymentType
select 4, 'Private-Pay'

--ContractPayment (ContractID (int), PaymentID (int), StartDate (date), EndDate (date)) 
create table ContractPayment 
(ContractID int, 
PaymentID int, 
StartDate date, 
EndDate date,
constraint pk_ContractPayment primary key (ContractID, PaymentID),
constraint fk_ContractPayment_Contracts foreign key (ContractID) references Contracts(ContractID),
constraint fk_ContractPayment_PaymentType foreign key (PaymentID) references PaymentType(PaymentID)
)
insert ContractPayment
select 1, 1, convert(date, '02/05/2023'), convert(date, '06/21/2023')
insert ContractPayment
select 2, 2, convert(date, '02/09/2023'), convert(date, '07/14/2023')
insert ContractPayment
select 3, 3, convert(date, '10/11/2023'), convert(date, '10/31/2023')

--EmployeeServices (EmployeeID (int), ServiceID (int))
create table EmployeeServices (
    EmployeeID int,
    ServiceID int,

    constraint pk_EmployeeServices primary key (EmployeeID, ServiceID),
    constraint fk_EmployeeServices_Employees foreign key (EmployeeID) references Employees(EmployeeID),
    constraint fk_EmployeeServices_Services foreign key (ServiceID) references Services(ServiceID)
)
insert EmployeeServices
select 1, 1
insert EmployeeServices
select 2, 2
insert EmployeeServices
select 3, 3

--Direct (EmployeeID (int), EmployeeTypeID (int), isDirect (bool)) 
create table Direct 
(EmployeeID int, 
EmployeeTypeID int, 
isDirect bit,
constraint pk_Direct primary key (EmployeeID, EmployeeTypeID),
constraint fk_Direct_Employees foreign key (EmployeeID) references Employees (EmployeeID),
constraint fk_Direct_EmployeeType foreign key (EmployeeTypeID) references EmployeeType (EmployeeTypeID))
insert Direct
select 1, 1, 1
insert Direct 
select 2, 2, 2
insert Direct
select 3, 3, 3
--Availability (ScheduleID (int), EmployeeID (int), Date (date), StartTime (time), EndTime (time))
create table Availability 
(ScheduleID int, 
Date date, 
StartTime time, 
EndTime time,
EmployeeID int not null, 
constraint pk_Availability primary key (ScheduleID),
constraint fk_Availability_Employees foreign key (EmployeeID) references Employees (EmployeeID))
insert Availability
select 1, '2023-01-01', '08:08:08', '10:10:10', 1
insert Availability
select 2, '2023-02-01', '09:09:09', '10:10:10', 2
insert Availability
select 3, '2023-03-01', '10:10:10', '11:11:11', 3

--AnnualCostReport (CostReportID (int), DirectCosts (float), IndirectCosts (float), Date (date))
create table AnnualCostReport 
(CostReportID int,
DirectCosts float,
IndirectCosts float, 
Date date,
constraint pk_AnnualCostReport primary key (CostReportID))
insert AnnualCostReport
select 1, 2000000, 1000000, '01-01-2000'
insert AnnualCostReport
select 2, 2000000, 1000000, '01-01-2001'
insert AnnualCostReport
select 3, 2000000, 1000000, '01-01-2002'

--AdminPay (AdminPayID (int), GrossPaycheck (float), FICAwithholding (float), PremiumsDeducted (float), Percent401k (float), HCOmatch (float))
create table AdminPay 
(AdminPayID int, 
GrossPaycheck float, 
FICAwithholding float, 
PremiumsDeducted float, 
Percent401k float, 
HCOmatch float,
constraint pk_AdminPay primary key (AdminPayID))
insert AdminPay
select 1, 120000, 1000, 10000, 0.08, 0.08
insert AdminPay
select 2, 150000, 2000, 10000, 0.08, 0.08
insert AdminPay
select 3, 190000, 3000, 10000, 0.08, 0.08

--AdminPayDate (PayDate (date), AdminPayID (int), Amount (float))
create table AdminPayDate 
(PayDate date,
AdminPayID int, 
Amount float,
constraint pk_AdminPayDate primary key (PayDate, AdminPayID),
constraint fk_AdminPayDate_AdminPay foreign key (AdminPayID) references AdminPay (AdminPayID))
insert AdminPayDate
select '01-01-2000', 1, 5000
insert AdminPayDate
select '01-15-2000', 2, 5000
insert AdminPayDate
select '02-01-2000', 3, 5000

--DutyType (DutyID (int), TypeName (varchar20))
create table DutyType 
(DutyID int, 
TypeName varchar(20),
constraint pk_DutyType primary key (DutyID))
insert DutyType
select 1, 'Duty1'
insert DutyType
select 2, 'Duty2'
insert DutyType
select 3, 'Duty3'

--DutiesAssigned (AssignedID (int), EmployeeID (int), DutyID (int))
create table DutiesAssigned 
(AssignedID int, 
EmployeeID int not null, 
DutyID int not null,
constraint pk_Assigned primary key (AssignedID),
constraint fk_Assigned_Employees foreign key (EmployeeID) references Employees (EmployeeID),
constraint fk_Assigned_DutyType foreign key (DutyID) references DutyType (DutyID))
insert DutiesAssigned
select 1, 1, 1
insert DutiesAssigned
select 2, 2, 2
insert DutiesAssigned
select 3, 3, 3

--BenefitType (BenefitID (int), TypeName (varchar20))
create table BenefitType
(BenefitID int, 
TypeName varchar(20),
constraint pk_BenefitType primary key (BenefitID))
insert BenefitType
select 1, 'Benefit1'
insert BenefitType
select 2, 'Benefit2'
insert BenefitType
select 3, 'Benefit3'

--BenefitsAssigned (AssignedID (int), EmployeeID (int), BenefitID (int))
create table BenefitsAssigned 
(AssignedID int, 
EmployeeID int not null, 
BenefitID int not null,
constraint pk_BenefitsAssigned primary key (AssignedID),
constraint fk_BenefitsAssigned_Employees foreign key (EmployeeID) references Employees (EmployeeID),
constraint fk_BenefitsAssigned_BenefitType foreign key (BenefitID) references BenefitType (BenefitID))

insert BenefitsAssigned
select 1, 1, 1
insert BenefitsAssigned
select 2, 2, 2
insert BenefitsAssigned
select 3, 3, 3






exec sp_help Suppliers
select * from Suppliers

exec sp_help SuppliesAndEquipment
select * from SuppliesAndEquipment

exec sp_help Purchases
select * from Purchases

exec sp_help Patients
select * from Patients

exec sp_help Doctors
select * from Doctors

exec sp_help Referrals
select * from Referrals

exec sp_help Insurance
select * from Insurance

exec sp_help Contracts
select * from Contracts

exec sp_help PaymentHelp
select * from PaymentHelp

exec sp_help Services
select * from Services

exec sp_help ContractServices
select * from ContractServices

exec sp_help ProvisionAgreement
select * from ProvisionAgreement

exec sp_help ReferralResources
select * from ReferralResources

exec sp_help SEReferred
select * from SEReferred

exec sp_help Employees
select * from Employees

exec sp_help Visits
select * from Visits

exec sp_help ServiceLog
select * from ServiceLog

exec sp_help SEUsed
select * from SEUsed

exec sp_help EmployeeType
select * from EmployeeType

exec sp_help PaymentType
select * from PaymentType

exec sp_help ContractPayment
select * from ContractPayment

exec sp_help EmployeeServices
select * from EmployeeServices

exec sp_help Direct
select * from Direct

exec sp_help Availability
select * from Availability

exec sp_help AnnualCostReport
select * from AnnualCostReport

exec sp_help AdminPay
select * from AdminPay

exec sp_help AdminPayDate
select * from AdminPayDate

exec sp_help DutyType
select * from DutyType

exec sp_help DutiesAssigned
select * from DutiesAssigned

exec sp_help BenefitType
select * from BenefitType

exec sp_help BenefitsAssigned
select * from BenefitsAssigned
