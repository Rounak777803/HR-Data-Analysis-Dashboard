select * from hr_data;

-- Check for duplicates
 SELECT Name, Emp_ID, COUNT(*) as count
FROM hr_data
GROUP BY Name, Emp_ID
HAVING count > 1;

-- Check for full-row duplicates 
SELECT Name, Gender, Education_Qualification, Date_of_Join, Job_Title, Salary, Age, Leave_Balance, COUNT(*) as count
FROM hr_data
GROUP BY Name, Gender, Education_Qualification, Date_of_Join, Job_Title, Salary, Age, Leave_Balance
HAVING count > 1;

-- Check for NULL values
SELECT *
FROM hr_data
WHERE Name IS NULL
   OR Emp_ID IS NULL
   OR Gender IS NULL
   OR Education_Qualification IS NULL
   OR Date_of_Join IS NULL
   OR Job_Title IS NULL
   OR Salary IS NULL
   OR Age IS NULL
   OR Leave_Balance IS NULL;
   
-- Check Gender values
SELECT Gender, COUNT(*) as count
FROM hr_data
GROUP BY Gender;

-- Check Education_Qualification values
SELECT Education_Qualification, COUNT(*) as count
FROM hr_data
GROUP BY Education_Qualification;

-- Check Job_Title values
SELECT Job_Title, COUNT(*) as count
FROM hr_data
GROUP BY Job_Title
ORDER BY Job_Title;

-- Check Age, Salary, Leave_Balance ranges
SELECT MIN(Age), MAX(Age), AVG(Age) FROM hr_data;
SELECT MIN(Salary), MAX(Salary), AVG(Salary) FROM hr_data;
SELECT MIN(Leave_Balance), MAX(Leave_Balance), AVG(Leave_Balance) FROM hr_data;

--  Identify outliers
 SELECT Emp_ID, Name, Age, Salary, Leave_Balance
FROM hr_data
WHERE Age > 65 OR Leave_Balance > 30
ORDER BY Age DESC, Leave_Balance DESC;

-- Check Date_of_Join range
SELECT MIN(Date_of_Join), MAX(Date_of_Join) FROM hr_data;
SELECT Emp_ID, Name, Date_of_Join
FROM hr_data
WHERE Date_of_Join > '2025-06-28' OR Date_of_Join < '2000-01-01';

-- Trim whitespace
UPDATE hr_data
SET Name = TRIM(Name),
    Job_Title = TRIM(Job_Title);
    
-- Cap Leave_Balance at 30
UPDATE hr_data
SET Leave_Balance = 30
WHERE Leave_Balance > 30;

select * from hr_data;

-- Verify constraint compliance
SELECT Emp_ID, Name, Salary, Age, Leave_Balance
FROM hr_data
WHERE Salary < 0 
OR Age < 18 
OR Age > 100 
OR Leave_Balance < 0;

UPDATE hr_data
SET Name = TRIM(Name),
    Job_Title = TRIM(Job_Title);



