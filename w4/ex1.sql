SELECT *
FROM country
ORDER BY country_id
OFFSET 11 LIMIT 6;

SELECT city.city, address.address
FROM address
         JOIN city ON address.city_id = city.city_id
WHERE city LIKE 'A%';

SELECT customer.first_name, customer.last_name, city.city
FROM customer
         JOIN address ON address.address_id = customer.address_id
         JOIN city ON city.city_id = address.city_id;

SELECT first_name, last_name, payment.amount
FROM customer
         JOIN payment ON customer.customer_id = payment.customer_id
WHERE payment.amount > 11;

SELECT customer.first_name, COUNT(*)
FROM customer
GROUP BY customer.first_name
HAVING COUNT(*) > 1;
