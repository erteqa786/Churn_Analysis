/* Validate Data */

SELECT * FROM customers LIMIT (5);

SELECT COUNT(*) FROM customers;

/* Overall Churn Rate (KPI) */

SELECT 
    ROUND(
        COUNT(*) FILTER (WHERE churn = 'Yes') * 100.0 / COUNT(*), 2
    ) AS churn_rate
FROM customers;

-- Churn by Gender

SELECT 
    gender,
    ROUND(COUNT(*) FILTER (WHERE churn='Yes') * 100.0 / COUNT(*), 2) AS churn_rate
FROM customers
GROUP BY gender;

-- Churn by Age Group

SELECT 
    CASE 
        WHEN age < 30 THEN 'Young Adult'
        WHEN age BETWEEN 30 AND 45 THEN 'Adult'
        WHEN age BETWEEN 46 AND 60 THEN 'Middle-aged'
        ELSE 'Senior'
    END AS age_group,
    ROUND(COUNT(*) FILTER (WHERE churn='Yes') * 100.0 / COUNT(*), 2) AS churn_rate
FROM customers
GROUP BY age_group;

-- AVERAGE MONTHLY CHARGE
SELECT AVG(monthly_charges) FROM customers;

-- Revenue lost due to churn
SELECT SUM(monthly_charges) 
FROM customers
WHERE churn='Yes';

-- Do high-paying customers churn more?

SELECT 
    CASE 
        WHEN monthly_charges < 40 THEN 'Low'
        WHEN monthly_charges BETWEEN 40 AND 80 THEN 'Medium'
        ELSE 'High'
    END AS charge_group,
    ROUND(COUNT(*) FILTER (WHERE churn='Yes') * 100.0 / COUNT(*), 2) AS churn_rate
FROM customers
GROUP BY charge_group;

-- CHURN BY CONTRACT TYPE

SELECT 
    contract_type,
    COUNT(*) AS total,
    ROUND(COUNT(*) FILTER (WHERE churn='Yes') * 100.0 / COUNT(*), 2) AS churn_rate
FROM customers
GROUP BY contract_type
ORDER BY churn_rate DESC;

-- CHURN BY INTERNET SERVICE

SELECT 
    internet_service,
    ROUND(COUNT(*) FILTER (WHERE churn='Yes') * 100.0 / COUNT(*), 2) AS churn_rate
FROM customers
GROUP BY internet_service;

-- COMPLAINTS V/S CHURN

SELECT 
    complaints,
    ROUND(COUNT(*) FILTER (WHERE churn='Yes') * 100.0 / COUNT(*), 2) AS churn_rate
FROM customers
GROUP BY complaints
ORDER BY complaints;

-- SATISFACTION SCORE V/S CHURN

SELECT 
    satisfaction_score,
    ROUND(COUNT(*) FILTER (WHERE churn='Yes') * 100.0 / COUNT(*), 2) AS churn_rate
FROM customers
GROUP BY satisfaction_score
ORDER BY satisfaction_score;

-- CHURN BY PAYMENT METHOD

SELECT 
    payment_method,
    ROUND(COUNT(*) FILTER (WHERE churn='Yes') * 100.0 / COUNT(*), 2) AS churn_rate
FROM customers
GROUP BY payment_method;

-- Which segment has highest churn overall?

SELECT 
    contract_type,
    CASE 
        WHEN age < 30 THEN 'Young Adult'
        WHEN age BETWEEN 30 AND 45 THEN 'Adult'
        WHEN age BETWEEN 46 AND 60 THEN 'Middle-aged'
        ELSE 'Senior'
    END AS age_group,
    ROUND(COUNT(*) FILTER (WHERE churn='Yes') * 100.0 / COUNT(*), 2) AS churn_rate
FROM customers
GROUP BY contract_type, age_group
ORDER BY churn_rate DESC;