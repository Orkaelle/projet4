# Countries in numbers
## Simplon - P3 Data IA

This application allows you to consult differents data from a country.

### Installation
You have to install a postgresql solution on your device before using this application.

### Start
#### Creation
Create the table "Country" :
```sql
CREATE TABLE IF NOT EXISTS "country" (
"country_name" TEXT NULL,
"pop" INT NULL,
"density" INT NULL,
"land_area" INT NULL
);
```

#### Insertion
To insert the values in the table, use the sql script '2_insert' by copy/paste it on your database solution.

### Usage
#### Function

