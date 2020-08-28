USE countries
CREATE FUNCTION dbo.country_search(country)
RETURNS TABLE
AS
BEGIN
DECLARE @result TABLE
SET @result=SELECT * FROM countries WHERE country_name = country
END