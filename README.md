# Countries Data

### Description
This application allows you to consult and manipulate differents data about countries. It was developed as part of an AI Developer training with the AI Microsoft School powered by Simplon.

### Requierements
You must have a postgresql database solution installed on your device before using this application.

### SetUp
#### 1 - Create the table "country" :
```sql
CREATE TABLE IF NOT EXISTS "country" (
"country_name" TEXT NULL,
"pop" INT NULL,
"density" INT NULL,
"land_area" INT NULL,
"update_time" TIMESTAMP NULL
);
```

#### 2 - Create the trigger to auto-complete the update column :  
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

#### 3 - Create the function to consult a specific country data :
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

#### 4 - Create the procedure to add a country with random values :
```sql
CREATE OR REPLACE PROCEDURE new (name TEXT)
LANGUAGE plpgsql
AS
$$
DECLARE 
    maxpop int;
    minpop int;
    pop int;
    maxarea int;
    minarea int;
    area int;
    density int;
BEGIN
SELECT MAX(country.pop) INTO maxpop FROM country;
SELECT MIN(country.pop) INTO minpop FROM country;
SELECT MAX(country.land_area) INTO maxarea FROM country;
SELECT MIN(country.land_area) INTO minarea FROM country;
pop := floor(random() * ((maxpop - minpop)+1) + minpop);
area := floor(random() * ((maxarea - minarea)+1) + minarea);
density := pop/area;
INSERT INTO country VALUES (
    name,
    pop,
    density,
    area
);
END;
$$
```

#### 5 - Create the functions to view the interval of density for countries :
*For all countries :*
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
    FROM country
    ORDER BY density_interval;
END;
$$
```
*For a specific country :*
```sql
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

#### 6 - Insert the values in the table :  
Open the file named ['6_insert.sql'](https://github.com/Orkaelle/projet4/blob/develop/6_insert.sql) and copy/paste the code in your database interpretor.


### Usage
*To use the code, replace the parameter 'countryname' by the name of the country of your choice.*

#### To view the entire table :
```sql
SELECT * FROM country;
```

#### To view the data of a specific country :
```sql
SELECT * FROM search('countryname');
```

#### To add a country with random values :
```sql
CALL new('countryname');
```

#### To view the density interval :  
*For all countries :*
```sql
SELECT * FROM interval_density ();
```
*For a specific country :*
```sql
SELECT * FROM interval_density_ctry ('countryname');
```


