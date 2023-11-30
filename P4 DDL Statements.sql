CREATE DATABASE CityTramConveyanceManagementSystem;
USE CityTramConveyanceManagementSystem;

CREATE TABLE Tram(
    tram_id INT NOT NULL PRIMARY KEY,
    manufacturer VARCHAR(50),
    energy_efficiency VARCHAR(50),
    seating_capacity INT,
    maximum_speed INT
);

CREATE TABLE Accident(
    accident_id INT NOT NULL PRIMARY KEY,
    tram_id INT,
    accident_location VARCHAR(50),
    accident_date_time DATETIME,
    accident_type VARCHAR(50),
    FOREIGN KEY(tram_id) REFERENCES Tram(tram_id)
);

CREATE TABLE Maintenance (
    maintenance_id INT NOT NULL PRIMARY KEY,
    tram_id INT,
    maintenance_date DATETIME,
    remarks VARCHAR(50),
    FOREIGN KEY(tram_id) REFERENCES Tram(tram_id)
);

CREATE TABLE Driver (
    driver_id INT NOT NULL PRIMARY KEY,
    tram_id INT,
    driver_name VARCHAR(50),
    driver_address VARCHAR(50),
    driver_phone INT,
    license_id INT,
    FOREIGN KEY(tram_id) REFERENCES Tram(tram_id)
);

CREATE TABLE Route(
    route_id INT NOT NULL PRIMARY KEY,
    distance INT,
    route_hours INT
);

CREATE TABLE Locality (
    locality_id INT NOT NULL PRIMARY KEY,
    locality_name VARCHAR(50),
    locality_zipcode INT
);

CREATE TABLE Stop (
    stop_id INT NOT NULL PRIMARY KEY,
    locality_id INT NOT NULL,
    route_id INT,
    stop_name VARCHAR(50),
    FOREIGN KEY(locality_id) REFERENCES Locality(locality_id),
    FOREIGN KEY(route_id) REFERENCES Route(route_id)
);

CREATE TABLE Tracking (
    tracking_id INT NOT NULL PRIMARY KEY,
    tram_id INT,
	route_id INT,
    latitude DECIMAL(9, 6),
    longitude DECIMAL(9, 6),
    date_time DATETIME,
    FOREIGN KEY(tram_id) REFERENCES Tram(tram_id),
	FOREIGN KEY(route_id) REFERENCES Route(route_id)
);

CREATE TABLE Schedule (
    schedule_id INT NOT NULL PRIMARY KEY,
    route_id INT,
    tram_id INT,
    departure_time DATETIME,
    arrival_time DATETIME,
    current_status VARCHAR(50),
    FOREIGN KEY (route_id) REFERENCES Route(route_id),
    FOREIGN KEY (tram_id) REFERENCES Tram(tram_id)
);

CREATE TABLE Passenger (
    passenger_id INT NOT NULL PRIMARY KEY,
    passenger_name VARCHAR(50),
    passenger_address VARCHAR(50),
    passenger_phone INT,
    passenger_email VARCHAR(50),
    date_of_birth DATE,
    gender VARCHAR(50),
    passenger_username VARCHAR(50),
    passenger_password VARCHAR(40)
);

CREATE TABLE Ticket (
    ticket_id INT NOT NULL PRIMARY KEY,
    passenger_id INT,
    route_id INT,
    seat_number INT,
    price DECIMAL(10, 2),
    ticket_date DATETIME,
    ticket_time_slot TIME,
    mode_of_payment VARCHAR(50),
    FOREIGN KEY(passenger_id) REFERENCES Passenger(passenger_id),
    FOREIGN KEY(route_id) REFERENCES Route(route_id)
);

CREATE TABLE Booking_Detail (
    reference_num INT NOT NULL PRIMARY KEY,
    ticket_id INT,
    payment_status VARCHAR(15),
    booking_date DATETIME,
    FOREIGN KEY(ticket_id) REFERENCES Ticket(ticket_id)
);

CREATE TABLE Feedback (
    reference_id INT NOT NULL PRIMARY KEY,
    ticket_id INT,
    comment VARCHAR(50),
    rating INT,
    FOREIGN KEY (ticket_id) REFERENCES Ticket(ticket_id)
);