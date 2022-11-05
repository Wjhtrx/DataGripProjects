#查询练习
show tables;
select *from emp;
desc emp;
select *from dept;
select *from salgrade;
select ENAME,SAL from emp where SAL=5000;
select ENAME,SAL from emp where SAL>=3000;
select ENAME,SAL from emp where SAL!=3000;
select ENAME,SAL from emp where SAL between 1100 and 5000;   #闭区间（大小有序）
select ENAME from emp where ENAME between 'A' and 'K' ;
select ENAME,SAL,COMM from emp where COMM is null order by SAL desc ;
select ENAME,SAL,COMM from emp where COMM is not null order by SAL  ;
select ENAME,SAL,COMM from emp where COMM=0;
select ENAME,JOB from emp where JOB='MANAGER' or JOB='SALESMAN';
select ENAME,SAL,DEPTNO from emp where SAL>1000 and (DEPTNO=20 or DEPTNO=30);

#in 的写法  in(具体的值) 并不是区间 等同于or
select ENAME,JOB from emp where JOB in ('MAnAGER','SALESMAN');

select ENAME from emp where ENAME like '%o%';
select ENAME from emp where ENAME like '__A%'; #__A 表示第三个字母为A
# select ENAME from emp where ENAME like '%_%';
select ENAME from emp where ENAME like '%\_%'; #查找名字中含有下划线的
select ENAME from emp where ENAME like '%T';
select ENAME,SAL from  emp order by SAL;
select ENAME,SAL from  emp order by SAL desc ;
select ENAME,SAL from emp order by SAL desc ,ENAME asc ;
select ENAME,JOB,SAL from emp where JOB='SALESMAN' order by SAL desc ;

#分组函数的练习   (分组函数都是针对某一组数而言的)
select sum(SAL) as sumOfSAl from emp;
select max(SAL) as highestOfSal from emp;
select min(SAL) as minSal from emp;
select avg(SAL) as averageSal from emp;
select count(*) from emp;
select count(ENAME) from emp;

select count(comm) from emp; #忽略了null

#找出工资高于平均工资的员工
select ENAME,SAL from emp where SAL>(SELECT avg(SAL) from emp);

#计算每个员工的年薪(ifnull(含有null的字段名,被代替为的值))
select ENAME,(SAL+ifnull(COMM,0))*12 as yearSal from emp;
select ENAME,ifnull(COMM,0) from emp;

#查找每个工作岗位工资最高的员工和工资
/**
  分组函数会和group by 联合使用。注意 分组函数先分组后使用
  执行次序在group by 之后
 */
select ENAME,job,max(SAL) from emp group by JOB;

select job,avg(SAL)  from emp group by job;

#找出每个部门不同岗位的最高薪资
select DEPTNO,JOB,max(SAL) from emp group by DEPTNO, JOB;










