CREATE SCHEMA SF

CREATE TABLE SF.Client(
	
	client_id INT IDENTITY NOT NULL,
	client_name VARCHAR(30) NOT NULL,
	client_surname VARCHAR(30) NOT NULL,
	client_email VARCHAR(60) NOT NULL UNIQUE,
	client_age INT NOT NULL,
	client_birthday DATE NOT NULL,
	client_gender CHAR NOT NULL CHECK (client_gender IN ('M', 'F')),
	client_height FLOAT NOT NULL,
	client_weight FLOAT NOT NULL,
	client_password VARCHAR(60) NOT NULL,
	client_active BIT NOT NULL,

	PRIMARY KEY(client_id)

)

CREATE TABLE SF.Adm(

	adm_id INT IDENTITY NOT NULL,
	adm_email VARCHAR(60) NOT NULL UNIQUE,
	adm_password VARCHAR(60) NOT NULL,
	adm_salary FLOAT NOT NULL,
	adm_active BIT NOT NULL,

	PRIMARY KEY(adm_id)

)

CREATE TABLE SF.Muscle(

	muscle_id INT IDENTITY NOT NULL,
	muscle_name VARCHAR(30) NOT NULL,

	PRIMARY KEY(muscle_id),

)

CREATE TABLE SF.Exercise(

	exercise_id INT IDENTITY NOT NULL,
	exercise_name VARCHAR(60) NOT NULL,
	exercise_path VARCHAR(1000) NOT NULL,
	exercise_muscle INT NOT NULL,
	exercise_active BIT NOT NULL,

	PRIMARY KEY(exercise_id),
	FOREIGN KEY(exercise_muscle) REFERENCES SF.Muscle(muscle_id)

)

CREATE TABLE SF.Recipe(

	recipe_id INT IDENTITY NOT NULL,
	recipe_client INT NOT NULL,
	recipe_exercise INT NOT NULL,
	recipe_weight FLOAT NULL,

	PRIMARY KEY(recipe_id),
	FOREIGN KEY(recipe_client) REFERENCES SF.Client(client_id),
	FOREIGN KEY(recipe_exercise) REFERENCES SF.Exercise(exercise_id)

)