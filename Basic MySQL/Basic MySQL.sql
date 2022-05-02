USE bi_marathon_zulhumor_halmamatova;

--SELECT, WHERE, LIMIT 

--Select university, rank_display and number of international students from fact table 

SELECT university, rank_display, international_students
FROM fact_uni_rankings f
INNER JOIN university u ON f.university_id= u.university_id;

--Select universitites that has score more than 90

SELECT DISTINCT university, score 
FROM fact_uni_rankings f
INNER JOIN university u ON f.university_id=u.university_id
WHERE score>90
LIMIT 15;

b. --Insert values into location table 

INSERT INTO location (region, country, city)
VALUES ('Asia', 'Uzbekistan', 'Termez');

SELECT *
FROM location
WHERE city LIKE 'T%z';

c.--Drop the record 

DELETE FROM location 
WHERE region= 'Asia' AND country='Uzbekistan' AND city='Termez';

d. --Find value with tr in it

SELECT *
FROM university
WHERE university LIKE '%tr%';

e. --Filter one of your dimentions to show only IDs from 4 to 50 

SELECT fact_id
FROM fact_uni_rankings
WHERE fact_id BETWEEN 4 AND 50; 

f. --Insert Null values into university table 

INSERT INTO university (university, logo, link, type, size)
VALUES ('Tashkent State Univeristy','logo.png', 'http//tsul.uz/en', 'public', NULL);

SELECT* 
FROM university
WHERE size IS NULL;

DELETE FROM university 
WHERE size IS NULL;

g. --Select from a fact table and give temporary name to Score column as points 

SELECT score AS "points"
FROM fact_uni_rankings;
