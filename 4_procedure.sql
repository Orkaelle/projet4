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


CALL new('NomDuPays');