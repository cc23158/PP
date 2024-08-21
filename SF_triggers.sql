-- TRIGGER CLIENT INSERT --
CREATE OR ALTER TRIGGER SF.ClientInsert ON SF.Client INSTEAD OF INSERT AS
BEGIN
	
	INSERT INTO SF.Client (client_name, client_age, client_birthday, client_gender, client_height, client_weight, client_password)
    SELECT client_name, client_age, client_gender, client_birthday, client_height, client_weight, client_password
    FROM inserted 
	
	WHERE client_age > 12 AND 
		  client_height > 50 AND 
		  client_height < 210 AND 
		  client_weight > 0 AND 
		  client_weight < 610 AND
		  client_birthday <= GETDATE() AND
		  ISDATE(CONVERT(varchar, client_birthday, 23)) = 1;

END

-- TRIGGER CLIENT UPDATE --
CREATE OR ALTER TRIGGER SF.ClientUpdate ON SF.Client INSTEAD OF UPDATE AS
BEGIN

	UPDATE SF.Client SET client_age = i.client_age,
						 client_height = i.client_height,
						 client_weight = i.client_weight,
						 client_password = i.client_password FROM inserted i

	WHERE SF.Client.client_id = i.client_id 
		AND i.client_age > 12 
		AND i.client_height > 50 
		AND i.client_height < 210 
		AND i.client_weight > 0 
		AND i.client_weight < 610;

END