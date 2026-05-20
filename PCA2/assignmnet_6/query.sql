USE Assignment6DB;

-- =====================================================
-- 1. BEFORE INSERT Trigger on EMPLOYEE
-- =====================================================

DELIMITER //

CREATE TRIGGER trg_salary_check
BEFORE INSERT ON EMPLOYEE
FOR EACH ROW
BEGIN

    IF NEW.SALARY < 5000 THEN
        SET NEW.SALARY = 5000;
    END IF;

END //

DELIMITER ;

INSERT INTO EMPLOYEE VALUES (4, 'Riya', 3000);

SELECT * FROM EMPLOYEE;


-- =====================================================
-- 2. AFTER INSERT Trigger for AUDIT_EMPLOYEE
-- =====================================================

DELIMITER //

CREATE TRIGGER trg_employee_audit
AFTER INSERT ON EMPLOYEE
FOR EACH ROW
BEGIN

    INSERT INTO AUDIT_EMPLOYEE
    VALUES (
        NEW.EMP_ID,
        NEW.EMP_NAME,
        CURDATE()
    );

END //

DELIMITER ;

INSERT INTO EMPLOYEE VALUES (5, 'Amit', 10000);

SELECT * FROM AUDIT_EMPLOYEE;


-- =====================================================
-- 3. BEFORE DELETE Trigger on STUDENT
-- =====================================================

DELIMITER //

CREATE TRIGGER trg_prevent_delete
BEFORE DELETE ON STUDENT
FOR EACH ROW
BEGIN

    IF OLD.MARKS > 80 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete student with marks greater than 80';
    END IF;

END //

DELIMITER ;

-- Test
DELETE FROM STUDENT WHERE STUD_ID = 1;


-- =====================================================
-- 4. AFTER UPDATE Trigger for SALARY_LOG
-- =====================================================

DELIMITER //

CREATE TRIGGER trg_salary_update
AFTER UPDATE ON EMPLOYEE
FOR EACH ROW
BEGIN

    INSERT INTO SALARY_LOG
    VALUES (
        OLD.EMP_ID,
        OLD.SALARY,
        NEW.SALARY,
        CURDATE()
    );

END //

DELIMITER ;

UPDATE EMPLOYEE
SET SALARY = 40000
WHERE EMP_ID = 1;

SELECT * FROM SALARY_LOG;


-- =====================================================
-- 5. BEFORE UPDATE Trigger for Salary Increase Limit
-- =====================================================

DELIMITER //

CREATE TRIGGER trg_salary_limit
BEFORE UPDATE ON EMPLOYEE
FOR EACH ROW
BEGIN

    IF NEW.SALARY > OLD.SALARY * 1.25 THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary increase cannot exceed 25%';

    END IF;

END //

DELIMITER ;

-- Test
UPDATE EMPLOYEE
SET SALARY = 100000
WHERE EMP_ID = 2;


-- =====================================================
-- 6. AFTER DELETE Trigger on CUSTOMER
-- =====================================================

DELIMITER //

CREATE TRIGGER trg_customer_backup
AFTER DELETE ON CUSTOMER
FOR EACH ROW
BEGIN

    INSERT INTO CUSTOMER_BACKUP
    VALUES (
        OLD.CUST_ID,
        OLD.CUST_NAME,
        OLD.CITY
    );

END //

DELIMITER ;

DELETE FROM CUSTOMER
WHERE CUST_ID = 1;

SELECT * FROM CUSTOMER_BACKUP;


-- =====================================================
-- 7. BEFORE INSERT Trigger on ATTENDANCE
-- =====================================================

DELIMITER //

CREATE TRIGGER trg_attendance_status
BEFORE INSERT ON ATTENDANCE
FOR EACH ROW
BEGIN

    IF NEW.STATUS IS NULL THEN
        SET NEW.STATUS = 'Absent';
    END IF;

END //

DELIMITER ;

INSERT INTO ATTENDANCE
VALUES (1, 101, CURDATE(), NULL);

SELECT * FROM ATTENDANCE;


-- =====================================================
-- 8. AFTER INSERT Trigger on STUDENT
-- =====================================================

DELIMITER //

CREATE TRIGGER trg_student_count
AFTER INSERT ON STUDENT
FOR EACH ROW
BEGIN

    UPDATE DEPARTMENT
    SET STUDENT_COUNT = STUDENT_COUNT + 1
    WHERE DEPT_ID = NEW.DEPT_ID;

END //

DELIMITER ;

INSERT INTO STUDENT
VALUES (10, 'Priya', 80, 20, 101);

SELECT * FROM DEPARTMENT;


-- =====================================================
-- 9. BEFORE INSERT Trigger for Age Validation
-- =====================================================

DELIMITER //

CREATE TRIGGER trg_age_validation
BEFORE INSERT ON STUDENT
FOR EACH ROW
BEGIN

    IF NEW.AGE < 17 THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Age must be at least 17';

    END IF;

END //

DELIMITER ;

-- Test
INSERT INTO STUDENT
VALUES (11, 'Rohit', 70, 15, 102);


-- =====================================================
-- 10. AFTER UPDATE Trigger on DEPARTMENT
-- =====================================================

DELIMITER //

CREATE TRIGGER trg_department_log
AFTER UPDATE ON DEPARTMENT
FOR EACH ROW
BEGIN

    INSERT INTO DEPARTMENT_LOG
    VALUES (
        OLD.DEPT_NAME,
        NEW.DEPT_NAME,
        CURDATE()
    );

END //

DELIMITER ;

UPDATE DEPARTMENT
SET DEPT_NAME = 'Computer Science'
WHERE DEPT_ID = 101;

SELECT * FROM DEPARTMENT_LOG;