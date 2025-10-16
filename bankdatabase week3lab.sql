CREATE DATABASE Bank;
USE Bank;

CREATE TABLE Branch (
    branch_name VARCHAR(50) PRIMARY KEY,
    branch_city VARCHAR(50),
    assets REAL
);

CREATE TABLE BankAccount (
    accno INT PRIMARY KEY,
    branch_name VARCHAR(50),
    balance REAL,
    FOREIGN KEY (branch_name) REFERENCES Branch(branch_name)
);

CREATE TABLE BankCustomer (
    customer_name VARCHAR(50) PRIMARY KEY,
    customer_street VARCHAR(100),
    customer_city VARCHAR(50)
);

CREATE TABLE Depositer (
    customer_name VARCHAR(50),
    accno INT,
    FOREIGN KEY (customer_name) REFERENCES BankCustomer(customer_name),
    FOREIGN KEY (accno) REFERENCES BankAccount(accno)
);

CREATE TABLE Loan (
    loan_number INT PRIMARY KEY,
    branch_name VARCHAR(50),
    amount REAL,
    FOREIGN KEY (branch_name) REFERENCES Branch(branch_name)
);

INSERT INTO Branch VALUES
('SBI_chamrajpet', 'Bangalore', 50000),
('SBI_ResidencyRoad', 'Bangalore', 10000),
('SBI_Shivajiroad', 'Bombay', 20000),
('SBI_ParlimentRoad', 'Delhi', 10000),
('SBI_Jantarmantar', 'Delhi', 20000);

INSERT INTO BankAccount VALUES
(1, 'SBI_Chamrajpet', 2000),
(2, 'SBI_ResidencyRoad', 5000),
(3, 'SBI_ShivajiRoad' ,6000),
(4, 'SBI_ParlimentRoad' , 9000),
(5, 'SBI_Jantarmantar' , 8000),
(6, 'SBI_ShivajiRoad' , 4000),
(8, 'SBI_ResidencyRoad' , 4000),
(9, 'SBI_ParlimentRoad' , 3000),
(10, 'SBI_Residencyroad' , 5000),
(11, 'SBI_Jantarmantar' , 2000);

INSERT INTO BankCustomer VALUES
( 'Avinash' , 'Bull_Temple_Road ' ,'Banglore'),
( 'Dinesh' , 'Bannergatta_Road ' ,'Banglore'),
( 'Mohan' , 'NationalCollege_Road ' ,'Banglore'),
( 'Nikil' , 'Akbar_Road ' ,'Delhi'),
( 'Ravi' , 'Prithviraj_Road' ,'Delhi');

INSERT INTO Depositer VALUES
('Avinash' , 1),
('Dinesh' , 2),
('Nikil' , 4),
('Ravi' , 5),
('Avinash' , 8),
('Nikil' , 9),
('Dinesh' , 10),
('Nikil' , 11);

INSERT INTO Loan VALUES
( 1, 'SBI_Chamrajpet' , 1000),
( 2, 'SBI_ResidencyRoad' , 2000),
( 3, 'SBI_ShivajiRoad' , 3000),
( 4, 'SBI_ParlimentRoad' , 4000),
( 5, 'SBI_Jantarmantar', 5000);

-- QUERIES----------------
-- Display Branch Name and Assets (in Lakhs)

SELECT branch_name, assets / 100000 AS "assets in lakhs"
FROM Branch;

-- Find Customers Having Two or More Accounts at Same Branch

SELECT D.customer_name, COUNT(*) AS no_of_accounts
FROM Depositer D
JOIN BankAccount B ON D.accno = B.accno
GROUP BY D.customer_name
HAVING COUNT(*) >= 2;

--  Create View – Branch Wise Loan Total

CREATE VIEW BranchLoanSummary AS
SELECT branch_name, SUM(amount) AS total_loan_amount
FROM Loan
GROUP BY branch_name;
SELECT * FROM BranchLoanSummary;







