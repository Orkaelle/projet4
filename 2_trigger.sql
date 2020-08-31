CREATE FUNCTION maj()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
    NEW.update_time := current_timestamp;
    RETURN NEW;
END;
$$



CREATE TRIGGER maj BEFORE INSERT OR UPDATE ON country
    FOR EACH ROW EXECUTE PROCEDURE maj();