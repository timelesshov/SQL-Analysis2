WITH Data_Analyst_Anywhere AS (
    SELECT
        fact_table.job_id AS jobid,
        fact_table.job_title_short,
        fact_table.job_title,
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

SELECT 
    Data_Analyst_Anywhere.*,
    skilldim.skills
FROM 
    Data_Analyst_Anywhere
INNER JOIN 
    skills_job_dim AS job_skillz
ON
    Data_Analyst_Anywhere.jobid = job_skillz.job_id
INNER JOIN
    skills_dim AS skilldim
ON
    job_skillz.skill_id = skilldim.skill_id
ORDER BY
    salary_year_avg
DESC