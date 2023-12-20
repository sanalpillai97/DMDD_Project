--Stored Procedure 1: Count Number of Stops for a Given Route

CREATE PROCEDURE CountStopsByRoute @route_id INT, @stop_count INT OUTPUT
AS
BEGIN
    SELECT @stop_count = COUNT(*) FROM Stop 
	WHERE route_id = @route_id;
END

DECLARE @StopCount INT;
EXEC CountStopsByRoute @route_id = 1, @stop_count = @StopCount OUTPUT; -- Testing Procedure 1
SELECT @StopCount AS NumberOfStops;

--Stored Procedure 2: Get Average Rating for a Given Driver

CREATE PROCEDURE GetAverageRatingForDriver
    @driver_id INT,
    @average_rating DECIMAL(3,2) OUTPUT
AS
BEGIN
    SELECT @average_rating = AVG(CAST(f.rating AS DECIMAL(3,2)))
    FROM Feedback f
    INNER JOIN Ticket t ON f.ticket_id = t.ticket_id
    INNER JOIN Driver d ON t.ticket_id = d.tram_id
    WHERE d.driver_id = @driver_id;
END

DECLARE @outputAverageRating DECIMAL(3,2);
EXEC GetAverageRatingForDriver @driver_id = 3, @average_rating = @outputAverageRating OUTPUT; -- Testing Procedure 2
SELECT @outputAverageRating AS AverageRating;


--Stored Procedure 3: Latest Maintenance as per Tram

CREATE PROCEDURE LatestMaintenancePerTram @tram_id INT, @latest_maintenance_date DATE OUTPUT
AS
BEGIN 
    SELECT @latest_maintenance_date = MAX(maintenance_date) FROM Maintenance
		   WHERE tram_id = @tram_id 
END

Declare @LMT DATE;
EXEC LatestMaintenancePerTram @tram_id = 3, @latest_maintenance_date = @LMT OUTPUT; -- Testing Procedure 3
SELECT @LMT AS Latest_Maintenance_Date



