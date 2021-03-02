-- Task #1.1
-- First solution
SELECT * FROM
(SELECT f.film_id, f.rating, f.title, c.first_name, c.last_name, c.customer_id FROM film f, customer c) t

JOIN film_category fc ON t.film_id = fc.film_id
JOIN category cat ON fc.category_id = cat.category_id

JOIN inventory inv ON t.film_id = inv.film_id
JOIN rental r ON inv.inventory_id = r.inventory_id

WHERE t.customer_id = r.customer_id -- something with this first condition here
	AND t.rating IN ('R', 'PG-13')
	AND cat.name IN ('Horror', 'Sci-fi')

-- Second solution
SELECT DISTINCT film.title, film.rating FROM film
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id
INNER JOIN inventory ON film.film_id = inventory.film_id
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE film.rating IN ('R', 'PG-13') -- rating is either R or PG13
	AND category.name IN ('Horror', 'Sci-fi') -- category is either Horror or Scifi
	AND rental.return_date is null -- null => it's not been returned => not been rented