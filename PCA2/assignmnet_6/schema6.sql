DROP DATABASE IF EXISTS Assignment6DB;

CREATE DATABASE IF NOT EXISTS Assignment6DB;
USE Assignment6DB;

-- =========================================
-- EMPLOYEE
-- =========================================

DROP TABLE IF EXISTS EMPLOYEE;

CREATE TABLE EMPLOYEE (
    EMP_ID INT PRIMARY KEY,
    EMP_NAME VARCHAR(50),
    SALARY INT
);

INSERT INTO EMPLOYEE VALUES
(1, 'Rahul', 20000),
(2, 'Ananya', 30000),
(3, 'Vikram', 25000);

-- =========================================
-- AUDIT_EMPLOYEE
-- =========================================

DROP TABLE IF EXISTS AUDIT_EMPLOYEE;

CREATE TABLE AUDIT_EMPLOYEE (
    EMP_ID INT,
    EMP_NAME VARCHAR(50),
    INSERT_DATE DATE
);

-- =========================================
-- SALARY_LOG
-- =========================================

DROP TABLE IF EXISTS SALARY_LOG;

CREATE TABLE SALARY_LOG (
    EMP_ID INT,
    OLD_SALARY INT,
    NEW_SALARY INT,
    UPDATE_DATE DATE
);

-- =========================================
-- STUDENT
-- =========================================

DROP TABLE IF EXISTS STUDENT;

CREATE TABLE STUDENT (
    STUD_ID INT PRIMARY KEY,
    STUD_NAME VARCHAR(50),
    MARKS INT,
    AGE INT,
    DEPT_ID INT
);

INSERT INTO STUDENT VALUES
(1, 'Aman', 85, 20, 101),
(2, 'Ananya', 75, 19, 102),
(3, 'Rahul', 90, 18, 101);

-- =========================================
-- CUSTOMER
-- =========================================

DROP TABLE IF EXISTS CUSTOMER;

CREATE TABLE CUSTOMER (
    CUST_ID INT PRIMARY KEY,
    CUST_NAME VARCHAR(50),
    CITY VARCHAR(50)
);

INSERT INTO CUSTOMER VALUES
(1, 'Raj', 'Kolkata'),
(2, 'Priya', 'Delhi');

-- =========================================
-- CUSTOMER_BACKUP
-- =========================================

DROP TABLE IF EXISTS CUSTOMER_BACKUP;

CREATE TABLE CUSTOMER_BACKUP (
    CUST_ID INT,
    CUST_NAME VARCHAR(50),
    CITY VARCHAR(50)
);

-- =========================================
-- ATTENDANCE
-- =========================================

DROP TABLE IF EXISTS ATTENDANCE;

CREATE TABLE ATTENDANCE (
    ATT_ID INT PRIMARY KEY,
    STUD_ID INT,
    ATT_DATE DATE,
    STATUS VARCHAR(20)
);

-- =========================================
-- DEPARTMENT
-- =========================================

DROP TABLE IF EXISTS DEPARTMENT;

CREATE TABLE DEPARTMENT (
    DEPT_ID INT PRIMARY KEY,
    DEPT_NAME VARCHAR(50),
    STUDENT_COUNT INT
);

INSERT INTO DEPARTMENT VALUES
(101, 'CSE', 0),
(102, 'IT', 0);

-- =========================================
-- DEPARTMENT_LOG
-- =========================================

DROP TABLE IF EXISTS DEPARTMENT_LOG;

CREATE TABLE DEPARTMENT_LOG (
    OLD_NAME VARCHAR(50),
    NEW_NAME VARCHAR(50),
    CHANGE_DATE DATE
);

SELECT * FROM EMPLOYEE ;
SELECT * FROM AUDIT_EMPLOYEE;
SELECT * FROM SALARY_LOG;
SELECT * FROM STUDENT;
SELECT * FROM CUSTOMER;
SELECT * FROM CUSTOMER_BACKUP;
SELECT * FROM ATTENDANCE;
SELECT * FROM DEPARTMENT;
SELECT * FROM DEPARTMENT_LOG;