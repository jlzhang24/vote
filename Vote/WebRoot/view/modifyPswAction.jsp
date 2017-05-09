<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="check.jsp"%>
<%@page import="com.vote.service.*"%>
<%@page import="com.vote.bean.*"%>
<%
String userName = request.getParameter("userName");//用户名
String oldpassword = request.getParameter("oldpassword");//原密码
String newpassword = request.getParameter("newpassword");//新密码

boolean flag = AdminService.updatePassword(userName,newpassword);
if(flag==true){
%>
<script type="text/javascript">
	alert("修改密码成功！");
	window.location.href="./main.jsp";
</script>
<%
}
%>
