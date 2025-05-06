-- Question 1: Create original ProductDetail table
CREATE TABLE ProductDetail (
    OrderID INT,
    CustomerName VARCHAR(100),
    Products VARCHAR(255)
);

-- Insert the original denormalized data
INSERT INTO ProductDetail VALUES
(101, 'John Doe', 'Laptop, Mouse'),
(102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
(103, 'Emily Clark', 'Phone');

-- Create normalized version (1NF) 
CREATE TABLE Product (
    OrderID INT,
    CustomerName VARCHAR(100),
    ProductName VARCHAR(100),
    Quantity INT
);

-- Insert normalized data with quantities
INSERT INTO Product VALUES
(101, 'John Doe', 'Laptop', 1),
(101, 'John Doe', 'Mouse', 1),
(102, 'Jane Smith', 'Tablet', 1),
(102, 'Jane Smith', 'Keyboard', 1),
(102, 'Jane Smith', 'Mouse', 1),
(103, 'Emily Clark', 'Phone', 1);

-- Question 2: Create 2NF tables
-- Orders table (contains order information)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Insert distinct orders
INSERT INTO Orders
SELECT DISTINCT OrderID, CustomerName FROM Product;

-- Create proper Product table in 2NF (with Quantity)
CREATE TABLE Product_new (
    OrderID INT,
    ProductName VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, ProductName),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert product data with quantities
INSERT INTO Product_new
SELECT OrderID, ProductName, Quantity FROM Product;

-- Drop the old Product table and rename the new one
DROP TABLE Product;
ALTER TABLE Product_new RENAME TO Product;
