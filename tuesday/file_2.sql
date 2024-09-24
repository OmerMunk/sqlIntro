-- sub-queries
-- exist
-- views
-- functions

-- single sub query

-- בוא נכניס משכורת לעובדים
select *
from employees;

alter table employees
    add salary numeric(8, 2);

update employees
set salary = 1.5
where emp_id = 1;

update employees
set salary = 3.379
where emp_id = 2;

-- update employees
-- set salary = 123456789
-- where emp_id = 3;

-- single sub query
select emp_name, salary
from employees
where salary = (select max(salary) from employees);

-- multi row sub query
select emp_name, salary
from employees
where salary <= 2
  and emp_name in (select emp_name from employees where salary > 2);


-- EXISTS
SELECT cname
from clients
where exists (select *
              from carrent
              where cid = clients.cid);

-- NOT EXISTS
SELECT cname
from clients
where not exists (select *
                  from carrent
                  where cid = clients.cid);


-- views
-- view is a virtual table
-- it does not store the data itself,
-- but dynamically generates the data when called

-- why?
-- simplicity
-- security - restrict access to data
-- maintainability - change the view, not the table


-- create view
CREATE VIEW clients_carrent AS
SELECT cname, cid, carid
from clients
         natural join carrent;

select *
from clients_carrent;


-- UPDATE VIEW ...

-- DROP VIEW ...


-- functions
CREATE FUNCTION get_client_name(client_id varchar(9)) RETURNS varchar(20) AS
$$
BEGIN
    select cname from clients where cid = client_id;
END;
$$ LANGUAGE plpgsql;

CREATE FUNCTION get_current_year() RETURNS INT AS
$$
BEGIN
    RETURN date_part('year', current_date)::INT;
END;
$$ LANGUAGE plpgsql;

select get_current_year();



CREATE FUNCTION calculate_bonus(emp_salary numeric(8, 2)) RETURNS numeric(8, 2) AS
$$
BEGIN
    RETURN emp_salary * 0.1;
END;
$$ LANGUAGE plpgsql;

SELECT calculate_bonus(1000);

select emp_name, salary, calculate_bonus(salary) as bonus
from employees;


select emp_name, salary, salary + calculate_bonus(salary) as updated
from employees;









