-- Insert more clients
INSERT INTO Clients (CId, CName, Address, PhoneNum, BirthDate)
VALUES
('111333555', 'Eli Cohen', '10 Beach Ave', '0505555555', '1980-06-12'),
('222444666', 'Rachel Levi', '12 Mountain Rd', '0516666666', '1995-03-23'),
('333555777', 'David Green', '7 City St', '0527777777', '1975-09-18'),
('444666888', 'Sarah Blue', '99 Lake Dr', '0538888888', '2000-01-02'),
('555777999', 'Tom White', '88 River Ave', '0549999999', '1992-04-15');

-- Insert more cars
INSERT INTO Cars (CarID, CarType, DayRate, MYear)
VALUES
('CAR004', 'BMW 320i', 250, '2017-01-01'),
('CAR005', 'Mazda 3', 130, '2020-01-01'),
('CAR006', 'Audi A4', 220, '2019-01-01'),
('CAR007', 'Toyota Prius', 180, '2018-01-01'),
('CAR008', 'Hyundai Tucson', 200, '2019-01-01');

-- Insert more rentals
INSERT INTO CarRent (CarID, CId, RDate, RPeriod)
VALUES
('CAR001', '111222333', '2024-01-01', 10),
('CAR002', '222333444', '2024-01-10', 7),
('CAR003', '333444555', '2024-02-15', 12),
('CAR004', '444666888', '2024-02-25', 30),
('CAR005', '555777999', '2024-03-10', 20),
('CAR006', '111333555', '2024-03-15', 25),
('CAR007', '222444666', '2024-04-01', 15),
('CAR008', '333555777', '2024-04-15', 40);

-- Insert more bills
INSERT INTO Bills (OrderId, BillDate, PDate, TotalPayment)
VALUES
('B003', '2024-04-25', '2024-05-01', 3000),
('B004', '2024-05-10', '2024-06-01', 2500),
('B005', '2024-06-15', '2024-07-01', 1800),
('B006', '2024-07-01', '2024-07-15', 2000);

-- Insert more client-bill relations
INSERT INTO ClientBill (OrderId, CId, Status)
VALUES
('B003', '111222333', 'Paid'),
('B004', '222333444', 'Paid'),
('B005', '333444555', 'Open'),
('B006', '444666888', 'Open');

-- Insert more car-order relations
INSERT INTO OrderCarRent (OrderId, CarID)
VALUES
('B003', 'CAR004'),
('B004', 'CAR005'),
('B005', 'CAR006'),
('B006', 'CAR007');
