/*
Question: What are the top-paying skills?
- Look at the average salary associated with each skill for Data Analyst positons
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and
    helps identify the most financially rewarding skills to acquire or improve
*/

SELECT
    skills,
    TO_CHAR(AVG(salary_year_avg), 'FM999,999.00') AS avg_salary_formatted
FROM job_postings_fact
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id 
WHERE 
    job_title_short = 'Data Analyst' 
    AND
    salary_year_avg IS NOT NULL
GROUP BY 
    skills
ORDER BY 
    AVG(salary_year_avg) DESC
LIMIT 25