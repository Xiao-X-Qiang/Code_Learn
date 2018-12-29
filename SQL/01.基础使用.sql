-- 链接数据库
	mysql -uroot -p
	mysql -uroot -proot

	-- 退出数据库
	exit/quit/ctro+d

	-- 数据库语句以分号；结尾
	-- 查看所有的数据库
	show databases;

	-- 显示时间
	select now();

	-- 显示数据库版本
	select version();


create table student(
	id int unsigned not null  auto_increment primary key,
	name varchar(30),
	age tinyint unsigned default 0,
	high decimal(5,2),
	gender enum("男","女","保密") default "保密",
	cls_id int unsigned 
	);

create table class(
id int unsigned not null auto_increment primary key,
name varchar(30) 
);

insert into student values(0, "小李",20,"男",2,"2010-01-01");
insert into student values(default, "小李",20,"男",2,"2010-01-01");
insert into student values(null, "小李",20,"男",2,"2010-01-01");

insert into student values(null, "小李",20,2,2,"2010-01-01");

insert into student(name,age) values("能人",23),("貂蝉",25);	

insert into student values(null, "小si",20,"男",2,"2012-01-01"),(default, "小wu",20,"男",2,"2022-01-01");


create table stu1(
id int unsigned primary key not null auto_increment ,
name varchar(30),
sex enum("femal","male","bgirl"),
height decimal(5,2)
);


create table stu2(
id int unsigned primary key  not null,

)

 
