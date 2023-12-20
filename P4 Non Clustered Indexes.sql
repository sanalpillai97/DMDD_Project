CREATE NONCLUSTERED INDEX NCI_PassengerName ON Passenger(passenger_name);
CREATE NONCLUSTERED INDEX NCI_DriverName ON Driver(driver_name);
CREATE NONCLUSTERED INDEX NCI_Ticket_id ON Ticket(ticket_id);

--Verify Index Creation
SELECT 
  I.name AS IndexName,
  OBJECT_NAME(I.object_id) AS TableName,
  COL_NAME(IC.object_id,IC.column_id) AS ColumnName
FROM 
  sys.indexes AS I INNER JOIN sys.index_columns AS IC ON I.object_id = IC.object_id AND I.index_id = IC.index_id
WHERE 
  I.object_id = OBJECT_ID('Passenger') OR 
  I.object_id = OBJECT_ID('Driver') OR 
  I.object_id = OBJECT_ID('Ticket');


--Testing Nonclustered Indexes
SELECT * FROM Passenger WHERE passenger_name LIKE 'Henry%';

SELECT * FROM Driver WHERE driver_name LIKE '%Jill%';

SELECT * FROM Ticket WHERE ticket_id > 8;
