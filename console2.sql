-- join ... on
-- from r join s on r.A = s.B
-- the condition is defined, the properties to join on, can be different


-- display a list of cars (car_type) the differs from each other
-- that rented to a period for at least a month.
-- use join on

select distinct cartype from cars join carrent on cars.carid = carrent.carid
where carrent.rperiod >= 30;


-- outer join
-- an extension of the join, that prevents lost a part of the data.
-- does the match and adds rows from one table that doesn't have match in the other table
-- uses null values
-- left outer join preserves the rows of the left table
-- right outer join preserves the rows of the right table


-- display names of all cars, and the identity of the clients that rented them
select cartype, cid from cars natural join carrent;


select cartype, cid from cars left outer join carrent on cars.carid = carrent.carid;


-- פונקציות הקבצה
-- in english: aggregate functions
-- avg, min, max, sum, count
-- it is not possible to activate them on each other



-- find the most expensive payment ever paid for a rent car
select max(totalpayment) as maxprice from bills;


-- ilegal:
select * from bills where max(totalpayment) < 20;

-- becuase where acts on rows, and max acts on columns
-- those function are only on select and having.

select * from bills where totalpayment = (select max(totalpayment) from bills)
limit 1;


-- group by
-- creates from the table, groups by properties after the group by.
-- the aggregate functions are activated on each group separately.
-- columns the on the select, out of the aggregate function, must be on the group by.
-- DONT use group by without use of an aggregate function in the select or having


-- find how many orders were to each client

select cname, cid, count(cid) as orders from clients natural join carrent
group by cid;

select cid, count(orderid) as num_of_orders
    from clientbill
        group by cid;


-- find the sum of payment that each client paid for all his bills after 1/1/2016
select cid, sum(totalpayment) as total_payment
from bills natural join clientbill
where
    date_part('year', pdate) > 2015
group by cid;




-- having
-- checks a condition of a GROUP of values
-- will be only condition with aggregate functions
-- having is only after group by
-- select, from ,where ,group by, having, order by
--   5      1      2      3        4         6
-- the conditions in the having is happening only after the grouping
-- the conditions in the where is happening before the grouping


-- find the names of clients that paid for all their bills after 1/1/2016, more than 1500
select cname, sum(totalpayment) as total_payment
from clients natural join clientbill natural join bills
where
    date_part('year', pdate) > 2015
group by cid
having sum(totalpayment) > 1500;


-- each client, how many cars did he rent on january
select cname, count(cid) as num_of_rents_on_jan
    from clients natural inner join carrent
        where date_part('month', rdate) = 1
group by cid;




-- actions on groups
-- union
-- intersect
-- except (minus)
-- implementation of union - every sql
-- intersect and except - not every sql
-- it drops duplicates automatically,
-- to preserve duplicates, use union all, intersect all, except all

-- cars that were rented by danny but never rented by yossi
select carid from carrent natural inner join clients where cname = 'Danny'
except
select carid from carrent natural inner join clients where cname = 'Yossi';


-- cars that were rented by danny and rented by yossi
select carid from carrent natural inner join clients where cname = 'Danny'
intersect
select carid from carrent natural inner join clients where cname = 'Yossi';


-- cars that were rented by danny or rented by yossi
select carid from carrent natural inner join clients where cname = 'Danny'
union
select carid from carrent natural inner join clients where cname = 'Yossi';



-- find clients that didn't pay for more than 1 order, and has a car right now
select cid
    from clientbill natural join carrent
where status = 'open' and rdate <= current_date and current_date <= rdate + rperiod
    group by cid
having count(orderid) >= 2;



select cid
from bills natural join clientbill
where date_part('year', pdate) = 2016
and status = 'paid'
group by cid
having sum(totalpayment) > 10000
except
select cid
from carrent natural join cars
where cartype = 'Volvo';


-- nested sub queries
-- sub query can be on from, where or having.
-- very common to use sub queries to check belonging to a group,
-- comparison of groups, and a size of group
-- use with all, any, not in, in



-- find the car id's of the company
select distinct carid from cars;


-- does the car number 6055570 is a company car?
select '6055570' in (select distinct carid from cars);
select '6055572' in (select distinct carid from cars);

-- comparison of a single value to grup of values
-- v is value, r is table (relation)
-- v in r
-- v not in r
-- v = any r
-- v <> any r
-- v = all r
-- v <> all r


-- ex:
-- find the order number that it's payment was the highest
-- find a car that has only 1 order
-- find what is the oldest car, and how many times it was rented
-- make a list of cars (carid and type), that were rented for more than 10 days and not paid yet.
