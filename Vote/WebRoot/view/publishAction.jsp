<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.vote.service.*"%>
<%
	String id = request.getParameter("oid");
	String action = request.getParameter("action");
	MyTool tool = new MyTool();
	if (action.equals("publish")) {
		int result = tool.UpdateCol("wj_object", "state", "1", "oid",
		id);
		if (result > 0) {
%>
<script type="text/javascript">
	window.alert("发布完成！");
	window.location.href="./wjList.jsp";
</script>
<%
	}
	} else if (action.equals("unpublish")) {
		int result = tool.UpdateCol("wj_object", "state", "0", "oid",
		id);
		if (result > 0) {
%>
<script type="text/javascript">
	window.alert("撤消完成！");
	window.location.href="./wjList.jsp";
</script>
<%
	}
	} else if (action.equals("stop")) {
		int result = tool.UpdateCol("wj_object", "state", "2", "oid",
		id);
		if (result > 0) {
%>
<script type="text/javascript">
	window.alert("已终止对该卷的评议！");
	window.location.href="./wjList.jsp";
</script>
<%
	}
	}
%>
