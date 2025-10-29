/*
Question : What skills are required for the top-paying data analyst jobs?
- Use the top 10 highest-paying Data Analyst jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills,
 helping job seekers understand which skills to develop that align with top salaries
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
    WHERE 
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON skills_job_dim.job_id = top_paying_jobs.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id 
ORDER BY 
    salary_year_avg DESC

/*
 Most commonly required skills (Top skills)
- SQL (8 mentions): The backbone of data querying and manipulation. Almost every role expects SQL proficiency.
- Python (7 mentions): Essential for data analysis, automation, and machine learning tasks.
- Tableau (6 mentions): A leading data visualization tool, crucial for communicating insights.
- R (4 mentions): Preferred for statistical analysis and academic-style data work.
- Excel (3 mentions): Still a staple for quick analysis and reporting.
- Snowflake, Pandas, Power BI, Azure, AWS (2–3 mentions each): These reflect the growing demand for cloud-based 
  data warehousing and advanced analytics.

*/