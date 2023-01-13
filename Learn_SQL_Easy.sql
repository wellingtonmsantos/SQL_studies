-- SQL Practice - Dificult (Easy) - https://www.sql-practice.com/ 
--1 Show first name, last name, and gender of patients who's gender is 'M'
SELECT first_name, last_name, gender
FROM patients
where gender = 'M'


--2 Show first name and last name of patients who does not have allergies. (null)
SELECT 
	first_name, 
    last_name
FROM patients
WHERE allergies is NULL;

--3 Show first name of patients that start with the letter 'C'
SELECT 
	first_name 
FROM patients
WHERE first_name LIKE 'c%';

-- 4 Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)
SELECT 
	first_name,
    last_name
FROM patients
WHERE weight BETWEEN 100 AND 120;

--5 Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'
UPDATE patients
    SET allergies = 'NKA'
    WHERE allergies is NULL;

--6 Show first name and last name concatinated into one column to show their full name.
SELECT CONCAT(first_name,' ', last_name) AS full_name
FROM patients;

--7 Show first name, last name, and the full province name of each patient.
SELECT first_name, last_name, province_name
FROM patients
join province_names on province_names.province_id = patients.province_id;

-- 8  Show how many patients have a birth_date with 2010 as the birth year.
select COUNT(birth_date) as total
FROM patients
WHERE YEAR(birth_date) = 2010;

-- 9 Show the first_name, last_name, and height of the patient with the greatest height.
select first_name, last_name, MAX(height)
FROM patients


-- 10 Show all columns for patients who have one of the following patient_ids:
1,45,534,879,1000
select *
from patients
where patient_id in (1, 45, 534, 879, 1000)


--11 Show the total number of admissions
select count(*) as total_admissions
from admissions


--12 Show all the columns from admissions where the patient was admitted and discharged on the same day.
select * 
from admissions 
where admission_date = discharge_date;


-- Write a query to find list of patients first_name, last_name, and allergies from Hamilton where allergies are not null
select first_name, last_name, allergies
from patients
where city = 'Hamilton' and allergies is not null


-- Based on cities where our patient lives in, write a query to display the list of unique
-- city starting with a vowel (a, e, i, o, u). Show the result order in ascending by city.
SELECT distinct(city) FROM patients
WHERE city LIKE 'A%'
OR city like 'E%'
OR city like 'I%'
OR city like 'O%'
OR city like 'U%'
order by city asc


















