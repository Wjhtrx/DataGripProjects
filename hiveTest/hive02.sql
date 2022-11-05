set hive.stats.autogather=false ;
/**
  hive : DML语句
 */
// hive 向表中导入数据，
use db_hive;
//建立一张表  id与name之间用'\t'分隔
create table student(id string,name string) row format delimited fields terminated by '\t';

//从本地导入数据(相当于copy操作)
load data local inpath '/opt/data/student.txt' into table student;
select *from student;
select count(*) from student;

//从hdfs导入数据(相当于剪切操作)
create table student1(id string,name string)row format delimited fields terminated by '\t';
load data inpath '/student.txt' into table student1;
select *from student1;

/**
  insert操作
 */
 //1:普通插入一条或者多条数据
insert into student values ("1004","zhangSan");
insert into student values ("1005","tianQi"),("1006","suWu"),("1007","chengLiuXiang");
select *from student;
//2:将查询结果作为数据插入另一张表中
insert into  student select *from student1;
select *from student;
//3:覆盖操作(将所有数据覆盖)
insert overwrite table student select *from student1;
select *from student;

/**
  As Select :查询语句中创建表并加载数据
 */
create table if not exists student3 as select id,name from student;
select *from student3;
desc student3;          //查看student表的结构与student1相同

/**
   创建表时通过 Location 指定加载数据路径
  1：在本地首先放入数据
  2:location指定数据（数据先有，再建表）
 */
create table student2(id string,name string) row format delimited fields terminated by '\t';
select *from student2;
create table student4(id string,name string) row format delimited fields terminated by '\t' location
'/student4';      //此时表在hdfs的根目录下
select *from student4;

/**
  数据导出
  insert导出：(以student表为例)
  1： 将查询的结果导出到本地
  2： 将查询的结果格式化导出到本地
  如果不加 local 默认在hdfs目录下

     hadoop命令直接导出(get命令)
    Sqoop 导出
    Hive Shell 命令导出：
  bin/hive -e 'select * from default.student;' >
/opt/module/hive/data/export/student4.txt;

  */
 select *from student ;
insert overwrite  local directory '/opt/data/student' row format delimited fields terminated by ','
select *from student  ;
export table student to '/student1'; //导出数据

/**
  将数据导入(在shell下执行)
  表存在但无数据 或者 表不存在 的情况下使用
 */
import table student5 from '/student1';
select *from student5;

/**
  清除表数据
 */
 select *from student4;
truncate table student4;


/**
    select 查询
 */
 use hive2;
//1:数据准备(dept 和 emp 表)
create table if not exists dept(
    deptno int,
   dname string,
     loc int
)row format delimited fields terminated by '\t';
create table if not exists emp(
empno int,
ename string,
job string,
mgr int,
hiredate string,
sal double,
comm double,
deptno int)
row format delimited fields terminated by '\t';
show tables ;
load data local inpath '/opt/data/dept.txt' into table dept;
load data local inpath '/opt/data/emp.txt' into table emp;
/**
  查询全表
  查询特定列的查询
 */
select *from dept;
select *from emp;
select empno,ename from emp;

/**
 查询常用函数
    求总行数（count）     求工资的最大值（max）
   求工资的最小值（min）   求工资的总和（sum）
  求工资的平均值（avg）
 */
select count(*) from emp;
select max(sal) as max_sal from emp ;
select min(sal) as min_sal from emp ;
select sum(sal) as sum_sal from emp ;
select avg(sal) as avg_sal from emp ;

/**
过滤操作
Limite, where, 比较运算符(between,in,is null)
 */
 select *from emp limit 5;                            //查询emp表中的5条记录
 select *from emp where sal=5000;                    //找出薪水等于5000的记录
 select *from emp where comm is null;                //找出奖金是空的记录
 select *from emp where sal in (1500,5000,2450);    // 找出工资是1500和5000和2450的员工信息
 select *from emp where sal between 1500 and 5000;  //找出3000和5000之间的员工信息

