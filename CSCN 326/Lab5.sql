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