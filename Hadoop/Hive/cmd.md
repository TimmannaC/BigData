## Hive commands

#Create the database.
create database testdb; or create schema testdb;

##to show the databases and tables
show databases;
show tables;

#use the database.
use testdb;

#create the table.
create table testTable(name string,age int,city string);

#To get the table metadata.
desc <tableName> or desc formatted <tableName>

#insert into table.
inert into table testTable values ('a',10,'Bengaluru');

#retrive the data.
select *from testTable;

##Hive Tables

1) Internal
on droping the internal table data inside the table is lost forever.

CREATE TABLE Emp(name STRING,age INT) 
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LOCATION 'File Name';

2) External
On dropping the external table data inside the table is not deleted.
only the table gets dropped but the data is still present in HDFS.

CREATE EXTERNAL TABLE Emp(name STRING,age INT)
ROW FORMAT DELIMITTED
FILEDS TERMINATED BY ','
LOCATION 'File Name';


##HIVE UDF

UDF         ---     USER DEFINED FUNCTIONS
UDAF        ---     USER DEFINED AGGREGATION FUNCTIONS
UDTF        ---     USER DEFINED TABLE FUNCTIONS
___

### Loading data from file to Hive table and vice-versa.
1) Loading the data from file to hive table.
```
$> LOAD DATA LOCAL INAPTH 'file_path' OVERWRITE INTO TABLE temp_table;
```

2) Loading the data from hive table into the file.
```
$>  INSERT OVERWRITE DIRECTORY '/tmp/output_folder' SELECT a.* from a where a.ds='2018-02-02';
$>  INSERT OVERWRITE TABLE test SELECT a.* from a where a.ds='2018-02-02';
```
___

#Functions in Hive;

##To see all available functions in hive;
show functions;

## To see details of each function.
describe function <functionName>
eg: describe function length;

## To test the function:
eg: select length("Hello World"); // 11

## IMP functions related to Strings are:
1) substr or substring.

2) instr --> gives the position of a sub-string from a string.
  eg: select "Hello World,How are you" like 'Hello%' // true NOTE: if we dont use Hello(%) --> then it will just compare both       strings and give false as o/p.

3) like --> for matching
4) rlike --> regular expression matching
5) length 
6) lcase or lower
7) ucase or upper
8) trim, ltrim, rtrim
9) lpad,rpad
10) split 
11) initcap -> to get capital letter of each word.
12) cast --> to do typecasting.
  eg : select cast('12' as int);
  
# Imp functions related to date:
1) current_date
2) current_timestamp
3) date_add
4) date_format
5) date_sub
6) datediff
7) day
8) dayofmonth
9) to_date
10) to_unix_timestamp
11) to_utc_timestamp
12) from_unixtime
13) from_utc_timestamp
14) minute
15) month
16) months_between
17) next_day

## CASE function
case are like if else conditions in sql.
eg:
  select case order_status
          when 'CLOSED' then 'No Action'
          when 'COMPLETE' then 'No Action'
          when 'on_HOLD' then 'Pending Action'
          else 'Risky'
          end from orders limit 10;
