PRAGMA foreign_keys = ON;

CREATE TABLE DEPARTMENT (
    Dname VARCHAR(15) NOT NULL,
    Dnumber INT PRIMARY KEY
);

CREATE TABLE EMPLOYEE (
    Fname VARCHAR(15),
    Lname VARCHAR(15),
    Ssn CHAR(9) PRIMARY KEY,
    Salary DECIMAL(10,2),
    Super_ssn CHAR(9),
    Dno INT
);

CREATE TABLE PROJECT (
    Pname VARCHAR(15),
    Pnumber INT PRIMARY KEY,
    Dnum INT
);

CREATE TABLE WORKS_ON (
    Essn CHAR(9),
    Pno INT,
    Hours DECIMAL(3,1),
    PRIMARY KEY (Essn, Pno)
);

CREATE TABLE DEPENDENT (
    Essn CHAR(9),
    Dependent_name VARCHAR(15),
    PRIMARY KEY (Essn, Dependent_name)
);

-- Insert Data 
INSERT INTO DEPARTMENT VALUES ('Research', 5), ('Admin', 4), ('HQ', 1);

-- Note: 4 employees in Dept 5 so the "HAVING > 3" query works
INSERT INTO EMPLOYEE VALUES 
('James', 'Borg', '888665555', 55000, NULL, 1),
('Franklin', 'Wong', '333445555', 45000, '888665555', 5),
('John', 'Smith', '123456789', 30000, '333445555', 5),
('Ramesh', 'Narayan', '666884444', 38000, '333445555', 5),
('Joyce', 'English', '453453453', 25000, '333445555', 3),
('Ahmad', 'Jabbar', '987654321', 25000, '888665555', 4);

INSERT INTO PROJECT VALUES ('ProductX', 1, 5), ('ProductY', 2, 5), ('Computerization', 10, 4);
INSERT INTO WORKS_ON VALUES ('123456789', 1, 32.5), ('333445555', 2, 10.0), ('987654321', 10, 35.0);
INSERT INTO DEPENDENT VALUES ('333445555', 'Alice'), ('333445555', 'Theodore'), ('987654321', 'Abner');