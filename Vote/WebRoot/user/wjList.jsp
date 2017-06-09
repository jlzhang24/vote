<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="com.vote.service.*"%>
<%@page import="com.vote.bean.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%	
	List objList = ObjectBeanService.ListObjectBean();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String contextPath = request.getContextPath();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>问卷管理</title>
<link rel="stylesheet" type="text/css" href="skin/css/base.css">
</head>
<body leftmargin="8" topmargin="8" background='skin/images/allbg.gif'>

	<!--  内容列表   -->
	<form name="fm" action="" method="post">
		<input type="hidden" name="doType" value="" />
		<table width="50%" border="0" cellpadding="2" cellspacing="1"
			bgcolor="#D1DDAA" align="center" style="margin-top:58px">
			<tr bgcolor="#E7E7E7">
				<td height="60" align="center" background="skin/images/tbg.gif">&nbsp;调查问卷名称&nbsp;</td>
			</tr>
			<%
				if (objList.size() == 0) {
			%>
			<tr align='left' bgcolor="#FFFFFF"
				onMouseMove="javascript:this.bgColor='#FCFDEE';"
				onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
				<td height="24" colspan="10" background="skin/images/tbg.gif">no
					data&nbsp;</td>
			</tr>
			<%
				}
			%>
			<%
				if (objList.size() > 0) {
					for (int i = 0; i < objList.size(); i++) {
						ObjectBean ob = (ObjectBean) objList.get(i);
						int oid = ob.getOid();
						int state = ob.getState();
						String stateAlias = "";
						if (state == 0)
							stateAlias = "草稿";
						if (state == 1)
							stateAlias = "已发布";
						if (state == 2)
							stateAlias = "已终止评议";
			%>
			<tr align='center' bgcolor="#EEF4EA"
				onMouseMove="javascript:this.bgColor='#FCFDEE';"
				onMouseOut="javascript:this.bgColor='#FFFFFF';" height="42">
				<td align="left"><a href="evaluate.jsp?oid=<%=oid%>" target="_blank"><%=(i + 1)%>
						. <%=ob.getTitle()%></a></td>
			</tr>
			<%
				}
				}
			%>
		</table>
	</form>
</body>
</html>