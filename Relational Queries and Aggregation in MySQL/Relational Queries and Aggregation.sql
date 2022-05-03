USE bi_marathon_zulhumor_halmamatova;

-- 1.Perform LEFT, RIGHT, UNION joins with your dataset

-- find the universities in Europe that have High research outputs

SELECT DISTINCT (university_id), research_output
FROM research r
LEFT JOIN fact_uni_rankings f
ON r.research_id = f.research_id
LEFT JOIN university u
ON u.university_id = f.university_id
LEFT JOIN location l
ON l.location_id = f.location_id
WHERE r.research_output = 'High' AND l.region = 'Europe'
ORDER BY u.university;

-- Find the university and number of international students in North America
SELECT DISTINCT u.university, f.international_students, l.region
FROM university u
RIGHT JOIN fact_uni_rankings f
ON f.university_id = u.university_id
JOIN location l
ON f.location_id = l.location_id
WHERE region = 'North America';

-- find ALL IDs from fact table and university
SELECT f.university_id
FROM fact_uni_rankings f
UNION
SELECT u.university_id
FROM university u;

-- 2.Find all universities and any score associated with those univercities

SELECT u.university, f.score 
FROM university u
INNER JOIN fact_uni_rankings f ON u.university_id=f.University_id
GROUP BY u.university_id
ORDER BY u.university_id ASC;;


-- 3.Find all years and any associated universities names

SELECT f.year, u.university
FROM fact_uni_rankings f
LEFT JOIN university u ON u.university_id=f.University_id
ORDER BY f.year ASC;


-- 4.Present all unique university IDs from university and fact tables

SELECT DISTINCT (university_id)
FROM university u
LEFT JOIN fact_uni_rankings f ON u.university_id = f.university_id;


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


