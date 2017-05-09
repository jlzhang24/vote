<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="check.jsp"%>
<%@page import="com.vote.bean.*"%>
<%@page import="com.vote.service.*"%>
<%
	ObjectBeanService obs = new ObjectBeanService();
	FileUtil fu = new FileUtil();
	ObjectBean ob = new ObjectBean();
	String title = request.getParameter("title");
	String discribe = request.getParameter("discribe");
	String anonymousFlag = request.getParameter("anonymousFlag");
	String remark = request.getParameter("remark");
	System.out.println(title);
	System.out.println(discribe);
	System.out.println(anonymousFlag);
	System.out.println(remark);
	ob.setTitle(title);
	ob.setDiscribe(discribe);
	ob.setAnonymousFlag(anonymousFlag);
	ob.setRemark(remark);

	int id = obs.intsertObjectBean(ob);
	String pathinfo = request.getRealPath("");
	String from = pathinfo + "/view/diaocha.txt";
	String to = pathinfo + "/view/diaocha_" + id + ".jsp";
	String wj = "<% String id=\"" + id + "\";" + "%" + ">";
	fu.copyFile(from, null, to, "UTF-8", wj);
	System.out.println(pathinfo);
	if (id > 0) {
		response.sendRedirect("wjList.jsp");
	} else {
%>
<script>
	alert("创建失败");
</script>
<%
	response.sendRedirect("wjNew.jsp");
	}
%>