CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'DMDD@123';

CREATE CERTIFICATE PassengerEncryptCertificate WITH SUBJECT = 'Passenger Username Certificate';

-- Create the Symmetric Key using AES_256 algorithm
CREATE SYMMETRIC KEY PassengerUsernameKey WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE PassengerEncryptCertificate;

-- Add Encrypted Columns to the Passenger table for Username and Password
ALTER TABLE Passenger
ADD username_encrypted VARBINARY(MAX),
    password_encrypted VARBINARY(MAX);

-- Encrypt the Username and Password columns
OPEN SYMMETRIC KEY PassengerUsernameKey
DECRYPTION BY CERTIFICATE PassengerEncryptCertificate;

UPDATE Passenger
SET 
    username_encrypted = EncryptByKey(Key_GUID('PassengerUsernameKey'), passenger_username),
    password_encrypted = EncryptByKey(Key_GUID('PassengerUsernameKey'), passenger_password);

CLOSE SYMMETRIC KEY PassengerUsernameKey;

-- Decrypt and View the Data
OPEN SYMMETRIC KEY PassengerUsernameKey
DECRYPTION BY CERTIFICATE PassengerEncryptCertificate;

SELECT 
    passenger_id, 
    passenger_name, 
    CONVERT(VARCHAR, DecryptByKey(username_encrypted)) AS username_decrypted,
    CONVERT(VARCHAR, DecryptByKey(password_encrypted)) AS password_decrypted
FROM 
    Passenger;

CLOSE SYMMETRIC KEY PassengerUsernameKey;

SELECT * FROM Passenger;