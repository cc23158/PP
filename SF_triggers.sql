-- TRIGGER CLIENT INSERT --
CREATE OR ALTER TRIGGER SF.ClientInsert ON SF.Client INSTEAD OF INSERT as
BEGIN
	
	INSERT INTO SF.Client (client_name, client_surname, client_email, client_age, client_birthday, client_gender, client_height, client_weight, client_password, client_active)
    SELECT client_name, client_surname, client_email, client_age, client_birthday, client_gender, client_height, client_weight, client_password, 1
    FROM inserted
	
	WHERE client_age > 12 AND 
		  client_height > 50 AND 
		  client_height < 210 AND 
		  client_weight > 0 AND 
		  client_weight < 610 AND
		  client_birthday < GETDATE()

END

-- TRIGGER CLIENT UPDATE --
CREATE OR ALTER TRIGGER SF.ClientUpdate ON SF.Client INSTEAD OF UPDATE
AS
BEGIN
    
    UPDATE SF.Client
    SET client_age = i.client_age, 
        client_height = i.client_height, 
        client_weight = i.client_weight,
		client_password = i.client_password,
		client_active = i.client_active
    FROM inserted i

    WHERE SF.Client.client_id = i.client_id
      AND i.client_age > 12 
      AND i.client_height > 50 
      AND i.client_height < 210 
      AND i.client_weight > 0 
      AND i.client_weight < 610;

END

-- TRIGGER ADM INSERT --
CREATE OR ALTER TRIGGER SF.AdmInsert ON SF.Adm INSTEAD OF INSERT
AS
BEGIN

	INSERT INTO SF.Adm (adm_email, adm_password, adm_salary, adm_active)
    SELECT adm_email, adm_password, adm_salary, 1
    FROM inserted
	
	WHERE adm_salary > 0.0

END

-- TRIGGER ADM UPDATE --
CREATE OR ALTER TRIGGER SF.AdmUpdate ON SF.Adm INSTEAD OF UPDATE
AS
BEGIN

	UPDATE SF.Adm
    SET adm_salary = i.adm_salary,
		adm_password = i.adm_password,
		adm_active = i.adm_active
    FROM inserted i

    WHERE SF.Adm.adm_id = i.adm_id
      AND i.adm_salary > 0.0

END

-- TRIGGER RECIPE INSERT --
CREATE OR ALTER TRIGGER SF.RecipeInsert ON SF.Recipe INSTEAD OF INSERT
AS
BEGIN

	INSERT INTO SF.Recipe (recipe_client, recipe_exercise, recipe_weight)
    SELECT recipe_client, recipe_exercise, recipe_weight
    FROM inserted
	
	WHERE recipe_weight > 0.0

END

-- TRIGGER RECIPE UPDATE --
CREATE OR ALTER TRIGGER SF.RecipeUpdate ON SF.Recipe INSTEAD OF UPDATE
AS
BEGIN

	UPDATE SF.Recipe
    SET recipe_weight = i.recipe_weight FROM inserted i

    WHERE SF.Recipe.recipe_id = i.recipe_id AND i.recipe_weight > 0.0

END