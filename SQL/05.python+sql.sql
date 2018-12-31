
-- python DB API访问数据库
	from pymysql import connect
	connect-->cursor-->执行sql-->关闭cursor-->关闭connect-->结束
	-- connect 用以连接数据库
	-- cursor 用以操作数据库

-- 连接数据库、打开游标、查询、关闭游标及连接
	conn = connect(host="localhost", port=3306, user="root", password="root", database="jing_dong", charset="utf8")
	cusor = self.conn.cursor()
	cusor.execute("select * from goods;")  #执行的结果保存在cusor对象中
		cusor.fetchone()  # 取一条数据；fetchmany(num) 取num条数据；fetchall() 取所有数据；其中数据是以元组组的形式

	cusor.close()
	conn.close()

-- 连接数据库、打开游标、插入[删除、修改]、关闭游标及连接
	conn = connect(host="localhost", port=3306, user="root", password="root", database="jing_dong", charset="utf8")
	cusor = self.conn.cursor()
	cursor.execute("insert into goods_brands values(fault,'%s')"%item_input)
	conn.commit()  # 对于变动数据库时，要以连接执行该语句，事务提交，方才修改数据库；
	conn.rollback()  # 如果不变动数据库，执行该语句，则抛弃execute()所作的修改；
	cursor.close()
	conn.close()


-- SQL注入
	-- 在某些语句中，拼接的SQL语句可能因为某些特殊的输入会获取意外的全部数据，比如
	name = input("请输入商品名：")
    sql = """select * from goods_brands where name = "%s";"""%name
    self.cusor.execute(sql)
    print(self.cusor.fetchall())
    -- 当输入 " or 2=2 or"  时，会显示goods_brands的所有数据，这是因为：
    -- select * from goods_brands where name = ""or 2=2 or""  A or B or C ，A，C虽然不满足，但B(2=2)满足，此时显示所有数据

-- 反SQL注入
	-- 不再自拼接SQL语句，而是将输入的数据放入列表，使sql语句参数化，由cusor.execute()进行拼接，输入数据全部使用%s占位，可以避免此问题；
    name = input("请输入商品名：")
    # sql = """select * from goods_brands where name = "%s";"""%name
    # self.cusor.execute(sql)
    # print(self.cusor.fetchall())
    params = [name]
    sql = "select * from goods_brands where name = %s;"
    self.cusor.execute(sql, [name])
    print(sql+str([name]))
    print(self.cusor.fetchall())
    -- 注意：%s不再加”“或‘’  另execute()拼接；





-- 完整小实例：
	from pymysql import connect

	class JD(object):

	    def __init__(self):
	        self.conn = connect(host="localhost", port=3306, user="root", password="root", database="jing_dong", charset="utf8")
	        self.cusor = self.conn.cursor()

	    def __del__(self):
	        self.cusor.close()
	        self.conn.close()

	    def show_all_items(self):
	        self.cusor.execute("select * from goods;")
	        for temp in self.cusor:
	            print(temp)

	    def show_cates(self):
	        self.cusor.execute("select name from goods_cates;")
	        for temp in self.cusor:
	            print(temp)

	    def show_brands(self):
	        self.cusor.execute("select name from goods_brands;")
	        for temp in self.cusor:
	            print(temp)

	    def add_brands(self):
	        item_brand = input("请输入品牌名称：")
	        self.cusor.execute("""insert into goods_brands values(default, '%s');""" % item_brand)
	        self.conn.commit()

	    def exit_1(self):
	        exit()

	    @staticmethod
	    def show_meau():
	        print("-----京东-----")
	        print("1.查看所有信息：")
	        print("2.查询分类信息：")
	        print("3.查询品牌信息：")
	        print("4.添加品牌信息：")
	        print("5.退出")
	        return input("请选择：")

	    def run(self):
	        while True:

	            choice = self.show_meau()
	            if choice == "1":
	                self.show_all_items()
	            elif choice == "2":
	                self.show_cates()
	            elif choice == "3":
	                self.show_brands()
	            elif choice == "4":
	                self.add_brands()
	            elif choice == "5":
	                self.exit_1()
	            else:
	                print("输入有误，请重新输入")


	def main():

	    jd = JD()
	    jd.run()


	if __name__ == "__main__":
	    main()



