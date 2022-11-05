-- noinspection SqlCurrentSchemaInspectionForFile

-- create table test1(id int);
-- insert into test1 values (1001);
-- select count(*) from test1;
-- insert into test1 values (1002);
-- select *from test1;
-- select count(*) from test1;
-- insert into test1 values (2300);
--
-- select *from test1;
-- show create table  test;
-- create database db_hive ;
-- create database db_hive1;
-- show databases like 'db_hive*';
-- show databases like 'hive*';
-- desc database db_hive;
-- show databases ;
--
-- alter database db_hive set dbproperties('createtime'='2021-10-7');
-- desc database db_hive;
-- desc database extended db_hive;
-- drop database db_hive1 ;
-- show databases ;
-- create database hive1;
-- create database hive2;
-- create database hive3;
-- show databases ;
-- use hive1;
-- create table test01(id int);
-- drop database hive1 cascade ;
-- create database hive;


-- create EXTERNAL table test1(id string);
-- use default;
-- select *from test;
-- drop table test;
-- show tables ;
-- create table test2(id int,name string);
-- insert into test2 values (1001,'张三');
-- select *from test2;
-- use hive;
-- create table test2(id int,name string ) row format delimited fields terminated by ',';
--  insert into test values (1290,'寒爽');
-- select *from test;
-- ALTER TABLE test2 rename to test;
-- select *from test;
-- alter table test change id  stu_id string;
-- desc test;
-- set hive.stats.autogather=false ;


//创建一张外部表
use hive ;       //在这个数据库中建立表格
create external table if not exists outerTable_dept(
    deptno int,
    dname string,
    loc int
)row format delimited fields terminated by '\t';
desc formatted outerTable_dept;
drop table outerTable_dept;
show tables ;
-- drop table test1;
-- drop table test;

create table if not exists outerTable_dept(
    deptno int,
    dname string,
    loc int
)row format delimited fields terminated by '\t';
show tables ;
drop table hive.outerTable_dept;












