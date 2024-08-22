-- GET CLIENT --
CREATE OR ALTER PROCEDURE SF.GET_Client
@name VARCHAR(30),
@surname VARCHAR(30)
as
BEGIN
	
	SELECT client_id, client_name, client_surname, client_email, client_age, client_birthday, client_gender, client_height, client_weight, client_password, client_active
    FROM SF.Client WHERE client_name = @name AND client_surname = @surname;

END

-- GET ADM (VERIFICATION) --
CREATE OR ALTER PROCEDURE SF.GET_Adm
@email VARCHAR(60),
@password VARCHAR(60),
@result BIT OUTPUT
as
BEGIN

	IF EXISTS (SELECT 1 FROM SF.Adm WHERE adm_email = @email AND adm_password = @password AND adm_active = 0)
        SET @result = 1;

    ELSE
        SET @result = 0;

END

-- POST CLIENT --
CREATE OR ALTER PROCEDURE SF.POST_Client
@name VARCHAR(30),
@surname VARCHAR(30),
@email VARCHAR(60),
@age INT,
@birthday DATE,
@gender CHAR,
@height FLOAT,
@weight FLOAT,
@password VARCHAR(60)
as
BEGIN

	INSERT INTO SF.Client (client_name, client_surname, client_email, client_age, client_birthday, client_gender, client_height, client_weight, client_password, client_active)
	VALUES (@name, @surname, @age, @email, @birthday, @gender, @height, @weight, @password, 0)

END

-- POST ADM --
CREATE OR ALTER PROCEDURE SF.POST_Adm
@email VARCHAR(30),
@password VARCHAR(60),
@salary FLOAT
as
BEGIN

	INSERT INTO SF.Adm (adm_email, adm_password, adm_salary, adm_active)
	VALUES (@email, @password, @salary, 0)

END

-- UPDATE DATA CLIENT --
CREATE OR ALTER PROCEDURE SF.UPDATE_ClientData
@id INT,
@age INT,
@height FLOAT,
@weight FLOAT
as
BEGIN

	UPDATE SF.Client SET client_age = @age, client_height = @height, client_weight = @weight WHERE client_id = @id

END

-- UPDATE CLIENT PASSWORD --
CREATE OR ALTER PROCEDURE SF.UPDATE_ClientPassword
@id INT,
@password VARCHAR(60)
as
BEGIN

	UPDATE SF.Client SET client_password = @password WHERE client_id = @id

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

-- DELETE CLIENT --
CREATE OR ALTER PROCEDURE SF.DELETE_Client
@id INT
as
BEGIN

	UPDATE SF.Client SET client_active = 1 WHERE client_id = @id

END

-- DELETE ADM --
CREATE OR ALTER PROCEDURE SF.DELETE_Adm
@id INT
as
BEGIN

	UPDATE SF.Adm SET adm_active = 1 WHERE adm_id = @id

END