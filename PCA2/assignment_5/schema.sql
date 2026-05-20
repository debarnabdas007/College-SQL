CREATE DATABASE IF NOT EXISTS Assignment5DB;
USE Assignment5DB;

DROP TABLE IF EXISTS Student;

CREATE TABLE Student (
    sid INT PRIMARY KEY,
    name VARCHAR(50),
    dept VARCHAR(20),
    age INT
);

INSERT INTO Student VALUES
(1, 'Aman', 'CSE', 20),
(2, 'Ananya', 'IT', 21),
(3, 'Rahul', 'ECE', 19),
(4, 'Aditi', 'IT', 22),
(5, 'Vikram', 'CSE', 20),
(6, 'Aryan', 'IT', 18),
(7, 'Priya', 'ECE', 21),
(8, 'Akash', 'IT', 23),
(9, 'Sneha', 'CSE', 19),
(10, 'Arjun', 'IT', 20);

SELECT * FROM Student;