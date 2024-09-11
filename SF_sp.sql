-- GET CLIENT BY NAME --
CREATE OR ALTER PROCEDURE SF.GET_ClientByName
@name VARCHAR(30)
as
BEGIN
	
	SELECT client_id, client_name, client_email, client_birthday, client_gender, client_weight, client_password, client_active
    FROM SF.Client WHERE client_name = @name

END

-- GET CLIENT BY EMAIL --
CREATE OR ALTER PROCEDURE SF.GET_ClientByEmail
@email VARCHAR(60)
as
BEGIN

	SELECT client_id, client_name, client_email, client_birthday, client_gender, client_weight, client_password, client_active
    FROM SF.Client WHERE client_email = @email

END

-- GET ADM (VERIFICATION) --
CREATE OR ALTER PROCEDURE SF.GET_Adm
@email VARCHAR(60),
@password VARCHAR(60),
@result BIT OUTPUT
as
BEGIN

	IF EXISTS (SELECT 1 FROM SF.Adm WHERE adm_email = @email AND adm_password = @password AND adm_active = 1)
        SET @result = 1;

    ELSE
        SET @result = 0;

END

-- POST ADM --
CREATE OR ALTER PROCEDURE SF.POST_Adm
@email VARCHAR(30),
@password VARCHAR(60),
@salary FLOAT
as
BEGIN

	INSERT INTO SF.Adm (adm_email, adm_password, adm_salary, adm_active)
	VALUES (@email, @password, @salary, 1)

END

-- UPDATE ADM SALARY --
CREATE OR ALTER PROCEDURE SF.UPDATE_AdmSalary
@id INT,
@salary FLOAT
as
BEGIN

	UPDATE SF.Adm SET adm_salary = @salary WHERE adm_id = @id

END

-- UPDATE ADM PASSWORD --
CREATE OR ALTER PROCEDURE SF.UPDATE_AdmPassword
@id INT,
@password VARCHAR(60)
as
BEGIN

	UPDATE SF.Adm SET adm_password = @password WHERE adm_id = @id

END

-- DELETE ADM --
CREATE OR ALTER PROCEDURE SF.DELETE_Adm
@id INT
as
BEGIN

	UPDATE SF.Adm SET adm_active = 0 WHERE adm_id = @id

END

-- GET EXERCISE BY MUSCLE --
CREATE OR ALTER PROCEDURE SF.GET_Exercise
@id INT
as
BEGIN

	SELECT e.exercise_id, e.exercise_name, e.exercise_path
	FROM SF.Exercise e
	JOIN SF.Muscle m ON e.exercise_muscle = m.muscle_id
	WHERE m.muscle_id = @id


END

-- POST EXERCISE --
CREATE OR ALTER PROCEDURE SF.POST_Exercise
@name VARCHAR(30),
@path VARCHAR(1000),
@muscle INT
as
BEGIN

	INSERT INTO SF.Exercise(exercise_name, exercise_path, exercise_muscle, exercise_active) VALUES(@name, @path, @muscle, 1)

END

-- UPDATE EXERCISE PATH -- 
CREATE OR ALTER PROCEDURE SF.UPDATE_Exercise
@id INT,
@path VARCHAR(1000)
as
BEGIN

	UPDATE SF.Exercise SET exercise_path = @path WHERE exercise_id = @id

END

-- DELETE EXERCISE --
CREATE OR ALTER PROCEDURE SF.DELETE_Exercise
@id INT
as
BEGIN

	UPDATE SF.Exercise SET exercise_active = 0 WHERE exercise_id = @id

END

-- POST MUSCLE --
CREATE OR ALTER PROCEDURE SF.POST_Muscle
@name VARCHAR(30)
as
BEGIN

	INSERT INTO SF.Muscle(muscle_name) VALUES(@name)

END

-- GET RECIPE BY CLIENT --

-- POST RECIPES --
CREATE OR ALTER PROCEDURE SF.POST_Recipe
@client INT,
@exercise INT,
@WEIGHT FLOAT
as
BEGIN

	INSERT INTO SF.Recipe(recipe_client, recipe_exercise, recipe_weight) VALUES(@client, @exercise, @WEIGHT)

END

-- UPDATE RECIPES --
CREATE OR ALTER PROCEDURE SF.UPDATE_Recipe
@id INT,
@weight FLOAT
as
BEGIN

	UPDATE SF.Recipe SET recipe_weight = @weight WHERE recipe_id = @id

END

-- ACTIVES OR NOT --
CREATE OR ALTER PROCEDURE SF.ACTIVE_Client
@id INT
as
BEGIN

	UPDATE SF.Client SET client_active = 1 WHERE client_id = @id

END

EXEC SF.ACTIVE_Client 1
select * from sf.exercise