/**
  group by
 */
//计算emp表每个部门的平均薪资
select t.deptno,avg(t.sal) as avg_sal from emp t group by t.deptno;
//计算 emp 每个部门中每个岗位的最高薪水
select t.deptno ,max(t.sal) as max_sal from emp t group by t.deptno;

/**
  hiving语句
  （1）where 后面不能写分组函数，而 having 后面可以使用分组函数。
  （2）having 只用于 group by 分组统计语句。
 */
//求每个部门的平均工资
select deptno ,avg(sal) from emp group by deptno;
//求每个部门的平均薪水大于 1000 的部门
select deptno ,avg(sal) as avg_sal  from emp group by deptno having avg_sal>2000;

/**
  like 和 rlike
 */
select *from emp where ename like "A%";    //查找名字以 A 开头的员工信息
select *from emp where ename like "_A%";  //查找名字中第二个字母为 A 的员工信息
select *from emp where ename rlike "[A]"; //查找名字中带有 A 的员工信息

/**
      关联查询(多表)
      join语句
 */
//根据员工表和部门表中的部门编号相等，查询员工编号、员工名称和部门名称；(测试表的别名)-----内连接
select e.empno,e.ename ,d.deptno,d.dname from emp e join dept d on e.deptno=d.deptno;

//JOIN 操作符左边表中符合 WHERE 子句的所有记录将会被返回。---------左外连接
 select e.empno, e.ename, d.deptno from emp e left join dept d on e.deptno = d.deptno;

//：JOIN 操作符右边表中符合 WHERE 子句的所有记录将会被返回。 -------------右外连接
select e.empno, e.ename, d.deptno from emp e right join dept d on e.deptno = d.deptno;

/**
  将会返回所有表中符合 WHERE 语句条件的所有记录。如果任一表的指定字段没有符合条件的值的话，
  那么就使用 NULL 值替代。        -------------------满外连接
 */
 select e.empno, e.ename, d.deptno from emp e full join dept d on e.deptno = d.deptno;

/**
   排序（order by）
  Order By：全局排序，只有一个 Reducer
 */
select ename ,sal from emp order by sal;      //按照工资进行升序排列
select ename ,sal from emp order by sal desc ;//按照工资进行降序排列
/**
  sort by :
  Sort By：对于大规模的数据集 order by 的效率非常低。在很多情况下，并不需要全局排
序，此时可以使用 sort by,Sort by 为每个 reducer 产生一个排序文件，每个 Reducer 内部进行排序，对全局结果集
来说不是排序.
 */
set mapreduce.job.reduces=3;       //设置mapred的数量
set mapreduce.job.reduces;
select * from emp sort by deptno desc;
 //将排序结果写入到本地
insert overwrite local directory '/opt/data/sortby-result'
 select * from emp sort by deptno desc;

/**
  创建一张分区表
 */
create table dept_par(deptno int ,dname String ,loc String)
partitioned by (day String)
row format delimited fields terminated by '\t';
//导入数据并
-- load data local inpath '/opt/data/dept1.txt' into table dept_par
-- partition (day="2022-10-9");
select *from dept_par where day ="2022-10-9";
show partitions dept_par;
desc formatted dept_par;




/**函数 */
show functions;        //显示自带函数
desc function extended upper; //详细显示自带的函数的用法
select comm,nvl(comm, -1) from emp;//nvl函数(空字段赋值)，空字段用-1代替

create table emp_sex(
name string,
dept_id string,
sex string)
row format delimited fields terminated by "\t";
load data local inpath '/opt/data/emp_sex.txt' into table emp_sex;
select *from emp_sex;
//找出不同部门男女各有多少人
select
 dept_id,
 sum(case sex when '男' then 1 else 0 end) male_count,
 sum(case sex when '女' then 1 else 0 end) female_count
from emp_sex
group by dept_id;






