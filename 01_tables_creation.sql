\-- Creating `customers` table
CREATE TABLE customers (
customer_id INT PRIMARY KEY,
customer_name VARCHAR(100),
loyalty_tier VARCHAR(20)
);

\-- Inserting sample data into `customers`
INSERT INTO customers (customer_id, customer_name, loyalty_tier) 
VALUES
(1, 'Alice Johnson', 'Gold'),
(2, 'Bob Smith', 'Silver'),
(3, 'Charlie Brown', 'Platinum'),
(4, 'Diana Prince', 'Gold'),
(5, 'Evan Taylor', 'Silver'),
(6, 'Faith Hill', 'Bronze');

\-- Creating `sales_data` table
CREATE TABLE sales_data (
order_id INT PRIMARY KEY,
customer_id INT,
order_date DATE,
region VARCHAR(20),
product_category VARCHAR(50),
sales_amount DECIMAL(10,2),
quantity INT,
FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

\-- Insert sample data into `sales_data`
INSERT INTO sales_data (order_id, customer_id, order_date, region, product_category, sales_amount, quantity) 
VALUES
(101, 1, '2023-01-15', 'North', 'Electronics', 250.00, 1),
(102, 2, '2023-02-17', 'East', 'Clothing', 150.00, 2),
(103, 1, '2023-03-10', 'North', 'Furniture', 500.00, 1),
(104, 3, '2023-01-22', 'West', 'Electronics', 750.00, 3),
(105, 4, '2023-03-25', 'East', 'Clothing', 120.00, 2),
(106, 2, '2023-04-05', 'East', 'Electronics', 200.00, 1),
(107, 5, '2023-02-11', 'South', 'Furniture', 400.00, 2),
(108, 6, '2023-03-20', 'South', 'Clothing', 90.00, 1),
(109, 3, '2023-04-01', 'West', 'Electronics', 600.00, 2),
(110, 5, '2023-04-18', 'South', 'Electronics', 320.00, 2),
(111, 6, '2023-04-21', 'South', 'Furniture', 450.00, 1),
(112, 1, '2023-04-25', 'North', 'Clothing', 180.00, 2);
