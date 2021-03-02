-- Task #1.2
SELECT store.store_id, SUM(payment.amount) FROM store

INNER JOIN staff ON store.store_id = staff.store_id
INNER JOIN payment ON staff.staff_id = payment.staff_id

WHERE (TO_CHAR(payment.payment_date, 'YYYY'),
        TO_CHAR(payment.payment_date, 'MM'))
= (SELECT TO_CHAR(payment_date, 'YYYY') AS y, TO_CHAR(payment_date, 'MM') AS m FROM payment
  ORDER BY y DESC, m DESC LIMIT 1)

GROUP BY store.store_id;
