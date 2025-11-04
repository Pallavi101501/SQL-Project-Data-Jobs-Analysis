/*
Question : What are the most optimal skills to learn (aka it's in high demand and a high-paying skill)?
- Identify skills in high demand and assosciated with high sversge salaries for Data Analyst roles
- Concentrates on remote positions (India) with specified salaries
- Why? Targets skill that offer job security (high demand) and financial benefits (high salaries),
     offering strategic insights for career development in data analysis.
*/


-- using CTE's and previous queries
WITH skills_demand AS (
    SELECT
        skills_job_dim.skill_id,
        skills,
        COUNT(job_postings_fact.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id 
    WHERE 
        job_title_short = 'Data Analyst' 
        AND job_location LIKE '%India%'
        AND salary_year_avg IS NOT NULL
    GROUP BY 
        skills_job_dim.skill_id,skills
),  average_salary AS(
    SELECT
        skills_job_dim.skill_id,
        skills,
        TO_CHAR(AVG(salary_year_avg), 'FM999,999') AS avg_salary_formatted
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id 
    WHERE 
        job_title_short = 'Data Analyst'
        AND job_location LIKE '%India%'
        AND salary_year_avg IS NOT NULL
    GROUP BY 
        skills_job_dim.skill_id,skills

)
SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary_formatted
FROM skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE demand_count > 25
ORDER BY 
    avg_salary_formatted DESC,
    demand_count DESC
LIMIT 25



-- Concised way of writing the same query
SELECT 
    sjd.skill_id,
    skills,
    COUNT(jpc.job_id) AS demand_count,
    TO_CHAR(AVG(salary_year_avg),'FM999,999') AS avg_salary 
FROM job_postings_fact AS jpc 
INNER JOIN skills_job_dim AS sjd ON jpc.job_id = sjd.job_id
INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE 
    job_title_short = 'Data Analyst'
    AND job_location LIKE '%India%'
    AND salary_year_avg IS NOT NULL
GROUP BY 
    sjd.skill_id,
    skills
HAVING COUNT(jpc.job_id) > 20
ORDER BY 
    avg_salary DESC,
    demand_count DESC
LIMIT 10