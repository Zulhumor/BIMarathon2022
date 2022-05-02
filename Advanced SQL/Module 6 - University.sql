use bi_marathon_zulhumor_halmamatova;

-- 1. add 3 duplicates into 2 dimensions 

INSERT INTO university (university, link)
VALUES ('Duplicate University','Duplicate'),
		('Duplicate University','Duplicate'),
		('Duplicate University','Duplicate');
        
SELECT university, link, logo FROM university;

-- 2. run a script of finding duplicates using method 1 and method 2
-- METHOD 1
SELECT university, logo, link, count(*) as DUPL_COUNT FROM university 
GROUP BY university, logo 
HAVING COUNT(*) >1;


-- METHOD 2 
WITH CTE(university, link, duplicatecount)
AS (SELECT university, link,
			row_number()	OVER (partition by university, link
			order by university) AS DuplicateCount
	FROM university)
SELECT * FROM CTE
WHERE duplicatecount>1;

-- 3. INSERT NULL value in one dimension and use COALESCE function to replace NULLs with 'NA' 
SELECT university, link, NULLIF(logo, 'logo.png') AS logo FROM university;
SELECT  university, link, COALESCE(logo, 'NA') AS logo FROM university;

-- 4. Find average score by university name in North America region. 
-- 			Showcase all universities in North america together with their score and average score

WITH average_score AS(
	SELECT u.university, AVG(f.score) as average_score
    FROM university u
    INNER JOIN fact_uni_rankings f ON f.university_id = u.university_id
    group by u.university
)
SELECT u.university, l.region, f.score, avs.average_score
FROM university u
INNER JOIN fact_uni_rankings f ON u.university_id = f.university_id
INNER JOIN location l ON l.location_id = f.location_id
INNER JOIN average_score avs ON avs.university = u.university
WHERE l.region = 'North America'
GROUP by u.university;

