EXPLAIN ANALYSE SELECT * FROM
(SELECT f.film_id, f.rating, f.title, c.first_name, c.last_name, c.customer_id FROM film f, customer c) t

JOIN film_category fc ON t.film_id = fc.film_id
JOIN category cat ON fc.category_id = cat.category_id

JOIN inventory inv ON t.film_id = inv.film_id
JOIN rental r ON inv.inventory_id = r.inventory_id

WHERE t.customer_id = r.customer_id -- something with this first condition here
	AND t.rating IN ('R', 'PG-13')
	AND cat.name IN ('Horror', 'Sci-fi')

-- JOIN is most expensive, we can reduce cost utilizing indexes
