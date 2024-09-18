CREATE SCHEMA SF;

CREATE TABLE SF.Client
(
	client_id SERIAL NOT NULL,
	client_name VARCHAR(30) NOT NULL,
	client_email VARCHAR(60) NOT NULL UNIQUE,
	client_birthday DATE NOT NULL,
	client_gender CHAR(1) NOT NULL,
	client_weight REAL NOT NULL,
	client_password VARCHAR(30) NOT NULL,
	client_active BOOLEAN NOT NULL,

	PRIMARY KEY(client_id),
	CHECK (client_gender IN ('M', 'F'))
)

CREATE TABLE SF.Adm
(
	adm_id SERIAL NOT NULL,
	adm_email VARCHAR(60) NOT NULL UNIQUE,
	adm_password VARCHAR(60) NOT NULL,
	adm_salary REAL NOT NULL,
	adm_active BOOLEAN NOT NULL,

	PRIMARY KEY(adm_id)
)

CREATE TABLE SF.Muscle
(
	muscle_id SERIAL NOT NULL,
	muscle_name VARCHAR(30) NOT NULL,

	PRIMARY KEY(muscle_id)
)

-- IMAGENS SERÃO EM FORMATO BYTE
CREATE TABLE SF.Exercise
(
	exercise_id SERIAL NOT NULL,
	exercise_name VARCHAR(60) NOT NULL,
	exercise_image BYTEA NOT NULL,
	exercise_path TEXT NOT NULL,
	exercise_muscle INT NOT NULL,
	exercise_active BOOLEAN NOT NULL,

	PRIMARY KEY(exercise_id),
	FOREIGN KEY(exercise_muscle) REFERENCES SF.Muscle(muscle_id)
)

CREATE TABLE SF.Recipe
(
	recipe_id SERIAL NOT NULL,
	recipe_client INT NOT NULL,
	recipe_exercise INT NOT NULL,
	recipe_weight INT NOT NULL,

	PRIMARY KEY(recipe_id),
	FOREIGN KEY(recipe_client) REFERENCES SF.Client(client_id),
	FOREIGN KEY(recipe_exercise) REFERENCES SF.Exercise(exercise_id)
)

CREATE TABLE SF.History
(
	history_id SERIAL NOT NULL,
	history_client INT NOT NULL,
	history_recipe INT NOT NULL,
	history_date DATE NOT NULL,

	PRIMARY KEY(history_id),
	FOREIGN KEY(history_client) REFERENCES SF.Client(client_id),
	FOREIGN KEY(history_recipe) REFERENCES SF.Recipe(recipe_id)
)