create database University
use University

create table Campuses
(CampusID int,
CampusName varchar(20)
constraint pk_Campuses primary key (CampusID)
)
SELECT * FROM Campuses
exec sp_help Campuses

create table ZipCodes
(ZipCode varchar(10),
City varchar(20),
StateAbbr varchar(2),
constraint pk_ZipCodes primary key (ZipCode)
)
SELECT * FROM ZipCodes
exec sp_help ZipCodes

create table Buildings
(BuildingID int,
Address varchar(20),
BuildingName varchar(20),
CampusID int not null,
ZipCode varchar(10) not null,
constraint pk_Buildings primary key (BuildingID),
constraint fk_Buildings_Campuses foreign key (CampusID) references Campuses(CampusID),
constraint fk_Buildings_ZipCodes foreign key (ZipCode) references ZipCodes(ZipCode)
)
SELECT * FROM Buildings
exec sp_help Buildings

create table FacultyOffices
(OfficeNumber varchar(5),
BuildingID int not null,
constraint pk_FacultyOffices primary key (BuildingID, OfficeNumber),
constraint fk_FacultyOffices_Buildings foreign key (BuildingID) 
	references Buildings(BuildingID) ON DELETE CASCADE
)
SELECT * FROM FacultyOffices
exec sp_help FacultyOffices

create table Faculty
(FacultyID int,
FirstName varchar(20),
LastName varchar(20),
Address varchar(20),
Rank varchar(20),
Salary float,
Specialty varchar(20),
ZipCode varchar(10) not null,
OfficeNumber varchar(5),
BuildingID int,
constraint pk_Faculty primary key (FacultyID),
constraint fk_Faculty_ZipCodes foreign key (ZipCode) references ZipCodes(ZipCode),
constraint fk_Faculty_FacultyOffices foreign key (BuildingID, OfficeNumber) 
	references FacultyOffices(BuildingID, OfficeNumber)
)
SELECT * FROM Faculty
exec sp_help Faculty

create table ClassRooms
(RoomNumber varchar(5),
Occupancy int,
BuildingID int not null,
constraint pk_ClassRooms primary key (BuildingID, RoomNumber),
constraint fk_ClassRooms_Buildings foreign key (BuildingID) 
	references Buildings(BuildingID) ON DELETE CASCADE
)
SELECT * FROM ClassRooms
exec sp_help ClassRooms

create table Courses
(CourseID int,
CoursePrefix varchar(4),
CourseNumber varchar(3),
CourseName varchar(20),
constraint pk_Courses primary key (CourseID)
)
SELECT * FROM Courses
exec sp_help Courses

--Patients (PatientID, FirstName, LastName, DOB, Street, City, State, ZipCode, Gender)

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
constraint pk_Patients primary key (PatientID)
)
insert Patients
select '1234', 'John', 'Doe', convert(date, '03/02/1997'), '123 Oak Ln.', 'Lynchburg', 'VA', '24515', 'Male'
insert Patients
select '1235', 'Jane', 'Smith', convert(date, '01/22/1991'), '141 Briggs Ln.', 'Lynchburg', 'VA', '24515', 'Female'
insert Patients
select '1236', 'Bob', 'Connelly', convert(date, '06/06/1974'), '175 Mayburry Dr.', 'Lynchburg', 'VA', '24515', 'Male'

-- Doctors (DoctorID, FirstName, LastName, Phone, Email, Location, Specialty)
create table Doctors
(DoctorID int, 
FirstName varchar(20), 
LastName varchar(20), 
Phone varchar(9), 
Email varchar(20), 
Location varchar(20), 
Specialty varchar(20),
constraint pk_Doctors primary key (DoctorID)
)
insert Doctors
select '1234', 'Doug', 'Smith', '123-456-7890', 'john.doe@gmail.com', 'Lynchburg General', 'Surgeon'
insert Doctors
select '1235', 'Ellie', 'Blanchard', '325-465-7540', 'ellie.blanchard54@gmail.com', 'St. Judes', 'Physicals'
insert Doctors
select '1236', 'Bob', 'Buchanan', '142-853-1923', 'bbuchanan@gmail.com', 'Richmond General', 'Physical Therapy'

