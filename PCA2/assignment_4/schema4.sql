CREATE DATABASE IF NOT EXISTS Assignment4DB;
USE Assignment4DB;

-- Employee Table
CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Salary INT,
    DeptID INT
);

-- Department Table
CREATE TABLE Department (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50)
);

-- Insert into Department
INSERT INTO Department VALUES
(101, 'HR'),
(102, 'IT'),
(103, 'Finance');

-- Insert into Employee
INSERT INTO Employee VALUES
(1, 'Rahul', 50000, 101),
(2, 'Ananya', 60000, 102),
(3, 'Vikram', 55000, 103);

SELECT * FROM Employee;
SELECT * FROM Department;