package org.fkit.controller;
import java.sql.*;
public class SqlBean {
	public Connection conn = null;

	public ResultSet rs = null;
	// �������ݿ������ַ���
	private String DatabaseDriver = "com.mysql.jdbc.Driver";
	// DataSource ����Դ����DSN

	//private static final String  url="jdbc:mysql://127.0.0.1:3306/gettemp";
	private static final String  url="jdbc:mysql://192.168.20.52:3306/gettemp";
	
	private static final String  user ="root";
	
	private static final String  pwd ="778899";
	// ���巽��
	/* setXxx������������ֵ;getXxx���ڵõ�����ֵ */
	public void setDatabaseDriver(String Driver) {
		this.DatabaseDriver = Driver;
	}

	public String getDatabaseDriver() {
		return (this.DatabaseDriver);
	}


	public SqlBean() {///// ���캯��
		try {

			Class.forName(DatabaseDriver);
		} catch (java.lang.ClassNotFoundException e) {
			System.err.println("�����������д���:" + e.getMessage());
			System.out.print("ִ�в����д���:" + e.getMessage());// ������ͻ���
		}
	}

	// ִ�в�������ķ���
	public int executeInsert(String sql) {
		int num = 0;
		try {
			conn = DriverManager.getConnection(url, user, pwd);
			PreparedStatement ps = conn.prepareStatement(sql);
			num = ps.executeUpdate();
		} catch (SQLException ex) {
			System.err.println("ִ�в����д���:" + ex.getMessage());
			System.out.print("ִ�в����д���:" + ex.getMessage());// ������ͻ���
		}

		CloseDataBase();
		return num;
	}
	// ִ�в�ѯ�����ķ���

	public ResultSet executeQuery(String sql) {
		rs = null;
		try {
			conn = DriverManager.getConnection(url, user, pwd);
			Statement stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
		} catch (SQLException ex) {
			System.err.println("ִ�в�ѯ�д���:" + ex.getMessage());
			System.out.print("ִ�в�ѯ�д���:" + ex.getMessage()); // ������ͻ���
		}

		return rs;
	}

	// ִ��ɾ�������ķ���
	public int executeDelete(String sql) {
		int num = 0;
		try {

			conn = DriverManager.getConnection(url, user, pwd);
			Statement stmt = conn.createStatement();
			num = stmt.executeUpdate(sql);
		} catch (SQLException ex) {
			System.err.println("ִ��ɾ���д���:" + ex.getMessage());
			System.out.print("ִ��ɾ���д���:" + ex.getMessage()); // ������ͻ���
		}
		CloseDataBase();
		return num;
	}

	// �ر����ݿ�����
	public void CloseDataBase() {
		try {
			conn.close();
		} catch (Exception end) {
			System.err.println("ִ�йر�Connection�����д���" + end.getMessage());
			System.out.print("ִ��ִ�йر�Connection�����д����д���:" + end.getMessage()); // ������ͻ���
		}
	}
}
