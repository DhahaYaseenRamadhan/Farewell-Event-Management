create database  event_farewell;
use event_farewell;
create table guest(guest_id int primary key, gname varchar(30));
insert into guest values(1,"varun"),(2,"karun"),(3,"arun"),(4,"ali");
select * from guest;
create table Student(rollno int, sname varchar(30), 
felicitation int, foreign key(felicitation) references guest(guest_id));
insert into Student values(001, "aarav", 1),
(002, "omar", 1),
(003, "vikram", 1),
(004, "abinaya", 1),
(005, "kavin", 1),
(006, "rekha", 1),
(007, "sanjay", 1),
(008, "ravi", 1),
(009, "tharun", 2),
(010, "anika", 2),
(011, "priya", 2),
(012, "jay", 2),
(013, "harini", 2),
(014, "santhosh", 2),
(015, "naresh", 2),
(016, "kumar", 2),
(017, "lenin", 3),
(018, "mary", 3),
(019, "ella", 3),
(020, "gokul", 3),
(021, "ismail", 3),
(022, "fathima", 3),
(023, "yasodha", 3),
(024, "vishal", 3),
(025, "dharani", 4),
(026, "naveen", 4),
(027, "paul", 4),
(028, "tanya", 4),
(029, "bindhu", 4),
(030, "aarthi", 4),
(031, "vinay", 4),
(032, "peter", 4);
select * from Student;
create table organiser(oname varchar(30), designation varchar(80), role_taken varchar(80));
insert into organiser values("tamil vaanan", "department HOD", "planning and controlling"),
("stella", "class incharge", "planning and controlling"),
("harish", "lab assistant", "executing and ordering students"),
("surya", "lab assistant", "executing and ordering students"),
("boopathi", "sports_coach", "executing and ordering students"),
("yelena", "PG", "gather volunteers and organise them"),
("amir", "PG", "gather volunteers and organise them"),
("kalai", "PG", "gather volunteers and organise them"),
("rishi", "3rd year boy rep", "gather volunteers,arrange,instruct"),
("gauthami", "3rd year girl rep", "gather volunteers,arrange,instruct");
select * from organiser;
create table volunteer(rollno varchar(30) unique, vname varchar(30), class varchar(30));
insert into volunteer values("t1", "dennis", "3rd_year"),
("t2", "chandru", "3rd_year"),
("t3", "kathir", "3rd_year"),
("t4", "nandhini", "3rd_year"),
("t5", "faruk", "3rd_year"),
("t6", "praneetha", "3rd_year"),
("t7", "zainullah", "3rd_year"),
("t8", "preethi", "3rd_year"),
("t9", "shanmugam", "3rd_year"),
("t10", "christopher", "3rd_year"),
("s1", "deepika", "2nd_year"),
("s2", "dharshan", "2nd_year"),
("s3", "karthik", "2nd_year"),
("s4", "logan", "2nd_year"),
("s5", "rookmani", "2nd_year"),
("s6", "gabriel", "2nd_year"),
("s7", "abdullah", "2nd_year"),
("s8", "ilakkiya", "2nd_year"),
("s9", "ezhil", "2nd_year"),
("s10", "subash", "2nd_year");
select * from volunteer;
create table teacher(tname varchar(30), subject_taken varchar(30),designation varchar(50), honour_id int, 
foreign key(honour_id) references guest(guest_id));
insert into teacher values("mathivanan", "subject1", "scientist", 1),
("kannadasan", "subject2", "scientist", 2),
("parameshwari", "subject3", "scientist", 3),
("harry", "subject4", "scientist", 4),
("krishna", "subject5", "professor", null),
("suhail", "subject6", "professor", null),
("nirmala", "subject7", "professor", null),
("bejoy", "subject8", "professor", null),
("karan", "subject9", "professor", null),
("manav", "subject10", "professor", null);
select * from teacher;
create table sponsor(spname varchar(30), amount int);
create table budget(amount int, items varchar(30), price int);
delimiter //
create trigger enter
after insert on sponsor
for each row
begin
	insert into budget(amount , items , price)
    values(new.amount, null, null);
end;
//
delimiter ;
insert into sponsor values("department", 25000),
("3rd year class", 50000),
("2nd yaer class", 45000),
("1st year class", 40000),
("student club", 15000);
select * from sponsor;
select * from budget;
update budget 
set items=case amount
	when 25000 then "item1"
    when 50000 then "item2"
    when 45000 then "item3"
    when 40000 then "item4"
    when 15000 then "item5"
    else null
end
where amount in(25000, 50000, 45000, 40000,15000);
update budget 
set price=case amount
	when 25000 then 23500
    when 50000 then 48000
    when 45000 then 41000
    when 40000 then 40000
    when 15000 then 13000
    else null
end
where amount in(25000, 50000, 45000, 40000,15000);
/*.................. select queries ..............*/
select * from Student;
select gname from guest;
select a.sname, b.gname from Student as a 
left join guest as b on b.guest_id=a.felicitation where guest_id=2;
select oname,role_taken from organiser;
select vname,class from volunteer where class="2nd_year";
select count(rollno) from Student;
select count(a.rollno) as avg_felicitation, b.gname from Student as a
left join guest as b on b.guest_id=a.felicitation group by gname;
select tname from teacher order by tname asc;
select spname from sponsor where amount>30000;
select max(amount) as highest_sponsorship from sponsor;
select min(price) as cheapest_buy from budget;
select sum(amount) as amount_collected from sponsor;
select avg(price) from budget;
select a.sname,b.gname from Student as a
left join guest as b on b.guest_id=a.felicitation;
select b.tname,a.gname as honoured_guest from guest as a
left join teacher as b on a.guest_id=b.honour_id;
select oname from organiser where designation="lab assistant";
select count(vname),class as no_of_volunteers from volunteer group by class;
select distinct tname from teacher where designation="professor" and honour_id is null;
select a.spname,b.items,b.price from sponsor as a 
left join budget as b on a.amount=b.amount;
select a.sname as students_felicitated_by_ali from Student as a
left join guest as b on b.guest_id=a.felicitation where gname="ali";
select distinct designation from organiser;
select count(b.felicitation), a.gname from guest as a 
join student as b on b.felicitation=a.guest_id group by felicitation having count(sname)>6;
select * from sponsor where amount=(select max(amount) from sponsor);
select tname from teacher where tname like "m%";
select oname from organiser where role_taken like "%planning%";
select vname from volunteer where length(vname)>6;
select max(amount) from sponsor where amount<(select max(amount) from sponsor);
select amount from sponsor order by amount desc limit 1 offset 2;
select a.sname,b.gname from student as a
join guest as b on b.guest_id=a.felicitation where guest_id=1 or guest_id=3;
select sum(amount) from sponsor where spname like "%class";
select tname from teacher where honour_id is null;
call farewell(); -- stored procedure
create view sponsorship as select * from sponsor;
select * from sponsorship; -- view