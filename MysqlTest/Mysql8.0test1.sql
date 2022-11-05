use myexer;
select prod_name from products ;
select *from products;
select prod_price from products;
select prod_id,prod_name,prod_price from products;
select vend_id from products ;

select distinct vend_id from products;                #去重操作

select prod_name from products limit 5;               #限制操作
select prod_name from products limit 5,5;

select products.prod_name from products ;
select products.prod_name from myexer.products;

select prod_name  from products order by prod_name;




