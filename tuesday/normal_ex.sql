-- 1nf

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    product_ids VARCHAR(255)  -- Multiple product IDs in a single column (e.g., '1,2,3')
);

-- Create separate tables to store product details
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100)
);

CREATE TABLE order_products (
    order_id INT REFERENCES orders(order_id),
    product_id INT
);

-- Insert example data after normalization
INSERT INTO orders (customer_name) VALUES ('John Doe');
INSERT INTO order_products (order_id, product_id) VALUES (1, 1), (1, 2), (1, 3);









CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100),
    phone_numbers VARCHAR(255)  -- Multiple phone numbers (e.g., '123-456-7890, 987-654-3210')
);

-- Normalize the table by creating a separate table for phone numbers
CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100)
);

CREATE TABLE employee_phone_numbers (
    emp_id INT REFERENCES employees(emp_id),
    phone_number VARCHAR(15)
);

-- Insert example data after normalization
INSERT INTO employees (emp_name) VALUES ('Alice');
INSERT INTO employee_phone_numbers (emp_id, phone_number) VALUES (1, '123-456-7890'), (1, '987-654-3210');










CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100),
    instructor_1 VARCHAR(100),
    instructor_2 VARCHAR(100)
);

-- Normalize the table by storing instructors in a separate table
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100)
);

CREATE TABLE course_instructors (
    course_id INT REFERENCES courses(course_id),
    instructor_name VARCHAR(100)
);

-- Insert example data after normalization
INSERT INTO courses (course_name) VALUES ('Database Systems');
INSERT INTO course_instructors (course_id, instructor_name) VALUES (1, 'Prof. Smith'), (1, 'Prof. Johnson');





-- 2nf






CREATE TABLE order_products (
    order_id INT,
    product_id INT,
    product_name VARCHAR(100),  -- Partial dependency
    PRIMARY KEY (order_id, product_id)
);


-- Move product_name to a separate table
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100)
);

CREATE TABLE order_products (
    order_id INT,
    product_id INT REFERENCES products(product_id),
    PRIMARY KEY (order_id, product_id)
);

-- Insert example data after normalization
INSERT INTO products (product_name) VALUES ('Laptop');
INSERT INTO order_products (order_id, product_id) VALUES (1, 1);












CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(100),
    department_id INT,
    department_name VARCHAR(100)  -- Partial dependency
);

-- Move department_name to a separate table
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(100),
    department_id INT REFERENCES departments(department_id)
);

-- Insert example data after normalization
INSERT INTO departments (department_name) VALUES ('Computer Science');
INSERT INTO students (student_name, department_id) VALUES ('Bob', 1);






CREATE TABLE enrollments (
    student_id INT,
    course_id INT,
    course_name VARCHAR(100),  -- Partial dependency
    PRIMARY KEY (student_id, course_id)
);


-- Move course_name to a separate table
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100)
);

CREATE TABLE enrollments (
    student_id INT,
    course_id INT REFERENCES courses(course_id),
    PRIMARY KEY (student_id, course_id)
);

-- Insert example data after normalization
INSERT INTO courses (course_name) VALUES ('Database Management');
INSERT INTO enrollments (student_id, course_id) VALUES (1, 1);





-- 3nf
CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100),
    address VARCHAR(255),
    city VARCHAR(100)  -- Transitive dependency on address
);

-- Separate address and city into their own table
CREATE TABLE addresses (
    address_id SERIAL PRIMARY KEY,
    address VARCHAR(255),
    city VARCHAR(100)
);

CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100),
    address_id INT REFERENCES addresses(address_id)
);

-- Insert example data after normalization
INSERT INTO addresses (address, city) VALUES ('123 Main St', 'New York');
INSERT INTO employees (emp_name, address_id) VALUES ('Alice', 1);





CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    customer_address VARCHAR(255),
    customer_city VARCHAR(100)  -- Transitive dependency
);

-- Separate customer_address and customer_city into a new table
CREATE TABLE addresses (
    address_id SERIAL PRIMARY KEY,
    customer_address VARCHAR(255),
    customer_city VARCHAR(100)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    address_id INT REFERENCES addresses(address_id)
);

-- Insert example data after normalization
INSERT INTO addresses (customer_address, customer_city) VALUES ('456 Oak St', 'San Francisco');
INSERT INTO orders (customer_name, address_id) VALUES ('John Doe', 1);








CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    category_id INT,
    category_name VARCHAR(100)  -- Transitive dependency
);


-- Move category_name to a separate table
CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100)
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    category_id INT REFERENCES categories(category_id)
);

-- Insert example data after normalization
INSERT INTO categories (category_name) VALUES ('Electronics');
INSERT INTO products (product_name, category_id) VALUES ('Smartphone', 1);