--Referrals (ReferralID, DoctorID, PatientID, Description, ReferralDate, Equipment)
create table Referrals
(ReferralID int,  
Description varchar(20), 
ReferralDate date, 
Equipment varchar(20),
DoctorID int not null, 
PatientID int not null,
constraint pk_Referrals primary key (ReferralID),
constraint fk_Students_ZipCode foreign key (ZipCode) references ZipCodes(ZipCode),
)

--Contracts (ContractID (int), NumberOfVisits (tiny), StartDate(date), EndDate (date), MaxVisits(tiny)) 
create table Contracts 
(ContractID int, 
NumberOfVisits tinyint, 
StartDate date, 
EndDate date, 
MaxVisits tinyint,
constraint pk_Contracts primary key (ContractsID)
)
insert Contracts
select 1, 3, convert(date, '03/02/2023'), convert(date, '08/02/2024'), 10
select 2, 5, convert(date, '02/19/2020'), convert(date, '08/15/2020'), 12
select 3, 4, convert(date, '05/12/2024'), convert(date, '11/03/2024'), 15

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
select 1
insert ServiceLog
select 2
insert ServiceLog
select 3


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
select 1
insert SEUsed
select 2
insert SEUsed
select 3

--Services (ServiceID (int), Name (varchar20)) 
create table Services 
(ServiceID int,
Name varchar(20),
constraint pk_Services primary key (ServiceID)
) 
insert Services
select 1, 'Bathing'
select 2, 'Cleaning'
select 3, 'Cooking'

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
select 1, convert(date, '03/02/2023'), '12:34:56', '15:04:36', 300
insert Visits
select 2, convert(date, '08/05/2023'), '09:04:00', '13:50:42', 400
insert Visits
select 3, convert(date, '05/23/2024'), '08:40:23', '11:41:23', 300

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
select convert(date, '02/05/2023'), convert(date, '06/21/2023')
insert ContractPayment
select convert(date, '02/09/2023'), convert(date, '07/14/2023')
insert ContractPayment
select convert(date, '10/11/2023'), convert(date, '10/31/2023')

create table Students
(StudentID int,
FirstName varchar(20),
LastName varchar(20),
StreetAddress varchar(20),
Phone varchar(9),
ZipCode varchar(10) not null,
FacultyID int not null,
MentorID int,
constraint pk_Students primary key (StudentID),
constraint fk_Students_ZipCode foreign key (ZipCode) references ZipCodes(ZipCode),
constraint fk_Students_Faculty foreign key (FacultyID) references Faculty(FacultyID),
constraint fk_Students_Mentor foreign key (MentorID) references Students(StudentID)
)
SELECT * FROM Students
exec sp_help Students

create table Sections
(SectionID int,
SectionNumber varchar(3),
Term varchar(10),
Year int,
CourseID int not null,
BuildingID int not null,
RoomNumber varchar(5) not null,
FacultyID int not null,
constraint pk_Sections primary key (SectionID),
constraint fk_Sections_Courses foreign key (CourseID) references Courses(CourseID), 
constraint fk_Sections_ClassRooms foreign key (BuildingID, RoomNumber) references ClassRooms(BuildingID, RoomNumber), 
constraint fk_Sections_Faculty foreign key (FacultyID) references Faculty(FacultyID)
)
SELECT * FROM Sections
exec sp_help Sections

create table Enroll
(StartDate date,
EndDate date,
Grade varchar(2),
StudentID int not null,
SectionID int not null,
constraint pk_Enroll primary key (StudentID, SectionID),
constraint fk_Enroll_Students foreign key (StudentID) 
	references Students(StudentID) ON DELETE CASCADE,
constraint fk_Enroll_Sections foreign key (SectionID) 
	references Sections(SectionID) ON DELETE CASCADE
)
SELECT * FROM Enroll
exec sp_help Enroll