USE CityTramConveyanceManagementSystem;

INSERT INTO Tram VALUES
(1, 'TramCo', 'A', 30, 60),
(2, 'SpeedyTram', 'B', 40, 70),
(3, 'EcoTram', 'A+', 25, 50),
(4, 'TramTech', 'B+', 35, 65),
(5, 'MetroTram', 'A-', 32, 55),
(6, 'UrbanTram', 'A', 28, 60),
(7, 'TramWay', 'B', 42, 75),
(8, 'CityTram', 'A+', 26, 50),
(9, 'ExpressTram', 'B+', 38, 68),
(10, 'ComfortTram', 'A-', 30, 60);


INSERT INTO Accident VALUES
(1, 1, 'Main St', '2023-03-01 10:00:00', 'Minor Collision'),
(2, 2, 'Grand Ave', '2023-03-02 11:00:00', 'Derailment'),
(3, 3, 'Oak St', '2023-03-03 12:00:00', 'Signal Issue'),
(4, 4, 'Pine St', '2023-03-04 10:00:00', 'Obstruction'),
(5, 5, 'Central Station', '2023-03-05 11:00:00', 'Technical Fault'),
(6, 6, 'Maple St', '2023-03-06 12:00:00', 'Minor Collision'),
(7, 7, 'Cedar St', '2023-03-07 10:00:00', 'Derailment'),
(8, 8, 'Elm St', '2023-03-08 11:00:00', 'Signal Issue'),
(9, 9, 'Birch St', '2023-03-09 12:00:00', 'Obstruction'),
(10, 10, 'Walnut St', '2023-03-10 10:00:00', 'Technical Fault'),
(11, 10, 'Main St', '2023-03-01 10:00:00', 'Minor Collision'),
(12, 9, 'Grand Ave', '2023-03-02 11:00:00', 'Derailment'),
(13, 8, 'Oak St', '2023-03-03 12:00:00', 'Signal Issue'),
(14, 7, 'Pine St', '2023-03-04 10:00:00', 'Obstruction'),
(15, 6, 'Central Station', '2023-03-05 11:00:00', 'Technical Fault'),
(16, 5, 'Maple St', '2023-03-06 12:00:00', 'Minor Collision'),
(17, 4, 'Cedar St', '2023-03-07 10:00:00', 'Derailment'),
(18, 3, 'Elm St', '2023-03-08 11:00:00', 'Signal Issue'),
(19, 2, 'Birch St', '2023-03-09 12:00:00', 'Obstruction'),
(20, 1, 'Walnut St', '2023-03-10 10:00:00', 'Technical Fault');

INSERT INTO Maintenance VALUES
(1, 1, '2023-01-10 10:00:00', 'Routine check-up'),
(2, 2, '2023-01-15 10:00:00', 'Oil change'),
(3, 3, '2023-01-20 10:00:00', 'Tire replacement'),
(4, 1, '2023-01-25 10:00:00', 'Brake inspection'),
(5, 2, '2023-02-01 10:00:00', 'Engine tuning'),
(6, 3, '2023-02-05 10:00:00', 'General maintenance'),
(7, 1, '2023-02-10 10:00:00', 'Air conditioning repair'),
(8, 2, '2023-02-15 10:00:00', 'Suspension adjustment'),
(9, 3, '2023-02-20 10:00:00', 'Paint job'),
(10, 1, '2023-02-25 10:00:00', 'Battery check'),
(11, 4, '2023-01-10 10:00:00', 'Routine check-up'),
(12, 5, '2023-01-15 10:00:00', 'Oil change'),
(13, 4, '2023-01-20 10:00:00', 'Tire replacement'),
(14, 5, '2023-01-25 10:00:00', 'Brake inspection'),
(15, 6, '2023-02-01 10:00:00', 'Engine tuning'),
(16, 7, '2023-02-05 10:00:00', 'General maintenance'),
(17, 6, '2023-02-10 10:00:00', 'Air conditioning repair'),
(18, 7, '2023-02-15 10:00:00', 'Suspension adjustment'),
(19, 8, '2023-02-20 10:00:00', 'Paint job'),
(20, 9, '2023-02-25 10:00:00', 'Battery check');

