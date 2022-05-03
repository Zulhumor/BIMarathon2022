USE bi_marathon_zulhumor_halmamatova;

-- 1.Perform LEFT, RIGHT, UNION joins with your dataset

SELECT f.year, f.score, l.city
FROM location l
LEFT JOIN fact_uni_rankings f ON f.location_id=l.Location_id;


SELECT f.year, f.score, l.city
FROM fact_uni_rankings f
RIGHT JOIN location l ON f.location_id=l.Location_id;

-- return IDs of the universities which are private and year=2019

SELECT u.university_id 
FROM university u
JOIN fact_uni_rankings f ON u.university_id=f.University_id
WHERE type='private' AND year= 2019;

-- 2.Find all universities and any score associated with those univercities

SELECT u.university, f.score 
FROM university u
LEFT JOIN fact_uni_rankings f ON u.university_id=f.University_id;

-- 3.Find all years and any associated universities names

SELECT f.year, u.university
FROM university u
JOIN fact_uni_rankings f ON u.university_id=f.University_id;

-- correct query 

SELECT f.year, u.university
FROM fact_uni_rankings f
LEFT JOIN university u ON u.university_id=f.University_id;

-- 4.Present all unique university IDs from university and fact tables

SELECT university_id
FROM university
UNION 
SELECT university_id
FROM fact_uni_rankings;

-- trying wih the city 
SELECT city
FROM location
UNION
SELECT country
FROM location
ORDER BY 1;


-- 5.Calculate how many universities had student faculty ratio more than 4
-- added distinct 

SELECT COUNT(DISTINCT u.university)
FROM university u 
JOIN fact_uni_rankings f ON u.university_id=f.University_id
WHERE student_faculty_ratio>4;

-- 6.How many Faculty count in 'Cambridge' city for year 2020
-- added city in SELECT 

SELECT city, year, COUNT(Faculty_count)
FROM fact_uni_rankings f
JOIN location l ON l.Location_id=f.Location_id
WHERE city='Cambridge' AND year=2020;
GROUP BY city, year;

-- 7. Present average score for 'Stanford University' for each region

SELECT AVG(f.score), l.region, university
FROM fact_uni_rankings f
JOIN university u ON u.university_id=f.university_id
JOIN location l ON l.location_id=f.location_id
WHERE u.university='Stanford University'
GROUP BY l.region, university;

-- query to check whether 'Stanford University' is only in North America 

SELECT city, region
FROM fact_uni_rankings f
JOIN university u ON u.university_id=f.university_id
JOIN location l ON l.location_id=f.location_id
WHERE u.university='Stanford University';

-- 8.What is the percentage of international students in 'Princeton University'

SELECT university, COUNT(f.International_students),
CONCAT(ROUND(f.International_students/(f.Student_faculty_ratio*f.Faculty_count)*100),'%')
FROM fact_uni_rankings f
JOIN university u ON u.university_id=f.university_id
WHERE u.university='Princeton University'
GROUP BY university;


