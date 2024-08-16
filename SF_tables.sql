CREATE SCHEMA SF

-- BIT => 0 = false and 1 = true

CREATE TABLE SF.Client(
	
	client_id INT IDENTITY NOT NULL,
	client_name VARCHAR(30) NOT NULL,
	client_surname VARCHAR(30) NOT NULL,
	client_age INT NOT NULL,
	client_gender CHAR NOT NULL CHECK (client_gender IN ('M', 'F')),
	client_height FLOAT NOT NULL,
	client_weight FLOAT NOT NULL,
	client_password VARCHAR(60) NOT NULL,
	client_active BIT NOT NULL,

	PRIMARY KEY(client_id)

)

CREATE TABLE SF.Adm(

	adm_id INT IDENTITY NOT NULL,
	adm_user VARCHAR(30) NOT NULL UNIQUE,
	adm_password VARCHAR(60) NOT NULL,
	adm_active BIT NOT NULL,

	PRIMARY KEY(adm_id)

)

CREATE TABLE SF.Exercise(

	exercise_id INT IDENTITY NOT NULL,
	exercise_name VARCHAR(30) NOT NULL,
	exercise_path NVARCHAR NOT NULL

	PRIMARY KEY(exercise_id)

)

CREATE TABLE SF.Recipe(

	recipe_id INT IDENTITY NOT NULL,
	recipe_client INT NOT NULL,
	recipe_exercise INT NOT NULL,

	PRIMARY KEY(recipe_id),
	FOREIGN KEY(recipe_client) REFERENCES SF.Client(client_id),
	FOREIGN KEY(recipe_exercise) REFERENCES SF.Exercise(exercise_id)

)

DBCC CHECKIDENT ('SF.Client', RESEED, 0)
DBCC CHECKIDENT ('SF.Adm', RESEED, 0)
DBCC CHECKIDENT ('SF.Exercise', RESEED, 0)
DBCC CHECKIDENT ('SF.Recipe', RESEED, 0)

INSERT INTO SF.Client (client_name, client_surname, client_age, client_gender, client_height, client_weight, client_password, client_active)
VALUES 
('Alice', 'Johnson', 30, 'F', 165.5, 55.0, 'password123', 0),
('Bob', 'Smith', 45, 'M', 175.0, 80.0, 'securepass456', 0),
('Charlie', 'Brown', 25, 'M', 180.0, 70.0, 'mysecret789', 0),
('Diana', 'Prince', 35, 'F', 160.0, 60.0, 'wonderpass321', 0),
('Eve', 'Davis', 40, 'F', 170.0, 65.0, 'evepassword000', 0);

INSERT INTO SF.Adm (adm_user, adm_password, adm_active)
VALUES 
('adm1', 'admpass123', 0),
('adm2', 'admpass456', 0),
('adm3', 'admpass789', 0),
('adm4', 'admpass321', 0),
('adm5', 'admpass000', 0);

/* TRIGGERS */

CREATE OR ALTER TRIGGER SF.ClientAge ON SF.Client INSTEAD OF INSERT AS
BEGIN
	
	INSERT INTO SF.Client (client_name, client_age, client_gender, client_height, client_weight, client_password)
    SELECT client_name, client_age, client_gender, client_height, client_weight, client_password
    FROM inserted WHERE client_age > 12;

END