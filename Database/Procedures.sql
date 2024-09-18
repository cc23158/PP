-- GET CLIENT BY NAME --
CREATE OR REPLACE FUNCTION SF.GET_ClientByName(name VARCHAR)
RETURNS TABLE(client_id INT, client_name VARCHAR, client_email VARCHAR, client_birthday DATE, client_gender CHAR(1), client_weight REAL, client_password VARCHAR, client_active BOOLEAN) AS $$
BEGIN
    RETURN QUERY
    SELECT c.client_id, c.client_name, c.client_email, c.client_birthday, c.client_gender, c.client_weight, c.client_password, c.client_active
    FROM SF.Client c WHERE c.client_name = name;
END;
$$ LANGUAGE plpgsql;

-- GET CLIENT BY EMAIL --
CREATE OR REPLACE FUNCTION SF.GET_ClientByEmail(email VARCHAR)
RETURNS TABLE(client_id INT, client_name VARCHAR, client_email VARCHAR, client_birthday DATE, client_gender CHAR(1), client_weight REAL, client_password VARCHAR, client_active BOOLEAN) AS $$
BEGIN
    RETURN QUERY
    SELECT c.client_id, c.client_name, c.client_email, c.client_birthday, c.client_gender, c.client_weight, c.client_password, c.client_active
    FROM SF.Client c WHERE c.client_email = email;
END;
$$ LANGUAGE plpgsql;

-- GET ADM (VERIFICATION) --
CREATE OR REPLACE FUNCTION SF.GET_Adm(email VARCHAR, password VARCHAR)
RETURNS BOOLEAN AS $$
DECLARE
    result BOOLEAN;
BEGIN
    SELECT EXISTS (SELECT 1 FROM SF.Adm WHERE adm_email = email AND adm_password = password AND adm_active = TRUE) INTO result;
    RETURN result;
END;
$$ LANGUAGE plpgsql;

-- GET EXERCISE BY MUSCLE --
CREATE OR REPLACE FUNCTION SF.GET_Exercise(id INT)
RETURNS TABLE(exercise_id INT, exercise_name VARCHAR, exercise_path VARCHAR) AS $$
BEGIN
    RETURN QUERY
    SELECT e.exercise_id, e.exercise_name, e.exercise_path
    FROM SF.Exercise e
    JOIN SF.Muscle m ON e.exercise_muscle = m.muscle_id
    WHERE m.muscle_id = id;
END;
$$ LANGUAGE plpgsql;

-- POST EXERCISE --
CREATE OR REPLACE FUNCTION SF.POST_Exercise(name VARCHAR, path VARCHAR, muscle INT)
RETURNS VOID AS $$
BEGIN
    INSERT INTO SF.Exercise(exercise_name, exercise_path, exercise_muscle, exercise_active)
    VALUES (name, path, muscle, TRUE);
END;
$$ LANGUAGE plpgsql;

-- UPDATE EXERCISE PATH --
CREATE OR REPLACE FUNCTION SF.UPDATE_Exercise(id INT, path VARCHAR)
RETURNS VOID AS $$
BEGIN
    UPDATE SF.Exercise SET exercise_path = path WHERE exercise_id = id;
END;
$$ LANGUAGE plpgsql;

-- DELETE EXERCISE --
CREATE OR REPLACE FUNCTION SF.DELETE_Exercise(id INT)
RETURNS VOID AS $$
BEGIN
    UPDATE SF.Exercise SET exercise_active = FALSE WHERE exercise_id = id;
END;
$$ LANGUAGE plpgsql;

-- POST MUSCLE --
CREATE OR REPLACE FUNCTION SF.POST_Muscle(name VARCHAR)
RETURNS VOID AS $$
BEGIN
    INSERT INTO SF.Muscle(muscle_name) VALUES (name);
END;
$$ LANGUAGE plpgsql;

-- POST RECIPES --
CREATE OR REPLACE FUNCTION SF.POST_Recipe(client INT, exercise INT, weight FLOAT)
RETURNS VOID AS $$
BEGIN
    INSERT INTO SF.Recipe(recipe_client, recipe_exercise, recipe_weight)
    VALUES (client, exercise, weight);
END;
$$ LANGUAGE plpgsql;

-- UPDATE RECIPES --
CREATE OR REPLACE FUNCTION SF.UPDATE_Recipe(id INT, weight FLOAT)
RETURNS VOID AS $$
BEGIN
    UPDATE SF.Recipe SET recipe_weight = weight WHERE recipe_id = id;
END;
$$ LANGUAGE plpgsql;

-- ACTIVES OR NOT --
CREATE OR REPLACE FUNCTION SF.ACTIVE_Client(id INT)
RETURNS VOID AS $$
BEGIN
    UPDATE SF.Client SET client_active = TRUE WHERE client_id = id;
END;
$$ LANGUAGE plpgsql;

-- Execução da função ACTIVE_Client
SELECT SF.ACTIVE_Client(1);
