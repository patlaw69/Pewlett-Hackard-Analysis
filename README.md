# Pewlett-Hackard-Analysis
Create entity relationship diagrams, perform data modeling, and complete analysis on an employee database using SQL techniques.

## Project Overview
This week's lessons centered around Human Resources data for a large company with a great deal of people aging into retirement. In this project, we learned about data modeling, engineering, and analysis. Applying our knowledge of DataFrames and tabular data, we created entity relationship diagrams (ERDs), import data into a database, troubleshot common errors, and created queries that use data to answer questions using SQL.
![EmployeeDB](https://user-images.githubusercontent.com/75762456/109455867-2c408c00-7a1d-11eb-9903-16bc9f970c1e.png)


##Resources:
Data: departments.csv, dept_emp.csv, employees.csv, salaries.csv, dept_manager.csv, titles.csv
Software: postgresql, pgadmin 4, visual studio code

## Results
With the retirment_titles table we are able to see every eligible for retirement employee and how long they have worked at each position over the course of their career.

The unique titles table that we created is showing the most recent title for employees of retirment age.

Our retiring_titles shows us the a majority of the employees of retirment age (57,668/90,398 = 64%) have senior titles.

![Retiring_titles](C:\Users\patla\Class Folder\Resources\retiring_titles)

The final part of our project shows mentorship eligibility, if you look at the head of the new csv - you can see that most of these employees have senior titles.

![Menotor](C:\Users\patla\Class Folder\Resources\mentor_elig)

## Summary
Based on the findings of my analysis Pewlett Hackard is potentially facing over 90,000 vacant positions company wide. Taking into consideration the low amount of employees who are eligible for mentorship, Pewlett hackard will face a great deficit once a majority of eligible employees retire.
