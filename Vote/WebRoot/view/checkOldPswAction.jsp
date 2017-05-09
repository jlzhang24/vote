<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="check.jsp"%>
<%@page import="com.vote.service.*"%>
<%@page import="com.vote.bean.*"%>
<%
   //String path = request.getContextPath();   
   //String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";   

	String oldpassword = request.getParameter("oldpassword");//原密码
    String userName = (String)session.getAttribute("userName");
	String oldpsw = AdminService.getOldPsw(userName);
	//System.out.println("原密码： "+oldpsw);
	String oldpsw2 = MD5Util.MD5Encrypt(oldpassword);
	boolean isSame = oldpsw.equals(oldpsw2);
	request.setAttribute("isSame",isSame);
	request.setAttribute("oldpassword",oldpassword);
%>
<jsp:forward page="/view/modifyPsw.jsp">
 <jsp:param value="<%=isSame%>" name="isSame"/>
</jsp:forward>