-- Создаём таблицы, загружаем данные
CREATE TABLE IF NOT EXISTS employee (
                                        name string,
                                        work_place ARRAY<string>,
                                        gender_age STRUCT<gender:string,age:int>,
                                        skills_score MAP<string,int>,
                                        depart_title MAP<STRING,ARRAY<STRING>>
)
--     PARTITIONED BY (year INT, month INT)
    ROW FORMAT DELIMITED
        FIELDS TERMINATED BY '|'
        COLLECTION ITEMS TERMINATED BY ','
        MAP KEYS TERMINATED BY ':'
    STORED AS TEXTFILE;

-- INSERT INTO employee_part PARTITION (year=2020, month=12) SELECT * from employee where name = 'Will';
LOAD DATA LOCAL INPATH '/employee/employee.txt' OVERWRITE INTO TABLE employee;

CREATE TABLE IF NOT EXISTS employee_hr
(
    name string,
    employee_id int,
    sin_number string,
    start_date date
)
    ROW FORMAT DELIMITED
        FIELDS TERMINATED BY '|'
    STORED AS TEXTFILE;

LOAD DATA LOCAL INPATH '/employee/employee_hr.txt' OVERWRITE INTO TABLE employee_hr;

--
CREATE TABLE IF NOT EXISTS employee_contract
(
    name string,
    dept_num int,
    employee_id int,
    salary int,
    type string,
    start_date date
)
    ROW FORMAT DELIMITED
        FIELDS TERMINATED BY '|'
    STORED AS TEXTFILE;

LOAD DATA LOCAL INPATH '/employee/employee_contract.txt' OVERWRITE INTO TABLE employee_contract;

select * from employee
where gender_age.gender = 'Female' and gender_age.age < 30;

select name, skills_score["DB"] as DB, skills_score["Python"] as Python from employee;

select name, depart_title['Product'][0] as Product_role, depart_title['Test'][0] as Test_role from employee;

create table emploee_cte as
with r1 as (select name from employee where gender_age.gender = 'Male'),
     r2 as (select name from r1 where name = 'Michael'),
     r3 as (select name from employee where gender_age.gender = 'Female')
select * from r2 union all select * from r3;

select
    CASE
        when gender_age.gender = 'Female'
            then 'Ms.'
        else 'Mr.'
        END as prefix,
    name,
    IF(array_contains(work_place, 'New York'), 'US', 'CA') as country
from employee;

select avg(CASE WHEN gender_age.gender = 'Female' AND gender_age.age is not null THEN gender_age.age ELSE 0) as avg_female,
       avg(CASE WHEN gender_age.gender = 'Male' AND gender_age.age is not null THEN gender_age.age ELSE 0) as avg_male,
from employee

