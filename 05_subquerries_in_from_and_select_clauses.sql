USE class_data;
-- subquerries in the from generates tables while ones in the select generates values.

-- Extracting students whose scalled GPA changes its value by more than one
-- thus, scalling their GPA changes (modifies) its value by more than one eitherway
select sID, sName, GPA, GPA*(sizeHS/1000.0) as scaledGPA
from Student 
where GPA*(sizeHS/1000.0) - GPA > 1
or GPA - GPA*(sizeHS/1000.0) > 1;

-- simplification by using absolute value function
select sID, sName, GPA, GPA*(sizeHS/1000.0) as scaledGPA
from Student
where abs(GPA*(sizeHS/1000) - GPA) > 1;

-- further using a subquerry in from
-- G refers to select that's been put in the from clause
select *
from (select sID, sName, GPA, GPA*(sizeHS/1000) as scaledGPA from Student) G
where abs(scaledGPA - GPA) > 1;

-- Pairing colleges with the highest GPAs among their applicants
select distinct College.cName, state, GPA
from College, Apply, Student
where College.cName = Apply.cName
  and Apply.sID = Student.sID
  and GPA>= all(select GPA from Student, Apply 
                where Student.sID = Apply.sID
				 and Apply.cName = College.cName);

-- Using a subquerry in select
select distinct College.cName, state, 
 (select distinct GPA
 from Apply, Student
 where College.cName = Apply.cName
  and Apply.sID = Student.sID
  and GPA>= all(select GPA from Student, Apply 
                where Student.sID = Apply.sID
				 and Apply.cName = College.cName)) as GPA
from College;