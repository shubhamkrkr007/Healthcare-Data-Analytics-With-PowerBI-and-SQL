1. Total Patients (KPI)
SELECT COUNT(DISTINCT patient_id) AS total_patients
FROM patient_journey_analytics_db.patient_journey_analytics_dataset_csv;


2. Gender Distribution
SELECT gender, COUNT(*) AS patient_count
FROM patient_journey_analytics_db.patient_journey_analytics_dataset_csv
GROUP BY gender;


3. Age Group Segmentation
SELECT 
CASE 
WHEN age < 40 THEN 'Under 40'
WHEN age BETWEEN 40 AND 60 THEN '40-60'
ELSE 'Above 60'
END AS age_group,
COUNT(*) AS patient_count
FROM patient_journey_analytics_db.patient_journey_analytics_dataset_csv
GROUP BY age_group;


4. Most Prescribed Drugs
SELECT drug_name, COUNT(*) AS prescription_count
FROM patient_journey_analytics_db.patient_journey_analytics_dataset_csv
GROUP BY drug_name
ORDER BY prescription_count DESC;


5. Average Adherence by Drug
SELECT drug_name,
AVG(adherence_rate_percent) AS avg_adherence
FROM patient_journey_analytics_db.patient_journey_analytics_dataset_csv
GROUP BY drug_name
ORDER BY avg_adherence DESC;


6. Drug Switching Patterns
SELECT drug_name, switch_drug_name, COUNT(*) AS switch_count
FROM patient_journey_analytics_db.patient_journey_analytics_dataset_csv
WHERE therapy_switch_flag = 1
GROUP BY drug_name, switch_drug_name
ORDER BY switch_count DESC;


7. Treatment Drop-off Analysis
SELECT drop_off_flag, COUNT(*) AS patient_count
FROM patient_journey_analytics_db.patient_journey_analytics_dataset_csv
GROUP BY drop_off_flag;


8. Copay Impact on Adherence
SELECT payer_type,
AVG(adherence_rate_percent) AS avg_adherence,
AVG(copay_amount_usd) AS avg_copay
FROM patient_journey_analytics_db.patient_journey_analytics_dataset_csv
GROUP BY payer_type;


9. Top Doctors by Patient Volume
SELECT doctor_id, COUNT(*) AS patient_count
FROM patient_journey_analytics_db.patient_journey_analytics_dataset_csv
GROUP BY doctor_id
ORDER BY patient_count DESC
LIMIT 10;


10. Hospital Patient Volume
SELECT hospital_id, COUNT(*) AS total_patients
FROM patient_journey_analytics_db.patient_journey_analytics_dataset_csv
GROUP BY hospital_id
ORDER BY total_patients DESC;


11. Treatment Delay (Very Strong Insight)
SELECT 
AVG(DATEDIFF(therapy_start_date, diagnosis_date)) AS avg_days_to_treatment
FROM patient_journey_analytics_db.patient_journey_analytics_dataset_csv;


12. Monthly Therapy Starts (Trend Analysis)
SELECT 
DATE_FORMAT(therapy_start_date,'%Y-%m') AS month,
COUNT(*) AS therapy_starts
FROM patient_journey_analytics_db.patient_journey_analytics_dataset_csv
GROUP BY month
ORDER BY month;


13. ROW_NUMBER (Latest Patient Record)
SELECT *
FROM (
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY patient_id
ORDER BY last_followup_date DESC
) AS rn
FROM patient_journey_analytics_db.patient_journey_analytics_dataset_csv
) t
WHERE rn = 1;


14. Doctor Ranking (Window Function)
SELECT doctor_id,
COUNT(*) AS patient_count,
RANK() OVER (ORDER BY COUNT(*) DESC) AS doctor_rank
FROM patient_journey_analytics_db.patient_journey_analytics_dataset_csv
GROUP BY doctor_id;


15. Patients Above Average Adherence
SELECT *
FROM patient_journey_analytics_db.patient_journey_analytics_dataset_csv
WHERE adherence_rate_percent >
(
SELECT AVG(adherence_rate_percent)
FROM patient_journey_analytics_db.patient_journey_analytics_dataset_csv
);


16. Patients by Medical Condition
SELECT medical_condition,
COUNT(*) AS patient_count
FROM patient_journey_analytics_db.patient_journey_analytics_dataset_csv
GROUP BY medical_condition
ORDER BY patient_count DESC;

17. Adherence by Line of Therapy
SELECT line_of_therapy,
AVG(adherence_rate_percent) AS avg_adherence
FROM patient_journey_analytics_db.patient_journey_analytics_dataset_csv
GROUP BY line_of_therapy
ORDER BY line_of_therapy;

18. Treatment Outcomes
SELECT therapy_outcome,
COUNT(*) AS patient_count
FROM patient_journey_analytics_db.patient_journey_analytics_dataset_csv
GROUP BY therapy_outcome
ORDER BY patient_count DESC;
