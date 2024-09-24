-- Medium Exercises

-- Exercise 1: Create a table `events` with columns `event_id` as a `SERIAL`, `event_date` as `DATE`, and `event_start_time` as `TIME`. Insert 3 records.
-- Guidance: The `SERIAL` type auto-increments, and the `DATE` and `TIME` types store the event's date and start time.





-- Solution:
CREATE TABLE events (
    event_id SERIAL PRIMARY KEY,
    event_date DATE,
    event_start_time TIME
);

INSERT INTO events (event_date, event_start_time)
VALUES ('2024-11-01', '09:00:00'), 
       ('2024-12-10', '14:00:00'), 
       ('2025-01-15', '16:30:00');





-- Exercise 2: Create a `tasks` table that tracks `task_id` as `SERIAL`, `task_name`, and `due_date` (DATE). Use a subquery to find tasks with due dates later than the earliest event.
-- Guidance: Create a table with a `SERIAL` primary key, and use a subquery to compare task due dates with event dates.





-- Solution:
CREATE TABLE tasks (
    task_id SERIAL PRIMARY KEY,
    task_name VARCHAR(100),
    due_date DATE
);

INSERT INTO tasks (task_name, due_date)
VALUES ('Prepare Report', '2024-12-05'), 
       ('Review Proposal', '2025-01-10');

SELECT task_name, due_date 
FROM tasks
WHERE due_date > (SELECT MIN(event_date) FROM events);





-- Exercise 3: Use `EXISTS` to check if any tasks are due before 2025.
-- Guidance: Use `EXISTS` with a subquery to return whether any task due dates are before 2025.




-- Solution:
SELECT EXISTS (SELECT 1 FROM tasks WHERE due_date < '2025-01-01');





-- Exercise 4: Create a view `upcoming_events_view` to show all events with `event_date` in 2024.
-- Guidance: Use the `CREATE VIEW` statement to create a view that filters events based on the `event_date`.




-- Solution:
CREATE VIEW upcoming_events_view AS
SELECT event_id, event_date, event_start_time 
FROM events
WHERE event_date BETWEEN '2024-01-01' AND '2024-12-31';





-- Exercise 5: Select all events from the `upcoming_events_view`.
-- Guidance: Select all rows from the view you created in the previous exercise.




-- Solution:
SELECT * FROM upcoming_events_view;





-- Exercise 6: Create a function `event_count()` that returns the total number of events.
-- Guidance: Use `CREATE FUNCTION` to create a simple function that returns the total count of events from the `events` table.




-- Solution:
CREATE FUNCTION event_count() RETURNS INT AS $$
BEGIN
    RETURN (SELECT COUNT(*) FROM events);
END;
$$ LANGUAGE plpgsql;

SELECT event_count();





-- Exercise 7: Create a function that takes an `event_date` and returns all events on that date.
-- Guidance: Use parameters in the function to pass in a specific event date and return events from that date.





-- Solution:
CREATE FUNCTION get_events_on_date(event_date DATE) RETURNS TABLE(event_id INT, event_start_time TIME) AS $$
BEGIN
    RETURN QUERY SELECT event_id, event_start_time FROM events WHERE event_date = event_date;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM get_events_on_date('2024-11-01');





-- Exercise 8: Use a subquery to find the event scheduled after '2024-12-05'.
-- Guidance: Write a query with a subquery in the `WHERE` clause to filter events scheduled after a specific date.





-- Solution:
SELECT event_id, event_date, event_start_time 
FROM events
WHERE event_date > (SELECT '2024-12-05');





-- Exercise 9: Use `EXISTS` to find out if there are any events with a start time before '12:00:00'.
-- Guidance: Use the `EXISTS` clause to check for events starting before noon.




-- Solution:
SELECT EXISTS (SELECT 1 FROM events WHERE event_start_time < '12:00:00');





-- Exercise 10: Create a view that shows tasks with due dates after '2024-12-31'.
-- Guidance: Use `CREATE VIEW` to create a view filtering tasks based on the `due_date`.





-- Solution:
CREATE VIEW future_tasks_view AS
SELECT task_name, due_date
FROM tasks
WHERE due_date > '2024-12-31';





-- Hard Exercises