INSERT INTO Driver VALUES
(1, 1, 'John Doe', '123 Elm St', 666789, 1001),
(2, 2, 'Jane Smith', '456 Oak St', 777867, 1002),
(3, 3, 'Jim Brown', '789 Pine St', 243567, 1003),
(4, 1, 'Jill Taylor', '321 Maple St', 989887, 1004),
(5, 2, 'Jake Wilson', '654 Cedar St', 666777, 1005),
(6, 3, 'Jessica Jones', '987 Birch St', 435678, 1006),
(7, 1, 'Jeremy Black', '159 Walnut St', 378787, 1007),
(8, 2, 'Julia Green', '753 Ash St', 555666, 1008),
(9, 3, 'James White', '357 Chestnut St', 888777, 1009),
(10, 1, 'Janet King', '951 Alder St', 354676, 1010);

INSERT INTO Route VALUES
(1, 10, 1),
(2, 15, 2),
(3, 20, 1),
(4, 25, 2),
(5, 30, 3),
(6, 35, 1),
(7, 40, 2),
(8, 45, 3),
(9, 50, 1),
(10, 55, 2);

INSERT INTO Locality VALUES
(1, 'Springfield', 12345),
(2, 'Shelbyville', 23456),
(3, 'Ogdenville', 34567),
(4, 'North Haverbrook', 45678),
(5, 'Capital City', 56789),
(6, 'Cypress Creek', 67890),
(7, 'West Springfield', 78901),
(8, 'East Springfield', 89012),
(9, 'New Springfield', 90123),
(10, 'South Springfield', 10123);

INSERT INTO Stop VALUES
(1, 1, 1, 'Main St'),
(2, 1, 2, 'Grand Ave'),
(3, 2, 3, 'Oak St'),
(4, 3, 1, 'Pine St'),
(5, 4, 2, 'Central Station'),
(6, 5, 3, 'Maple St'),
(7, 6, 1, 'Cedar St'),
(8, 7, 2, 'Elm St'),
(9, 8, 3, 'Birch St'),
(10, 9, 1, 'Walnut St'),
(11, 10, 4, 'Main St'),
(12, 9, 5, 'Grand Ave'),
(13, 8, 4, 'Oak St'),
(14, 7, 5, 'Pine St'),
(15, 6, 6, 'Central Station'),
(16, 5, 7, 'Maple St'),
(17, 4, 8, 'Cedar St'),
(18, 3, 7, 'Elm St'),
(19, 2, 8, 'Birch St'),
(20, 1, 9, 'Walnut St');


INSERT INTO Tracking VALUES
(1, 10, 1, 34.052235, -118.243683, '2023-03-01 08:00:00'),
(2, 9, 2, 34.052235, -118.243683, '2023-03-01 09:00:00'),
(3, 8, 3, 34.052235, -118.243683, '2023-03-01 10:00:00'),
(4, 7, 4, 34.052235, -118.243683, '2023-03-01 11:00:00'),
(5, 6, 5, 34.052235, -118.243683, '2023-03-01 12:00:00'),
(6, 5, 6, 34.052235, -118.243683, '2023-03-01 13:00:00'),
(7, 4, 7, 34.052235, -118.243683, '2023-03-01 14:00:00'),
(8, 3, 8, 34.052235, -118.243683, '2023-03-01 15:00:00'),
(9, 2, 9, 34.052235, -118.243683, '2023-03-01 16:00:00'),
(10, 1, 10, 34.052235, -118.243683, '2023-03-01 17:00:00');

