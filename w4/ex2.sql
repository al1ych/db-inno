CREATE VIEW film_release_year_2006 AS
SELECT title, film_id, rental_duration
FROM film
WHERE release_year = 2006;

CREATE VIEW cities_start_with_A AS
SELECT city_id, country_id
FROM city
WHERE (city.city LIKE 'A%');

SELECT *
FROM film_release_year_2006;



CREATE FUNCTION trigger___address()
    RETURNS TRIGGER
    LANGUAGE PLPGSQL
AS
$$
BEGIN
    insert into address (address, address2, district, city_id, postal_code, phone)
    values ('Ffffff', 4, 'dsf', 56, 345, 56);
    RETURN NEW;
END;
$$;

CREATE TRIGGER on_address___update
    BEFORE UPDATE
    ON address
    FOR EACH ROW
EXECUTE PROCEDURE trigger___address();


update address
set address = 'fgdf'
where address_id = 1;

