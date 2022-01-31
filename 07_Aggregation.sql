USE class_data;
-- Claculating average GPA of all students
select avg(GPA)
from Student;

-- Lowest GPA of students applying for CS
select min(GPA)
from Student, Apply
where Student.sID = Apply.sID and major = 'CS';

-- To capture distinct GPA scores, we use a subquerry
select avg(GPA)
from Student
where sID in (select sID from Apply where major = 'CS');

-- Number of colleges bigger than 15,000
select count(*)
from College
where enrollment > 15000;

-- Number of Students Applying to Cornell
-- use distinct with sID to avoid overcounting
select count(distinct sID)
from Apply
where cName = 'Cornell';

-- Students where the number of other students with the same GPA equals
-- the number of other students with the same sizeHS
select *
from Student S1
where (select count(*) from Student S2
       where S1.sID <> S2.sID and S1.GPA = S2.GPA) =
       (select count(*) from Student S2
       where S1.sID <> S2.sID and S1.sizeHS = S2.sizeHS);
       
       
-- Amount by which average GPA of students applying to CS
-- exceeds average of students not applying to CS
select CS.avgGPA - NonCS.avgGPA
from (select avg(GPA) as avgGPA from Student
      where sID in (select sID from Apply where major = 'CS')) as CS,
      (select avg(GPA) as avgGPA from Student
      where sID not in (select sID from Apply where major = 'CS')) as nonCS;
	
-- using subquerries in select
select distinct (select avg(GPA) as avgGPA from Student 
                 where sID in (select sID from Apply where major = 'CS')) -
                 (select avg(GPA) as avgGPA from Student
                 where sID not in (select sID from Apply where major = 'CS')) as d
from Student;

-- Extracting the number of applicants to each college
-- frist we picture the grouping criteria
select *
from Apply
order by cName;

-- grouping by college name
select cName, count(*)
from Apply
group by cName;

-- College enrollment by State
select state, sum(enrollment)
from College
group by state;

-- Minimum and maximum GPAs for applicants to each college and major
select cName, major, min(GPA), max(GPA)
from Student, Apply
where Student.sID = Apply.sID
group by cName, major;

-- querry tp picture the grouping
select cName, major, GPA
from Student, Apply
where Student.sID = Apply.sID
order by cName, major;

-- querrying
select cName, major, min(GPA), max(GPA)
from Student, Apply
where Student.sID = Apply.sID
group by cName, major;

-- Widest spread
select max(mx-mn)
from(select cName, major, min(GPA) as mn, max(GPA) as mx
     from Student, Apply
     where Student.sID = Apply.sID
     group by cName, major) M;
     
     
-- Number of colleges applied to by each student
-- although adding college name on the select clause wont work in some systems
select Student.sID, sName, count(distinct cName), cName
from Student, Apply
where Student.sID = Apply.sID
group by sID;

-- Number of Colleges applied to by each student, including 0 for those who applied
-- nowhere
select Student.sID, count(distinct cName)
from Student, Apply
where Student.sID = Apply.sID
group by Student.sID
union
select sID, 0
from Student
where sID not in (select sID from Apply);

-- HAVING clause checks the conditions that apply to the entire group
-- Colleges with fewer than 5 applicants
select cName
from Apply
group by cName
having count(distinct sID) < 5;

-- Majors whose applicants maximum GPA is below the average
select major 
from Student, Apply
where Student.sID = Apply.sID
group by major
having max(GPA) < (select avg(GPA) from Student);