INSERT INTO Schedule VALUES
(1, 1, 1, '2023-03-01 07:00:00', '2023-03-01 08:00:00', 'On Time'),
(2, 2, 2, '2023-03-01 08:30:00', '2023-03-01 09:30:00', 'On Time'),
(3, 3, 3, '2023-03-01 09:00:00', '2023-03-01 10:00:00', 'On Time'),
(4, 1, 4, '2023-03-01 10:30:00', '2023-03-01 11:30:00', 'Delayed'),
(5, 2, 5, '2023-03-01 11:00:00', '2023-03-01 12:00:00', 'On Time'),
(6, 3, 6, '2023-03-01 12:30:00', '2023-03-01 13:30:00', 'Cancelled'),
(7, 1, 7, '2023-03-01 13:00:00', '2023-03-01 14:00:00', 'On Time'),
(8, 2, 8, '2023-03-01 14:30:00', '2023-03-01 15:30:00', 'On Time'),
(9, 3, 9, '2023-03-01 15:00:00', '2023-03-01 16:00:00', 'On Time'),
(10, 1, 10, '2023-03-01 16:30:00', '2023-03-01 17:30:00', 'Delayed'),
(11, 4, 9, '2023-03-01 07:00:00', '2023-03-01 08:00:00', 'On Time'),
(12, 5, 8, '2023-03-01 08:30:00', '2023-03-01 09:30:00', 'On Time'),
(13, 4, 7, '2023-03-01 09:00:00', '2023-03-01 10:00:00', 'On Time'),
(14, 5, 6, '2023-03-01 10:30:00', '2023-03-01 11:30:00', 'Delayed'),
(15, 6, 5, '2023-03-01 11:00:00', '2023-03-01 12:00:00', 'On Time'),
(16, 7, 4, '2023-03-01 12:30:00', '2023-03-01 13:30:00', 'Cancelled'),
(17, 8, 3, '2023-03-01 13:00:00', '2023-03-01 14:00:00', 'On Time'),
(18, 7, 2, '2023-03-01 14:30:00', '2023-03-01 15:30:00', 'On Time'),
(19, 8, 1, '2023-03-01 15:00:00', '2023-03-01 16:00:00', 'On Time'),
(20, 9, 10, '2023-03-01 16:30:00', '2023-03-01 17:30:00', 'Delayed');


INSERT INTO Passenger VALUES
(1, 'Alice Johnson', '123 Broadway St', 5550101, 'alice.j@example.com', '1990-01-01', 'Female', 'alicej', 'alice@pass123'),
(2, 'Bob Smith', '456 Main St', 5550102, 'bob.s@example.com', '1985-02-02', 'Male', 'bobsmith', 'bob@pass123'),
(3, 'Carol White', '789 Park Ave', 5550103, 'carol.w@example.com', '1978-03-03', 'Female', 'carolwhite', 'carol@pass123'),
(4, 'David Lee', '321 Maple St', 5550104, 'david.l@example.com', '1992-04-04', 'Male', 'davidlee', 'david@pass123'),
(5, 'Eva Brown', '654 Cedar St', 5550105, 'eva.b@example.com', '1988-05-05', 'Female', 'evabrown', 'eva@pass123'),
(6, 'Frank Jones', '987 Birch St', 5550106, 'frank.j@example.com', '1975-06-06', 'Male', 'frankjones', 'frank@pass123'),
(7, 'Grace King', '159 Walnut St', 5550107, 'grace.k@example.com', '1991-07-07', 'Female', 'graceking', 'grace@pass123'),
(8, 'Henry Garcia', '753 Ash St', 5550108, 'henry.g@example.com', '1987-08-08', 'Male', 'henrygarcia', 'henry@pass123'),
(9, 'Isabel Martinez', '357 Chestnut St', 5550109, 'isabel.m@example.com', '1983-09-09', 'Female', 'isabelmartinez', 'isabel@pass123'),
(10, 'Jake Wilson', '951 Alder St', 5550110, 'jake.w@example.com', '1979-10-10', 'Male', 'jakewilson', 'jake@pass123');

