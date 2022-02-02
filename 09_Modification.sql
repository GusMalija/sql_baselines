use class_data;
-- INSERT NEW COLLEGE
insert into College values ('Carnegie Mellon', 'PA', 11500);

-- Have all students who didn't apply anywhere apply to CS at Carnegie Mellon
-- To see who will be inserted
select *
from Student
where sID not in (select sID from Apply);

-- inserting them
insert into Apply
  select sID, 'Carnegie Mellon', 'CS', null
  from Student
  where sID not in (select sID from Apply);
  
-- Admit to Carnegie Mellon EE all students who were turned down
-- in EE elsewhere
-- to first see who will be inserted
select sID, count(distinct major)
from Apply
group by sID
having count(distinct major) > 2;

-- we then delete them
delete from Student
where sID in 
(select sID from Apply group by sID having count(distinct major) > 2);

-- deleting same ones from Apply
delete from Apply
where sID in 
(select sID from Apply group by sID having count(distinct major)) > 2;

-- Deleting colleges with no computer science applicants
delete from College
where cName not in (select cName from Apply where major = 'CS');

-- UPDATE COMMANDS
-- Accept applicants to Carnegie Mellon with GPA < 3.6 but turn
-- them into economics majors
-- to see who will be updated
select * from Apply
where cName = 'Carnegie Mellon'
  and sID in ( select sID from Student where GPA < 3.6 );

-- updating them
update Apply
set decision = 'Y', major = 'economics'
where cName = 'Carnegie Mellon' 
  and sID in (select sID from Student GPA < 3.6);

-- Turn students with the highest GPA and applied to EE into CSE Applicants
-- Assessing who will be updated
select * from Apply
where major = 'EE'
 and SID in 
   (select sID from Student where GPA >= all 
     (select GPA from Student 
       where sID in (select sID from Apply where major = 'EE')));
       
       
-- Updating them
update Apply
set major = 'CSE'
where major = 'EE'
  and sID in 
   (select sID from Student 
   where GPA >= all
     (select GPA from Student
     where sID in (select sID from Apply where major = 'EE')));
     
-- Giving everyone the highest GPA and the smallest high school
update Student
set GPA = (select max(GPA) from Student),
    sizeHS = (select min(sizeHS) from Student);
    
-- Accepting everyone
update Apply
set decision = 'Y';
