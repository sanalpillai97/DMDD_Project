USE CityTramConveyanceManagementSystem;

CREATE TRIGGER TicketPriceUpdates ON Ticket
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF UPDATE(price) 
    BEGIN
        DECLARE @old_price DECIMAL(10, 2);
        DECLARE @new_price DECIMAL(10, 2);
        DECLARE @route_id INT;

        SELECT @old_price = D.price, @new_price = I.price, @route_id = I.route_id
        FROM deleted D INNER JOIN inserted I ON D.ticket_id = I.ticket_id;

        IF @old_price < @new_price
        BEGIN
            PRINT 'The price for ticket on route ' + CAST(@route_id AS VARCHAR) + ' has been increased from ' + CAST(@old_price AS VARCHAR) + ' to ' + CAST(@new_price AS VARCHAR);
        END
        ELSE IF @old_price > @new_price
        BEGIN
            PRINT 'The price for ticket on route ' + CAST(@route_id AS VARCHAR) + ' has been decreased from ' + CAST(@old_price AS VARCHAR) + ' to ' + CAST(@new_price AS VARCHAR);
        END
        ELSE
        BEGIN
            PRINT 'The price for ticket on route ' + CAST(@route_id AS VARCHAR) + ' remains the same at ' + CAST(@new_price AS VARCHAR);
        END
    END
END
GO


-- Examples testing related to the above trigger
UPDATE Ticket
SET price = 27.50
WHERE ticket_id = 1;

UPDATE Ticket
SET price = 20.50
WHERE ticket_id = 2;

UPDATE Ticket
SET price = 40.50
WHERE ticket_id = 7;
