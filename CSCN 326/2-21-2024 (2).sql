create database hourglass1
go

use hourglass1
go

CREATE TABLE Regions
(RegionID int not null,
 RegionName varchar(40),
 CONSTRAINT PK_Regions PRIMARY KEY (RegionID));

CREATE TABLE Countries
(CountryID int not null,
 CountryName varchar(50),
 RegionID int not null,
 CONSTRAINT PK_Countries PRIMARY KEY (CountryID),
 CONSTRAINT FK_CountriesRegions FOREIGN KEY (RegionID) References Regions);

CREATE TABLE Offices
(OfficeID int,
OfficeName varchar(50),
CountryID int not null,
CONSTRAINT pk_Offices PRIMARY KEY (OfficeID),
CONSTRAINT fk_Offices_Countries FOREIGN KEY (CountryID) REFERENCES Countries)

CREATE TABLE Employees
(EmpID int,
FirstName varchar(30),
LastName varchar(50),
Email varchar(50),
Salary decimal(10, 2),
OfficeID int not null,
SupervisorID int,
CONSTRAINT pk_Employees PRIMARY KEY (EmpID),
CONSTRAINT fk_Employees_Offices FOREIGN KEY (OfficeID) REFERENCES Offices,
CONSTRAINT fk_Employees_Employees FOREIGN KEY (SupervisorID) REFERENCES Employees)

CREATE TABLE Clients
(ClientID int,
LegalName varchar(100),
ClientName varchar(50),
CountryID int not null,
CONSTRAINT pk_Clients PRIMARY KEY (ClientID),
CONSTRAINT fk_Clients_Countries FOREIGN KEY (CountryID) REFERENCES Countries)

CREATE TABLE ContractTypes
(ContractTypeID int not null,
 ContractTypeName varchar(50),
 CONSTRAINT pk_ContractTypes PRIMARY KEY (ContractTypeID))

CREATE TABLE Contracts
(ContractID int not null,
 ContractDesc varchar(100),
 ClientID int not null,
 ContractTypeID int not null,
 CONSTRAINT PK_Contracts PRIMARY KEY (ContractID),
 CONSTRAINT FK_ContractsClients FOREIGN KEY (ClientID) REFERENCES Clients,
 CONSTRAINT FK_ContractsContractTypes FOREIGN KEY (ContractTypeID) REFERENCES ContractTypes)

CREATE TABLE Projects
(ProjectID int,
ProjectName varchar(100),
ManagerID int not null,
ContractID int not null,
CONSTRAINT pk_Projects PRIMARY KEY (ProjectID),
CONSTRAINT fk_Projects_Employees FOREIGN KEY (ManagerID) REFERENCES Employees,
CONSTRAINT fk_Projects_Contracts FOREIGN KEY (ContractID) REFERENCES Contracts)

CREATE TABLE EmployeeProjectAssignments
(ProjectID int,
EmpID int,
StartDate smalldatetime,
EndDate smalldatetime,
CONSTRAINT pk_EmployeeProjectAssignments PRIMARY KEY (ProjectID, EmpID),
CONSTRAINT fk_EmployeeProjectAssignments_Projects FOREIGN KEY (ProjectID) REFERENCES Projects,
CONSTRAINT fk_EmployeeProjectAssignments_Employees FOREIGN KEY (EmpID) REFERENCES Employees)

CREATE TABLE WorkHours
(ProjectID int,
EmpID int,
Day int,
Month int,
Year int,
HoursWorked float,
CONSTRAINT pk_WorkHours PRIMARY KEY (ProjectID, EmpID, Day, Month, Year),
CONSTRAINT fk_WorkHours_Projects FOREIGN KEY (ProjectID) REFERENCES Projects,
CONSTRAINT fk_WorkHours_Employees FOREIGN KEY (EmpID) REFERENCES Employees)

