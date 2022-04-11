SELECT year(birthDate) as birthYear, count(*) AS total
FROM default.people10m
WHERE firstName = 'Mary' AND gender = 'F'
GROUP BY birthYear
ORDER BY birthYear
