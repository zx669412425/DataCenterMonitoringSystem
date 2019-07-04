package org.fkit.controller;
import java.sql.*;
public class SqlBean {
	public Connection conn = null;

	public ResultSet rs = null;
	// 声明数据库连接字符串
	private String DatabaseDriver = "com.mysql.jdbc.Driver";
	// DataSource 数据源名称DSN

	//private static final String  url="jdbc:mysql://127.0.0.1:3306/gettemp";
	private static final String  url="jdbc:mysql://192.168.20.52:3306/gettemp";
	
	private static final String  user ="root";
	
	private static final String  pwd ="778899";
	// 定义方法
	/* setXxx用于设置属性值;getXxx用于得到属性值 */
	public void setDatabaseDriver(String Driver) {
		this.DatabaseDriver = Driver;
	}

	public String getDatabaseDriver() {
		return (this.DatabaseDriver);
	}


	public SqlBean() {///// 构造函数
		try {

			Class.forName(DatabaseDriver);
		} catch (java.lang.ClassNotFoundException e) {
			System.err.println("加载驱动器有错误:" + e.getMessage());
			System.out.print("执行插入有错误:" + e.getMessage());// 输出到客户端
		}
	}

	// 执行插入操作的方法
	public int executeInsert(String sql) {
		int num = 0;
		try {
			conn = DriverManager.getConnection(url, user, pwd);
			PreparedStatement ps = conn.prepareStatement(sql);
			num = ps.executeUpdate();
		} catch (SQLException ex) {
			System.err.println("执行插入有错误:" + ex.getMessage());
			System.out.print("执行插入有错误:" + ex.getMessage());// 输出到客户端
		}

		CloseDataBase();
		return num;
	}
	// 执行查询操作的方法

	public ResultSet executeQuery(String sql) {
		rs = null;
		try {
			conn = DriverManager.getConnection(url, user, pwd);
			Statement stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
		} catch (SQLException ex) {
			System.err.println("执行查询有错误:" + ex.getMessage());
			System.out.print("执行查询有错误:" + ex.getMessage()); // 输出到客户端
		}

		return rs;
	}

	// 执行删除操作的方法
	public int executeDelete(String sql) {
		int num = 0;
		try {

			conn = DriverManager.getConnection(url, user, pwd);
			Statement stmt = conn.createStatement();
			num = stmt.executeUpdate(sql);
		} catch (SQLException ex) {
			System.err.println("执行删除有错误:" + ex.getMessage());
			System.out.print("执行删除有错误:" + ex.getMessage()); // 输出到客户端
		}
		CloseDataBase();
		return num;
	}

	// 关闭数据库连接
	public void CloseDataBase() {
		try {
			conn.close();
		} catch (Exception end) {
			System.err.println("执行关闭Connection对象有错误：" + end.getMessage());
			System.out.print("执行执行关闭Connection对象有错误：有错误:" + end.getMessage()); // 输出到客户端
		}
	}
}
