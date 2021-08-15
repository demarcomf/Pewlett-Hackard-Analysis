--Deliverable 1 number of retiring employees by title
--select employee numbers and names from employees table
SELECT e.emp_no,
e.first_name,
e.last_name,
--select titles and hiring/employment lengths from the title table
t.title,
t.from_date,
t.to_date
--create new retirement_titles table based off the inner join selection
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS t
--join both tables on the primary keys
ON (e.emp_no = t.emp_no)
--filter the data for those born between 52 and 55
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
--order employees by their employee number
ORDER BY emp_no ASC;

--print out check for accuracy
SELECT * FROM retirement_titles;

-- Use Distinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles AS rt
ORDER BY emp_no ASC, to_date DESC;

--print out check for accuracy
SELECT * FROM retirement_titles;

--group the retiring tables by title
SELECT COUNT(ut.emp_no), ut.title
--export into new retiring_titles table
INTO retiring_titles
FROM unique_titles as ut
GROUP BY title 
--sort the column in descending order
ORDER BY COUNT(title) DESC;

--print out check for accuracy
SELECT * FROM retiring_titles;

--Deliverable 2 - query to create mentorship elegibility table for current employees
--born between 1/1/65 and 12/31/65
SELECT DISTINCT ON(e.emp_no)e.emp_no,
--selections from employee table, name and birth date
e.first_name,
e.last_name,
e.birth_date,
--selections from department employee, employment dates
de.from_date,
de.to_date,
t.title
--create new mentor_eligiblity table based off the inner join selection
INTO mentor_eligibility
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1962-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
--order by employee number for this table
ORDER BY emp_no;

SELECT * FROM mentor_eligibility;
