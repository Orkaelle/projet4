CREATE OR REPLACE FUNCTION search (name TEXT)
RETURNS TABLE (
    country_name TEXT,
    pop INT,
    density INT,
    land_area INT
)
LANGUAGE plpgsql
AS
$$
BEGIN
RETURN QUERY
    SELECT * FROM country WHERE country.country_name = name;
END;
$$



SELECT * FROM search(name);