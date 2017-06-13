<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@page import="com.vote.service.*"%>
<%
	//错误提示信息
	//String errMsg = Func.getString(request.getParameter("errMsg"));
	String errMsg = new String(request.getParameter("errMsg").getBytes("ISO-8859-1"),"UTF8");
	//System.out.println("errMsg "+errMsg);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>提示信息</title>
<style>
body {margin:0;padding:0;font-size:12px;color:#0c6868;background:#ecf8f5;}
/* Link */
a:link {color: #09797b; text-decoration:none;}
a:visited {color: #09797b;text-decoration:none;}
a:hover {color: #d9964d; text-decoration:underline;}
a:active {color: #09797b;}
</style>
<script type="text/javascript" src=""></script>
</head>
<body style="text-align:center">
<div style="width:50%;margin:0 auto;margin-top:15%;">
<div style="font-weight:bold;background:url(images/tishi_title_bg.gif) repeat-x;height:32px;">
<div style="background:url(images/corner2.gif) no-repeat;width:4px;float:right;height:32px;"></div>
<div style="background:url(images/corner1.gif) no-repeat;width:100px;height:23px;padding:9px 0 0 10px;text-align:center;"></div></div>
<div style="background:#fff;border-left:1px solid #b5e1d6;border-right:1px solid #b5e1d6;text-align:center;height:120px;padding-top:20px;"><span style="font-size:18px;font-family:黑体;">信息提示</span>
<p style="margin:5px;text-align:left;padding:0 20px;text-indent:2em;line-height:1.6em;font-size:14px;text-align:center;"><%=errMsg%><br/>
</p>
</div>
<div style="background:url(images/tishi_bottom_bg.gif);height:5px;font-size:0;">
<div style="background:url(images/corner4.gif) no-repeat;width:4px;float:right;height:4px;"></div>
<div style="background:url(images/corner3.gif) no-repeat;width:4px;height:4px;"></div>
</div>
</div>
</body>
</html>