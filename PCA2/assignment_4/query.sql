USE Assignment4DB;

-- 1. Create View from Single Table
CREATE VIEW EmployeeSalary AS
SELECT EmpID, EmpName, Salary
FROM Employee;

-- 2. Display Data from View
SELECT * FROM EmployeeSalary;

-- 3. Create View with Condition
CREATE VIEW HighSalaryEmp AS
SELECT *
FROM Employee
WHERE Salary > 50000;

-- Display HighSalaryEmp
SELECT * FROM HighSalaryEmp;

-- 4. Update Data through View
UPDATE EmployeeSalary
SET Salary = 65000
WHERE EmpID = 2;

SELECT * FROM Employee;

-- 5. Insert Data through View
INSERT INTO EmployeeSalary
VALUES (4, 'Priya', 58000);

SELECT * FROM Employee;

-- 6. Delete Data through View
DELETE FROM EmployeeSalary
WHERE EmpID = 3;

SELECT * FROM Employee;

-- 7. Create View Using Two Tables
CREATE VIEW EmployeeDeptView AS
SELECT Employee.EmpName, Department.DeptName
FROM Employee
INNER JOIN Department
ON Employee.DeptID = Department.DeptID;

-- 8. Display Data from Multi-Table View
SELECT * FROM EmployeeDeptView;

-- 9. Modify Base Table and Observe View Change
UPDATE Employee
SET Salary = 70000
WHERE EmpID = 1;

SELECT * FROM EmployeeSalary;

-- 10. Drop the Views
DROP VIEW EmployeeSalary;
DROP VIEW HighSalaryEmp;
DROP VIEW EmployeeDeptView;