# Countries Data

This application allows you to consult and manipulate differents data about countries.

### Requierements
You have to install a postgresql solution on your device before using this application.

### SetUp
1 - Create the table "country" :
```sql
CREATE TABLE IF NOT EXISTS "country" (
"country_name" TEXT NULL,
"pop" INT NULL,
"density" INT NULL,
"land_area" INT NULL,
"update_time" TIMESTAMP NULL
);
```

2 - Create the trigger to auto-complete the update column :  
*Create the function called by the trigger :*
```sql
CREATE FUNCTION maj()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
    NEW.update_time := current_timestamp;
    RETURN NEW;
END;
$$
```
*Create the trigger :*
```sql
CREATE TRIGGER maj BEFORE INSERT OR UPDATE ON country
    FOR EACH ROW EXECUTE PROCEDURE maj();
```

3 - Create the function to consult a specific country data :
```sql
CREATE OR REPLACE FUNCTION search (name TEXT)
RETURNS TABLE (
    country_name TEXT,
    pop INT,
    density INT,
    land_area INT,
    update_time TIMESTAMP
)
LANGUAGE plpgsql
AS
$$
BEGIN
RETURN QUERY
    SELECT * FROM country WHERE country.country_name = name;
END;
$$
```

4 - Create the procedure to add a country with random values :
```sql
CREATE OR REPLACE PROCEDURE new (name TEXT)
LANGUAGE plpgsql
AS
$$
BEGIN
INSERT INTO country VALUES (
    name,
    floor(random() * (999990000+1) + 10000)::int,
    floor(random() * (999+1) + 1)::int,
    floor(random() * (999990+1) + 10)::int
);
END;
$$
```

5 - Create the functions to view the interval of density for countries :
```sql
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
```

6 - Insert the values in the table :  
Open the file named '6_insert.sql' and copy/paste the code in your database interpretor.


### Usage
To view the entire table :
```sql
SELECT * FROM country;
```

To view the data of a specific country :
```sql
SELECT * FROM search('countryname');
```

To add a country with random values :
```sql
CALL new('countryname');
```

To view the density interval :  
*For all countries :*
```sql
SELECT * FROM interval_density ();
```
*For a specific country :*
```sql
SELECT * FROM interval_density_ctry ('countryname');
```


