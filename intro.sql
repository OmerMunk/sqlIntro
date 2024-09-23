-- CREATE DATABASE DATEBASE_NAME;

CREATE DATABASE test1db;

CREATE TABLE test1table
(
    id   INT PRIMARY KEY,
    name VARCHAR(255)
);

INSERT INTO test1table (id, name)
VALUES (1, 'test1');

select *
from TeSt1tAbLe;
-- not case sensitive


-- מבנה שאילתה בסיסית ללא קינון
-- structure of a basic query without nesting
-- SELECT [DISTINCT] A1, A2, ..... , An
-- FROM r1, r2, .... , rm
-- [WHERE p]
-- [Group by A1, A2, ... An]
-- [Having P]

-- הטלה, בחירה שילוב בין יחסים

-- מצאו את רשימת כל הלקוחות
SELECT *
FROM clients;

-- מצאו את ת.ז ושמות כל הלקוחות
SELECT CId, CName
FROM clients;

-- מצאו את סוגי הרישיון של הלקוחות distinct
-- distict - מוחק כפילויות

SELECT DISTINCT TLicence
FROM clients;


-- מצאו לקוחות עם רישיון נהיגה מסוג 2
SELECT *
FROM clients
WHERE TLicence = 2;

-- שמות לקוחות שגרים בכתובת המכילה את הרצף ada
SELECT CName
FROM clients
WHERE Aaddress = 'ada';

SELECT CName
FROM clients
WHERE Aaddress LIKE '%ada%';

SELECT *
FROM clients
WHERE Aaddress = 'Kalanit 7';



-- handling dates
-- date
-- to take something of a date:
-- Date_part('part', date)

SELECT *
FROM clients
WHERE date_part('year', birthdate) > 1981;
-- יעבוד רק אם הסוג של התאריך הוא date


CREATE TABLE test2table
(
    id        int primary key,
    name      varchar(255),
    birthdate DATE
);

select *
from test2table;


set datestyle to "ISO,DMY";
insert into test2table (id, name, birthdate)
values (2, 'test2', to_date('19/12/1956', 'DD/MM/YYYY'));

insert into test2table (id, name, birthdate)
values (3, 'test2', to_date('1956', 'YYYY'));


-- מצאו רכבים (מספר זיהוי וסוג) שיוצרו לפני שנת 2019
select CarID, CarType
from cars
where date_part('year', MYear) < 2019;

select *
from cars;


-- הגדרת תבניות
-- table
-- create table r
-- (A1 D1,
-- A2 D2,
-- ....
-- An Dn,
-- integrity-constraints1,
-- integrity-constraints2,
-- ....
-- integrity-constraints-k );

-- A תכונות
-- D תחומי ערכים
-- integrity-constraints אילוצים

-- example for creating in the example

-- Exercise 1: Select all columns from the Clients table.
SELECT *
FROM Clients;

-- Exercise 2: Select the Client ID (CId) and Client Name (CName) from the Clients table.
SELECT CId, CName
FROM Clients;

-- Exercise 3: Select distinct Client addresses (Aaddress) from the Clients table.
SELECT DISTINCT Aaddress
FROM Clients;

-- Exercise 4: Select all clients who were born on or after January 1st, 1980.
SELECT *
FROM Clients
WHERE BirthDate >= '1980-01-01';

-- Exercise 5: Select the names of clients who live on Hanasi street.
SELECT CName
FROM Clients
WHERE Aaddress LIKE 'Hanasi%';

-- Exercise 6: Select all clients whose name starts with 'R'.
SELECT *
FROM Clients
WHERE CName LIKE 'R%';

-- Exercise 7: Select distinct phone numbers from the Clients table.
SELECT DISTINCT PhoneNum
FROM Clients;

-- Exercise 8: Select all columns for clients whose phone number ends with '333'.
SELECT *
FROM Clients
WHERE PhoneNum LIKE '%333';

-- Exercise 9: Select the Client ID and Name of clients who were born before 1980.
SELECT CId, CName
FROM Clients
WHERE BirthDate < '1980-01-01';

