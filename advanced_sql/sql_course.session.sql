-- Create table for January jobs
CREATE TABLE January_Jobs AS 
SELECT * 
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

-- Create table for February jobs
CREATE TABLE February_Jobs AS 
SELECT * 
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

-- Create table for March jobs
CREATE TABLE March_Jobs AS 
SELECT * 
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

SELECT
    COUNT(job_id) AS number_of_jobs,
    CASE
    WHEN job_location = 'Anywhere' THEN 'Remote'
    WHEN job_location = 'New York, NY' THEN 'Local'
    ELSE 'Onsite'
    END AS location_category
FROM
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY
    location_category;

-- Sub Query
SELECT * FROM (
-- Subquery Start Here
SELECT *
FROM job_postings_fact WHERE EXTRACT(MONTH FROM job_posted_date) = '1'
) AS January_Jobz

WITH January_Jobx AS (
-- CTE DEFINITION STARTS HERE
    SELECT *
    FROM job_postings_fact WHERE EXTRACT(MONTH FROM job_posted_date) = '1'     
)

SELECT * FROM January_Jobx;

SELECT name AS company_name
FROM company_dim
WHERE company_id IN (
    SELECT company_id from job_postings_fact
    WHERE
        job_no_degree_mention = true
)

WITH company_job_count AS (
SELECT 
    company_id,
    COUNT(*) AS total_jobs
FROM
    job_postings_fact
GROUP BY
    company_id
)

SELECT 
    company_dim.name AS company_name,
    company_job_count.total_jobs
FROM company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY total_jobs DESC




WITH remote_job_skills AS (
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM
        skills_job_dim AS skills_to_job
    INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
    WHERE 
        job_postings.job_work_from_home = true
    AND
        job_postings.job_title_short = 'Data Analyst'
    GROUP BY 
        skill_id
)


SELECT 
    skills.skill_id,
    skills.skills AS skill_name,
    skill_count
FROM
    remote_job_skills
INNER JOIN
    skills_dim AS skills
ON skills.skill_id = remote_job_skills.skill_id
ORDER BY
    skill_count
DESC
LIMIT
    5;

-- UNION

-- Get Jobs and Companies from January
SELECT 
    job_title_short,
    company_id,
    job_location
FROM
    January_Jobs

UNION

-- Get Jobs and Companies from February
SELECT 
    job_title_short,
    company_id,
    job_location
FROM
    February_Jobs;


-- UNION ALL
SELECT
    qtr1jobpostings.job_title_short,
    qtr1jobpostings.job_location,
    qtr1jobpostings.job_via,
    qtr1jobpostings.job_posted_date::DATE,
    qtr1jobpostings.salary_year_avg
    
FROM (
    SELECT * 
    FROM January_Jobs
    UNION ALL
    SELECT *
    FROM February_Jobs
    UNION ALL
    SELECT *
    FROM March_Jobs
) AS qtr1jobpostings
WHERE
    qtr1jobpostings.salary_year_avg > 70000
AND
    qtr1jobpostings.job_title_short = 'Data Analyst'
ORDER BY
    qtr1jobpostings.salary_year_avg DESC