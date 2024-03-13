1. Создаём таблицы, загружаем данные. Пример:
```sql
CREATE TABLE IF NOT EXISTS employee (
  name string,
  work_place ARRAY<string>,
  gender_age STRUCT<gender:string,age:int>,
  skills_score MAP<string,int>,
  depart_title MAP<STRING,ARRAY<STRING>>
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
COLLECTION ITEMS TERMINATED BY ','
MAP KEYS TERMINATED BY ':'
STORED AS TEXTFILE;
```
2. Query the ARRAY in the table
3. Query the STRUCT in the table
4. Query the MAP in the table
5. window aggregate functions

rank() over(PARTITION BY dep_num ORDER BY salary) 
