--Deliverable 1: The Number of Retiring Employees by Title
SELECT	e.emp_no,
		e.first_name,
		e.last_name,
		ts.title,
		ts.from_date,
		ts.to_date
INTO retirement_titles
FROM employees as e
    INNER JOIN titles as ts
	    ON (e.emp_no = ts.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
		first_name,
		last_name,
		title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

-- Retrive number of retirees per title
SELECT COUNT (emp_no), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT DESC;

--Deliverable 2: The Employees Eligible for the Mentorship Program
SELECT DISTINCT ON (e.emp_no, de.emp_no, ts.emp_no)	e.emp_no,
		e.first_name,
		e.last_name,
		e.birth_date,
		de.from_date,
		de.to_date,
		ts.title
INTO mentorship_eligibility
FROM employees as e
	INNER JOIN dept_emp as de
		ON (e.emp_no = de.emp_no)
	INNER JOIN titles as ts
		ON (e.emp_no = ts.emp_no)
WHERE (de.to_date = '9999-01-01')
	AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;