-- Exercise 10: Select all clients whose address contains the word 'Kalanit'.
SELECT *
FROM Clients
WHERE Aaddress LIKE '%Kalanit%';



-- group by

-- כמה פעמים מופיע כל בטבלה
SELECT COUNT(cname), cname
FROM clients
GROUP BY cname;


-- syntax
-- SELECT column_name, aggregate_function(column_name)
-- FROM table_name
-- [WHERE condition]
-- GROUP BY column_name;


select *
from clients;
-- how many client have each licence
SELECT TLicence, COUNT(*) AS NumberOfClients
from clients
group by TLicence;

select *
from cars;
-- calculate the average day rate for each licence type
select licencet, AVG(dayrate) as AverageDayRate
from cars
group by licencet;

select *
from clients;

insert into clients (cid, cname, aaddress, phonenum, birthdate, tlicence)
values ('123456788', 'Shublu', 'Yonatan 19', '052-246390', '9/12/2002', 1);

-- find the number of clients born in each year
select date_part('year', birthdate) as year, count(*) as NumberOfClients
from clients
group by year;



-- group by: aggregate and analyze based on shared values
-- you can use functions like: count, sum, avg, max, min ...
-- having is used to filter after the group by

select *
from cars;

-- calculate the average day rate for each licence type
select licencet, AVG(dayrate) as AverageDayRate
from cars
group by licencet;

-- calculate the average day rate for each licence type, display only above 200
select licencet, AVG(dayrate) as AverageDayRate
from cars
group by licencet
having AVG(dayrate) > 200;



select *
from clients;

-- insert an existing row with id 123456788 but change the id before inserting
insert into clients (cid, cname, aaddress, phonenum, birthdate, tlicence)
select '123456787', cname, aaddress, phonenum, birthdate, tlicence
from clients
where cid = '123456788';

-- insert 3 rows with the same data
insert into clients (cid, cname, aaddress, phonenum, birthdate, tlicence)
values ('123456989', 'Shublu8', 'bubulu 19', '052-246340', '9/6/2002', 1),
       ('123456790', 'Shublu7', 'bubulu 20', '052-246330', '2/4/2002', 2),
       ('123456791', 'Shublu9', 'bubulu 19', '052-246320', '3/5/2002', 2);



-- deletion of relations / tables

-- Drop table CarRent cascade;
-- Drop table ClientBill cascade;
-- Drop table Cars cascade;
-- Drop table Clients cascade;
-- Drop table Bills cascade;
-- cascade - delete all foreign keys that are connected to the table
-- restrict - delete only if the table has no relations
-- if exists - delete only if the table exists




alter table carrent
    add constraint carrent_carid_fkey foreign key (carid) references cars;


-- find cars that their day rate is above 150 and manufactured before 2019
select *
from cars
where dayrate > 150
  and date_part('year', myear) < 2019;


select *
from bills;
-- give 10% discount for bills over 1000, display original price and updated price
select orderid, totalpayment, 0.9 * totalpayment as updatedprice
from bills
where totalpayment > 1000;

-- same question, but only for those that even after the discount the price would still be over 1000
select orderid, totalpayment, 0.9 * totalpayment as updatedprice
from bills
where 0.9 * totalpayment > 1000;

insert into CarRent
values ('6544432', '234567890', '01/09/2015', 5);



-- types of join
-- inner join - returns rows when there is at least one match in both tables
-- left outer join - returns all rows from the left table, and the matched rows from the right table
-- right outer join - returns all rows from the right table, and the matched rows from the left table
-- full outer join - returns rows when there is a match in one of the tables

-- join conditions:
-- natural join - automatically connects between the tables by the common columns
-- on<predicate> - connects between the tables by the columns that are specified in the on clause
-- using (column) - connects between the tables by the columns that are specified in the using clause


-- left join
select *
from clients
         left join carrent on clients.cid = carrent.cid;

-- right join
select *
from clients
         right join carrent on clients.cid = carrent.cid;

-- full join
select *
from clients
         full join carrent on clients.cid = carrent.cid;

-- inner join
select *
from clients
         inner join carrent on clients.cid = carrent.cid;


