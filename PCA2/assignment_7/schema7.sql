DROP DATABASE IF EXISTS Assignment8DB;
CREATE DATABASE IF NOT EXISTS Assignment8DB;

USE Assignment8DB;

-- =========================================
-- ACCOUNTS TABLE
-- =========================================

DROP TABLE IF EXISTS accounts;

CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    account_name VARCHAR(50),
    balance INT
);

INSERT INTO accounts VALUES
(1, 'Rahul', 10000),
(2, 'Ananya', 8000);

SELECT * FROM accounts;


-- =========================================
-- CUSTOMERS TABLE
-- =========================================

DROP TABLE IF EXISTS Customers;

CREATE TABLE Customers (
    ID INT PRIMARY KEY,
    Name VARCHAR(50),
    State VARCHAR(50)
);

INSERT INTO Customers VALUES
(1, 'Aman', 'Texas'),
(2, 'Priya', 'Florida'),
(3, 'Rahul', 'Ohio');

SELECT * FROM Customers;