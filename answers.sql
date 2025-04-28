-- Question 1: Create ProductDetail table and transform to 1NF
CREATE TABLE ProductDetail (
    OrderID INT,
    CustomerName VARCHAR(100),
    Products VARCHAR(255)
);

INSERT INTO ProductDetail VALUES
(101, 'John Doe', 'Laptop, Mouse'),
(102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
(103, 'Emily Clark', 'Phone');

CREATE TABLE Product AS
SELECT 101 AS OrderID, 'John Doe' AS CustomerName, 'Laptop' AS ProductName UNION ALL
SELECT 101, 'John Doe', 'Mouse' UNION ALL
SELECT 102, 'Jane Smith', 'Tablet' UNION ALL
SELECT 102, 'Jane Smith', 'Keyboard' UNION ALL
SELECT 102, 'Jane Smith', 'Mouse' UNION ALL
SELECT 103, 'Emily Clark', 'Phone';

-- Question 2: Transform to 2NF
CREATE TABLE Orders AS
SELECT DISTINCT OrderID, CustomerName
FROM Product;

CREATE TABLE Product_new AS
SELECT OrderID, ProductName
FROM Product;

DROP TABLE Product;
ALTER TABLE Product_new RENAME TO Product;

ALTER TABLE Orders ADD PRIMARY KEY (OrderID);
ALTER TABLE Product ADD PRIMARY KEY (OrderID, ProductName);
