<%@page language="java" contentType="text/html; charset=UTF-8" 	pageEncoding="UTF-8"%>
<%@include file="check.jsp"%>
<%@page import="com.vote.service.*"%>
<%@page import="com.vote.bean.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%
		//从请求当中获取到ID，根据ID查询出题目和内容
		String id = request.getParameter("oid");
		int oid = Integer.parseInt(id);
		ObjectBean ob = ObjectBeanService.findObjectBeanByID(oid);
		QuestionService qs = new QuestionService();
		SelecterService ss = new SelecterService();
		List quesList = qs.litQuesByOid(oid);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>问卷管理系统</title>
<link type="text/css" rel="stylesheet" href="/vote/view/css/main.css" />
<script type="text/javascript">
//新建题目
function newQues() {
	window.self.location="./newQues.jsp?oid="+<%=oid%>;
}

//新建题目
function delQues(seq) {
	if(confirm("您确实要删除该问题吗？删除后，不能再恢复。"))
	{
		window.self.location="./delQues.jsp?oid="+<%=oid%>+"&seq="+seq;
	}
}
	
//返回
function back() {
	window.location.href="./wjList.jsp";
}
</script>
</head>
<body topmargin="2">
		<table class="table">
			<tr>
				<td valign="top">
					<table class="table">
						<tr>
							<td width="35" rowspan="2" valign="top"></td>
							<td>
								<table class="table">
									<tr>
										<td colspan="2">
											<div align="center" style="font-size: 14px;">
												<strong><%=ob.getTitle()%></strong>
											</div>
											<br />
										</td>
									</tr>
									<tr>
										<td>
											<table class="table">
												<tr>
													<td>
														<%=ob.getDiscribe().replaceAll("\\n","<br/>")%>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<td height="10">
											<span> <input type="button" name="sbmQues"  onclick="newQues();" value=" 新建题目 " /> </span>
										</td>
									</tr>
									<tr>
										<td colspan="5">
											<form method="post" action="" name="myForm">
												<table class="table2">
													<%
																																		int subCnt = 0;
																																		if (quesList != null && quesList.size() > 0) {
																																			for (int i = 0; i < quesList.size(); i++) {
																																				Question ques = (Question) quesList.get(i);
																																				int qtype = ques.getQtype();
																																				int seq = ques.getSeq();
																																				subCnt++;
																																	%>
													<tr>
														<td bgcolor="#CDE2FD" colspan=4>
															<span id="title<%=i%>"><%=seq%>.<%=ques.getContent()%></span>
															<br />
														</td>
													</tr>
													<tr>
														<%
																																			List selList = ss.listSelecterBySeq(seq, oid);
																																					if (qtype == 0) {
																																		%>
														<td>
															<table class="table2">
																<%
																																					for (int j = 0; j < selList.size(); j++) {
																																									Selecter sel = (Selecter) selList.get(j);
																																									String radioName = "radio_" + sel.getQseq();
																																				%>
																<tr>
																	<td width="25%" valign="top">
																		<input type="radio" id="<%=radioName%>"
																			name="<%=radioName%>" value="<%=sel.getSelseq()%>" /><%=sel.getContent()%></td>
																	<%
																																						if (j == 3) {
																																					%>
																</tr>
																<tr>
																	<%
																																						}
																																									}
																																					%>
																																					
																</tr>
																
					<tr>
					<td>
						<br/>
						<a
							href="addQues.jsp?oid=<%=oid%>&seq=<%=ques.getSeq()%>">插入题目</a>
						<a
							href="updateQues.jsp?oid=<%=oid%>&seq=<%=ques.getSeq()%>">编辑题目</a>
						<a onclick="delQues(<%=ques.getSeq()%>);" href="#">删除题目</a>
						<br />
					</td>
				    </tr>
															</table>
														</td>
														<%
																																			} else if (qtype == 1) {
																																		%>
													
													<tr>
														<td>
															<table class="table2">
																<%
																																						for (int j = 0; j < selList.size(); j++) {
																																										Selecter sel = (Selecter) selList.get(j);
																																										String cbxName = "check_" + sel.getQseq();
																																					%>
																<tr>
																	<td width="25%" style="word-break: break-all;"
																		valign="top">
																		<input type="checkbox" name="<%=cbxName%>"
																			value="<%=sel.getSelseq()%>" />
																		<%=sel.getContent()%>
																		<br />
																	</td>
																	<%
																																							if (j == 3) {
																																						%>
																</tr>
																<tr>
																	<%
																																							}
																																										}
																																						%>
																</tr>
																<tr>
					<td>
						<br/>
						<a
							href="addQues.jsp?oid=<%=oid%>&seq=<%=ques.getSeq()%>">插入题目</a>
						<a
							href="updateQues.jsp?oid=<%=oid%>&seq=<%=ques.getSeq()%>">编辑题目</a>
						<a onclick="delQues(<%=ques.getSeq()%>);" href="#">删除题目</a>
						<br />
					</td>
				    </tr>
															</table>
														</td>
														<%
																																				} else if (qtype == 2) {
																																							String selectname = "select_" + ques.getSeq();
																																			%>
														<td colspan=4>
															<select name="<%=selectname%>">
																<option value="-1">
																	请选择
																</option>
																<%
																																						for (int j = 0; j < selList.size(); j++) {
																																										Selecter sel = (Selecter) selList.get(j);
																																					%>
																<option value="<%=sel.getSelseq()%>">
																	<%=sel.getContent()%>
																</option>
																<%
																																						}
																																					%>
															</select>
														</td>
					<tr>							
					<td>
						<br/>
						<a
							href="addQues.jsp?oid=<%=oid%>&seq=<%=ques.getSeq()%>">插入题目</a>
						<a
							href="updateQues.jsp?oid=<%=oid%>&seq=<%=ques.getSeq()%>">编辑题目</a>
						<a onclick="delQues(<%=ques.getSeq()%>);" href="#">删除题目</a>
						<br />
					</td>
					</tr>
														
														<%
																																				} else if (qtype == 3) {
																																							Selecter sel = (Selecter) selList.get(0);
																																							String txtname = "txt_" + sel.getQseq();
																																							String textValue = "";
																																							textValue = sel.getContent();
																																			%>
														<td colspan=4>
															&nbsp;&nbsp;&nbsp;
															<span><%=textValue%></span>
															<br />
															<textarea name="<%=txtname%>" rows="3"
																style="width: 100%"></textarea>
														</td>
					<tr>								
					<td>
						<br/>
						<a
							href="addQues.jsp?oid=<%=oid%>&seq=<%=ques.getSeq()%>">插入题目</a>
						<a
							href="updateQues.jsp?oid=<%=oid%>&seq=<%=ques.getSeq()%>">编辑题目</a>
						<a onclick="delQues(<%=ques.getSeq()%>);" href="#">删除题目</a>
						<br />
					</td>
					</tr>
														
														<%
																																				}
																																					}
																																				}
																																			%>

												</table>
											</form>
										</td>
									</tr>
									<tr>
										<td height="5">

										</td>
									</tr>
									<tr>
										<td height="5">
										</td>
									</tr>
									<tr>
										<td>
											<div id="buttonArea">
												<input type="button" name="btnOK" value=" 返  回   "  onclick="back();" />
												<br />
											</div>
										</td>
									</tr>
								</table>
								<input type="hidden" name="subCnt" id="subCnt"
									value="<%=subCnt%>" />
							</td>
						</tr>
						<tr>
							<td height="20"></td>
						</tr>
					</table>
					<br />
				</td>
				<td width="23" rowspan="2">
					&nbsp;
				</td>
			</tr>
		</table>

	</body>
</html>
