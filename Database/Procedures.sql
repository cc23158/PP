-- GET CLIENT BY NAME --
CREATE OR REPLACE FUNCTION SF.GET_ClientByName(name TEXT)
RETURNS TABLE (client_id INT, client_name TEXT, client_email TEXT, client_birthday DATE, client_gender CHAR(1), client_weight REAL, client_password TEXT, client_active BOOLEAN) AS $$
BEGIN
    RETURN QUERY
    SELECT c.client_id, c.client_name, c.client_email, c.client_birthday, c.client_gender, c.client_weight, c.client_password, c.client_active
    FROM SF.Client c WHERE c.client_name = name;
END
$$ LANGUAGE plpgsql;

-- GET CLIENT BY EMAIL --
CREATE OR REPLACE FUNCTION SF.GET_ClientByEmail(email TEXT)
RETURNS TABLE (client_id INT, client_name TEXT, client_email TEXT, client_birthday DATE, client_gender CHAR(1), client_weight REAL, client_password Text, client_active BOOLEAN) AS $$
BEGIN
    RETURN QUERY
    SELECT c.client_id, c.client_name, c.client_email, c.client_birthday, c.client_gender, c.client_weight, c.client_password, c.client_active
    FROM SF.Client c WHERE c.client_email = email;
END;
$$ LANGUAGE plpgsql;

-- VERIFY ADM --
CREATE OR REPLACE FUNCTION SF.GET_Adm(email TEXT, password TEXT)
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
RETURNS TABLE(exercise_id INT, exercise_name TEXT, exercise_image TEXT, exercise_path TEXT, exercise_muscle INT) AS $$
BEGIN
    RETURN QUERY
    SELECT e.exercise_id, e.exercise_name, e.exercise_path, e.exercise_image, e.exercise_muscle
    FROM SF.Exercise e
    JOIN SF.Muscle m ON e.exercise_muscle = m.muscle_id
    WHERE m.muscle_id = id;
END; 
$$ LANGUAGE plpgsql;

-- GET TRAINING BY CLIENT --
CREATE OR REPLACE FUNCTION SF.GET_TrainingByClient(id INT)
RETURNS TABLE(training_id INT, training_name TEXT, training_category INT, training_client INT) AS $$
BEGIN
    RETURN QUERY
    SELECT t.training_id, t.training_name, t.training_category, t.training_client
    FROM SF.Training t
    JOIN SF.Client c ON t.training_client = c.client_id
    WHERE c.client_id = id;
END;
$$ LANGUAGE plpgsql;

-- GET TRAINING BY CATEGORY --
CREATE OR REPLACE FUNCTION SF.GET_TrainingByCategory(client INT, category INT)
RETURNS TABLE(training_id INT, training_name TEXT, training_category INT, training_client INT) AS $$
BEGIN
    RETURN QUERY
    SELECT t.training_id, t.training_name, t.training_category, t.training_client
    FROM SF.Training t
    JOIN SF.Client c ON t.training_client = c.client_id
    WHERE c.client_id = client AND t.training_category = category;
END;
$$ LANGUAGE plpgsql;

-- GET EXERCISES BY TRAINING --
CREATE OR REPLACE FUNCTION SF.GET_Recipe(training INT)
RETURNS TABLE(recipe_id INT, recipe_training INT, recipe_exercise INT, recipe_weight TEXT, recipe_reps TEXT, recipe_sets INT) AS $$
BEGIN
    RETURN QUERY
    SELECT r.recipe_id, r.recipe_training, r.recipe_exercise, r.recipe_weight, r.recipe_reps, r.recipe_sets
    FROM SF.Recipe r
    JOIN SF.Training t ON r.recipe_training = t.training_id
    WHERE r.recipe_training = training ORDER BY recipe_id ASC;
END;
$$ LANGUAGE plpgsql;

-- GET HISTORY BY CLIENT --
CREATE OR REPLACE FUNCTION SF.GET_History(clientId INT, date DATE)
RETURNS TABLE(history_id INT, history_client INT, history_exercise INT, history_weight TEXT, history_reps TEXT, history_sets INT, history_date DATE) AS $$
BEGIN
    RETURN QUERY
    SELECT history_id, history_client, history_exercise, history_weight, history_reps, history_sets, history_date
    FROM  SF.History
    WHERE history_client = clientId AND history_date = date;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION SF.GET_HistoryByClient(clientId INT)
RETURNS TABLE(history_id INT, history_client INT, history_exercise INT, history_weight TEXT, history_reps TEXT, history_sets INT, history_date DATE) AS $$
BEGIN
    RETURN QUERY
    SELECT h.history_id, h.history_client, h.history_exercise, h.history_weight, h.history_reps, h.history_sets, h.history_date
    FROM SF.History h
    WHERE h.history_client = clientId;
END;
$$ LANGUAGE plpgsql;

select * from sf.get_historybyclient(6)