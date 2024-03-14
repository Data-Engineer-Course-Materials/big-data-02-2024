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
