-- SQL Practice - Dificult (Medium) - https://www.sql-practice.com/ 

-- Show unique birth years from patients and order them by ascending.
SELECT distinct(year(birth_date)) FROM patients
order by birth_date asc

--Show unique first names from the patients table which only occurs once in the list.
--For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list. 
--If only 1 person is named 'Leo' then include them in the output.
SELECT DISTINCT(first_name) 
FROM patients
group by first_name
having count(first_name) = 1

-- Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.
SELECT patient_id, first_name 
FROM patients
WHERE first_name LIKE 's____%s';

--Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.
--Primary diagnosis is stored in the admissions table.
SELECT 
	p.patient_id,
	p.first_name, 
	p.last_name
FROM patients as p 
	join admissions AS a 
    on a.patient_id = p.patient_id
where a.diagnosis = 'Dementia'

--Display every patient's first_name.
--Order the list by the length of each name and then by alphbetically
select first_name
from patients
order by len(first_name), first_name ASC

--Show the total amount of male patients and the total amount of female patients in the patients table.
--Display the two results in the same row.
select
	(select count(*) from patients WHERE gender = 'M') as male_count,
	(select count(*) from patients WHERE gender = 'F') as female_count

-- Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
select  
	patient_id, 
	diagnosis 
from admissions 
group by 
	patient_id,
    diagnosis
having count(*) >1;

-- I found out that the admission table has an patient id  
select  p.patient_id, diagnosis as a
from patients as p
join admissions on admissions.patient_id = p.patient_id
group by 
diagnosis,
p.patient_id
having count(*) >1;

--Show the city and the total number of patients in the city. 
--Order from most to least patients and then by city name ascending.

SELECT 
	city, 
	COUNT(patient_id) 
FROM patients
group by city
order by count(patient_id) desc, city asc;

--Show first name, last name and role of every person that is either patient or doctor.
--The roles are either "Patient" or "Doctor"
select first_name, last_name ,'Patient' from patients
union All
select first_name, last_name,'Doctor' FROM doctors

--We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, 
--then first_name in all lower case letters. Separate the last_name and first_name with a comma. 
--Order the list by the first_name in decending order
--eX: SMITH,jane

select COncat(upper(last_name), ',' ,LOWER(first_name)) as full_name
from patients
order by first_name desc

--Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. 
--Sort the list starting from the earliest birth_date.

select 
	first_name, 
	last_name, 
	birth_date
from patients
where
	year(birth_date) between 1970 AND 1979
order by birth_date ASC

--display the number of duplicate patients based on their first_name and last_name.
select 
	first_name, 
    last_name,
    COUNT(*) AS OCURRENCA
FROM patients
group by 
	first_name, 
    last_name
having count(*) > 1

-- Having keeps the group which have moren than one occurence, 
-- Having clause was created because it can not be used with WHERE

--Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.
select 
    p.province_id,
    sum(height) as sum_height
from patients as p 
join province_names as pn on pn.province_id = p.province_id
group by province_name
having  sum_height >= 7000

-- As is possible to aggregate using province_id, there is no necessity to use the clause JOIN even though works 
select 
p.province_id,
sum(height) as sum_height
from patients as p 
group by province_id
having  sum_height >= 7000

-- For every admission, display the patient's full name, their admission diagnosis, 
-- and their doctor's full name who diagnosed their problem.
select 
	concat(p.first_name, ' ', p.last_name) as patient_full_name,
	a.diagnosis,
	concat(d.first_name, ' ', d.last_name) as doctors_full_name
from patients as p 
	join doctors as d on a.attending_doctor_id = d.doctor_id
	join admissions as a on a.patient_id = p.patient_id

--Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni' 
select max(weight) - min(weight) as difference_weight
from patients
where last_name ='Maroni'   

-- Show all of the days of the month (1-31) and how many admission_dates occurred on that day. 
--Sort by the day with most admissions to least admissions.
select 
DAY(admission_date) as day_number,
count(*) as number_of_admissions
from admissions
group by day_number
order by number_of_admissions desc


-- Display the total amount of patients for each province. Order by descending.
select province_name, count(*) patient_counting
from patients
join province_names on patients.province_id = province_names.province_id
group by province_name 
order by patient_counting desc


-- Show all columns for patient_id 542's most recent admission_date.
 select *
    from admissions
    where patient_id = '542'
    group by patient_id
    having admission_date = max(admission_date)

--Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
--1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
--2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.

	select 
	patient_id, 
	attending_doctor_id, 
	diagnosis
	from admissions
	where 
	(
		attending_doctor_id in (1,5,19)
		and patient_id % 2 != 0 
	)
	or 
	(
		attending_doctor_id like '%2%' 
		and len(patient_id) = 3
	)

--Show first_name, last_name, and the total number of admissions attended for each doctor.
--Every admission has been attended by a doctor.

select first_name, last_name, count(admission_date) AS number_of_admissions
from admissions
join doctors on admissions.attending_doctor_id = doctors.doctor_id
group by attending_doctor_id

	select
		doctor_id,
		first_name || ' ' || last_name as full_name,
		min(admission_date) as first_admission_date,
		max(admission_date) as last_admission_date
	rom admissions a
		join doctors ph on a.attending_doctor_id = ph.doctor_id
	roup by doctor_id;