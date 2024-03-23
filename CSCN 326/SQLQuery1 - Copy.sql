select * from students
select * from studentsmajors, students, majors
where studentsmajors.MajorID = majors.MajorID
and StudentsMajors.StudentID = students.StudentID