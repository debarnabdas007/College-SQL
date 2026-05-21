USE Assignment8DB;

-- =====================================================
-- RESET DATA
-- =====================================================

DELETE FROM accounts;

INSERT INTO accounts VALUES
(1, 'Rahul', 5000),
(2, 'Ananya', 7000);

DELETE FROM Customers;

INSERT INTO Customers VALUES
(1, 'Raj', 'Texas'),
(2, 'Priya', 'Florida'),
(3, 'Amit', 'Delhi');

SELECT * FROM accounts;
SELECT * FROM Customers;


-- =====================================================
-- 1. TRANSACTION WITH COMMIT
-- =====================================================

START TRANSACTION;

UPDATE accounts
SET balance = balance - 500
WHERE account_id = 1;

UPDATE accounts
SET balance = balance + 500
WHERE account_id = 2;

COMMIT;

SELECT * FROM accounts;


-- =====================================================
-- 2. DELETE + ROLLBACK
-- =====================================================

START TRANSACTION;

DELETE FROM Customers
WHERE ID = 3;

SELECT * FROM Customers;

ROLLBACK;

SELECT * FROM Customers;


-- =====================================================
-- 3. DELETE + COMMIT
-- =====================================================

START TRANSACTION;

DELETE FROM Customers
WHERE ID = 3;

COMMIT;

SELECT * FROM Customers;


-- =====================================================
-- RESET CUSTOMER DATA AGAIN
-- =====================================================

DELETE FROM Customers;

INSERT INTO Customers VALUES
(1, 'Raj', 'Texas'),
(2, 'Priya', 'Florida'),
(3, 'Amit', 'Delhi');

SELECT * FROM Customers;


-- =====================================================
-- 4. SAVEPOINT
-- =====================================================

START TRANSACTION;

-- First update
UPDATE Customers
SET State = 'California'
WHERE ID = 1;

-- Savepoint
SAVEPOINT sp_after_first_update;

-- Second update
UPDATE Customers
SET State = 'Nevada'
WHERE ID = 2;

SELECT * FROM Customers;

-- Rollback only second update
ROLLBACK TO SAVEPOINT sp_after_first_update;

SELECT * FROM Customers;

-- Permanently save first update
COMMIT;

SELECT * FROM Customers;