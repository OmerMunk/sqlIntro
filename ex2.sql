-- Easy Exercises

-- Exercise 1: Use an INNER JOIN to select the client names and car types for all rentals.
SELECT Clients.CName, Cars.CarType
FROM Clients
INNER JOIN CarRent ON Clients.CId = CarRent.CId
INNER JOIN Cars ON CarRent.CarID = Cars.CarID;

-- Exercise 2: Use a LEFT JOIN to find all clients and their rental details, even if they haven't rented a car.
SELECT Clients.CName, CarRent.RDate
FROM Clients
LEFT JOIN CarRent ON Clients.CId = CarRent.CId;

-- Exercise 3: Use a RIGHT JOIN to find all rentals and the client names, even if no client is found.
SELECT Clients.CName, CarRent.RDate
FROM Clients
RIGHT JOIN CarRent ON Clients.CId = CarRent.CId;

-- Exercise 4: Use a FULL JOIN to find all cars and their rental details, including cars that haven’t been rented.
SELECT Cars.CarType, CarRent.RDate
FROM Cars
FULL JOIN CarRent ON Cars.CarID = CarRent.CarID;

-- Exercise 5: Select the number of rentals for each car using GROUP BY.
SELECT CarID, COUNT(*) AS RentCount
FROM CarRent
GROUP BY CarID;

-- Medium Exercises

-- Exercise 6: Find the total payment for each client using GROUP BY and INNER JOIN on Bills and ClientBill.
SELECT Clients.CName, SUM(Bills.TotalPayment) AS TotalPayment
FROM Clients
INNER JOIN ClientBill ON Clients.CId = ClientBill.CId
INNER JOIN Bills ON ClientBill.OrderId = Bills.OrderId
GROUP BY Clients.CName;

-- Exercise 7: Use a LEFT JOIN and GROUP BY to find the total number of rentals for each client, even if they haven’t rented a car.
SELECT Clients.CName, COUNT(CarRent.CarID) AS TotalRentals
FROM Clients
LEFT JOIN CarRent ON Clients.CId = CarRent.CId
GROUP BY Clients.CName;

-- Exercise 8: Find the average day rate for cars that have been rented more than once, using GROUP BY and HAVING.
SELECT Cars.CarType, AVG(Cars.DayRate) AS AvgDayRate
FROM Cars
INNER JOIN CarRent ON Cars.CarID = CarRent.CarID
GROUP BY Cars.CarType
HAVING COUNT(CarRent.CarID) > 1;

-- Exercise 9: Use an INNER JOIN and WHERE clause to find all rentals made after '2024-09-22' and the client names.
SELECT Clients.CName, CarRent.RDate
FROM Clients
INNER JOIN CarRent ON Clients.CId = CarRent.CId
WHERE CarRent.RDate > '2024-09-22';

-- Exercise 10: Use a FULL JOIN to list all clients and the cars they rented, sorted by client name in ascending order.
SELECT Clients.CName, Cars.CarType
FROM Clients
FULL JOIN CarRent ON Clients.CId = CarRent.CId
FULL JOIN Cars ON CarRent.CarID = Cars.CarID
ORDER BY Clients.CName ASC;

-- Hard Exercises

-- Exercise 11: Find the total payment made by clients who rented a car after '2024-09-22', using JOINs, GROUP BY, and HAVING.
SELECT Clients.CName, SUM(Bills.TotalPayment) AS TotalPayment
FROM Clients
INNER JOIN ClientBill ON Clients.CId = ClientBill.CId
INNER JOIN Bills ON ClientBill.OrderId = Bills.OrderId
INNER JOIN CarRent ON Clients.CId = CarRent.CId
WHERE CarRent.RDate > '2024-09-22'
GROUP BY Clients.CName
HAVING SUM(Bills.TotalPayment) > 0;

-- Exercise 12: Find all clients who have rented cars more than once and list the number of times they rented, using GROUP BY and HAVING.
SELECT Clients.CName, COUNT(CarRent.CarID) AS RentCount
FROM Clients
INNER JOIN CarRent ON Clients.CId = CarRent.CId
GROUP BY Clients.CName
HAVING COUNT(CarRent.CarID) > 1;

-- Exercise 13: Use an INNER JOIN and GROUP BY to find the total number of rentals for each car type, and list only those with more than 2 rentals.
SELECT Cars.CarType, COUNT(CarRent.CarID) AS RentCount
FROM Cars
INNER JOIN CarRent ON Cars.CarID = CarRent.CarID
GROUP BY Cars.CarType
HAVING COUNT(CarRent.CarID) > 2;

-- Exercise 14: Find the total payments for each client, and show only clients who have made payments greater than 1000, using JOINs, GROUP BY, and HAVING.
SELECT Clients.CName, SUM(Bills.TotalPayment) AS TotalPayment
FROM Clients
INNER JOIN ClientBill ON Clients.CId = ClientBill.CId
INNER JOIN Bills ON ClientBill.OrderId = Bills.OrderId
GROUP BY Clients.CName
HAVING SUM(Bills.TotalPayment) > 1000;

-- Exercise 15: Use a combination of GROUP BY, JOINs, and ORDER BY to list all cars and their total rental period, sorted by the longest rental period first.
SELECT Cars.CarType, SUM(CarRent.RPeriod) AS TotalRentalPeriod
FROM Cars
INNER JOIN CarRent ON Cars.CarID = CarRent.CarID
GROUP BY Cars.CarType
ORDER BY TotalRentalPeriod DESC;
