---Question 1
---What is the total number of applicants for each contract type?
SELECT NAME_CONTRACT_TYPE, COUNT(*) AS total_applicants
FROM application_train
GROUP BY NAME_CONTRACT_TYPE;

---Question 2 (redo)
---What is the average income of male and female applicants?
SELECT code_gender, AVG(amt_income_total) AS avg_income
FROM application_train
GROUP BY code_gender;


---Question 3 (redo)
---How many applicants own a car or real estate, and how many do not?
SELECT FLAG_OWN_CAR AS owns_car, 
       FLAG_OWN_REALTY AS owns_realty, 
       COUNT(*) AS total_applicants
FROM application_train
GROUP BY FLAG_OWN_CAR, FLAG_OWN_REALTY;



---Question 4
---Which applicants have the highest credit amount, and what are their details?
SELECT *
FROM application_train
WHERE AMT_CREDIT = (SELECT MAX(AMT_CREDIT) FROM application_train);

---Question 5
---What is the distribution of total income among applicants with children?
SELECT CNT_CHILDREN, AVG(AMT_INCOME_TOTAL) AS avg_income
FROM application_train
GROUP BY CNT_CHILDREN
ORDER BY CNT_CHILDREN;

---Question 6
---What is the relationship between applicants' income and their credit amount (joined data)?
SELECT AMT_INCOME_TOTAL, AMT_CREDIT, (AMT_CREDIT / AMT_INCOME_TOTAL) AS credit_to_income_ratio
FROM application_train
WHERE AMT_INCOME_TOTAL > 0; 

---Question 7 
---Who are the defaulters, and what are their basic statistics?
SELECT COUNT(*) AS total_defaulters, 
       AVG(AMT_CREDIT) AS avg_credit_defaulters, 
       AVG(AMT_INCOME_TOTAL) AS avg_income_defaulters
FROM application_train
WHERE TARGET = '1';

--Question 8
--What are the top three most common income amounts among applicants?
SELECT AMT_INCOME_TOTAL, COUNT(*) AS frequency
FROM application_train
GROUP BY AMT_INCOME_TOTAL
ORDER BY frequency DESC
LIMIT 3;

---Question 9 (redo)
----What percentage of male vs. female applicants owns a car?
SELECT code_gender,
       ROUND(SUM(CASE WHEN flag_own_car = 'Y' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS percentage_owns_car
FROM application_train
GROUP BY code_gender;


---Question 10 (redo) 
---Which applicants have the largest difference between their credit amount and their income?
SELECT sk_id_curr,
       amt_income_total, 
       amt_credit, 
       (amt_credit - amt_income_total) AS credit_income_difference
FROM application_train
ORDER BY credit_income_difference DESC
LIMIT 5;
