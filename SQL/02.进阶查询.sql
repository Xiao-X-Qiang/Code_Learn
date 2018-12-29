-- 数据的准备
	-- 创建数据库
	create database python_test charset=utf8;

	-- 使用数据库
	use python_test;

	-- 显示当前使用的数据库
	select database();

	-- 创建数据表 students classes
	-- students表
	create table students(
	    id int unsigned primary key auto_increment not null,
	    name varchar(20) default '',
	    age tinyint unsigned default 0,
	    height decimal(5,2),
	    gender enum('男','女','中性','保密') default '保密',
	    cls_id int unsigned default 0,
	    is_delete bit default 0
	);

	-- classes表
	create table classes (
	    id int unsigned auto_increment primary key not null,
	    name varchar(30) not null
	);

	-- 查询所有字段
	-- select * from 表名
	select * from students
	select * from classes

	-- 查询指定字段
	-- select 列1，列2... from 表名
	select name,age from students;

	-- 使用as为字段起别名
	-- select 字段 [as 别名],字段2 [as 别名]... from 表名;
	select name as 姓名,age as 年龄 from students;

	-- 使用as为表起别名
	-- select 别名.字段,别名.字段... from 表名 as 别名；
	select students.name,students.age from students；
	select s.name,s.age from students as s;
	-- 错误的，select students.name,students.age from students as s 

	-- 消除重复行
	-- distinct 字段  针对某一个字段
	select distinct gender from students;

-- 条件查询

	-- 比较运算符
	-- > >= < <= = !=
	select * from students where age>18;
	select * from students where age<=18;
	select name,gender from students where age!=18;

	-- 逻辑运算符
	-- and or not
	-- 18到28之间的所有学生
	select * from students where age>18 and age<28;

	-- 不在  18岁以上的女性
	-- select * from students where not age>18 and gender=2;
	select * from students where not (age>18 and gender=2);

	-- 年龄不是小于18或者等于18的，并且还是女性
	select * from students where not age<=18 and gender=2;

	-- 模糊查询
	-- like
	-- % 表示0个或多个
	-- _ 表示1个
	-- 查询姓名中以“小”开始的名字
	select * from students where name like "小%";

	-- 查询姓名中有"小"的所有名字
	select * from students where name like "%小%";

	-- 查询是两个字的所有名字
	select name from students where name like "__";

	-- 查询至少有两个字的名字
	select name from students where name like "__%";


	-- rlike 正则
	-- 查询以“周”开始的名字
	select name from students where name rlike "^周.*";

	-- 查询以“周”开始，以“伦”结尾的名字
	select name from students where name rlike "^周.*伦$";


	-- 范围查询
	-- in(1,3,8) 表示在一个非连续的范围内
	-- 查询年龄为18、34的姓名 
	select name from students where age in (18,34);

	-- not in(1,3,8)  表示不在一个非连续的范围内
	-- 查询年龄不在18、34的姓名
	select name from students where age not in (18,34);

	-- between ... and ... 表示在一个连续的范围内(包括两端)
	-- 查询年龄在18至34之间的姓名 
	select name,age from students where age between 18 and 34;

	-- not between ... and ... 表示不在一个连续的范围内
	-- 查询年龄不在18至34之间的姓名
	select name from students where age not between 18 and 34;
	-- 错误的 select name from students where age not (between 18 and 34);


	-- 空判断
	-- is null 判空
	-- 查询身高为空的信息
	select * from students where height is null;

	-- is not null 不为空
	-- 查询身高不为空的信息
	select * from students where height is not null;

-- 排序

	-- order by 字段
	-- asc 从小到大排列，即升序 ，默认项
	-- desc 从大到小排列，即降序
	-- 缺省该字段，默认主键从小到大排序

	-- 查询年龄在18至34岁之间的男性，按照年龄从小到大排序；
	select * from students where age between 18 and 34 and gender=1 order by age;
	select * from students where (age between 18 and 34) and gender=1 order by age;  #也正确，加括号后，可读性更强

	-- 查询年龄在18至34之间的女性，身高从高到低排序
	select * from students where age between 18 and 34 and gender=2 order by height desc;

	-- order by 字段1，字段2 以第1字段排序，数值相同时，按第2字段排序，还相同，则按主键从小到大排序
	-- 查询年龄在18至34岁之间的女性，身高从高到低排序，如果身高相同则按年龄从小到大排序；
	select * from students where (age between 18 and 34) and gender=2 order by height desc,age asc;

	-- 按照年龄从小到大排序，身高从高到低排序；
	select * from students order by age asc,height desc;

-- 聚合函数
	-- count() 总数
	-- 查询有多少男性
	select count(*) as "男性人数" from students where gender=1;

	-- max(字段)  字段中的最大值
	-- 查询最大的年龄
	select max(age) as "最大年龄" from students;

	-- 查询女性中的最高身高
	select max(height) from students where gender=2;

	-- min(字段)  字段中的最小值

	-- sum(字段) 字段求和
	-- 计算所有人的年龄总和
	select sum(age) from students;

	-- avg(字段)  求字段的平均值
	-- 计算平均年龄
	select avg(age) from students;
	select sum(age)/count(*) from students;  #select 后可跟表达式

	-- round(字段,num)  保留字段几位小数，默认四舍五入，另在实际过程中避免存储上的误差，应避免存小数，可采用倍数成整数的方法
	-- 计算男性的平均年龄，保留2位小数
	select round(avg(age),2) from students where gender=1;

-- 分组
	 -- group by 字段 #相当于将原始数据表按照字段分别分组，随后的操作对象是分组后的数据(注意分组后的”主键“)
	 -- 通常，分组和聚合配合着使用方才有意义
	 -- 计算每种性别中的人数
	 select count(*) from students group by gender;
	 -- 错误的，select name,count(*) from students group by gender;  #对于分组后的4组数据中，每组中的name是有歧义的，会报错


	 -- 计算男性的人数
	 select count(*) from students where gender=1 group by gender;

	 -- group_concat(...) #操作对象是group by后的分组数据
	 -- 查询同种性别中的姓名
	 select gender,group_concat(name) from students where gender=1 group by gender;  #select ... from ... where ... group by ...
	 select gender,group_concat(name,' age: ',age,' ',id) from students group by gender;

	 -- having
	 -- having 的操作对象是group by后的”逻辑“数据表，而where 的操作对象是最初的数据表
	 -- 查询不同性别中平均年龄超过30岁的姓名
	 select gender,group_concat(name) from students group by gender having avg(age)>30;

	 -- 查询每种性别中的人数多于2个的信息
	 select gender,group_concat(name) from students group by gender having count(*)>2;

-- 分页
	-- limit start,count  #start 下标从0开始，而enum()下标从1开始
	-- limit count
	-- 查询女性中的前5个数据；
	select * from students where gender=2 limit 5;

	-- 计算方式 limit （第N页-1)*每页的个数,每页的个数
	-- 显示女性，且每页显示3个，显示第3页
	select * from students where gender=2 limit 6,3;
	--错误的 select * from students where gender=2 limit(3-1)*3,3

-- 连接查询
	



	











