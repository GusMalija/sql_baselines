-- Revealing IDs, Names and GPAs of students with GPA > 3.6
SELECT sID, sName, GPA
from Student
where GPA > 3.6;

-- Revealing student names and majors for which they have applied
select * from Student;
SELECT sName, major
from Student, Apply
where Student.sID = Apply.sID;

-- with distinct names of applicants
select distinct sName, major
from Student, Apply
where Student.sID = Apply.sID; 

--  Names and GPAs of students with sizeHS < 1000 applying to 
-- CS at Stanford, and the application decision
select * from Apply;
select sName, GPA, decision
from Student, Apply
where Student.sID = Apply.sID
and sizeHS < 1000 and major = 'CS' and cName = 'Stanford';

-- All large campuses with CS Applicants
select * from College;
select distinct College.cName
from College, Apply
where College.cName = Apply.cName
and enrollment > 20000 and major = 'CS';

-- application information with ascending GPA and descending enrollment
select Student.sID, sName, GPA, Apply.cName, enrollment
from Student, College, Apply
where Apply.sID = Student.sID and Apply.cName = College.cName
order by GPA desc, enrollment;

-- Applicants who applied to majors with 'bio' in it
select *
from Apply
where major like '%bio%';

-- adding scalled GPA column based on size highschool
select sID, sName, GPA, sizeHS, GPA*(sizeHS/1000) as scaledGPA
from Student;