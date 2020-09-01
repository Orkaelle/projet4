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


CALL new('NomDuPays');