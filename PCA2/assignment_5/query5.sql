USE Assignment5DB;

-- =====================================================
-- RESET EXTRA DATA
-- =====================================================

DELETE FROM Student
WHERE sid >= 11;

DELETE FROM Student
WHERE sid >= 100;


-- =====================================================
-- PART 1 : INDEX
-- =====================================================

-- Remove old indexes if already exist

DROP INDEX idx_dept ON Student;
DROP INDEX idx_name ON Student;


-- 3. Retrieve sid and name where dept is IT

SELECT sid, name
FROM Student
WHERE dept = 'IT';


-- 4. Create index on dept

CREATE INDEX idx_dept
ON Student(dept);


-- 5. Execute again

SELECT sid, name
FROM Student
WHERE dept = 'IT';


-- 6. Observation:
-- Without index -> Sequential Scan
-- With index -> Index Scan


-- 7 & 8. Names beginning with A

SELECT *
FROM Student
WHERE name LIKE 'A%';


-- Create index on name

CREATE INDEX idx_name
ON Student(name);


-- Execute again

SELECT *
FROM Student
WHERE name LIKE 'A%';


-- =====================================================
-- PART 2 : PROCEDURES
-- =====================================================


-- =====================================================
-- 1. Procedure to display all students
-- =====================================================

DROP PROCEDURE IF EXISTS show_students;

DELIMITER //

CREATE PROCEDURE show_students()
BEGIN

    SELECT *
    FROM Student;

END //

DELIMITER ;

CALL show_students();


-- =====================================================
-- 2. Procedure to display students by department
-- =====================================================

DROP PROCEDURE IF EXISTS get_by_dept;

DELIMITER //

CREATE PROCEDURE get_by_dept(IN p_dept VARCHAR(20))
BEGIN

    SELECT *
    FROM Student
    WHERE dept = p_dept;

END //

DELIMITER ;

CALL get_by_dept('IT');


-- =====================================================
-- 3. Procedure to count students
-- =====================================================

DROP PROCEDURE IF EXISTS count_students;

DELIMITER //

CREATE PROCEDURE count_students()
BEGIN

    SELECT COUNT(*) AS total_students
    FROM Student;

END //

DELIMITER ;

CALL count_students();


-- =====================================================
-- 4. Procedure to insert 5 students using loop
-- =====================================================

DROP PROCEDURE IF EXISTS insert_students;

DELETE FROM Student
WHERE sid BETWEEN 11 AND 15;

DELIMITER //

CREATE PROCEDURE insert_students()
BEGIN

    DECLARE i INT DEFAULT 11;

    WHILE i <= 15 DO

        INSERT INTO Student
        VALUES (
            i,
            CONCAT('S', i),
            'CSE',
            20
        );

        SET i = i + 1;

    END WHILE;

END //

DELIMITER ;

CALL insert_students();

SELECT * FROM Student;


-- =====================================================
-- 5. Procedure to check age
-- =====================================================

DROP PROCEDURE IF EXISTS check_age;

DELIMITER //

CREATE PROCEDURE check_age(IN p_age INT)
BEGIN

    IF p_age >= 18 THEN

        SELECT 'Adult' AS Result;

    ELSE

        SELECT 'Minor' AS Result;

    END IF;

END //

DELIMITER ;

CALL check_age(20);
CALL check_age(15);


-- =====================================================
-- 6. Procedure to increase age by 1 using sid
-- =====================================================

DROP PROCEDURE IF EXISTS increase_age;

DELIMITER //

CREATE PROCEDURE increase_age(IN p_sid INT)
BEGIN

    UPDATE Student
    SET age = age + 1
    WHERE sid = p_sid;

END //

DELIMITER ;

CALL increase_age(1);

SELECT * FROM Student;


-- =====================================================
-- 7. Procedure to display maximum age students
-- =====================================================

DROP PROCEDURE IF EXISTS max_age_students;

DELIMITER //

CREATE PROCEDURE max_age_students()
BEGIN

    SELECT *
    FROM Student
    WHERE age = (
        SELECT MAX(age)
        FROM Student
    );

END //

DELIMITER ;

CALL max_age_students();


-- =====================================================
-- 8. Procedure to check whether student exists
-- =====================================================

DROP PROCEDURE IF EXISTS check_student;

DELIMITER //

CREATE PROCEDURE check_student(IN p_sid INT)
BEGIN

    IF EXISTS (
        SELECT *
        FROM Student
        WHERE sid = p_sid
    ) THEN

        SELECT 'Exists' AS Result;

    ELSE

        SELECT 'Not Exists' AS Result;

    END IF;

END //

DELIMITER ;

CALL check_student(1);
CALL check_student(100);


-- =====================================================
-- 9. Procedure to insert N students
-- =====================================================

DROP PROCEDURE IF EXISTS insert_n_students;

DELETE FROM Student
WHERE sid >= 100;

DELIMITER //

CREATE PROCEDURE insert_n_students(IN n INT)
BEGIN

    DECLARE i INT DEFAULT 100;

    WHILE i < 100 + n DO

        INSERT INTO Student
        VALUES (
            i,
            CONCAT('Student', i),
            'IT',
            20
        );

        SET i = i + 1;

    END WHILE;

END //

DELIMITER ;

CALL insert_n_students(5);

SELECT * FROM Student;


-- =====================================================
-- 10. Procedure for department-wise student count
-- =====================================================

DROP PROCEDURE IF EXISTS dept_student_count;

DELIMITER //

CREATE PROCEDURE dept_student_count()
BEGIN

    SELECT dept,
           COUNT(*) AS total_students
    FROM Student
    GROUP BY dept;

END //

DELIMITER ;

CALL dept_student_count();