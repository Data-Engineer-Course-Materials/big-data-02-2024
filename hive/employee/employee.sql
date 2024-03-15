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
       avg(CASE WHEN gender_age.gender = 'Male' AND gender_age.age is not null THEN gender_age.age ELSE 0) as avg_male
from employee;

select name, dept_num, salary,
       count(*) over (PARTITION BY dept_num) as empl_count_dept,
       sum(salary) over (PARTITION BY dept_num) as dept_salary_sum,
       sum(salary) over (PARTITION BY dept_num ORDER BY dept_num) as dept_salary_sum2
from employee_contract
ORDER BY dept_num, name;

select name, dept_num, salary,
       row_number() over (PARTITION BY dept_num ORDER BY name) rn,
       rank() over (PARTITION BY dept_num ORDER BY salary) rk
from employee_contract
ORDER BY dept_num, name;

select name, dept_num, salary,
       lag(salary, 1) over (PARTITION BY dept_num ORDER BY salary) lag,
       lead(salary, 1) over (PARTITION BY dept_num ORDER BY salary) lead
from employee_contract
ORDER BY dept_num, name;

CREATE TABLE IF NOT EXISTS employee_part (
                                             name string,
                                             work_place ARRAY<string>,
                                             gender_age STRUCT<gender:string,age:int>,
                                             skills_score MAP<string,int>,
                                             depart_title MAP<STRING,ARRAY<STRING>>
)
    PARTITIONED BY (year INT, month INT)
    ROW FORMAT DELIMITED
        FIELDS TERMINATED BY '|'
        COLLECTION ITEMS TERMINATED BY ','
        MAP KEYS TERMINATED BY ':'
    STORED AS TEXTFILE;

INSERT INTO employee_part PARTITION (year=2020, month=12) SELECT * from employee where name = 'Will';
LOAD DATA LOCAL INPATH '/employee/employee.txt' OVERWRITE INTO TABLE employee_part PARTITION (year=2024, month=03);

create external table airports (
                                   ident String,
                                   type String,
                                   name string,
                                   elevation_ft String,
                                   continent String,
                                   iso_country String,
                                   iso_region String,
                                   municipality String,
                                   gps_code String,
                                   iata_code String,
                                   local_code String,
                                   coordinates String
) ROW FORMAT DELIMITED
    FIELDS TERMINATED BY ','
    STORED AS TEXTFILE
    LOCATION '/airports';

select * from airports;

drop table airports;

create external table airports (
                                   ident String,
                                   type String,
                                   name string,
                                   elevation_ft String,
                                   continent String,
                                   iso_country String,
                                   iso_region String,
                                   municipality String,
                                   gps_code String,
                                   iata_code String,
                                   local_code String,
                                   coordinates String
) ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
    WITH SERDEPROPERTIES (
        "separatorChar" = ",",
        "quoteChar" = "\""
        )
    STORED AS TEXTFILE
    LOCATION '/airports'
    TBLPROPERTIES ("skip.header.line.count"="1");

explain select * from airports;

describe airports;

create table airport_codes as select ident, name from airports;
create table airport_types as select ident, type from airports;

create table airport_joined as
select ac.ident as ident, ac.name as name, at.type as type from airport_codes ac
                                                                    join airport_types at on ac.ident = at.ident;

explain select ident, type from airport_joined;

