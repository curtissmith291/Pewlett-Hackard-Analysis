SELECT employees.emp_no, employees.first_name, employees.last_name,
	titles.title, titles.from_date, titles.to_date
INTO retirement_titles
FROM employees
	LEFT JOIN titles
	ON employees.emp_no = titles.emp_no
WHERE (employees.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no ASC, to_date DESC;

-- Retrieves the number of employees by their most recent job title who are about to retire
SELECT COUNT(unique_titles) AS number_of_titles, title 
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY number_of_titles DESC;

SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, 
d.from_date, d.to_date,
titles.title
INTO mentorship_eligibility
FROM employees AS e
	JOIN dept_emp AS d
	ON e.emp_no = d.emp_no
	JOIN titles
	ON e.emp_no = titles.emp_no
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31') and (d.to_date = '9999-01-01')
ORDER BY emp_no;