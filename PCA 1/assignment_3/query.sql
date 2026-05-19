-- View the initial data --
SELECT * FROM DEPARTMENT;
SELECT * FROM EMPLOYEE;
SELECT * FROM PROJECT;
SELECT * FROM WORKS_ON;
SELECT * FROM DEPENDENT;


-- =======================================================
-- Simple Nested Query using IN
-- =======================================================
-- 1. Employees on projects controlled by Dept 5
SELECT Fname, Lname FROM EMPLOYEE 
WHERE Ssn IN (SELECT Essn FROM WORKS_ON WHERE Pno IN (SELECT Pnumber FROM PROJECT WHERE Dnum = 5)); 

-- 2. Project names where 'Smith' works
SELECT Pname FROM PROJECT 
WHERE Pnumber IN (
    SELECT Pno FROM WORKS_ON 
    WHERE Essn IN (SELECT Ssn FROM EMPLOYEE WHERE Lname = 'Smith')
);



-- =======================================================
-- Scalar (Single-Value using >/<) Nested Query
-- =======================================================
-- 3. (Given) Salary > average company salary
SELECT Fname, Lname FROM EMPLOYEE 
WHERE Salary > (SELECT AVG(Salary) FROM EMPLOYEE);

-- 4. Earning less than the average salary of Dept 5
SELECT Fname, Lname FROM EMPLOYEE 
WHERE Salary < (SELECT AVG(Salary) FROM EMPLOYEE WHERE Dno = 5);



-- =======================================================
-- Nested Query with ANY and ALL
-- (Note for Teacher: SQLite doesn't natively support > ALL or > ANY keywords, 
--  so industry standard translates ALL to MAX() and ANY to MIN()).
-- =======================================================
-- 5. Earning more than ALL employees in Dept 4 (Meaning > MAX of Dept 4)
SELECT Fname, Lname FROM EMPLOYEE 
WHERE Salary > (SELECT MAX(Salary) FROM EMPLOYEE WHERE Dno = 4);

-- 6. Earning more than ANY employee in Dept 4 (Meaning > MIN of Dept 4)
SELECT Fname, Lname FROM EMPLOYEE 
WHERE Salary > (SELECT MIN(Salary) FROM EMPLOYEE WHERE Dno = 4);




-- =======================================================
-- Correlated Nested Query
-- =======================================================
-- 7. (Given) Have at least one dependent
SELECT Fname, Lname FROM EMPLOYEE E 
WHERE EXISTS (SELECT * FROM DEPENDENT D WHERE D.Essn = E.Ssn);

-- 8. Do NOT have dependents
SELECT Fname, Lname FROM EMPLOYEE E 
WHERE NOT EXISTS (SELECT * FROM DEPENDENT D WHERE D.Essn = E.Ssn);




-- =======================================================
-- Double Nested Query (Two-Level)
-- =======================================================
-- 9. Employees who work on ALL projects controlled by Dept 5.
-- (Logic: Count of Dept 5 projects they work on == Total count of Dept 5 projects)
SELECT Fname, Lname FROM EMPLOYEE E
WHERE (
    SELECT COUNT(Pno) FROM WORKS_ON 
    WHERE Essn = E.Ssn AND Pno IN (SELECT Pnumber FROM PROJECT WHERE Dnum = 5)
) = (
    SELECT COUNT(Pnumber) FROM PROJECT WHERE Dnum = 5
);



-- =======================================================
-- Tuple Comparison Nested Query
-- (Note for Teacher: SQLite doesn't support direct tuple matching like (A,B) IN (C,D). 
--  We use an EXISTS join to achieve the exact same logic).
-- =======================================================
-- 10. Same (Project, Hours) combination as 'John Smith' (Ssn '111')
SELECT DISTINCT E.Fname, E.Lname 
FROM EMPLOYEE E 
JOIN WORKS_ON W1 ON E.Ssn = W1.Essn
WHERE E.Ssn != '111' AND EXISTS (
    SELECT 1 FROM WORKS_ON W2 
    WHERE W2.Essn = '111' AND W1.Pno = W2.Pno AND W1.Hours = W2.Hours
);




-- =======================================================
-- Nested Query with COUNT (Aggregate inside)
-- =======================================================
-- 11. (Given) Two or more dependents
SELECT Fname, Lname FROM EMPLOYEE E 
WHERE (SELECT COUNT(*) FROM DEPENDENT D WHERE D.Essn = E.Ssn) >= 2;

-- 12. Work on more than 2 projects
SELECT Fname, Lname FROM EMPLOYEE E 
WHERE (SELECT COUNT(*) FROM WORKS_ON W WHERE W.Essn = E.Ssn) > 2;

-- 13. Highest salary in their specific department
SELECT Fname, Lname, Salary, Dno FROM EMPLOYEE E 
WHERE Salary = (SELECT MAX(Salary) FROM EMPLOYEE E2 WHERE E2.Dno = E.Dno);




-- =======================================================
-- Nested Query inside HAVING
-- =======================================================
-- 14. (Given) Depts where avg salary > company avg salary
SELECT Dno FROM EMPLOYEE 
GROUP BY Dno HAVING AVG(Salary) > (SELECT AVG(Salary) FROM EMPLOYEE);

-- 15. Depts whose minimum salary is greater than company minimum salary
SELECT Dno FROM EMPLOYEE 
GROUP BY Dno HAVING MIN(Salary) > (SELECT MIN(Salary) FROM EMPLOYEE);

-- 16. Depts having more employees than average department size
SELECT Dno FROM EMPLOYEE 
GROUP BY Dno 
HAVING COUNT(*) > (
    SELECT CAST(COUNT(*) AS FLOAT) / (SELECT COUNT(*) FROM DEPARTMENT) FROM EMPLOYEE
);




-- =======================================================
-- String Matching (LIKE, LENGTH, SUBSTRING)
-- =======================================================
-- 1. (Given) First name starts with 'J'
SELECT Fname FROM EMPLOYEE WHERE Fname LIKE 'J%';

-- 2. Last name ends with 'son'
SELECT Lname FROM EMPLOYEE WHERE Lname LIKE '%son';

-- 3. Address contains 'Houston'
SELECT Fname, Address FROM EMPLOYEE WHERE Address LIKE '%Houston%';

-- 4. First name has exactly 4 letters (Using four underscores)
SELECT Fname FROM EMPLOYEE WHERE Fname LIKE '____';

-- 5. Starts with 'A' and ends with 'a'
SELECT Fname FROM EMPLOYEE WHERE Fname LIKE 'A%a';

-- 6. Last name does NOT start with 'M'
SELECT Lname FROM EMPLOYEE WHERE Lname NOT LIKE 'M%';

-- 7. (Given) Length > 6
SELECT Fname FROM EMPLOYEE WHERE LENGTH(Fname) > 6;

-- 8. Last name length < 5
SELECT Lname FROM EMPLOYEE WHERE LENGTH(Lname) < 5;

-- 9. (Given) 3rd letter is 'r' (Note: SQLite uses SUBSTR instead of SUBSTRING)
SELECT Fname FROM EMPLOYEE WHERE SUBSTR(Fname, 3, 1) = 'r';

-- 10. 2nd letter is 'a'
SELECT Fname FROM EMPLOYEE WHERE SUBSTR(Fname, 2, 1) = 'a';