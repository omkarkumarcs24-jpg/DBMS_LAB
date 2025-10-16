create database omkarsql;
use omkarsql;
create table person ( 
driver_id varchar(10) , name varchar(20) , address varchar(20) , primary key(driver_id));
insert into person (driver_id , name , address)
values( 'A01' , 'Richard' , 'Srinivas nagar');
select * from person;
insert into person (driver_id , name , address)
values( 'A02' , 'Pradeep' , 'Rajaji nagar');
insert into person (driver_id , name , address)
values( 'A03' , 'smith' , 'Ashok nagar');
insert into person (driver_id , name , address)
values( 'A04' , 'venu' , 'N R colony');
insert into person (driver_id , name , address)
values( 'A05' , 'john' , 'Hanumanthnagar');
select * from person;

create table car(
reg_num varchar(10), model varchar(10), year int, primary key(reg_num));
insert into car values('KA052250' , 'INDICA ' , 1990),
('KA052260' , 'LANCER ' , 1957),
('KA095477' , 'TOYOTA ' , 1998),
('KA053408' , 'HONDA ' , 2005),
('KA041702' , 'AUDI' , 2008);
SELECT * FROM CAR;

create table owns(driver_id varchar(10),reg_num varchar(10),
primary key(driver_id, reg_num),
foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num));
insert into owns values ('A01' , 'KA052250'),
('A02' , 'KA052260'),
('A03' , 'KA095477'),
('A04' , 'KA053408'),
('A05' , 'KA041702');
select * from owns;

create table accident(report_num int, accident_date date, location varchar(20),primary key(report_num));
insert into accident values (11 , '2003-02-01' ,'MYSORE ROAD ' ),
(12 , '2004-02-02' ,'SOUTH END CIRCLE ' ),
(13 , '2003-01-21' ,'BULL TEMPLE ROAD ' ),
(14 , '2008-02-17' ,'MYSORE ROADD ' ),
(15 , '2005-03-04' ,'KANAKPURA ROAD ' );

SELECT * FROM ACCIDENT;

create table participated(driver_id varchar(10), reg_num varchar(10),
report_num int, damage_amount int, 
primary key(driver_id, reg_num, report_num), 
foreign key(driver_id) references person(driver_id));
INSERT INTO participated values
('A01', 'KA052250' , 11 ,10000 ),
('A02', 'KA052260' , 12 ,50000 ),
('A03', 'KA095477' , 13 ,25000 ),
('A04', 'KA053408' , 14 ,3000 ),
('A05', 'KA041702' , 15 ,5000 );

 select * from participated;

-- query3
update participated set damage_amount=25000 where reg_num='KA053408' and report_num=14;
commit;
select * from participated;

-- b)  Add a new accident to the database.
insert into accident values(16,'2008-03-08','Domlur');
select * from accident;

select accident_date, location 
from accident;

select driver_id
from participated
where damage_amount >=25000;

select * from car
order by year asc;



SELECT COUNT(*) AS number_of_accidents
FROM participated
WHERE reg_num IN (
    SELECT reg_num
    FROM car
    WHERE model = 'LANCER '
);

SELECT COUNT(DISTINCT driver_id) AS people_involved FROM owns
WHERE (driver_id, reg_num) IN ( SELECT driver_id, reg_num FROM participated
WHERE report_num IN (  SELECT report_num FROM accident WHERE YEAR(accident_date) = 2008));

select * from participated order by damage_amount desc;

SELECT AVG(damage_amount) AS average_damage
FROM participated;

delete from participated where damage_amount <(select avg_amount from( select avg(damage_amount) as avg_amount from participated ) as temp);
select * from participated;


SELECT NAME FROM PERSON A, PARTICIPATED B WHERE A.DRIVER_ID = B.DRIVER_ID AND DAMAGE_AMOUNT>(SELECT AVG(DAMAGE_AMOUNT) FROM PARTICIPATED);


SELECT MAX(damage_amount) AS max_damage FROM participated;








