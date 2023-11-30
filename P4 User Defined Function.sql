USE CityTramConveyanceManagementSystem;

CREATE FUNCTION CalculateStudentDiscount (@price DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @price * 0.80 -- Assuming a 20% student discount
END

ALTER TABLE Ticket
ADD student_discounted_price AS dbo.CalculateStudentDiscount(price);

SELECT ticket_id, price, student_discounted_price FROM Ticket; -- Testing UDFCalculateStudentDiscount

----------

CREATE FUNCTION Calculate_Passenger_Age ( @date_of_birth datetime ) 
RETURNS INT	 
AS 
BEGIN 
    DECLARE @age INT 
    SET @age = DATEDIFF (hour,@date_of_birth,GETDATE())/8766.0
    RETURN @age
END

ALTER TABLE Passenger
ADD passenger_age AS dbo.Calculate_Passenger_Age(date_of_birth);

SELECT passenger_id, passenger_name, passenger_age FROM Passenger; -- Testing UDF Calculate_Passenger_Age

---------