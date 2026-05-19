-- View the initial data
SELECT * FROM DEPARTMENT;
SELECT * FROM EMPLOYEE;
SELECT * FROM PROJECT;
SELECT * FROM WORKS_ON;
SELECT * FROM DEPENDENT;


-- Altering table (Adding and dropping a column)
ALTER TABLE EMPLOYEE ADD COLUMN Phone VARCHAR(15);
-- view changes --
SELECT * FROM EMPLOYEE;

ALTER TABLE EMPLOYEE DROP COLUMN Phone;
SELECT * FROM EMPLOYEE;


-- Check Updation (Cascade)
UPDATE DEPARTMENT SET Dnumber = 99 WHERE Dnumber = 10;
SELECT * FROM DEPARTMENT;

-- Check Deletion (Set Default)
DELETE FROM DEPARTMENT WHERE Dnumber = 20;
SELECT * FROM DEPARTMENT;

-- View the final data to prove cascades worked!
SELECT * FROM EMPLOYEE;