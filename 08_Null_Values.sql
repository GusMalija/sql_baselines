USE class_data;
-- Inserting NULL values
insert into Student values (432, 'Kevin', null, 1500);
insert into Student values (321, 'Lori', null, 2500);

select * from Student;

-- Extracting all students with high GPA
select sID, sName, GPA
from Student
where GPA > 3.5;

-- Either low or high GPA 
-- we still dont get Kelvin and Lorry
select sID, sName, GPA
from Student
where GPA > 3.5 or GPA <= 3.5;

-- Using is NULL
select sID, sName, GPA
from Student
where GPA > 3.5 or GPA <= 3.5 or GPA is null;

-- Students with high GPA or Small HS
select sID, sName, GPA, sizeHS
from Student
where GPA > 3.5 or sizeHS < 1600;

select sID, sName, GPA, sizeHS
from Student
where GPA > 3.5 or sizeHS < 1600 or sizeHS >= 1600;

-- Number of Students with non-NULL GPAs
-- when we count distinct GPAs, null values are returned as opposed to
-- counting distinct Student iDS
select count(distinct GPA)
from Student;

select distinct GPA
from Student;