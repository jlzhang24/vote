package com.vote.service;

import java.io.IOException;
import java.sql.*;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UserVerifyServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 获取登录页面的数据

		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		String xh = request.getParameter("xh");
		String sfzh = request.getParameter("sfzh");
		if (isUserExist(xh, sfzh)) {
			// 获取用户的信息
			System.out.println("登录成功");
			request.getSession().setAttribute("xh", xh);
			request.getSession().setAttribute("sfzh", sfzh);
			response.sendRedirect("/Vote/user/wjList.jsp");
			// request.getRequestDispatcher("/evaluate.jsp").forward(request,
			// response);// 页面跳转
		} else {
			out.print("<script>alert('you hava evaluted!'); window.location='/login.jsp' </script>");
		}
	}

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
