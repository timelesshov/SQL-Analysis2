-- WITH Data_Analyst_Anywhere AS (
--     SELECT
--         fact_table.job_id,
--         fact_table.job_title_short,
--         fact_table.job_title,
--         fact_table.job_location,
--         fact_table.job_schedule_type,
--         fact_table.salary_year_avg,
--         fact_table.job_posted_date,
--         company.name AS Company_Name
--     FROM 
--         job_postings_fact AS fact_table
--     LEFT JOIN company_dim AS company
--     ON fact_table.company_id = company.company_id 
--     WHERE
--         fact_table.job_title_short = 'Data Analyst'
--         AND fact_table.job_location = 'Anywhere'
--         AND fact_table.salary_year_avg IS NOT NULL
--     ORDER BY 
--         fact_table.salary_year_avg DESC
--     LIMIT
--         10
-- )

-- SELECT * INTO Top_10_Jobs_Anywhere
-- FROM Data_Analyst_Anywhere;





WITH Data_Analyst_Anywhere AS (
SELECT
    fact_table.job_id,
    fact_table.job_title_short,
    fact_table.job_title,
    fact_table.job_location,
    fact_table.job_schedule_type,
    fact_table.salary_year_avg,
    fact_table.job_posted_date,
    company.name AS Company_Name
FROM 
    job_postings_fact AS fact_table
LEFT JOIN company_dim 
AS company
ON
fact_table.company_id = company.company_id 
WHERE
    fact_table.job_title_short = 'Data Analyst'
AND
    fact_table.job_location = 'Anywhere'
AND
    fact_table.salary_year_avg IS NOT NULL
ORDER BY 
    fact_table.salary_year_avg DESC
LIMIT
10
)

SELECT *
FROM Data_Analyst_Anywhere;

