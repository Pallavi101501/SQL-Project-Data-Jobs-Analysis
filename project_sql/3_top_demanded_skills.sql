/*
Question: What are the most in-demand skills for data analysts?
-Join job postings to inner join table similar to query 2
-Identify the top 5 in-demand skills for data analyst.
-Focus on all job postings. (I tweaked it specifically for India as Job location)
-Why? Retrieves the top 5 skills with the highest demand in the job market,
providing insights into the most valuable skills for job seekers.
*/

SELECT
    skills,
    COUNT(job_postings_fact.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id 
WHERE 
    job_title_short = 'Data Analyst' 
    AND
    job_location LIKE '%India%'
GROUP BY 
    skills
ORDER BY 
    COUNT(job_postings_fact.job_id) DESC
LIMIT 5