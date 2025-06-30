-- Demographic Distribution (Gender, Education, Age)
WITH AgeGroups AS (
    SELECT 
        Emp_ID,
        Gender,
        Education_Qualification,
        CASE 
            WHEN Age < 30 THEN 'Under 30'
            WHEN Age BETWEEN 30 AND 40 THEN '30-40'
            WHEN Age BETWEEN 41 AND 50 THEN '41-50'
            ELSE 'Over 50'
        END AS Age_Group
    FROM hr_data
)
SELECT 
    Gender,
    Education_Qualification,
    Age_Group,
    COUNT(*) AS Employee_Count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS Percentage
FROM AgeGroups
GROUP BY Gender, Education_Qualification, Age_Group
ORDER BY Gender, Education_Qualification, Age_Group;

-- Salary Distribution by Job Title and Gender
WITH SalaryStats AS (
    SELECT 
        Job_Title,
        Gender,
        ROUND(AVG(Salary), 2) AS Avg_Salary,
        COUNT(*) AS Employee_Count,
        RANK() OVER (PARTITION BY Gender ORDER BY AVG(Salary) DESC) AS Salary_Rank
    FROM hr_data
    GROUP BY Job_Title, Gender
)
SELECT 
    Job_Title,
    Gender,
    Avg_Salary,
    Employee_Count,
    Salary_Rank
FROM SalaryStats
WHERE Employee_Count >= 3 -- Filter for roles with sufficient sample size
ORDER BY Gender, Salary_Rank;

-- Tenure Analysis (Years of Service)
WITH Tenure AS (
    SELECT 
        Emp_ID,
        Name,
        Job_Title,
        Date_of_Join,
        ROUND(DATEDIFF('2025-06-28', Date_of_Join) / 365.25, 1) AS Years_of_Service
    FROM hr_data
),
HiringTrends AS (
    SELECT 
        YEAR(hr_data.Date_of_Join) AS Hire_Year,
        hr_data.Job_Title,
        COUNT(*) AS Hires,
        AVG(Tenure.Years_of_Service) AS Avg_Tenure
    FROM hr_data
    JOIN Tenure USING (Emp_ID)
    GROUP BY YEAR(hr_data.Date_of_Join), hr_data.Job_Title
)
SELECT 
    Hire_Year,
    Job_Title,
    Hires,
    Avg_Tenure,
    DENSE_RANK() OVER (PARTITION BY Hire_Year ORDER BY Hires DESC) AS Hire_Rank
FROM HiringTrends
ORDER BY Hire_Year, Hires DESC;



-- Salary vs. Education and Experience
 WITH EmployeeStats AS (
    SELECT 
        Emp_ID,
        Education_Qualification,
        Job_Title,
        Salary,
        ROUND(DATEDIFF('2025-06-28', Date_of_Join) / 365.25, 1) AS Years_of_Service,
        AVG(Salary) OVER (PARTITION BY Education_Qualification) AS Avg_Salary_by_Education
    FROM hr_data
)
SELECT 
    Education_Qualification,
    Job_Title,
    COUNT(*) AS Employee_Count,
    ROUND(AVG(Salary), 2) AS Avg_Salary,
    ROUND(AVG(Years_of_Service), 1) AS Avg_Tenure,
    ROUND(AVG(Salary - Avg_Salary_by_Education), 2) AS Salary_Diff_from_Edu_Avg
FROM EmployeeStats
WHERE Years_of_Service > 0
GROUP BY Education_Qualification, Job_Title
HAVING Employee_Count >= 3
ORDER BY Education_Qualification, Avg_Salary DESC;

-- Leave Balance Analysis
WITH LeaveCategories AS (
    SELECT 
        Emp_ID,
        Name, -- Added Name column
        Job_Title,
        Age,
        Leave_Balance,
        CASE 
            WHEN Leave_Balance <= 10 THEN 'Low (0-10)'
            WHEN Leave_Balance <= 20 THEN 'Medium (11-20)'
            ELSE 'High (21+)'
        END AS Leave_Category,
        ROW_NUMBER() OVER (PARTITION BY Job_Title ORDER BY Leave_Balance DESC) AS Leave_Rank
    FROM hr_data
)
SELECT 
    Job_Title,
    Leave_Category,
    COUNT(*) AS Employee_Count,
    ROUND(AVG(Age), 1) AS Avg_Age,
    ROUND(AVG(Leave_Balance), 1) AS Avg_Leave_Balance,
    (SELECT lc2.Name 
     FROM LeaveCategories lc2 
     WHERE lc2.Job_Title = LeaveCategories.Job_Title 
     AND lc2.Leave_Rank = 1) AS Top_Leave_Employee
FROM LeaveCategories
GROUP BY Job_Title, Leave_Category
ORDER BY Job_Title, Leave_Category;


-- Outlier Detection (High Salaries and Ages)
WITH Stats AS (
    SELECT 
        AVG(Salary) AS Avg_Salary,
        STDDEV(Salary) AS Std_Salary,
        AVG(Age) AS Avg_Age,
        STDDEV(Age) AS Std_Age
    FROM hr_data
)
SELECT 
    h.Emp_ID,
    h.Name,
    h.Job_Title,
    h.Salary,
    h.Age,
    CASE 
        WHEN h.Salary > (s.Avg_Salary + 2 * s.Std_Salary) THEN 'High Salary'
        WHEN h.Age > (s.Avg_Age + 2 * s.Std_Age) THEN 'High Age'
        ELSE 'Normal'
    END AS Outlier_Type
FROM hr_data h
CROSS JOIN Stats s
WHERE h.Salary > (s.Avg_Salary + 2 * s.Std_Salary)
   OR h.Age > (s.Avg_Age + 2 * s.Std_Age)
ORDER BY h.Salary DESC, h.Age DESC;

-- Validate Top Employee
SELECT Name, Job_Title, Leave_Balance
FROM hr_data
WHERE Job_Title = 'Chocolatier'
ORDER BY Leave_Balance DESC LIMIT 1;



