<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="check.jsp"%>
<%@page import="com.vote.service.*"%>
<%@page import="com.vote.bean.*"%>
<%@page import="java.sql.*"%>
<%
	String id = request.getParameter("oid");
	String qseq = request.getParameter("seq");
	int oid = Integer.parseInt(id);
	int seq = Integer.parseInt(qseq);
	MyTool tool = new MyTool();
	QuestionService qs = new QuestionService();
	SelecterService ss = new SelecterService();
	ObjectBean ob = ObjectBeanService.findObjectBeanByID(oid);
	int count = qs.getQuesCount(oid);
	int state = ob.getState();
	if (state == 1 || state == 2) {
	    //清空回复表中的数据
	    ReplayService.delReplay(oid);
	    //修改问卷状态为草稿
	    tool.UpdateCol("wj_object", "state", "0", "oid", id);
	}
	//如果题目顺序等于１的情况下执行以下代码
	if (seq == 1) {
		if(count==1){
			int flags = ss.deleteSelecter(seq, oid);//删除选项
			if (flags > 0) {
				int flagq = qs.deleteQues(seq, oid);//删除问题
				if (flagq > 0)	response.sendRedirect("quesList.jsp?oid=" + oid);
			}
		}else{
			int flags = ss.deleteSelecter(seq, oid);//删除选项
			if (flags > 0) {
				int flagq = qs.deleteQues(seq, oid);//删除问题
				if (flagq > 0) {
					int updateQseq = qs.updateQseq(seq, oid);//修改问题顺序
					if (updateQseq > 0) {
						int updateSseq = ss.updateSseq(seq, oid);//修改选项顺序
 						if (updateSseq > 0)	response.sendRedirect("quesList.jsp?oid="+oid);
				 	 }
				}
			}
 }
}
	//如果题目顺序小于题目总数并且不等于１的情况下执行以下代码
	if (seq < count && seq != 1) {
		int flags = ss.deleteSelecter(seq, oid);
		if (flags > 0) {
			int flagq = qs.deleteQues(seq, oid);
			if (flagq > 0) {
				int updateQseq = qs.updateQseq(seq, oid);
				if (updateQseq > 0) {
					int updateSseq = ss.updateSseq(seq, oid);
					if (updateSseq > 0 && updateQseq > 0)	response.sendRedirect("quesList.jsp?oid=" + oid);

				}
			}
		}
	}
	//如果题目的顺序等于题目的总数的情况下执行以下代码
	if (seq == count) {
		int flags = ss.deleteSelecter(seq, oid);
		if (flags > 0) {
			int flagq = qs.deleteQues(seq, oid);
			if (flagq > 0)	response.sendRedirect("quesList.jsp?oid=" + oid);

		}
	}
%>
