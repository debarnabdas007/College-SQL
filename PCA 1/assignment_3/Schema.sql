PRAGMA foreign_keys = ON;

-- =======================================================
-- 1. Create Tables with FOREIGN KEYS
-- =======================================================
CREATE TABLE DEPARTMENT (
    Dname VARCHAR(15),
    Dnumber INT PRIMARY KEY
);

CREATE TABLE EMPLOYEE (
    Fname VARCHAR(15),
    Lname VARCHAR(15),
    Ssn CHAR(9) PRIMARY KEY,
    Salary DECIMAL(10,2),
    Address VARCHAR(30),
    Dno INT,
    FOREIGN KEY (Dno) REFERENCES DEPARTMENT(Dnumber)
);

CREATE TABLE PROJECT (
    Pname VARCHAR(15),
    Pnumber INT PRIMARY KEY,
    Dnum INT,
    FOREIGN KEY (Dnum) REFERENCES DEPARTMENT(Dnumber)
);

CREATE TABLE WORKS_ON (
    Essn CHAR(9),
    Pno INT,
    Hours DECIMAL(3,1),
    PRIMARY KEY (Essn, Pno),
    FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn),
    FOREIGN KEY (Pno) REFERENCES PROJECT(Pnumber)
);

CREATE TABLE DEPENDENT (
    Essn CHAR(9),
    Dependent_name VARCHAR(15),
    PRIMARY KEY (Essn, Dependent_name),
    FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn)
);

-- =======================================================
-- 2. Insert Custom Data (Guarantees results for Assignment 3)
-- =======================================================
INSERT INTO DEPARTMENT VALUES ('HQ', 1), ('Admin', 4), ('Research', 5);

-- Employee Data intentionally crafted to hit all LIKE and Math conditions
INSERT INTO EMPLOYEE VALUES 
('John', 'Smith', '111', 50000, '123 Houston St', 5),
('Jane', 'Doe', '222', 60000, '456 Dallas St', 5),
('Carl', 'Aaronson', '777', 55000, '999 Texas Way', 5), -- Makes Dept 5 largest
('Bob', 'Johnson', '333', 30000, '789 Austin St', 4),
('Amanda', 'Zane', '444', 40000, '101 Houston Ave', 4),
('Matthew', 'Adams', '555', 80000, 'Elm St', 1),
('Sarah', 'Connor', '666', 20000, 'Oak St', 1);

INSERT INTO PROJECT VALUES ('ProjA', 1, 5), ('ProjB', 2, 5), ('ProjC', 3, 4);

-- Works_On Data
INSERT INTO WORKS_ON VALUES 
('111', 1, 10.0), ('111', 2, 20.0), -- John works on ALL Dept 5 projects (Query 9)
('222', 1, 10.0), ('222', 2, 15.0), ('222', 3, 5.0), -- Jane works > 2 projects, has exact same (1, 10.0) tuple as John (Query 10 & 12)
('333', 3, 40.0),
('444', 3, 20.0);

-- Dependent Data
INSERT INTO DEPENDENT VALUES 
('111', 'Kid1'), ('111', 'Kid2'), -- John has >= 2 dependents (Query 11)
('222', 'Kid3');