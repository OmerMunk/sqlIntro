-- Easy Exercises

-- Exercise 1: Create a database named 'CarRentalDB'.
CREATE DATABASE CarRentalDB;

-- Exercise 2: Switch to the 'CarRentalDB' database.
\c CarRentalDB;

-- Exercise 3: Create a 'Clients' table with appropriate columns and constraints.
CREATE TABLE Clients (
    CId VARCHAR(9) PRIMARY KEY,
    CName VARCHAR(20),
    Address VARCHAR(50),
    PhoneNum VARCHAR(10),
    BirthDate DATE
);

-- Exercise 4: Create a 'Cars' table with appropriate columns and constraints.
CREATE TABLE Cars (
    CarID VARCHAR(7) PRIMARY KEY,
    CarType VARCHAR(20),
    DayRate NUMERIC(6,2),
    MYear DATE
);

-- Exercise 5: Insert 3 records into the 'Clients' table.
INSERT INTO Clients (CId, CName, Address, PhoneNum, BirthDate)
VALUES ('111222333', 'John Doe', '123 Main St', '0501234567', '1990-05-10'),
       ('222333444', 'Jane Smith', '456 Elm St', '0511234567', '1985-07-15'),
       ('333444555', 'Mike Johnson', '789 Oak St', '0521234567', '1992-10-20');

-- Exercise 6: Insert 3 records into the 'Cars' table.
INSERT INTO Cars (CarID, CarType, DayRate, MYear)
VALUES ('CAR001', 'Toyota Corolla', 150, '2020-01-01'),
       ('CAR002', 'Honda Civic', 180, '2019-01-01'),
       ('CAR003', 'Ford Focus', 170, '2018-01-01');

-- Exercise 7: Select all records from the 'Clients' table.
SELECT * FROM Clients;

-- Exercise 8: Select distinct car types from the 'Cars' table.
SELECT DISTINCT CarType FROM Cars;

-- Exercise 9: Select the client names and phone numbers from the 'Clients' table.
SELECT CName, PhoneNum FROM Clients;

-- Exercise 10: Select all cars where the day rate is greater than 160.
SELECT * FROM Cars WHERE DayRate > 160;

-- Medium Exercises

-- Exercise 11: Create a 'CarRent' table with foreign keys.
CREATE TABLE CarRent (
    CarID VARCHAR(7),
    CId VARCHAR(9),
    RDate DATE,
    RPeriod INTEGER,
    PRIMARY KEY (CarID, CId, RDate),
    FOREIGN KEY (CarID) REFERENCES Cars(CarID),
    FOREIGN KEY (CId) REFERENCES Clients(CId)
);

-- Exercise 12: Insert 2 rental records into the 'CarRent' table.
INSERT INTO CarRent (CarID, CId, RDate, RPeriod)
VALUES ('CAR001', '111222333', '2024-09-22', 5),
       ('CAR002', '222333444', '2024-09-23', 3);

-- Exercise 13: Select the maximum day rate from the 'Cars' table.
SELECT MAX(DayRate) FROM Cars;

-- Exercise 14: Select all clients born between 1980 and 1995.
SELECT * FROM Clients WHERE BirthDate BETWEEN '1980-01-01' AND '1995-12-31';

-- Exercise 15: Find all rentals that happened on or after '2024-09-22'.
SELECT * FROM CarRent WHERE RDate >= '2024-09-22';

-- Exercise 16: Use a subquery to select the clients who have rented 'Toyota Corolla'.
SELECT CName FROM Clients
WHERE CId IN (SELECT CId FROM CarRent WHERE CarID = 'CAR001');

-- Exercise 17: Select the total rental period of all cars from 'CarRent'.
SELECT SUM(RPeriod) FROM CarRent;

-- Exercise 18: Find the number of cars that have a day rate of exactly 170.
SELECT COUNT(*) FROM Cars WHERE DayRate = 170;

-- Exercise 19: Select clients whose phone number ends with '4567'.
SELECT * FROM Clients WHERE PhoneNum LIKE '%4567';

-- Exercise 20: Alter the 'Cars' table to add a new column for 'FuelType'.
ALTER TABLE Cars ADD COLUMN FuelType VARCHAR(20);

-- Hard Exercises

-- Exercise 21: Create a 'Bills' table with a primary key.
CREATE TABLE Bills (
    OrderId VARCHAR(5) PRIMARY KEY,
    BillDate DATE,
    TotalPayment NUMERIC(8,2)
);

-- Exercise 22: Create a 'ClientBill' table with foreign keys and constraints.
CREATE TABLE ClientBill (
    OrderId VARCHAR(5),
    CId VARCHAR(9),
    Status VARCHAR(10),
    PRIMARY KEY (OrderId, CId),
    FOREIGN KEY (OrderId) REFERENCES Bills(OrderId),
    FOREIGN KEY (CId) REFERENCES Clients(CId)
);

-- Exercise 23: Insert 2 bill records into the 'Bills' table.
INSERT INTO Bills (OrderId, BillDate, TotalPayment)
VALUES ('B001', '2024-09-25', 1500),
       ('B002', '2024-09-26', 1800);

-- Exercise 24: Insert 2 client-bill records into the 'ClientBill' table.
INSERT INTO ClientBill (OrderId, CId, Status)
VALUES ('B001', '111222333', 'Open'),
       ('B002', '222333444', 'Closed');

-- Exercise 25: Select the total payment and the average payment from the 'Bills' table.
SELECT SUM(TotalPayment), AVG(TotalPayment) FROM Bills;

-- Exercise 26: Find all clients who have an open bill and rented a car on '2024-09-22'.
SELECT CName FROM Clients
JOIN ClientBill ON Clients.CId = ClientBill.CId
JOIN CarRent ON Clients.CId = CarRent.CId
WHERE ClientBill.Status = 'Open' AND CarRent.RDate = '2024-09-22';

-- Exercise 27: Find all cars that have been rented more than once.
SELECT CarID, COUNT(*) AS RentCount
FROM CarRent
GROUP BY CarID
HAVING COUNT(*) > 1;

-- Exercise 28: Use a full outer join to find all cars and their rentals, even if they haven't been rented.
SELECT Cars.CarID, CarRent.RDate
FROM Cars
FULL OUTER JOIN CarRent ON Cars.CarID = CarRent.CarID;

-- Exercise 29: Drop the 'ClientBill' table if it exists, cascading to dependent objects.
DROP TABLE IF EXISTS ClientBill CASCADE;

-- Exercise 30: Select all clients and order them by their birthdate in descending order.
SELECT * FROM Clients ORDER BY BirthDate DESC;
