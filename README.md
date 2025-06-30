**📊 HR Data Analysis & Dashboard**
This repository showcases an end-to-end Human Resources (HR) data analysis project. The project encompasses rigorous data cleaning and extensive Exploratory Data Analysis (EDA) using SQL, culminating in an interactive dashboard visualization to provide actionable insights into employee demographics, compensation, tenure, and overall workforce health.

**✨ Project Overview**
The primary objective of this project was to leverage HR data to understand key aspects of the workforce, identify trends, and provide data-driven insights to support HR strategic planning and decision-making. The analysis focuses on understanding the distribution of employees, salary structures, leave patterns, and identifying potential areas for HR intervention or improvement.

**🛠️ Technologies & Tools Used**
**MySQL:**
Utilized for comprehensive ETL (Extract, Transform, Load) processes, meticulous data cleaning, and advanced Exploratory Data Analysis (EDA) using complex SQL queries, subqueries, Common Table Expressions (CTEs), and Window Functions.

**Microsoft Power BI:**
Employed for designing and implementing an interactive and visually compelling HR dashboard, incorporating DAX (Data Analysis Expressions) for robust data modeling and analytical calculations.

**SQL (DDL & DML):**
Proficiently used for defining database schemas, loading datasets, and performing intricate data manipulation and querying.

**📊 Key Analytical Steps & Deliverables**
**Data Ingestion & Initial Setup:**

Successfully loaded the hr_data.csv dataset into a MySQL table (hr_data) within the dedicated database.

Rigorous Data Cleaning & Preprocessing (in SQL):

Conducted thorough data validation to identify and address data quality issues, including duplicate records (both key-based and full-row duplicates) and NULL values across all critical columns.

Performed extensive data profiling to understand data ranges and distributions for Age, Salary, and Leave_Balance, setting the foundation for accurate analysis.

Implemented data standardization techniques: Trimmed whitespace from Name and Job_Title to ensure data consistency.

Addressed outliers and constrained data integrity: Capped Leave_Balance at 30 to prevent erroneous high values and verified all numerical constraints (e.g., Salary > 0, Age within reasonable bounds) to guarantee reliable data for analysis.

In-depth Exploratory Data Analysis (EDA) with Advanced SQL:

Analyzed demographic distribution by Gender, Education_Qualification, and custom Age_Group categories, providing detailed workforce segmentation (using CTEs and aggregate functions).

Investigated Salary distribution by Job_Title and Gender, employing window functions (RANK()) to identify salary ranking within gender groups and ensure fair compensation analysis.

Performed comprehensive Tenure Analysis (Years of Service), calculating employee tenure and identifying hiring trends across different Job_Titles over time (using DATEDIFF and DENSE_RANK() window functions).

Examined the relationship between Salary, Education_Qualification, and Years_of_Service, calculating average salaries by education level and highlighting salary deviations from the educational average.

Conducted detailed Leave Balance Analysis, categorizing leave balances into low, medium, and high groups, and identifying top leave-taking employees within job titles (using CTEs and ROW_NUMBER()).

Applied statistical methods for Outlier Detection in Salary and Age using standard deviation (STDDEV), identifying employees with values significantly deviating from the mean.

All analytical queries were meticulously crafted, leveraging complex SQL structures including subqueries, Common Table Expressions (CTEs), and various Window Functions.

Interactive Power BI Dashboard Development:

Designed and implemented a comprehensive and interactive Power BI dashboard (HR Data Analysis Dashboard.png - screenshot to be inserted).

The dashboard visually translates the SQL insights into actionable reports, covering:

Employee Demographics (Gender distribution, Age distribution by gender).

Job Role Distribution (What do Employee do).

Salary vs. Age and Education.

Team Growth Trends (Our Team is continuously growing).

Key HR KPIs (Total Employees, Average Salary, Average Leave Balance, Employees with High Leave Balance).

Utilized DAX formulas for advanced calculations and dynamic aggregations within the dashboard to ensure accurate and flexible reporting.




**💡 Key Learnings & Skills Demonstrated**
Advanced SQL & Database Management: Proficient in complex querying, data manipulation, and database schema management.

Comprehensive Data Cleaning & Preprocessing: Expertise in ensuring data quality and readiness for analysis.

Statistical Analysis & EDA: Skilled in identifying trends, patterns, and outliers for data-driven insights.

Business Intelligence & Data Visualization: Competent in designing and building impactful dashboards with Power BI and DAX.

Problem-Solving & Critical Thinking: Addressed specific HR analytical questions and derived actionable conclusions.

Data Storytelling: Translated technical analysis into clear, understandable business insights.
