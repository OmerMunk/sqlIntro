-- 1NF
-- eliminate repeating groups (for exmaple: customer name in two different tables)
-- ensure atomicity (each column should contain only one value)

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    product_ids VARCHAR(255)  -- Multiple product IDs stored in a single column
    -- 1,2,3,4,5,6,7
);

-- solution:

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100)
);

CREATE TABLE order_products (
    order_id INT REFERENCES orders(order_id),
    product_id INT
);


-- 2NF
-- ensure every non-key attribute is fully dependent on the entire primary key
-- לוודא שכל שדה שהוא לא מפתח, הוא תלוי באופן מלא בכל המפתח הראשי.
CREATE TABLE order_products (
    order_id INT,
    product_id INT,
    amount INT,
    product_name VARCHAR(100),  -- Violates 2NF (product_name should depend only on product_id)
    PRIMARY KEY (order_id, product_id)
);


-- solution:
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100)
);

CREATE TABLE order_products (
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES products(product_id),
    PRIMARY KEY (order_id, product_id)
);



-- 3NF
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    customer_address VARCHAR(255),
    city VARCHAR(100),  -- Violates 3NF (city depends on customer_address)
    postal_code VARCHAR(20)
);

-- solution:

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    address_id INT REFERENCES addresses(address_id)
);

CREATE TABLE addresses (
    address_id SERIAL PRIMARY KEY,
    customer_address VARCHAR(255),
    city VARCHAR(100),
    postal_code VARCHAR(20)
);






