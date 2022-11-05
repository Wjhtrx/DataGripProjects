create database if not exists E_Commerce;
use E_Commerce;
create table if not exists buy3(
    InvoiceNo string,
     StockCode string ,
    Description string ,
    Quantity integer ,
    InvoiceDate  string ,
    UnitPrice double ,
  CustomerID integer ,
  Country  string
)row format delimited fields terminated by "/t";
-- load data local  inpath '/opt/data/E_Commerce_Data_Clean.csv/part-00001-3e1ca330-eb89-4d28-8604-76dae307345a-c000.csv' into table buy1;
-- load data local  inpath '/opt/data/E_Commerce_Data_Clean.csv/part-00002-3e1ca330-eb89-4d28-8604-76dae307345a-c000.csv' into table buy1;
-- load data local  inpath '/opt/data/E_Commerce_Data_Clean.csv/part-00003-3e1ca330-eb89-4d28-8604-76dae307345a-c000.csv' into table buy1;
-- load data local  inpath '/opt/data/E_Commerce_Data_Clean.csv/part-00004-3e1ca330-eb89-4d28-8604-76dae307345a-c000.csv' into table buy1;
-- load data local  inpath '/opt/data/E_Commerce_Data_Clean.csv/part-00005-3e1ca330-eb89-4d28-8604-76dae307345a-c000.csv' into table buy1;
-- load data local  inpath '/opt/data/E_Commerce_Data_Clean.csv/part-00006-3e1ca330-eb89-4d28-8604-76dae307345a-c000.csv' into table buy1;
-- load data local  inpath '/opt/data/E_Commerce_Data_Clean.csv/part-00007-3e1ca330-eb89-4d28-8604-76dae307345a-c000.csv' into table buy1;

select count(*) from buy1;
-- select *from buy1;
create table result1(country string,
countofcustomer int)row format delimited fields terminated by "\t";

insert into resule1
SELECT Country,COUNT(DISTINCT CustomerID)
    AS countOfCustomer FROM buy1 GROUP BY Country
ORDER BY countOfCustomer DESC LIMIT 10   ;

select *from result1;

desc resule1;


