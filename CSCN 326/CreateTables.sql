create database cat
use cat

create table Person 
(PersonID int, 
LUID char(9), 
FirstName varchar(20), 
LastName varchar(20),
constraint pk_Person primary key (PersonID)
)

create table Faculty 
(FacultyID int, 
Title varchar(10),
constraint pk_Faculty primary key (FacultyID),
constraint fk_Faculty_Person foreign key (FacultyID) references Person(PersonID)
)

create table Students 
(StudentID int, 
GPA float, 
MentorID int,
constraint pk_Students primary key (StudentID),
constraint fk_Students_Person foreign key (StudentID) references Person(PersonID),
constraint fk_Students_Mentors foreign key (MentorID) references Students(StudentID)
)

select * from Person

create table Buildings 
(BuildingID int, 
BuildingName varchar(30),
constraint pk_Buildings primary key(BuildingID)
)

create table Rooms 
(RoomNo varchar(5), 
Capacity int, 
IsLab bit,
BuildingID int,
constraint pk_Rooms primary key (RoomNo, BuildingID),
constraint fk_Rooms_Buildings foreign key (BuildingID) references Buildings(BuildingID)
)

create table Courses
(CourseID int, 
CourseName varchar(20), 
NumCredits int, 
RoomNo varchar(5), 
BuildingID int,
constraint pk_Courses primary key (CourseID), 
constraint fk_Courses_Rooms foreign key (RoomNo, BuildingID) references Rooms(RoomNo, BuildingID)
)

select * from courses
alter table courses
add CoursePrefix varchar(4)

alter table courses
drop column CoursePrefix2

exec sp_help Person

-- 2/7/24
select * from INFORMATION_SCHEMA.tables

create table Enrollment 
(EnrollmentID int,
Grade char(2),
DateEnrolled smalldatetime,
CourseID int not null,
StudentID int not null,
constraint pk_Enrollment primary key (EnrollmentID),
constraint fk_Enrollment_Courses foreign key (CourseID)
	references Courses(CourseID),
constraint fk_Enrollment_Students foreign key (StudentID)
	references Students(StudentID)
)
exec sp_help Enrollment

select * from Person

insert Person
select 1, 'L12345', 'Melesa', 'Poole'

insert Person
select 2, 'L22222', 'John', 'Doe'

insert Person
select 3, 'L33333', 'Jane', 'Doe'

-- Specify which fields you are going to fill without copy and pasting null
insert into Person (PersonID, FirstName, LastName)
select 4, 'Simon', 'Peter'

select * from students

insert students
select 1, 3.4, null

insert students
select 2, 3.7, 1

update students
set mentorid = 2
where studentid = 1

delete person
where personid = 2

-- 2/24/24
use cat
select * from INFORMATION_SCHEMA.tables
select * from enrollment

exec sp_help enrollment

alter table enrollment
drop constraint pk_Enrollment

alter table enrollment
drop column EnrollmentID

alter table enrollment
add constraint pk_enrollment primary key (CourseID, StudentID)

alter table enrollment
add blah int

alter table enrollment
drop column blah

-- DATA (ROWS)
-- insert
-- update
-- delete

-- STRUCTURE (COLUMNS/CONSTRAINTS)
-- create
-- alter
-- drop

use StudentData326_001
select * from INFORMATION_SCHEMA.tables

select * from students

select firstname + ' ' + lastname as [StudentName], gpa
from students
where gpa > 3
order by firstname

select firstname + ' ' + lastname as [StudentName], gpa
from students
where lastname like '%K%' and gpa < 3 or firstname = 'Christian'-- patterned match
order by firstname
--where lastname = 'Kramer' -- exact match