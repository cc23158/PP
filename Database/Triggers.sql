-- TRIGGER CLIENT INSERT --
CREATE OR REPLACE FUNCTION Client_Insert()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.client_weight > 0 AND 
       NEW.client_weight < 610 AND 
       NEW.client_birthday < CURRENT_DATE THEN

        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'Dados inválidos para inserção.';
    END IF;

    RETURN NULL; -- Este retorno não deve ser alcançado
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER Client_Insert_Trigger
BEFORE INSERT ON SF.Client
FOR EACH ROW EXECUTE FUNCTION Client_Insert();

-- TRIGGER CLIENT UPDATE --
CREATE OR REPLACE FUNCTION Client_Update()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.client_password IS DISTINCT FROM OLD.client_password OR
	   NEW.client_active IS DISTINCT FROM OLD.client_active THEN
        RETURN NEW;
    END IF;

	IF NEW.client_weight < 0 OR NEW.client_weight > 610 THEN
        RAISE EXCEPTION 'Dados inválidos para atualização: client_weight deve estar entre 0 e 610.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER Client_Update_Trigger
BEFORE UPDATE ON SF.Client
FOR EACH ROW EXECUTE FUNCTION Client_Update();

-- TRIGGER ADM INSERT --
CREATE OR REPLACE FUNCTION Adm_Insert()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.adm_salary > 0 THEN
		RETURN NEW;
	END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER Adm_Insert_Trigger
BEFORE INSERT ON SF.Adm
FOR EACH ROW EXECUTE FUNCTION Adm_Insert();

-- TRIGGER ADM UPDATE --
CREATE OR REPLACE FUNCTION Adm_Update()
RETURNS TRIGGER AS $$
BEGIN

	IF NEW.adm_password IS DISTINCT FROM OLD.adm_password OR
	   NEW.adm_active IS DISTINCT FROM OLD.adm_active THEN
	   RETURN NEW;
	END IF;
	
    IF NEW.adm_salary > 0.0 THEN
		RETURN NEW;
	END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER Adm_Update_Trigger
BEFORE UPDATE ON SF.Adm
FOR EACH ROW EXECUTE FUNCTION Adm_Update();

-- TRIGGER RECIPE INSERT --
CREATE OR REPLACE FUNCTION Recipe_Insert()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.recipe_weight > 0.0 THEN
		RETURN NEW;
	END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER Recipe_Insert_Trigger
BEFORE INSERT ON SF.Recipe
FOR EACH ROW EXECUTE FUNCTION Recipe_Insert();

-- TRIGGER RECIPE UPDATE --
CREATE OR REPLACE FUNCTION Recipe_Update()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.recipe_weight > 0.0 THEN
		RETURN NEW;
	END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER Recipe_Update_Trigger
BEFORE UPDATE ON SF.Recipe
FOR EACH ROW EXECUTE FUNCTION Recipe_Update();