INSERT INTO Ticket VALUES
(1, 1, 1, 1, 25.50, '2023-03-01', '08:00:00', 'Credit Card'),
(2, 2, 2, 2, 30.00, '2023-03-01', '09:00:00', 'Debit Card'),
(3, 3, 3, 3, 20.75, '2023-03-01', '10:00:00', 'Cash'),
(4, 4, 1, 4, 25.50, '2023-03-02', '11:00:00', 'Credit Card'),
(5, 5, 2, 5, 30.00, '2023-03-02', '12:00:00', 'Debit Card'),
(6, 6, 3, 6, 20.75, '2023-03-02', '13:00:00', 'Cash'),
(7, 7, 1, 7, 25.50, '2023-03-03', '14:00:00', 'Credit Card'),
(8, 8, 2, 8, 30.00, '2023-03-03', '15:00:00', 'Debit Card'),
(9, 9, 3, 9, 20.75, '2023-03-03', '16:00:00', 'Cash'),
(10, 10, 1, 10, 25.50, '2023-03-04', '17:00:00', 'Credit Card'),
(11, 1, 4, 5, 32.00, '2023-04-01', '17:00:00', 'Credit Card'),
(12, 2, 5, 6, 35.00, '2023-04-02', '17:00:00', 'Credit Card'),
(13, 3, 6, 6, 18.00, '2023-04-03', '17:00:00', 'Debit Card'),
(14, 4, 7, 6, 15.00, '2023-04-04', '17:00:00', 'Credit Card'),
(15, 5, 8, 6, 27.00, '2023-04-05', '17:00:00', 'Debit Card'),
(16, 6, 4, 5, 32.00, '2023-04-01', '17:00:00', 'Cash'),
(17, 7, 5, 2, 35.00, '2023-04-02', '17:00:00', 'Credit Card'),
(18, 8, 8, 8, 16.00, '2023-04-03', '17:00:00', 'Debit Card'),
(19, 9, 9, 9, 29.00, '2023-04-04', '17:00:00', 'Cash'),
(20, 10, 10, 7, 22.00, '2023-04-05', '17:00:00', 'Cash');

INSERT INTO Booking_Detail VALUES
(1, 1, 'Confirmed', '2023-02-20 12:00:00'),
(2, 2, 'Pending', '2023-02-21 12:00:00'),
(3, 3, 'Cancelled', '2023-02-22 12:00:00'),
(4, 4, 'Confirmed', '2023-02-23 12:00:00'),
(5, 5, 'Pending', '2023-02-24 12:00:00'),
(6, 6, 'Cancelled', '2023-02-25 12:00:00'),
(7, 7, 'Confirmed', '2023-02-26 12:00:00'),
(8, 8, 'Pending', '2023-02-27 12:00:00'),
(9, 9, 'Cancelled', '2023-02-28 12:00:00'),
(10, 10, 'Confirmed', '2023-03-01 12:00:00'),
(11, 11, 'Confirmed', '2023-03-01 12:00:00'),
(12, 12, 'Confirmed', '2023-03-01 12:00:00'),
(13, 13, 'Cancelled', '2023-03-01 12:00:00'),
(14, 14, 'Confirmed', '2023-03-01 12:00:00'),
(15, 15, 'Pending', '2023-03-01 12:00:00'),
(16, 16, 'Confirmed', '2023-03-04 12:00:00'),
(17, 17, 'Confirmed', '2023-03-04 12:00:00'),
(18, 18, 'Confirmed', '2023-03-04 12:00:00'),
(19, 19, 'Confirmed', '2023-03-04 12:00:00'),
(20, 20, 'Confirmed', '2023-03-04 12:00:00');


INSERT INTO Feedback (reference_id, ticket_id, comment, rating) VALUES
(1, 1, 'Excellent service', 5),
(2, 2, 'Good, but delayed', 4),
(3, 3, 'Comfortable seats', 5),
(4, 4, 'Late arrival', 3),
(5, 5, 'Very clean and tidy', 5),
(6, 6, 'Inattentive staff', 2),
(7, 7, 'Smooth ride', 4),
(8, 8, 'Noisy environment', 3),
(9, 9, 'Affordable price', 4),
(10, 10, 'Excellent amenities', 5);

SELECT * FROM Tram;
SELECT * FROM Accident;
SELECT * FROM Maintenance;
SELECT * FROM Driver;
SELECT * FROM Route;
SELECT * FROM Tracking;
SELECT * FROM Locality;
SELECT * FROM Stop;
SELECT * FROM Schedule;
SELECT * FROM Passenger;
SELECT * FROM Ticket;
SELECT * FROM Booking_Detail;
SELECT * FROM Feedback;