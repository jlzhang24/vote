<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.vote.service.*"%>
<%@page import="com.vote.bean.*"%>
	<%
	String id=request.getParameter("oid");
	int oid = Integer.parseInt(id);
	String seq=request.getParameter("seq");
	int qseq = Integer.parseInt(seq);
	String content=request.getParameter("content");
	String selCount = request.getParameter("listCnt");
	int listCnt = Integer.parseInt(selCount);
	String type=request.getParameter("qtype");
	int qtype = Integer.parseInt(type);
	QuestionService qs = new QuestionService();
	SelecterService ss = new SelecterService();
	int count = ObjectBeanService.getCount(oid);
	//如果题目的最大顺序号小于所传进来的顺序号 则先修改顺序号再进行插入 否则直接插入
	if (count > qseq) {
		//修改问题表中题目的顺序
		int updateQuesOrder = qs.updateQuesOrder(oid, qseq);
		if (updateQuesOrder > 0) {
		//修改选项表中题目的顺序
		int updateSseq = ss.updateSelecterSeq(oid, qseq);
			if (updateSseq > 0) {
		//往题目表中插入题目
				int insertQues = qs.addQues(oid,content, qtype, (qseq+1));
				if (insertQues > 0) {
				//插入选项数据
					for (int i = 1; i <= listCnt; i++) {
						String name = String.valueOf("txt" + i);
						String value = request.getParameter(name);
						ss.addSelecter(oid, (qseq+1), value, i);
					}
				}
			}
		}
	} else {

		//往题目表中插入题目
		int addQues = qs.addQues(oid,content, qtype, (qseq+1));
		if (addQues > 0) {
	//插入选项数据
			for (int i = 1; i <= listCnt; i++) {
				String name = String.valueOf("txt" + i);
				String value = request.getParameter(name);
				ss.addSelecter(oid, (qseq+1), value, i);
			}
		}
	}
	response.sendRedirect("quesList.jsp?oid="+ oid);
%>