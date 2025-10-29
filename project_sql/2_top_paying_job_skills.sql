/*
Question : What skills are required for the top-paying data analyst jobs?
- Use the top 10 highest-paying Data Analyst jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which hig-paying jobs demand certain skills, helping job seekers understand which skills to develop that align with top salaries
*/


WITH top_paying_jobs AS(
    SELECT 
        job_postings_fact.job_id,
        job_title,
        name AS company_name,
        salary_year_avg
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
    --LEFT JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
    WHERE 
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)
SELECT * FROM top_paying_jobs