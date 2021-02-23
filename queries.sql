-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

CREATE TABLE employees (
	emp_no INT NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	gender VARCHAR NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no)
);

CREATE TABLE manager (
dept_no VARCHAR(4) NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);

DROP TABLE dept_employees;

CREATE TABLE dept_emp (
 	emp_no INT NOT NULL,
	dept_no VARCHAR(4) NOT NULL,
	from_date DATE NOT NULL,
 	to_date DATE NOT NULL,
 	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE titles (
	emp_no INT NOT NULL,
 	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
  	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
 	PRIMARY KEY (emp_no, title, from_date)
);

SELECT * FROM dept_employees;

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31'

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31'

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31'

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31'

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Retirement eligibility
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Retirement eligibility
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

DROP TABLE retirement_info;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;


-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     manager.emp_no,
     manager.from_date,
     manager.to_date
FROM departments
INNER JOIN manager
ON departments.dept_no = manager.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
	retirement_info.first_name,
retirement_info.last_name,
	dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

-- Joining retirement_info and dept_emp tables
SELECT ri.emp_no,
	ri.first_name,
ri.last_name,
	de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no;

-- Joining departments and dept_manager tables
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN manager as dm
ON d.dept_no = dm.dept_no;


SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- Employee count by department number
select count(ce.emp_no), de.dept_no
into emp_count_by_dept_no
from current_emp as ce
left join dept_emp as de
on ce.emp_no = de.emp_no
group by de.dept_no
order by de.dept_no;

-- Create the 1st List: Employee Information
select e.emp_no, 
	e.first_name, 
	e.last_name,
	e.gender,
	s.salary,
	de.to_date
into emp_info
from employees as e
	inner join salaries as s
		on (e.emp_no = s.emp_no)
	inner join dept_emp as de
		on (e.emp_no = de.emp_no)
where (e.birth_date between '1952-01-01' and '1955-12-31')
	and (e.hire_date between '1985-01-01' and '1988-12-31')
	and (de.to_date = '9999-01-01');

-- Create the 2nd List: Management
select mgr.dept_no,
	dpt.dept_name,
	mgr.emp_no,
	ce.last_name,
	ce.first_name,
	mgr.from_date,
	mgr.to_date
into manager_info
from managers as mgr
	inner join departments as dpt
		on (mgr.dept_no = dpt.dept_no)
	inner join current_emp as ce
		on (mgr.emp_no = ce.emp_no);
		
-- Create the 3rd List: Department Retirees
select ce.emp_no,
	ce.first_name,
	ce.last_name,
	dpt.dept_name
into dept_info
from current_emp as ce
	inner join dept_emp as de
		on (ce.emp_no = de.emp_no)
	inner join departments as dpt
		on (de.dept_no = dpt.dept_no);
        
-- Skill Drill 7.3.6: Create a query that returns the info relevant to the Sales Team
-- Requested list includes: employee numbers, first name, last name, department name
select ce.emp_no,
	ce.first_name,
	ce.last_name,
	de.dept_no,
	dpt.dept_name
from current_emp as ce
	inner join dept_emp as de
		on (ce.emp_no = de.emp_no)
	inner join departments as dpt
		on (de.dept_no = dpt.dept_no)
where dept_name = 'Sales';

-- Skill Drill 7.3.6: Create a query that returns the following info for the Sales & Development Teams
-- Requested list includes: employee numbers, first name, last, department name
select ce.emp_no,
	ce.first_name,
	ce.last_name,
	de.dept_no,
	dpt.dept_name
from current_emp as ce
	inner join dept_emp as de
		on (ce.emp_no = de.emp_no)
	inner join departments as dpt
		on (de.dept_no = dpt.dept_no)
where dept_name in ('Sales', 'Development');