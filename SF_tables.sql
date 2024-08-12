CREATE SCHEMA SF

CREATE TABLE SF.Client(
	
	client_id INT IDENTITY NOT NULL,
	client_name VARCHAR(30) NOT NULL,
	client_age INT NOT NULL,
	client_gender CHAR NOT NULL,
	client_height FLOAT NOT NULL,
	client_weight FLOAT NOT NULL,
	client_password VARCHAR(60) NOT NULL,

	PRIMARY KEY(client_id)

)

CREATE TABLE SF.Adm(

	adm_id INT IDENTITY NOT NULL,
	adm_user VARCHAR(30) NOT NULL,
	adm_password VARCHAR(60) NOT NULL,

	PRIMARY KEY(adm_id)


)

DBCC CHECKIDENT ('SF.Client', RESEED, 0)
DBCC CHECKIDENT ('SF.Adm', RESEED, 0)

INSERT INTO SF.Client (client_name, client_age, client_gender, client_height, client_weight, client_password)
VALUES 
('Alice Johnson', 30, 'F', 165.5, 55.0, 'password123'),
('Bob Smith', 45, 'M', 175.0, 80.0, 'securepass456'),
('Charlie Brown', 25, 'M', 180.0, 70.0, 'mysecret789'),
('Diana Prince', 35, 'F', 160.0, 60.0, 'wonderpass321'),
('Eve Davis', 40, 'F', 170.0, 65.0, 'evepassword000');

INSERT INTO SF.Adm (adm_user, adm_password)
VALUES 
('adm1', 'admpass123'),
('adm2', 'admpass456'),
('adm3', 'admpass789'),
('adm4', 'admpass321'),
('adm5', 'admpass000');

select * from sf.client
select * from sf.adm

delete sf.client
delete sf.adm

DROP TABLE SF.ADM


/* TRIGGERS */

CREATE OR ALTER TRIGGER SF.ClientAge ON SF.Client INSTEAD OF INSERT AS
BEGIN
	
	INSERT INTO SF.Client (client_name, client_age, client_gender, client_height, client_weight, client_password)
    SELECT client_name, client_age, client_gender, client_height, client_weight, client_password
    FROM inserted WHERE client_age > 12;

END


CREATE OR ALTER PROCEDURE SF.GET_Client @name varchar(30) as
BEGIN
	
	SELECT client_id, client_name, client_age, client_gender, client_height, client_weight, client_password
    FROM SF.Client WHERE client_name = @name;

END