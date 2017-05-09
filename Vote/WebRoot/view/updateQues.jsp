<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@include file="check.jsp"%>
<%@page import="java.util.*"%>
<%@page import="com.vote.service.*"%>
<%@page import="com.vote.bean.*"%>
<%
			String id = request.getParameter("oid");
			String qseq = request.getParameter("seq");
			int oid = Integer.parseInt(id);
			int seq = Integer.parseInt(qseq);
			MyTool tool = new MyTool();
			QuestionService qs=new QuestionService();
			SelecterService ss=new SelecterService();
			Question ques=qs.getQuesBySeq(seq,oid);
			ObjectBean ob = ObjectBeanService.findObjectBeanByID(oid);
			List selList=ss.listSelecterBySeq(seq,oid);
			int state = ob.getState();
			if (state == 1 || state == 2) {
			    //清空回复表中的数据
			    ReplayService.delReplay(oid);
			    //修改问卷状态为草稿
			    tool.UpdateCol("wj_object", "state", "0", "oid", id);
			}
%>
<html>
	<head>
		<title>问卷管理系统</title>
		<link type="text/css" rel="stylesheet" href="/vote/view/css/main.css" />
		<script type="text/javascript">
		var qvalue=0;
	function getSelect(){
		var qvalue = document.myForm.qtype.value;
		var addbutton=document.getElementById("add");
		 if(qvalue!=3){
		 	//alert("你选的是"+qvalue);
			//window.location.reload();
			addbutton.removeAttribute("disabled");
		}else if(qvalue==3)
		{

			//alert("你选的是文本类");
			addbutton.setAttribute("disabled","false");
		}
	 }
function addTextBox(form, afterElement) {
	var myTable = document.getElementById("myTable");
	var rowCnt = myTable.rows.length;
	var textNumber = (rowCnt-3);
	var sEle;
textNumber++;
var label = document.createElement("label");
	label.setAttribute("class", "m_left");
label.appendChild(document.createTextNode("选项"+textNumber+": "));
	var nextRow = myTable.insertRow(rowCnt - 1);
	var cellTitle = nextRow.insertCell(0);
	var cellText = nextRow.insertCell(1);
	cellTitle.className = "m_left";
	cellTitle.setAttribute("valign", "top");
	cellTitle.appendChild(label);
	var txtName = "txt_" + (textNumber-1);
	var txtId = "txt_" + (textNumber-1);
	//alert(txtName);
	cellText.innerHTML = "<input type='text' name='" + txtName + "' id='" + txtId + "' value='"+"' style=\"width:260px;\"/>";
}

function removeTextBox(form) {
	var textNumber = (rowCnt-3);
	var myTable = document.getElementById("myTable");
	var rowCnt = myTable.rows.length;
	myTable.deleteRow(rowCnt-2);
textNumber--;
	if (textNumber < 4) {
		alert("至少得有一个选项!");
}
}

	//提交
	function submit(){
 		if(document.myForm.content.value.length==0)	{
 			alert("输入域 题目 不能为空");
 			document.myForm.content.focus();
 			return false;
 		}else{
 				var listCnt = document.getElementById("listCnt");
 				var myTable = document.getElementById("myTable");
 				var textNumber = myTable.rows.length;
 				listCnt.value = (textNumber-3);
 		  	 	document.myForm.action="./updateQuesAction.jsp";
 		  	    document.myForm.submit();
 				return true;
		}
	}
	
	//返回
	function back() {
		window.location.href="./quesList.jsp?oid=<%=oid%>";
	}
</script>
	</head>
	<body topmargin="2">
		<table cellspacing="0" cellpadding="0" width="500" align="center" class="tab">
			<tbody>
				<tr>
					<td height="30"></td>
				</tr>
				<tr>
					<td class="dl_bt" align="center">
						修改题目
						<br>
						<br>
					</td>
				</tr>
				<tr>
					<td align="left">
						<button type="button" class="btn" class="btn" onclick="submit();"> 保     存 </button>
						<button type="button" class="btn" class="btn" onclick="back();"> 返     回 </button>
					</td>
				</tr>
			</tbody>
		</table>
		<form action="" name="myForm" method="post" >
			<table width="500" border="0" align="center" cellpadding="2" cellspacing="1" class="tab" id="myTable">
				<tr>
					<td width="60px">
						题目：
					</td>
					<td >
						<input type="text" name="content"
							value="<%=ques.getContent()%>" style="width:300px;"/>
					</td>
				</tr>
				<tr>
					<td valign="top">
						类型：
					</td>
					<%	int qtype=ques.getQtype(); %>
					<td>
						<select name="qtype" onchange=getSelect() style="width:120px;">
							<option value="0" <% if(qtype==0)out.println("selected");%>>
								单选
							</option>
							<option value="1"<% if(qtype==1)out.println("selected");%>>
								多选
							</option>
							<option value="2"<% if(qtype==2)out.println("selected");%>>
								下拉框
							</option>
							<option value="3"<% if(qtype==3)out.println("selected");%>>
								文本框
							</option>
						</select>
					</td>
				</tr>
					<%
					if(selList!=null&&selList.size()>0){
					for(int i=0;i<selList.size();i++){
					Selecter sel=(Selecter)selList.get(i);
					String txtname = "txt_"+(i);
					%>
				<tr>
					<td valign="top">
						<label>
							选项
							<%= i+1%>:
						</label>
					</td>
					<td>
						<input type="text" name="<%= txtname %>" id="<%= txtname %>"
							value="<%=sel.getContent()%>" style="width:260px;"/>
							<br />
					</td>
				</tr>
					<%
					}}
					%>
				<tr>
					<td >
					<input type="hidden" name="listCnt" id="listCnt" value="" />
					<input type="hidden" name="oid" id="oid" value="<%=oid %>" />
					<input type="hidden" name="seq" id="seq" value="<%=seq %>" />
					</td>
					<td id="td1">
						<input type="button" value="添加选项" name="add"
							onclick="addTextBox(this.form,this.parentNode)" class="btn"/>
						<input type="button" value="删除选项"
							onclick="removeTextBox(this.form)" class="btn"/>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>