USE Assignment8DB;

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
-- 2. DELETE + COMMIT + ROLLBACK
-- =====================================================

-- -------------------------------------
-- ROLLBACK EXAMPLE
-- -------------------------------------

START TRANSACTION;

DELETE FROM Customers
WHERE ID = 3;

SELECT * FROM Customers;

ROLLBACK;

SELECT * FROM Customers;


-- -------------------------------------
-- COMMIT EXAMPLE
-- -------------------------------------

START TRANSACTION;

DELETE FROM Customers
WHERE ID = 3;

COMMIT;

SELECT * FROM Customers;


-- =====================================================
-- 3. SAVEPOINT
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