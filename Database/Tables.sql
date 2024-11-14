CREATE SCHEMA IF NOT EXISTS SF;

CREATE TABLE IF NOT EXISTS SF.Client
(
  client_id SERIAL NOT NULL,
	client_name TEXT NOT NULL,
	client_email TEXT NOT NULL UNIQUE,
	client_birthday DATE NOT NULL,
	client_gender CHAR(1) NOT NULL,
	client_weight REAL NOT NULL,
	client_password TEXT NOT NULL,
	client_active BOOLEAN NOT NULL,

	PRIMARY KEY(client_id),
	CHECK (client_gender IN ('M', 'F'))
)

CREATE TABLE IF NOT EXISTS SF.Adm
(
	adm_id SERIAL NOT NULL,
	adm_email TEXT NOT NULL UNIQUE,
	adm_password TEXT NOT NULL,
	adm_salary REAL NOT NULL,
	adm_active BOOLEAN NOT NULL,

	PRIMARY KEY(adm_id)
)

CREATE TABLE IF NOT EXISTS SF.Muscle
(
	muscle_id SERIAL NOT NULL,
	muscle_name TEXT NOT NULL,

	PRIMARY KEY(muscle_id)
)

CREATE TABLE IF NOT EXISTS SF.Exercise
(
	exercise_id SERIAL NOT NULL,
	exercise_name TEXT NOT NULL,
	exercise_image TEXT NOT NULL,
	exercise_path TEXT NOT NULL,
	exercise_muscle INT NOT NULL,

	PRIMARY KEY(exercise_id),
	FOREIGN KEY(exercise_muscle) REFERENCES SF.Muscle(muscle_id)
)

CREATE TABLE IF NOT EXISTS SF.Training
(
	training_id SERIAL NOT NULL,
  training_name TEXT NOT NULL,
	training_category INT NOT NULL,
	training_client INT NOT NULL,
    
  PRIMARY KEY(training_id),
  FOREIGN KEY(training_client) REFERENCES SF.Client(client_id)
)

CREATE TABLE IF NOT EXISTS SF.Recipe
(
  recipe_id SERIAL NOT NULL,
  recipe_training INT NOT NULL,
  recipe_exercise INT NOT NULL,
	recipe_weight TEXT NULL,
	recipe_reps TEXT NULL,
	recipe_sets INT NULL,
    
  PRIMARY KEY(recipe_id),
  FOREIGN KEY(recipe_training) REFERENCES SF.Training(training_id) ON DELETE CASCADE,
  FOREIGN KEY(recipe_exercise) REFERENCES SF.Exercise(exercise_id)
)

CREATE TABLE IF NOT EXISTS SF.History
(
	history_id SERIAL NOT NULL,
	history_client INT NOT NULL,
	history_exercise INT NOT NULL,
	history_weight TEXT NULL,
	history_reps TEXT NULL,
	history_sets INT NULL,
	history_date DATE NULL,

	PRIMARY KEY(history_id),
	FOREIGN KEY(history_client) REFERENCES SF.Client(client_id),
	FOREIGN KEY(history_exercise) REFERENCES SF.Exercise(exercise_id)
)