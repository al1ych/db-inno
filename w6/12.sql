-- Task #1.2
SELECT * FROM city, store, address
where store.address_id = address.address_id
	and address.address_id = city.city_id