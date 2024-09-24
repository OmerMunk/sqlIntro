-- 1nf

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    product_ids VARCHAR(255)
);







CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100),
    phone_numbers VARCHAR(255)  
);





CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100),
    instructor_1 VARCHAR(100),
    instructor_2 VARCHAR(100)
);



-- 2nf






CREATE TABLE order_products (
    order_id INT,
    product_id INT,
    product_name VARCHAR(100),  -- Partial dependency
    PRIMARY KEY (order_id, product_id)
);





CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(100),
    department_id INT,
    department_name VARCHAR(100)  -- Partial dependency
);






CREATE TABLE enrollments (
    student_id INT,
    course_id INT,
    course_name VARCHAR(100),  -- Partial dependency
    PRIMARY KEY (student_id, course_id)
);




-- 3nf

CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100),
    address VARCHAR(255),
    city VARCHAR(100)  -- Transitive dependency on address
);



CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    customer_address VARCHAR(255),
    customer_city VARCHAR(100)  -- Transitive dependency
);




CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    category_id INT,
    category_name VARCHAR(100)  -- Transitive dependency
);



