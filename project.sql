create database project;
use project;
create table student_table(
sid varchar(20) primary key,
Name varchar(20),
Dob date,
Dept_Name varchar(10),
addr varchar(20),
Blood_Grp varchar(10),
Gender varchar(10),
Hosteller varchar(10),
Year int,
Current_Sem int
);

select*from student_table;

create table sports_table(
rno varchar(20),
Name varchar(20),
Dob date,
Dept varchar(10),
Sports_Name varchar(20),
slevel varchar(20)
);
alter table sports_table add constraint mm foreign key(rno) references student_table(sid);
desc sports_table;
select * from sports_table;

create table Placement_Table(
regno varchar(20),
name varchar(20),
Dob date,
Dept varchar(10),
Addr varchar(20),
Placed_Companies varchar(20),
constraint pt foreign key(regno) references student_table(sid)
);

desc Placement_Table;
select * from placement_Table;

create table Hostel_Table_Male(
regno varchar(20),
Name varchar(20),
Dob date,
Dept varchar(20),
Addr varchar(20),
Blood_Grp varchar(20),
Fees int,
Paid int,
Balance int,
fee_status varchar(20),
constraint hm foreign key(regno) references student_table(sid)
);
desc Hostel_Table_Male;
select * from Hostel_Table_Male;

create table Hostel_Table_Female(
regno varchar(20),
Name varchar(20),
Dob date,
Dept varchar(20),
Addr varchar(20),
Blood_Grp varchar(20),
Fees int,
Paid int,
Balance int,
fee_status varchar(20),
constraint hf foreign key(regno) references student_table(sid)
);
desc Hostel_Table_Female;
select * from Hostel_Table_Female;

create table Hostel_Menu(
Day varchar(30),
Breakfast varchar(30),
Lunch varchar(30),
Dinner varchar(30)
);
select * from Hostel_Menu;

create table Staff_Table(
Staff_Id varchar(20),
Staff_Name varchar(20),
Qualification varchar(60),
Dept varchar(10),
Salary int,
Designation varchar(30),
YOJ year
);


create table FinalResult(
Regno varchar(20),
Name varchar(20),
Dept varchar(10),
Year int,
Current_Sem int,
sem1 varchar(20),
sem2 varchar(20),
sem3 varchar(20),
sem4 varchar(20),
sem5 varchar(20),
sem6 varchar(20),
sem7 varchar(20),
sem8 varchar(20),
Cgpa varchar(20),
Backlogs varchar(20),
constraint re foreign key(regno) references student_table(sid)
);

select * from FinalResult;

create table IT_dept_4thyr_sem2_result(
regno varchar(20),
student_name char(20),
Dept char(20),
Computer_Architecture varchar(10),
Object_Oriented_Programming varchar(10),
Data_structures varchar(10),
dbms varchar(10),
Data_structures_laboratory varchar(10),
Object_oriented_programming_laboratory varchar(10),
constraint 4yr_sem2 foreign key(regno) references student_table(sid)
);


create table IT_dept_3rdyr_sem2_result(
regno varchar(20),
student_name char(20),
Dept char(20),
Computer_Architecture varchar(10),
Object_Oriented_Programming varchar(10),
Data_structures varchar(10),
dbms varchar(10),
Data_structures_laboratory varchar(10),
Object_oriented_programming_laboratory varchar(10),
constraint 3yr_sem2 foreign key(regno) references student_table(sid)
);

create table IT_dept_2ndyr_sem2_result(
regno varchar(20),
student_name char(20),
Dept char(20),
Computer_Architecture varchar(10),
Object_Oriented_Programming varchar(10),
Data_structures varchar(10),
dbms varchar(10),
Data_structures_laboratory varchar(10),
Object_oriented_programming_laboratory varchar(10),
constraint 2yr_sem2 foreign key(regno) references student_table(sid)
);
select * from it_dept_2ndyr_sem2_result;

create table mech_3rdyear_sem3(
regno varchar(20),
name varchar(20),
Dept char(10),
Manufacturing_Technology varchar(50),
Engineering_Thermodynamics varchar(50),
Fluid_Mechanics varchar(50),
Manufacturing_Technology1 varchar(50),
Electrical_drives_and_Control varchar(50),
Electrical_Engineering_Laboratory varchar(50),
Computer_Aided_and_Machine_Drawing varchar(50),
constraint mech_3rdyear_sem3 foreign key(regno) references student_table(sid)
);

