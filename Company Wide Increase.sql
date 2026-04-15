SELECT employee_id, pay_level, salary,
IF(pay_level = 1, salary+salary*0.1, pay_level=2, salary+salary*0.15, salary+salary) AS new_salary
FROM employees;



SELECT employee_id, pay_level, salary,
WHERE (pay_level = 1, salary+salary*0.1) AS new_salary

FROM employees;


##final correct solutipons below.##

SELECT 
    employee_id,
    pay_level,
    salary,
    IF (pay_level = 1, salary * 1.10,
        IF(pay_level = 2, salary * 1.15,
            IF(pay_level = 3, salary * 3.00, salary))) AS new_salary
FROM employees;

#-------------------------------------
#Below using IF clause along with ROUND function

SELECT 
    employee_id,
    pay_level,
    salary,
    IF(pay_level = 1, ROUND(salary * 1.10),
        IF(pay_level = 2, ROUND(salary * 1.15),
            IF(pay_level = 3, ROUND(salary * 3.00), salary)
        )
    ) AS new_salary
FROM employees;

#-------------------------------------
# Below using CASE function or clause

SELECT 
    employee_id,
    pay_level,
    salary,
    CASE
        WHEN pay_level = 1 THEN ROUND(salary * 1.10)
        WHEN pay_level = 2 THEN ROUND(salary * 1.15)
        WHEN pay_level = 3 THEN ROUND(salary * 3.00)
        ELSE salary
    END AS new_salary
FROM employees;

# Solution from Instructor is below

SELECT *, CASE
    WHEN Pay_Level = 1 THEN Salary * 1.1
    WHEN Pay_Level = 2 THEN Salary * 1.15
    WHEN Pay_Level = 3 THEN Salary * 3
    ELSE Salary
END as new_salary
FROM employees;



