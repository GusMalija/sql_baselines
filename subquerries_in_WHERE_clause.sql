USE class_data;
-- Identifying IDs and names of students applying to CS
select sID, sName
from Student
where sID in (select sID from Apply where major = 'CS');

-- without a subquerry in the where clause
-- Student.sID is used because sID could come from both
select distinct Student.sID, sName
from Student, Apply
where Student.sID = Apply.sID and major = 'CS';

-- Extracting names of students applying to computer science
select distinct sName
from Student
where sID in (select sID from Apply where major = 'CS');

-- without a subquerry in the where clause
select distinct sName
from Student, Apply
where Student.sID = Apply.sID and major = 'CS';

-- Showcasing the importance of duplicates
-- Average GPA of CS Applicants
select  distinct GPA
from Student
where sID in (select sID from Apply where major = 'CS');

-- without a subquerry in the in clause
select distinct GPA
from Student, Apply
where Student.sID = Apply.sID and major = 'CS';

-- Students who applied to computer science but not EE
select sID, sName
from Student
where sID in (select sID from Apply where major = 'CS')
and sID not in (select sID from Apply where major = 'EE');

-- altanetively, tweaking not SID in to test membesrship in a set
select sID, sName
from Student
where sID in (select sID from Apply where major = 'CS')
and not SID in (select sID from Apply where major = 'EE');

-- using exist to check whether the subquerry is empty or not 
-- and reffering to a value outside the set
-- finding all colleges such that some other college is in the
-- same state
select cName, state
from College C1
where exists (select * from College C2
               where C2.state = C1.state and C2.cName <> C1.cName);
-- finding a college with the largest enrollment
-- all colleges where it does not exist another college whose enrollment
-- is higher than the first college
select cName 
from College C1
where not exists (select * from College C2
                  where C2.enrollment > C1.enrollment);               

-- students with the highest GPA
select sName, GPA
from Student S1
where not exists (select * from Student S2 where S2.GPA > S1.GPA);

-- highest GPA with no subquerry
select distinct S1.sName, S1.GPA
from Student S1, Student S2
where S1.GPA > S2.GPA;

-- calculating highest GPA using ">= all"
select sName, GPA
from Student
where GPA >= all (select GPA from Student);

-- GPA greater than all other students
select sName, GPA
from Student S1
where GPA > all (select GPA from Student S2 where S2.sID <> S1.sID);

-- enrollment higher than all other
select cName
from College C1
where enrollment > all (select enrollment from College C2 where C2.cName <> C1.cName);

-- using any key word
select cName
from College S1
where not enrollment <= any (select enrollment from College S2 where S2.cName <> S1.cName);

-- students not from smallest high school
select sID, sName, sizeHS
from Student S1
where exists (select * from Student S2 where S2.sizeHS < S1.sizeHS);

-- students who applied to CS but not EE
select sID, sName
from Student
where sID = any (select sID from Apply where major = 'CS')
and not sID = any (select sID from Apply where major = 'EE');

