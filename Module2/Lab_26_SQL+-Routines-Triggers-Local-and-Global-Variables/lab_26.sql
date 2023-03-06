use employees_mod;

-- Create a procedure that will provide the average salary of all employees.
DELIMITER $$
DROP PROCEDURE IF EXISTS employees_mod.get_employees_avg_salary;
SET GLOBAL log_bin_trust_function_creators = 1;
DELIMITER $$
CREATE PROCEDURE get_employees_avg_salary()
BEGIN
Select avg(salary)
from t_salaries ts;
END
$$ DELIMITER ;
SET GLOBAL log_bin_trust_function_creators = 0;

-- Create a procedure called ‘emp_info’ that uses as 
-- parameters the first and the last name of an individual,
--  and returns their employee number.
DELIMITER $$
DROP PROCEDURE IF EXISTS emp_info;
CREATE PROCEDURE emp_info(IN em_first_name VARCHAR(14),
							IN em_last_name VARCHAR(16),
							OUT em_emp_no INTEGER)
	BEGIN
		SELECT e.emp_no INTO em_emp_no
			FROM t_employees e
            WHERE em_first_name = e.first_name AND em_last_name = e.last_name;
    END $$
DELIMITER ;
 
 -- Call the procedures
 call get_employees_avg_salary();
 call emp_info('Amalendu',	'Nyrup', @emp_no);
select @emp_no;

-- Create a function called ‘emp_info’ that takes for parameters the first and last name
-- of an employee, and returns the salary from the newest contract of that employee. 
-- Hint: In the BEGIN-END block of this program, you need to declare and use two 
-- variables – v_max_from_date that will be of the DATE type, and v_salary, 
-- that will be of the DECIMAL (10,2) type.
DELIMITER $$
CREATE FUNCTION f_emp_info (p_first_name VARCHAR(14), 
							p_last_name VARCHAR(16))
                            RETURNS DECIMAL(10,2)
BEGIN
	DECLARE v_max_from_date DATE;
    DECLARE v_salary DECIMAL(10,2);
    SELECT MAX(from_date) INTO v_max_from_date FROM t_salaries s
		JOIN t_employees e 
			ON e.emp_no = s.emp_no
        WHERE p_first_name = e.first_name 
			AND p_last_name = e.last_name;
    SELECT salary INTO v_salary FROM salaries s 
		JOIN employees e ON e.emp_no = s.emp_no
        WHERE p_first_name = e.first_name
			AND p_last_name = e.last_name 
            AND from_date = v_max_from_date;
    RETURN v_salary;
END$$
DELIMITER ;

-- Create a trigger that checks if the hire date of an employee is higher
-- than the current date. If true, set this date to be the current date. 
-- Format the output appropriately (YY-MM-DD)
DELIMITER $$
CREATE TRIGGER check_hire_date
BEFORE UPDATE ON t_employees
FOR EACH ROW
BEGIN
    IF NEW.hire_date > CURRENT_DATE() THEN
        SET NEW.hire_date = CURRENT_DATE();
    END IF;
END $$
DELIMITER ;

-- Create ‘i_hire_date’ and Drop the ‘i_hire_date’ index.
CREATE INDEX i_hire_date ON t_employees(hire_date);
DROP INDEX i_hire_date ON t_employees;

-- Select all records from the ‘salaries’ table of people whose salary is
-- higher than $89,000 per annum. Then, create an index on the ‘salary’ 
-- column of that table, and check if it has sped up the search of the 
-- same SELECT statement.
SELECT * FROM t_salaries WHERE salary > 89000;
CREATE INDEX i_salary ON t_salaries(salary); #creates an index i_salary on the t_salaries table
EXPLAIN SELECT * FROM t_salaries WHERE salary > 89000; #display info about how server will execute SELECT
SHOW INDEX FROM t_salaries; #display info about i_salary index

-- Use Case statement and obtain a result set containing the employee number, 
-- first name, and last name of all employees with a number higher than 109990.
--  Create a fourth column in the query, indicating whether this employee is also
--  a manager, according to the data provided in the dept_manager table, or a
--  regular employee.
SELECT e.emp_no, e.first_name, e.last_name,
       CASE WHEN dm.emp_no IS NULL THEN 'Regular Employee' #use case to create new column
            ELSE 'Manager' #whether the empl is a man or a regul
       END AS employee_type
FROM t_employees e 
LEFT JOIN t_dept_manager dm  #joins the employee table
ON e.emp_no = dm.emp_no #on emp_no column
WHERE e.emp_no > 109990; #filters the result to include with number > 109990

-- Extract a dataset containing the following information about the managers:
-- employee number, first name, and last name. Add two columns at the end – one 
-- showing the difference between the maximum and minimum salary of that employee,
-- and another one saying whether this salary raise was higher than $30,000 or NOT.
SELECT e.emp_no, e.first_name, e.last_name,
       (MAX(s.salary) - MIN(s.salary)) AS salary_diff, #calculates min and max and store in salary_diff
       CASE WHEN (MAX(s.salary) - MIN(s.salary)) > 30000 THEN 'Yes' #creates new column salary_raise_above
            ELSE 'No' #indicates if the salary raise was > 30 000$ or not
       END AS salary_raise_above_30k
FROM t_employees e #joins the employees table
JOIN t_dept_manager dm 
	ON e.emp_no = dm.emp_no
JOIN t_dept_emp de 
	ON e.emp_no = de.emp_no
JOIN t_salaries s 
	ON e.emp_no = s.emp_no
WHERE dm.to_date = '9999-01-01' #filters the results to only managers currently employed
	AND de.to_date = '9999-01-01' #filters the results to only employees currently employed
GROUP BY e.emp_no; #groups the result by employee number

-- Extract the employee number, first name, and last name of the first 100 employees,
-- and add a fourth column, called “current_employee” saying “Is still employed” if
-- the employee is still working in the company, or “Not an employee anymore” if
-- they aren’t. Hint: You’ll need to use data from both the ‘employees’ and the
-- ‘dept_emp’ table to solve this exercise.
SELECT e.emp_no, e.first_name, e.last_name,
#if function is used to create the curr_empl column which checks the date
       IF(de.to_date = '9999-01-01', 'Is still employed', 'Not an employee anymore') AS current_employee
FROM t_employees e #joins employees table with dept_emp table on emp_no column
JOIN t_dept_emp de ON e.emp_no = de.emp_no
ORDER BY e.emp_no #sorted by employee number 
LIMIT 100; #first 100 rows

