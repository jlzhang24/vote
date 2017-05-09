<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="check.jsp"%>
<%@page import="com.vote.service.*"%>
<%@page import="com.vote.bean.*"%>
<%
	String oldpassword = request.getParameter("oldpassword");//原密码
    String userName = (String)session.getAttribute("userName");
	String oldpsw = AdminService.getOldPsw(userName);
	//System.out.println("原密码： "+oldpsw);
	String oldpsw2 = MD5Util.MD5Encrypt(oldpassword);
	boolean isSame = oldpsw.equals(oldpsw2);
	if(!isSame) out.println("原密码输入错误！");
%>