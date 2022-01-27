USE class_data;

-- making querries more readable and renaming relations in the from clause
select S.sID, S.sName, S.GPA, A.CName, C.enrollment
from Student S, College C, Apply A
where A.sID = S.sID and A.cName = C.cName;

-- pairs of students with the same GPA using cross product
-- of two instances of Student table with different sIDs 
-- listed only once
select S1.sID, S1.sName, S1.GPA, S2.sID, S2.sName, S2.GPA
from Student S1, Student S2
-- we pick less than because we always list students with
-- smaller SIDs first
where S1.GPA = S2.GPA and S1.sID < S2.sID;

-- joining schemas from separate datasets
-- edit name attribute by as name argument
select cName as name from College
-- adding duplicates with all argument
union all
select sName as name from Student
-- to sort by name
order by name;

-- students applied to both CS and EE
-- for systems not allowing intersect
select  distinct A1.sID
from Apply A1, Apply A2
where A1.sID = A2.sID and A1.major = 'CS' and A2.major = 'EE';

-- ones who applied to computer science but not EE
select distinct A1.sID
from Apply A1, Apply A2
where A1.sID = A2.sID and A1.major = 'CS' and A2.major <> 'EE';
