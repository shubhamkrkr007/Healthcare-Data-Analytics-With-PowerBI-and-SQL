SQL Analysis Queries

---1. Total Tests & Total Revenue
SELECT 
COUNT(Test_ID) AS Total_Tests,
SUM(Revenue_INR) AS Total_Revenue
FROM healthcare_kpi_db.healthcare_diagnostic_mock_data_csv;

---2.Test Volume by Test Type
SELECT 
Test_Type,
COUNT(*) AS Total_Tests,
SUM(Revenue_INR) AS Total_Revenue
FROM healthcare_kpi_db.healthcare_diagnostic_mock_data_csv
GROUP BY Test_Type
ORDER BY Total_Revenue DESC;

---3.Revenue by Country
SELECT 
Country,
COUNT(Test_ID) AS Total_Tests,
SUM(Revenue_INR) AS Total_Revenue
FROM healthcare_kpi_db.healthcare_diagnostic_mock_data_csv
GROUP BY Country
ORDER BY Total_Revenue DESC;

---4. Region Performance
SELECT 
Region,
COUNT(Test_ID) AS Total_Tests,
SUM(Revenue_INR) AS Revenue
FROM healthcare_kpi_db.healthcare_diagnostic_mock_data_csv
GROUP BY Region
ORDER BY Revenue DESC;

---5. Referral Source Contribution
SELECT 
Referral_Source,
COUNT(Test_ID) AS Total_Tests,
SUM(Revenue_INR) AS Revenue
FROM healthcare_kpi_db.healthcare_diagnostic_mock_data_csv
GROUP BY Referral_Source
ORDER BY Revenue DESC;

---6. Payment Type Distribution
SELECT 
Payment_Type,
COUNT(Test_ID) AS Tests,
SUM(Revenue_INR) AS Revenue
FROM healthcare_kpi_db.healthcare_diagnostic_mock_data_csv
GROUP BY Payment_Type;

---7. Average Turnaround Time
SELECT 
AVG(Turnaround_Days) AS Avg_Turnaround_Days
FROM healthcare_kpi_db.healthcare_diagnostic_mock_data_csv;

---8. Top 5 Revenue Generating Test Types
SELECT 
Test_Type,
SUM(Revenue_INR) AS Revenue
FROM healthcare_kpi_db.healthcare_diagnostic_mock_data_csv
GROUP BY Test_Type
ORDER BY Revenue DESC
LIMIT 5;