-- Medium Exercises

-- Exercise 1: Create a table named `appointments` with an auto-incrementing `appointment_id` using the `SERIAL` type, and columns for `appointment_date` (DATE) and `appointment_time` (TIME).




-- Solution:
CREATE TABLE appointments (
    appointment_id SERIAL PRIMARY KEY,
    appointment_date DATE,
    appointment_time TIME
);





-- Exercise 2: Insert 3 rows into the `appointments` table with specific dates and times.




-- Solution:
INSERT INTO appointments (appointment_date, appointment_time)
VALUES 
    ('2024-12-25', '10:30:00'),
    ('2024-12-26', '14:00:00'),
    ('2024-12-27', '09:00:00');





-- Exercise 3: Update the time of the appointment on '2024-12-25' to '11:00:00'.




-- Solution:
UPDATE appointments
SET appointment_time = '11:00:00'
WHERE appointment_date = '2024-12-25';





-- Exercise 4: Delete the appointment scheduled on '2024-12-27'.



-- Solution:
DELETE FROM appointments
WHERE appointment_date = '2024-12-27';





-- Exercise 5: Create a `projects` table with a `start_date` (DATE) and an `end_date` (DATE) and use `BETWEEN` to select all projects starting between '2024-01-01' and '2024-12-31'.


-- Solution:
CREATE TABLE projects (
    project_id SERIAL PRIMARY KEY,
    project_name VARCHAR(50),
    start_date DATE,
    end_date DATE
);

SELECT project_name FROM projects
WHERE start_date BETWEEN '2024-01-01' AND '2024-12-31';





-- Exercise 6: Use `ANY` to find employees who are assigned to any department with a `dept_id` less than 5.


-- Solution:
SELECT emp_name
FROM employees
WHERE dept_id = ANY (SELECT dept_id FROM departments WHERE dept_id < 5);





-- Exercise 7: Use `ALL` to find employees whose salary is greater than the salary of all employees in department 2.



-- Solution:
SELECT emp_name
FROM employees
WHERE salary > ALL (SELECT salary FROM employees WHERE dept_id = 2);





-- Exercise 8: Use `CASE` to display employees' salary categories as 'High' for salaries above 80,000, 'Medium' for 50,000-80,000, and 'Low' for below 50,000.



-- Solution:
SELECT emp_name, 
CASE
    WHEN salary > 80000 THEN 'High'
    WHEN salary BETWEEN 50000 AND 80000 THEN 'Medium'
    ELSE 'Low'
END AS salary_category
FROM employees;





-- Exercise 9: Select the first 5 employees with the highest salaries using the `LIMIT` clause.



-- Solution:
SELECT emp_name, salary
FROM employees
ORDER BY salary DESC
LIMIT 5;





-- Exercise 10: Select all appointments from the `appointments` table, limiting the results to 2 rows.




-- Solution:
SELECT * FROM appointments
LIMIT 2;





-- Hard Exercises

-- Exercise 1: Insert multiple rows with both `timestamp` and `time` values into a `meetings` table.



-- Solution:
CREATE TABLE meetings (
    meeting_id SERIAL PRIMARY KEY,
    meeting_name VARCHAR(50),
    meeting_date TIMESTAMP,
    meeting_start TIME
);

INSERT INTO meetings (meeting_name, meeting_date, meeting_start)
VALUES 
    ('Board Meeting', '2024-10-20 09:00:00', '09:00:00'),
    ('Project Meeting', '2024-11-01 14:00:00', '14:00:00'),
    ('Client Meeting', '2024-12-10 11:00:00', '11:00:00');





-- Exercise 2: Update the `meeting_start` time of the 'Board Meeting' to '10:00:00'.



-- Solution:
UPDATE meetings
SET meeting_start = '10:00:00'
WHERE meeting_name = 'Board Meeting';





-- Exercise 3: Delete the 'Client Meeting' from the `meetings` table.


-- Solution:
DELETE FROM meetings
WHERE meeting_name = 'Client Meeting';





-- Exercise 4: Use `BETWEEN` to select all meetings happening between '2024-10-01' and '2024-12-31'.



-- Solution:
SELECT meeting_name, meeting_date 
FROM meetings
WHERE meeting_date BETWEEN '2024-10-01' AND '2024-12-31';





-- Exercise 5: Use `ANY` to find all projects that ended before any project started in '2024'.



-- Solution:
SELECT project_name 
FROM projects
WHERE end_date < ANY (SELECT start_date FROM projects WHERE start_date LIKE '2024%');





-- Exercise 6: Use `ALL` to find employees whose salary is higher than all other employees in department 3.



-- Solution:
SELECT emp_name
FROM employees
WHERE salary > ALL (SELECT salary FROM employees WHERE dept_id = 3);





-- Exercise 7: Use `CASE` to classify meetings as 'Morning' if they start before noon, and 'Afternoon' if they start after noon.



-- Solution:
SELECT meeting_name,
CASE 
    WHEN meeting_start < '12:00:00' THEN 'Morning'
    ELSE 'Afternoon'
END AS meeting_time
FROM meetings;





-- Exercise 8: Update all meetings to start at '09:00:00' if they are currently scheduled in the afternoon (after '12:00:00').



-- Solution:
UPDATE meetings
SET meeting_start = '09:00:00'
WHERE meeting_start > '12:00:00';





-- Exercise 9: Delete projects that started before '2023-01-01' and ended before '2023-12-31'.



-- Solution:
DELETE FROM projects
WHERE start_date < '2023-01-01' AND end_date < '2023-12-31';





-- Exercise 10: Select the top 3 employees with the longest employment duration using `LIMIT` and `ORDER BY`.




-- Solution:
SELECT emp_name, hire_date
FROM employees
ORDER BY hire_date
LIMIT 3;

