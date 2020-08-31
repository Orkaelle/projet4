CREATE OR REPLACE FUNCTION interval_density()
RETURNS TABLE (
    country_name TEXT,
    density_interval TEXT
)
LANGUAGE plpgsql
AS
$$
BEGIN
RETURN QUERY
    SELECT country.country_name,
    CASE 
        WHEN country.density < 40 THEN '< 40'
        WHEN country.density < 100 THEN '40-100'
        WHEN country.density < 500 THEN '100-500'
        ELSE '> 500' END
        AS density_interval
    FROM country;
END;
$$



SELECT * FROM interval_density ();



CREATE OR REPLACE FUNCTION interval_density_ctry(ctry TEXT)
RETURNS TABLE (
    country_name TEXT,
    density_interval TEXT
)
LANGUAGE plpgsql
AS
$$
BEGIN
RETURN QUERY
    SELECT country.country_name,
    CASE 
        WHEN country.density < 40 THEN '< 40'
        WHEN country.density < 100 THEN '40-100'
        WHEN country.density < 500 THEN '100-500'
        ELSE '> 500' END
        AS density_interval
    FROM country
    WHERE country.country_name = ctry;
END;
$$



SELECT * FROM interval_density_ctry ('NomDuPays');