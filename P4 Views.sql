-- View 1 : Fetch Date&Time of the most recent booking made by a passenger

CREATE VIEW Passenger_Recent_Booking AS
SELECT 
    P.passenger_id, 
    P.passenger_name, 
    P.passenger_phone, 
    P.passenger_email,
    MAX(B.booking_date) AS RecentBookingDate
FROM Passenger P JOIN Ticket T ON P.passenger_id = T.passenger_id
			     JOIN Booking_Detail B ON T.ticket_id = B.ticket_id
GROUP BY P.passenger_id, 
		 P.passenger_name, 
		 P.passenger_phone, 
		 P.passenger_email;

SELECT * FROM Passenger_Recent_Booking; -- Testing View 1
---
-- View 2 : Trams Running Above Average Speed

CREATE VIEW TramsAboveAverageSpeed AS
SELECT 
    tram_id, 
    manufacturer, 
    energy_efficiency, 
    seating_capacity, 
    maximum_speed
FROM 
    Tram
WHERE 
    maximum_speed > (SELECT AVG(maximum_speed) FROM Tram);

SELECT * FROM TramsAboveAverageSpeed; -- Testing View 2
---
-- View 3 : Mapping Stops, their Route inclusions and the Trams that pass through them

CREATE VIEW Stop_Route_Tram_Mapping AS
SELECT 
    SCH.tram_id, 
	ST.stop_name, 
	R.route_id, 
	T.manufacturer, 
	T.seating_capacity 
FROM Route R JOIN Stop ST ON R.route_id = ST.route_id
			 JOIN Schedule SCH ON R.route_id = SCH.route_id
			 JOIN Tram T ON SCH.tram_id = T.tram_id
GROUP BY SCH.tram_id, ST.stop_name, R.route_id, T.manufacturer, T.seating_capacity

SELECT * FROM Stop_Route_Tram_Mapping; -- Testing View 3
---
-- View 4 : Tram Maintenance History

CREATE VIEW Tram_Maintenance_History AS  
SELECT T.manufacturer, 
		 M.remarks,
		 M.maintenance_date, 
		 T.Seating_capacity
FROM TRAM T INNER JOIN Maintenance M ON T.tram_id = M.tram_id 
GROUP BY T.manufacturer, 
		 M.remarks,
		 M.maintenance_date, 
		 T.Seating_capacity
	   
SELECT * FROM Tram_Maintenance_History; -- Testing View 4
---
--View 5 : Tram Accident Details

CREATE VIEW Tram_Accident_Details AS  
SELECT A.accident_type,
	   T.tram_id,
	   T.manufacturer, 
	   A.accident_date_time, 
	   A.accident_location 
FROM Tram T LEFT JOIN Accident A ON T.tram_id = A.tram_id
GROUP BY A.accident_type,
		 T.tram_id,
		 T.manufacturer, 
		 A.accident_date_time, 
		 A.accident_location
		 
SELECT * FROM Tram_Accident_Details;-- Testing View 5
---