-- Exercise 1: Create a function `is_event_today()` that returns `TRUE` if there is an event scheduled for the current date, otherwise `FALSE`.
-- Guidance: Use `CREATE FUNCTION` with `EXISTS` to check if there are any events scheduled for the current date.





-- Solution:
CREATE FUNCTION is_event_today() RETURNS BOOLEAN AS $$
BEGIN
    RETURN EXISTS (SELECT 1 FROM events WHERE event_date = CURRENT_DATE);
END;
$$ LANGUAGE plpgsql;

SELECT is_event_today();





-- Exercise 2: Create a function that returns all tasks due within the next 7 days.
-- Guidance: Use a function with a return type of `TABLE` to return tasks that are due within the next 7 days from the current date.





-- Solution:
CREATE FUNCTION tasks_due_soon() RETURNS TABLE(task_name VARCHAR, due_date DATE) AS $$
BEGIN
    RETURN QUERY SELECT task_name, due_date FROM tasks WHERE due_date BETWEEN CURRENT_DATE AND (CURRENT_DATE + INTERVAL '7 days');
END;
$$ LANGUAGE plpgsql;

SELECT * FROM tasks_due_soon();





-- Exercise 3: Create a subquery that selects tasks due after the earliest event.
-- Guidance: Use a subquery to find tasks that have due dates after the earliest event date.





-- Solution:
SELECT task_name, due_date 
FROM tasks 
WHERE due_date > (SELECT MIN(event_date) FROM events);





-- Exercise 4: Create a view showing all events with start times in the afternoon (after '12:00:00').
-- Guidance: Use the `CREATE VIEW` statement to filter events based on the `event_start_time`.





-- Solution:
CREATE VIEW afternoon_events_view AS
SELECT event_id, event_date, event_start_time
FROM events
WHERE event_start_time > '12:00:00';





-- Exercise 5: Create a function that accepts a task name and deletes it from the `tasks` table if it exists.
-- Guidance: Use a `DELETE` statement inside a function that accepts a parameter to remove a specific task.





-- Solution:
CREATE FUNCTION delete_task(task_name_input VARCHAR) RETURNS VOID AS $$
BEGIN
    DELETE FROM tasks WHERE task_name = task_name_input;
END;
$$ LANGUAGE plpgsql;

SELECT delete_task('Prepare Report');





-- Exercise 6: Use a subquery to find tasks with due dates earlier than the latest event date.
-- Guidance: Use a subquery to compare task due dates with the latest event date.





-- Solution:
SELECT task_name, due_date 
FROM tasks 
WHERE due_date < (SELECT MAX(event_date) FROM events);





-- Exercise 7: Create a function to return the number of events scheduled after a specific date.
-- Guidance: Use a function with a parameter to return the count of events after a given date.






-- Solution:
CREATE FUNCTION event_count_after_date(given_date DATE) RETURNS INT AS $$
BEGIN
    RETURN (SELECT COUNT(*) FROM events WHERE event_date > given_date);
END;
$$ LANGUAGE plpgsql;

SELECT event_count_after_date('2024-11-01');





-- Exercise 8: Create a view showing tasks with due dates that match any of the event dates.
-- Guidance: Use the `IN` operator to compare the `due_date` with the event dates and create a view from the result.










-- Solution:
CREATE VIEW tasks_matching_events_view AS
SELECT task_name, due_date
FROM tasks
WHERE due_date IN (SELECT event_date FROM events);





-- Exercise 9: Create a function that takes an event ID and returns the event date and start time.
-- Guidance: Use a function with a parameter to return specific event details.









-- Solution:
CREATE FUNCTION get_event_details(event_id_input INT) RETURNS TABLE(event_date DATE, event_start_time TIME) AS $$
BEGIN
    RETURN QUERY SELECT event_date, event_start_time FROM events WHERE event_id = event_id_input;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM get_event_details(1);





-- Exercise 10: Create a function that returns the total number of tasks due before a specified date.
-- Guidance: Use a parameter in a function to return the count of tasks due before a given date.









-- Solution:
CREATE FUNCTION task_count_before_date(given_date DATE) RETURNS INT AS $$
BEGIN
    RETURN (SELECT COUNT(*) FROM tasks WHERE due_date < given_date);
END;
$$ LANGUAGE plpgsql;

SELECT task_count_before_date('2024-12-01');

