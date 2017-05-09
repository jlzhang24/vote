package com.vote.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.vote.bean.AdminBean;

public class AdminService {

	public AdminBean longin(String username, String password) throws Exception {
		DBConnection dbcon = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		AdminBean admin = new AdminBean();
		String md5Psw = MD5Util.MD5Encrypt(password);
		String sql = "select * from wj_admins where username =? and password =?";// 防止SQL注入
		try {
			dbcon = new DBConnection();
			con = dbcon.getConnection();
			ps = con.prepareStatement(sql);
			ps.setString(1, username);
			ps.setString(2, md5Psw);
			rs = ps.executeQuery();
			while (rs.next()) {
				String uname = rs.getString("username");
				String pwd = rs.getString("password");
				admin.setPassword(pwd);
				admin.setUsername(uname);
			}

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			dbcon.closeAll(con, ps, rs);
		}
		return admin;
	}

	public static String getOldPsw(String username) {
		DBConnection dbcon = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String psw = "";
		String sql = "select * from wj_admins where username =?";
		try {
			dbcon = new DBConnection();
			con = dbcon.getConnection();
			ps = con.prepareStatement(sql);
			ps.setString(1, username);
			rs = ps.executeQuery();
			while (rs.next()) {
				psw = rs.getString("password");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbcon.closeAll(con, ps, rs);
		}
		return psw;
	}

	/**
	 * 修改密码
	 * 
	 * @param username
	 * @param newpsw
	 * @return
	 * @throws Exception
	 */
	public static boolean updatePassword(String username, String newpsw)
			throws Exception {
		DBConnection dbcon = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		boolean flag = false;
		String md5Psw = MD5Util.MD5Encrypt(newpsw);
		String sql = "update wj_admins set password = ? where username = ?";
		System.out.println(sql);
		try {
			dbcon = new DBConnection();
			con = dbcon.getConnection();
			ps = con.prepareStatement(sql);
			ps.setString(1, md5Psw);
			ps.setString(2, username);
			ps.executeUpdate();
			flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbcon.closeAll(con, ps, rs);
		}
		return flag;
	}
}
