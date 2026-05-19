-- View the initial data
SELECT * FROM DEPARTMENT;
SELECT * FROM EMPLOYEE;
SELECT * FROM PROJECT;
SELECT * FROM WORKS_ON;
SELECT * FROM DEPENDENT;

-- ==========================================
-- Queries using JOIN
-- ==========================================

--- Describe alternate: 
PRAGMA table_info(DEPARTMENT)

-- 2. List all employees and their dependents (LEFT JOIN)
SELECT e.Fname, e.Lname, d.Dependent_name 
FROM EMPLOYEE e 
LEFT JOIN DEPENDENT d ON e.Ssn = d.Essn;

-- 3. List all departments and the employees working in them (RIGHT JOIN)
SELECT d.Dname, e.Fname, e.Lname 
FROM EMPLOYEE e 
RIGHT JOIN DEPARTMENT d ON e.Dno = d.Dnumber;

-- 4. Show all employees and all dependents matched or unmatched (FULL OUTER JOIN)
SELECT e.Fname, e.Lname, d.Dependent_name 
FROM EMPLOYEE e 
FULL OUTER JOIN DEPENDENT d ON e.Ssn = d.Essn;

-- 5. Show employee name and their manager name (SELF JOIN)
SELECT e.Fname AS Employee_Name, m.Fname AS Manager_Name 
FROM EMPLOYEE e 
LEFT JOIN EMPLOYEE m ON e.Super_ssn = m.Ssn;

-- 6. List employee name, project name, and hours worked (MULTIPLE JOINS)
SELECT e.Fname, p.Pname, w.Hours 
FROM EMPLOYEE e 
JOIN WORKS_ON w ON e.Ssn = w.Essn 
JOIN PROJECT p ON w.Pno = p.Pnumber;

-- 7. Show all combinations of employees and projects
-- Approach 1: CROSS JOIN
SELECT e.Fname, p.Pname 
FROM EMPLOYEE e CROSS JOIN PROJECT p;

-- Approach 2: Comma in FROM clause (Old syntax)
SELECT e.Fname, p.Pname 
FROM EMPLOYEE e, PROJECT p;


-- ==========================================
-- Aggregate Queries with GROUP BY
-- ==========================================

-- 2. Find Average Salary in Each Department
SELECT Dno, AVG(Salary) AS Avg_Salary 
FROM EMPLOYEE 
GROUP BY Dno;

-- 3. Maximum Salary in Each Department
SELECT Dno, MAX(Salary) AS Max_Salary 
FROM EMPLOYEE 
GROUP BY Dno;

-- 4. Total Hours Worked on Each Project
SELECT Pno, SUM(Hours) AS Total_Hours 
FROM WORKS_ON 
GROUP BY Pno;


-- ==========================================
-- Using GROUP BY and HAVING
-- ==========================================

-- 2. List Departments with Dnos, with Average Salary Greater Than 40000
SELECT Dno, AVG(Salary) AS Avg_Salary 
FROM EMPLOYEE 
GROUP BY Dno 
HAVING AVG(Salary) > 40000;


-- ==========================================
-- Use of GROUP BY clause with JOIN
-- ==========================================

-- 9. List the number of Employees Working on Each Project
SELECT p.Pname, COUNT(w.Essn) AS Total_Employees 
FROM PROJECT p 
JOIN WORKS_ON w ON p.Pnumber = w.Pno 
GROUP BY p.Pname;

-- 10. Departments Having More Than 3 Employees (Using JOIN for Dept Name)
SELECT d.Dname, COUNT(e.Ssn) AS Total_Employees 
FROM DEPARTMENT d 
JOIN EMPLOYEE e ON d.Dnumber = e.Dno 
GROUP BY d.Dname 
HAVING COUNT(e.Ssn) > 3;