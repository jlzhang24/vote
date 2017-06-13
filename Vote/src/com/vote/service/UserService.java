package com.vote.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserService {

	
	/**
	 * 判断登陆的用户是否存在
	 * 
	 * @param userid
	 * @param username
	 * @return
	 */
	public boolean isUserExist(String userid, String username) {
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
