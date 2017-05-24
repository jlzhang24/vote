<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- TemplateBeginEditable name="doctitle" -->
<title>学生实习评价</title>
<!-- TemplateEndEditable -->
<!-- TemplateBeginEditable name="head" -->
<!-- TemplateEndEditable -->
<style type="text/css">
<!--
body {
	background-color: #004C7E;
}

.STYLE2 {
	font-size: 18px;
}

.STYLE4 {
	font-size: 16px;
	font-weight: bold;
}

.STYLE5 {
	font-size: 16px;
}
-->
</style>


<script language="javaScript">
	function userLogin() {
		var userName = document.form1.xh.value;
		var userPwd = document.form1.sfzh.value;
		var flag = true;
		if (userName == "") {
			alert("用户名不能为空");
			flag = false;
			document.form1.username.focus();
			return;
		}
		if (userPwd == "") {
			alert("用户密码不能为空");
			flag = false;
			document.form1.password.focus();
			return;
		}
		if (flag) {
			document.form1.action = "UserVerifyServlet";
			document.form1.submit();
		}
	}
</script>

</head>
<body>
	<p>&nbsp;</p>
	<p>&nbsp;</p>
	<table width="347" height="315" border="1" align="center">
		<tr>
			<td height="105" colspan="2" bgcolor="#00CCFF"><img
				src="images/top.jpg" width="457" height="101" /></td>
		</tr>

		<tr>
			<td height="202" colspan="2" bgcolor="#00CCFF"><form id="form1"
					name="form1" method="post" action="">
					<table width="459" height="166" border="0">
						<tr>
							<td width="194" height="39"><div align="right"
									class="STYLE4">*用户名：</div></td>
							<td width="255"><span class="STYLE2"> <label>
										<input name="xh" type="text" id="xh" /> </label> </span></td>
						</tr>
						<tr>
							<td height="39"><div align="right" class="STYLE4">*密&nbsp; 码：</div>
							</td>
							<td><span class="STYLE2"> <label> <input
										name="sfzh" type="password" id="sfzh" /> </label> </span></td>
						</tr>
						<tr>
							<td height="39" colspan="2"><label> </label>
								<div align="center">
									<input type="submit" name="Submit" value="登  陆" onclick="userLogin();" />&nbsp;&nbsp;&nbsp;  <input name="reset" type="reset"
										id="reset" value="重  置" />
								</div></td>
						</tr>
					</table>
				</form>
			</td>
		</tr>
	</table>
</body>
</html>
