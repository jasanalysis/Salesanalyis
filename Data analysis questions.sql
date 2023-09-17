-- QUESTIONS : 

-- 1. What is the gender breakdown of employees in the company?

SELECT gender , COUNT(*) AS count
from hr
WHERE termdate = ''
group by gender;

-- 2. What is the ethnicity breakdown of employees?

Select race, COUNT(*) as ethnicity_count
from hr
WHERE termdate = ''
GROUP BY race
ORDER BY ethnicity_count DESC;

-- 3. What is the age distribution of employees in the company?

SELECT min(age) as youngest,
max(age) as oldest 
from hr;

SELECT CASE
WHEN age >= 21 and age <= 30 THEN '21-30'
WHEN age >= 31 and age <= 40 THEN '31-40'
WHEN age >=41 and age<= 50 THEN '41-50'
ELSE '51+'
END AS age_group, gender,
COUNT(*) as number_of_employees
from hr
where termdate = ''
group by age_group, gender
ORDER BY age_group, gender;


-- 4 . How many people work at headquarters vs remote locations ? 

SELECT location, count(*) as emp_dist
from hr 
where termdate = ''
group by location;

-- 5 What is the average length of employment for employees who have been terminated?
SELECT avg(datediff(termdate, hire_date))/365 AS len_of_employment from hr
WHERE termdate < curdate() AND termdate != '';

-- 6 How does the gender distribution vary across departments  ?

Select department, gender, count(*) as employees
from hr
where termdate = ''
group by department, gender
order by department;

-- 7. How does the employment distribution vary across job titles?

Select jobtitle, count(*) as emp
from hr
where termdate = ''
group by jobtitle
order by emp desc;

-- 8 Which department has the highest turnover rate?

SELECT department, total_count, terminated_count, terminated_count/total_count as termination_rate
FROM (
Select department, count(*) as total_count, 
sum(case when termdate != '' AND termdate <= curdate() THEN 1 ELSE 0 END) AS terminated_count
FROM hr
GROUP BY department) AS subquery
ORDER BY termination_rate DESC;


-- 9 What is the distribution of employees across locations by city and state ?
SELECT location_state, count(*) as number_of_emp
from hr
where termdate = ''
group by location_state
order by number_of_emp DESC;


-- 10 How has the company's employee count changed over time based on hire date and term date?

Select year, hires, terminations, (hires - terminations) as net_change ,round((hires - terminations)/hires * 100 , 2) as net_change_percent 
from (
SELECT YEAR(hire_date) as year,
count(*) as hires,
SUM(CASE WHEN termdate != '' AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminations
from hr
group by YEAR(hire_date) ) AS subquery
ORDER BY year ASC;


-- 11. What is the tenure distribution for each department??

Select department, round(avg(datediff(termdate, hire_date)), 2) AS avg_tenure
from hr
where termdate != '' AND termdate <= curdate()
group by department;



