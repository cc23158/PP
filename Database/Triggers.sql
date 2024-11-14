-- TRIGGER CLIENT INSERT --
CREATE OR REPLACE FUNCTION SF.T_ClientInsert()
RETURNS TRIGGER AS $$
DECLARE
    client_age INT;
BEGIN
    client_age := EXTRACT(YEAR FROM AGE(NEW.client_birthday));

    IF NEW.client_weight <= 0 OR NEW.client_weight >= 610 THEN
        RAISE NOTICE 'Peso inválido para o cliente: %', NEW.client_name;
        RETURN NULL;
    END IF;

    IF client_age <= 12 THEN
        RAISE NOTICE 'Cliente % deve ter mais de 12 anos.', NEW.client_name;
        RETURN NULL;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_client_insert
BEFORE INSERT ON SF.Client
FOR EACH ROW EXECUTE FUNCTION SF.T_ClientInsert();

-- TRIGGER CLIENT UPDATE --
CREATE OR REPLACE FUNCTION SF.T_ClientUpdate()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.client_password IS DISTINCT FROM OLD.client_password AND
       NEW.client_active IS TRUE THEN
        RETURN NEW;
    END IF;

    IF NEW.client_weight < 0 OR NEW.client_weight > 610 THEN
        RAISE NOTICE 'Dados inválidos para atualização: client_weight deve estar entre 0 e 610 para o cliente: %', NEW.client_name;
        RETURN NULL;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_client_update
BEFORE UPDATE ON SF.Client
FOR EACH ROW EXECUTE FUNCTION SF.T_ClientUpdate();

-- TRIGGER ADM INSERT --
CREATE OR REPLACE FUNCTION SF.T_AdmInsert()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.adm_salary > 0 THEN
		RETURN NEW;
	END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_adm_insert
BEFORE INSERT ON SF.Adm
FOR EACH ROW EXECUTE FUNCTION SF.T_AdmInsert();

-- TRIGGER ADM UPDATE --
CREATE OR REPLACE FUNCTION SF.T_AdmUpdate()
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

CREATE TRIGGER trg_check_adm_update
BEFORE UPDATE ON SF.Adm
FOR EACH ROW EXECUTE FUNCTION SF.T_AdmUpdate();