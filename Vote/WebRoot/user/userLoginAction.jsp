<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="com.vote.service.*"%>
<%@page import="com.vote.bean.*"%>
<%
	String username = request.getParameter("xh");
	String password = request.getParameter("sfzh");
	UserService us = new UserService();
	
	if (us.isUserExist(username, password)) {
		session.setAttribute("userName", username);
		response.sendRedirect("wjList.jsp");
	} else {
		out.print("<script>alert('username or password is error, please login again!'); window.location='login.jsp' </script>");
	}
%>