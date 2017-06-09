package com.vote.test;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.vote.service.DBConnection;

public class Test {

	public static void main(String[] args) {
		System.out.println(isUserExist("06250226", "6139"));
	}
	
	
	
	public static boolean isUserExist(String userid, String username) {
		boolean isExist = false;
		String sql = "select * from wj_user where xh=? and sfzh=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			try {
				conn = new DBConnection().getConnection();
			} catch (Exception e) {
				e.printStackTrace();
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setString(2, username);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				isExist = true;
			} else {
				isExist = false;
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return isExist;
	}
}