-- join is like writing inner join. it's the same.
-- so in the inner join we have:
-- natural join
-- join on<predicate>
-- join using (column1, column2, ...)

    select * from clients;
    select * from bills;
    select * from clientbill;

-- {1, 2}, {3, 4}
-- {1, 3}, {1, 4}, {2, 3}, {2, 4}
    select * from clients, bills, clientbill;

-- for example:
--(natural join)
-- find names of clients that the total payment they paid in 2015 was higher than 1500
-- without join:
select cname
from clients, bills, clientbill
where clients.cid = clientbill.cid
  and clientbill.orderid = bills.orderid
  and date_part('year', bills.pdate) = 2015
group by clients.cid, cname
having sum(bills.totalpayment) > 1500;

-- with natural join:
select cname
from clients natural join bills natural join clientbill
where date_part('year', pdate) = 2015
group by clients.cid, cname
having sum(totalpayment) > 1500;

-- example (join using)
-- find names of clients that rented 2 cars on the same day
--without join:
select distinct cname
from clients, carrent as cr1, carrent as cr2
where clients.cid = cr1.cid
  and cr1.cid = cr2.cid
  and cr1.carid <> cr2.carid
  and cr1.rdate = cr2.rdate;

select * from clients, carrent as cr1, carrent as cr2;

-- with join using:
select distinct cname
from clients natural join carrent cr1 join carrent cr2 using(cid, rdate)
  where cr1.carid <> cr2.carid;


-- example (join on)





-- tomorrow:
-- exercises from last day
-- learn & practice join
-- practice create, insert into, delete
-- like, in, between
-- any, all, case


select *
from Clients;
select *
from Cars;
select *
from CarRent;
select *
from Bills;
select *
from ClientBill;
select *
from OrderCarRent;



-- find the names of the clients that paid on the service over a month from the bill date
select * from bills;


select cname
from clients,
     clientbill,
     bills
where clients.cid = clientbill.cid
  and clientbill.orderid = bills.orderid
  and bills.pdate > bills.billdate + interval '1 month';
--   and bills.pdate > bills.billdate + 30;



-- clients that ordered 2 cars on the same day
select * from clients, carrent CR1, carrent CR2
where clients.cid = CR1.cid
  and CR1.cid = CR2.cid
  and CR1.carid < CR2.carid -- < instead of <> to avoid duplicates
    and CR1.rdate = CR2.rdate;




-- usage of orderby
-- will always be the last clause in the query
-- desc - descending order
-- asc - ascending order (default)



-- there is no division operator in SQL (like in relational algebra)



-- display bills details sorted by date ascending,
-- bills from the same date display in descending order of the payment sum
select * from bills
order by billdate asc, totalpayment desc;

-- the from is going first.
-- the order by happens only after the select.
-- the sort is expensive, it can cost n^2 or n*log(n).
-- use order by only if you need.



-- select data from multiple tables (relations)
-- cartesian product - all possible combinations of rows from the tables
-- join, natural join.


-- remember this?

select cname
from clients,
     clientbill,
     bills
where clients.cid = clientbill.cid
  and clientbill.orderid = bills.orderid
--   and bills.pdate > bills.billdate + interval '1 month';
  and bills.pdate > bills.billdate + 30;


-- we can do it differently
-- natural join
-- connects between all the rows that has the same values in all the common columns,
-- only 1 column is saved from the common columns.
-- from r natural join s;

-- example:
-- find id of clients that paid on the service over a month from the bill date
select cid from bills natural join clientbill
where pdate > billdate + 30;
-- so the natural join automatically connects between the tables by the common columns


-- find the total sum that each client paid for all his bills after 1/1/2012





-- example union
-- union - combines the result of two or more select statements
select cname from clients
union
select carid from cars;

-- union all - same as union but doesn't remove duplicates
select cname from clients
union all
select carid from cars;

-- intersect - returns rows that are in both select statements
select cname from clients
intersect
select carid from cars;


select * from bills;
select orderid from bills where
totalpayment = (select max(totalpayment) from bills) limit 1;



