create table mech_4thyear_sem3(
regno varchar(20),
name varchar(20),
Dept char(10),
Manufacturing_Technology varchar(50),
Engineering_Thermodynamics varchar(50),
Fluid_Mechanics varchar(50),
Manufacturing_Technology1 varchar(50),
Electrical_drives_and_Control varchar(50),
Electrical_Engineering_Laboratory varchar(50),
Computer_Aided_and_Machine_Drawing varchar(50),
constraint mech_4thyear_sem3 foreign key(regno) references student_table(sid)
);
select * from mech_4thyear_sem3;

create table subject_handling(
staff_id varchar(20),
sname char(20),
Department varchar(20),
semester_1 varchar(60),
semester_2 varchar(60),
semester_3 varchar(60),
semester_4 varchar(60),
semester_5 varchar(60),
semester_6 varchar(60),
semester_7 varchar(60),
semester_8 varchar(60)
);

select * from subject_handling;

/* 1---In college 50% below fees paid students namelist count by department wise */

select Dept, count(Name) as count_of_students
from Hostel_Table_Male
where Balance<=25000
group by Dept
union
select Dept, count(Name) as count_of_students
from Hostel_Table_Female
where Balance<=25000
group by Dept;


/*2---In EEE department 3rd semester syllabus paper*/

SELECT staff_id,sname,semester_3 as sem3_syllabus
from subject_handling 
where Department="EEE"and semester_3 is not null;

/*3---In mechanical thermodynamics syllabus arrear result*/

select name, Engineering_Thermodynamics from mech_3rdyear_sem3
where Engineering_Thermodynamics='RA'
union
select name, Engineering_Thermodynamics from mech_4thyear_sem3
where Engineering_Thermodynamics='RA';

/* 4--From IT department in dbms subject who have taken A+ grade?*/
select student_name,dbms from IT_dept_4thyr_sem2_result 
where dbms='a+'
union
select student_name,dbms from IT_dept_3rdyr_sem2_result 
where dbms='a+'
union
select student_name,dbms from IT_dept_2ndyr_sem2_result 
where dbms='a+';

/*5 wednesday breakfast menu--*/

select Breakfast from Hostel_Menu where day='wednesday';

/*6. In civil, final year student Placed count non placed count list*/

select count(p.regno) as placed_students,count(s.sid) as non_placed_students
from student_table s left join placement_table p
on s.sid=p.regno
where p.dept='civil' or s.Dept_Name='civil' and s.year=4;

/*7---from ece who have placed in IT field*/

select name,Dept,placed_companies
from placement_table
where Dept='ECE';

/*8-- students who have placed in tcs by department wise count */

select Dept,count(*) as placed_in_tcs
from Placement_Table
where Placed_companies='TCS'
group by Dept;


/* 9. In 3rd semester who have taken three ranks in cse department with their name lists?*/

select Name,Dept,sem3 as GPA 
from finalresult 
where Dept='CSE' 
order by sem3 desc
limit 3;

/*10-- who is getting highest salary in clg by name,dept,salary */

select Staff_Name, Dept, Salary
from Staff_Table
where Salary = (select max(Salary) from Staff_Table);


/*11---who is taking python syllabus by their name?*/
SELECT sname,semester_1
FROM subject_handling
WHERE semester_1 LIKE '%Python%';


/*12----subjects handled by a staff(choose one)*/

SELECT s.staff_id, s.sname, s.Department, s.semester_4 AS Current_Subject
FROM subject_handling s
WHERE s.staff_id = 'CSE001'; 

/*13--In 8th semester,Arrear count above 2 having by department wise count*/

select dept,count(regno) as backlogs_count 
from finalresult 
where backlogs>=2
group by dept;

/*14--In final semster who is having top 3 ranks by name,dept,cgpa*/

SELECT Name,Dept,Cgpa
FROM finalresult
WHERE cgpa >= 9 
ORDER BY Dept desc 
limit 3;























