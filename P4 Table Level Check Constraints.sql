USE CityTramConveyanceManagementSystem;
ALTER TABLE Passenger
ADD CONSTRAINT CHK_Gender CHECK (gender IN ('Female', 'Male', 'Other'));

ALTER TABLE Ticket
ADD CONSTRAINT CHK_Price CHECK (price > 0);

ALTER TABLE Feedback
ADD CONSTRAINT CHK_Rating CHECK (rating BETWEEN 1 AND 5);

ALTER TABLE locality
ADD CONSTRAINT CHK_ZipCode CHECK ((LEN(locality_zipcode) = 5));