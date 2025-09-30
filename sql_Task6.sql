CREATE DATABASE WorkBase;

USE WorkBase;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);


INSERT INTO Customers VALUES
(1, 'Rahul', 'Nagpur'),
(2, 'Priya', 'Mumbai'),
(3, 'Amit', 'Delhi');


SELECT * FROM Customers;


CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10,2),
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);


INSERT INTO Orders VALUES
(101, 1, 500, '2024-01-10'),
(102, 2, 1200, '2024-01-15'),
(103, 1, 700, '2024-02-01'),
(104, 3, 200, '2024-02-05');


SELECT * FROM Orders;

SELECT c.name AS CustomerName
FROM Customers c
WHERE EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.customer_id = c.customer_id
);


-- The subquery (stats) calculates total and average amount per customer.
SELECT c.name AS CustomerName, stats.TotalAmount, stats.AvgAmount
FROM Customers c
JOIN (
    SELECT customer_id, 
           SUM(amount) AS TotalAmount,
           ROUND(AVG(amount), 2) AS AvgAmount
    FROM Orders
    GROUP BY customer_id
) AS stats
ON c.customer_id = stats.customer_id;


SELECT name AS CustomerName, city AS City
FROM Customers
WHERE customer_id IN (
    SELECT DISTINCT customer_id
    FROM Orders
);


SELECT order_id, amount, customer_id
FROM Orders o
WHERE amount > (
    SELECT AVG(amount)
    FROM Orders
    WHERE customer_id = o.customer_id
);

SELECT c.city AS CustomerCity
FROM Customers c
WHERE EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.customer_id = c.customer_id
);
