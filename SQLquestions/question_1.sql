-- Question 1: How many staff are there in all of the UK stores?
SELECT country_code, SUM(staff_numbers) AS total_staff_numbers
FROM dim_store
GROUP BY country_code
HAVING country_code = 'GB';
