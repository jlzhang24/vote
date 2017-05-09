<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@include file="check.jsp"%>
<%@page import="com.vote.service.*"%>
<%
	String getid = request.getParameter("oid");
	int oid = Integer.parseInt(getid.trim());
	boolean flag = ObjectBeanService.delObjectBean(oid);
    response.sendRedirect("wjList.jsp");
%>