package com.vote.service;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

public class DBConnection {
	public Connection getConnection() throws Exception {
		InputStream is = this.getClass().getClassLoader().getResourceAsStream("database.properties");
		Properties property = new Properties();
		property.load(is);
		String driverClassName = property.getProperty("jdbc.driverClassName");
		String url = property.getProperty("jdbc.url");
		String username = property.getProperty("jdbc.username");
		String password = property.getProperty("jdbc.password");
		Connection conn = null;
		try {
			Class.forName(driverClassName);
			conn = DriverManager.getConnection(url, username, password);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}

	public int update(String sql, Connection conn){
		Statement sta = null;
		try {
			sta = conn.createStatement();
			System.out.println(sql);
			int i = sta.executeUpdate(sql);
			return i;
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}
		
	}
	public ResultSet execute(String sql, Connection conn) {
		Statement sta = null;
		try {
			sta = conn.createStatement();
			ResultSet rs = sta.executeQuery(sql);
			return rs;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} 
	}
	public boolean executeSql(String sql, Connection conn) {
		Statement sta = null;
		try {
			sta = conn.createStatement();
			sta.execute(sql);
			return true;
		} catch (SQLException e) {

			e.printStackTrace();
			return false;
		} 
	}
	public void closeAll(Connection conn) {
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public void closeAll(Connection conn, Statement sta) {
		try {
			if (conn != null) {
				conn.close();
			}
			if (sta != null) {
				sta.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public void closeAll(Connection conn, ResultSet rs) {
		try {
			if (conn != null) {
				conn.close();
			}
			if (rs != null) {
				rs.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public void closeAll(Connection conn, Statement sta, ResultSet rs) {
		try {
			if (conn != null) {
				conn.close();
			}
			if (sta != null) {
				sta.close();
			}
			if (rs != null) {
				rs.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void free(Statement sta, ResultSet rs) {
		try {
			if (sta != null) {
				sta.close();
			}
			if (rs != null) {
				rs.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
