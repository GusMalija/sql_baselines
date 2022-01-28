use class_data;
-- from cross product relations using comma to join tables in the where clause
-- to explicit joins using the join operator
-- INNER JOIN
-- Student names and majors for which they have applied
-- where operator changes to on
-- since inner join is a default, "join" is the abbreviation
select distinct sName, major
from Student inner join Apply
on Student.sID = Apply.sID;

-- INNER JOIN with additional conditions
-- Names and GPAs of students with sizeHS < 1000 applying for CS at Stanford
select sName, GPA
from Student join Apply
on Student.sID = Apply.sID
and sizeHS < 1000 and major = 'CS' and cName = 'Stanford';

-- THREE WAY INNER JOIN
-- ID, Name, GPA, college name, enrollment
select Apply.sID, sName, GPA, Apply.cName, enrollment
from Apply join Student join College
on Apply.sID = Student.sID and Apply.cName = College.cName;

-- For postgre SQL, binary join instead of all three joins works
select Apply.sID, sName, GPA, Apply.cName, enrollment
from (Apply join Student on Apply.SID = Student.SID) join College on Apply.cName = College.cName;

-- NATURAL JOIN
-- Student names and majors for which they have applied
select distinct sName, major
from Student natural join Apply;

-- Natural join eliminates duplicate attributes/columns
select distinct sID
from Student natural join Apply;
-- without a natural join, it returns an error because its ambiguous that
-- sID column is on both Student and Apply datasets

-- NATURAL JOIN WITH ADDITIONAL CONDITIONS
-- Names and GPAs of students with sizeHS < 1000 applying for CS at Stanford
select sName, GPA
from Student natural join Apply
where sizeHS < 1000 and major = 'CS' and cName = 'Stanford';

-- USING clause is safer to avoid clashes in columns that have the same name but
-- are not meant to be equated.
select sName, GPA
from Student join Apply using(sID)
where sizeHS < 1000 and major = 'CS' and cName = 'Stanford';

-- SELF JOIN
-- Pairs of Students with the same GPA
-- Basic querry
select S1.sID, S1.sName, S1.GPA, S2.sID, S2.sName, S2.GPA
from Student S1, Student S2
where S1.GPA = S2.GPA and S1.sID = S2.sID;

-- With JOIN and USING
select S1.sID, S1.sName, S1.GPA, S2.sID, S2.sName, S2.GPA
from Student S1 join Student S2 using(GPA)
where S1.sID < S2.sID;

-- SELF NATURAL JOIN
select *
from Student S1 natural join Student S2;
-- verifying eqivalence
select * from Student;

-- LEFT OUTER JOIN
-- Extracting Student name, ID, college name and major
-- as opposed to inner join, outer join includes students who havent applied anywhere
-- abbreviation is left join
select sName, sID, cName, major
from Student left join Apply using(sID);

-- using NATURAL OUTER JOIN
select sName, sID, cName, major
from Student natural left outer join Apply;

-- simulating without any join operators
select sName, Student.sID, cName, major
from Student, Apply
where Student.sID = Apply.sID
union
select sName, sID, NULL, NULL
from Student
where sID not in (select sID from Apply);

-- including applications without matching students
insert into Apply values (321, 'MIT', 'history', 'N');
insert into Apply values (321, 'MIT', 'psychology', 'Y');

select sName, sID, cName, major
from Apply natural left outer join Student;

-- RIGHT OUTER JOIN
-- Including applications without matching students
select sName, sID, cName, major
from Student natural right outer join Apply;

-- FULL OUTER JOIN
-- including students who havent applied anywhere and applications without matching students
-- UNION eliminates duplicates
select sName, sID, cName, major
from Student left outer join Apply using(sID)
union 
select sName, sID, cName, major
from Student right outer join Apply using(sID);
