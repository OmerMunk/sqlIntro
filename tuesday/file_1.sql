-- date, time, timestamp ,serial
-- update a row
-- delete a row
-- between
-- any, all, case
-- limit

CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name varchar(50),
    hire_date DATE
);

INSERT INTO employees (emp_name, hire_date)
values ('Abraham', '2021-09-24'),
('Isaac', '2021-09-24'),
('Jacob', '2021-09-24'),
('Joseph', '2021-09-24'),
('Moses', '2021-09-24'),
('Aaron', '2021-09-24'),
('David', '2021-09-24'),
('Solomon', '2021-09-24');

-- convention in postgres = YYYY-MM-DD

select * from employees;

-- TIME

CREATE TABLE meetings (
    meeting_id SERIAL PRIMARY KEY,
    meeting_time TIME
);

INSERT INTO meetings (meeting_time)
VALUES ('10:00:00'),
('11:00:00');

-- HH:MM:SS

INSERT INTO meetings (meeting_time)
VALUES ('13:00:00'),
('19:00:00');

SELECT * FROM meetings;


-- TIMESTAMP
CREATE TABLE event (
    event_id SERIAL PRIMARY KEY,
    event_name varchar(50),
    event_start TIMESTAMP
);

-- YYYY-MM-DD HH:MM:SS

INSERT INTO event (event_name, event_start)
VALUES ('Birthday Party', '2021-09-24 10:00:00'),
('Wedding', '2021-09-24 11:00:00');

SELECT * FROM event;


-- timestamp with time zone (timestamptz)

CREATE TABLE logs (
    log_id SERIAL PRIMARY KEY,
    log_time TIMESTAMPTZ DEFAULT NOW()
);

INSERT INTO logs DEFAULT VALUES;

SELECT * FROM logs;


CREATE TABLE logs2 (
    log_id SERIAL PRIMARY KEY,
    log_time TIMESTAMPTZ DEFAULT NOW(),
    log_message TEXT
);

INSERT INTO logs2 DEFAULT VALUES;

INSERT INTO logs2(log_message) VALUES ('This is a log message');

SELECT * FROM logs2;



-- serial
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    user_name varchar(50)
);

insert into users (user_name) values ('Alice'), ('Bob');

select * from users;


-- managing rows

-- UPDATE table_name
-- SET column_name1 = value1, column_name2 = value2 ...
-- WHERE CONDITION;

UPDATE users
SET user_name = 'Aliza'
WHERE user_name = 'Alice';

select * from users;

-- challenge for you:
-- check how to update only if exists
-- check how to insert if not exist

-- delete a row

-- DELETE FROM table_name
-- WHERE condition;

DELETE FROM users
WHERE user_name = 'Bob';

SELECT * FROM users;


-- BETWEEN

-- SELECT column_name
-- FROM table_name
-- WHERE column_name BETWEEN value1 AND value2;

-- IT IS INCLUSIVE
-- YAANI כולל

SELECT emp_name
from employees
where hire_date between '2021-09-24' and '2021-09-25';


-- ANY, ALL, CASE

-- any

select emp_name
from employees
where emp_name = ANY (
    ARRAY['Abraham', 'Isaac', 'Jacob', 'Omer']
    );

select emp_name
from employees
where hire_date = ANY (
    select hire_date from employees where emp_name = 'Abraham'
    );


SELECT emp_name
FROM employees
WHERE hire_date > ALL (SELECT hire_date FROM employees WHERE emp_id = 7);


SELECT emp_name
from employees
where hire_date LIKE ALL (
    SELECT hire_date FROM employees WHERE emp_name LIKE 'A%'
    );


-- CASE

SELECT emp_name,
    CASE
        WHEN emp_name = 'Abraham' THEN 'Father of Nations'
        WHEN emp_name = 'Isaac' THEN 'Laughter'
        ELSE 'Unknown'
    END AS nickname

FROM employees;



select emp_name
from employees
order by emp_name desc
limit 5;









