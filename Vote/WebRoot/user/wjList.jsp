<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../view/check.jsp"%>
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
<script language="javascript">
	//全选
	function selAll() {
		var ids = document.getElementsByName("id");
		var len = ids.length;
		for ( var i = 0; i < len; i++) {
			if (!ids[i].checked) {
				ids[i].checked = true;
			}
		}
	}

	//取消全选
	function noSelAll() {
		var ids = document.getElementsByName("id");
		var len = ids.length;
		for ( var i = 0; i < len; i++) {
			if (ids[i].checked) {
				ids[i].checked = false;
			}
		}
	}

	//获取选中的radio
	function getCheckedRadio(radioObj) {
		if (typeof radioObj == "undefined")
			return null;
		else if (typeof radioObj.length == "undefined")
			return radioObj;
		else {
			for ( var i = 0; i < radioObj.length; i++) {
				if (radioObj[i].checked)
					return radioObj[i];
			}
		}
		return null;
	}

	//获取radio值
	function getRadioValue(radioObj) {
		if (typeof radioObj == "undefined")
			return "";
		else if (typeof radioObj.length == "undefined")
			return radioObj.value;
		else {
			for ( var i = 0; i < radioObj.length; i++) {
				if (radioObj[i].checked)
					return radioObj[i].value;
			}
		}
		return "";
	}

	//获取CheckBox值
	function getCheckBoxValue(checkboxObj, cnt) {
		return getCheckBoxProperty(checkboxObj, cnt, 'value');
	}

	//获取CheckBox某个属性值
	function getCheckBoxProperty(checkboxObj, cnt, propertyName) {
		var sValue = null;
		if (typeof cnt == "undefined")
			cnt = 2;
		if (typeof checkboxObj == 'undefined') {
			alert("没有可以选择的记录！");
			return "";
		} else if (typeof checkboxObj.length == "undefined") {
			checkboxObj.checked = true;
			return checkboxObj[propertyName];
		} else {
			for ( var i = 0; i < checkboxObj.length; i++) {
				if (checkboxObj[i].checked) {
					if (sValue == null)
						sValue = '';
					sValue += ";" + checkboxObj[i][propertyName];
				}
			}
		}
		if (sValue == null) {
			alert("请至少选择一条记录！");
			return '';
		}
		if (sValue.length > 0 && sValue.charAt(0) == ';')
			sValue = sValue.substring(1);
		if (cnt == 1 && sValue.indexOf(';') > -1) {
			alert("只能选择一条记录！");
			return "";
		}

		return sValue;
	}

	//新增问卷
	function Add_onClick() {
		window.self.location = "./wjNew.jsp";
	}

	//修改问卷
	function Modify_onClick() {
		if (typeof document.fm.radio == 'undefined')
			return;
		var pkValue = getCheckBoxValue(document.fm.radio);
		if (pkValue != "") {
			var topicCode = pkValue.split(",")[0];
			window.self.location = "./wjUpdate.jsp?oid=" + topicCode;
		}
	}

	//删除问卷
	function Delete_onClick() {
		if (typeof fm.radio == 'undefined')
			return;
		var pkValue = getCheckBoxValue(fm.radio);
		if (pkValue != "") {
			var topicCode = pkValue.split(",")[0];
			var status = pkValue.split(",")[1];
			if (confirm("您确实要删除该问卷吗？删除该问卷将删除与之相关的题目\n\n信息，回答信息等，删除后，不能再恢复，请慎重。")) {
				window.self.location = "./wjDelAction.jsp?oid=" + topicCode;
			}
		}
	}

	//问卷内容编辑
	function QuestionEdit_onClick() {
		if (typeof document.fm.radio == 'undefined')
			return;
		var pkValue = getCheckBoxValue(document.fm.radio);
		if (pkValue != "") {
			var topicCode = pkValue.split(",")[0];
			var status = pkValue.split(",")[1];
			if (status == 1 || status == 2) {
				if (confirm("问卷发布后，修改问卷将造成以前的回复\n\n数据无效，您确定要编辑问卷内容吗？")) {
					window.self.location = "./quesList.jsp?oid=" + topicCode;
				}
			}
			if (status == 0) {
				window.self.location = "./quesList.jsp?oid=" + topicCode;
			}
		}

	}

	//发布
	function publish_onClick() {
		if (typeof document.fm.radio == 'undefined')
			return;
		var pkValue = getCheckBoxValue(document.fm.radio);
		if (pkValue != "") {
			var topicCode = pkValue.split(",")[0];
			var status = pkValue.split(",")[1];
			if (status == 0) {
				if (confirm("您确定发布该问卷吗？")) {
					window.location.href = "./publishAction.jsp?action=publish&oid="
							+ topicCode;
				}
			}
			if (status == 1) {
				alert("该问卷已发布，不能重复发布！");
				return;
			}
			if (status == 2) {
				alert("该问卷已终止评议，不能发布！");
				return;
			}
		}
	}

	//预览
	function preview_onClick() {
		if (typeof document.fm.radio == 'undefined')
			return;
		var pkValue = getCheckBoxValue(document.fm.radio);
		if (pkValue != "") {
			var topicCode = pkValue.split(",")[0];
			var status = pkValue.split(",")[1];
			if (status == 1 || status == 2) {
				preview(topicCode);
			} else {
				alert("该问卷尚未发布，不能预览!");
			}
		}
	}

	//预览2
	function preview_onClick2(pkValue) {
		if (pkValue != "") {
			var topicCode = pkValue.split(",")[0];
			var status = pkValue.split(",")[1];
			if (status == 1 || status == 2) {
				preview(topicCode);
			} else {
				alert("该问卷尚未发布，不能预览!");
			}
		}
	}

	//预览
	function preview(id) {
		window.open("./preview.jsp?oid=" + id);
	}

	//撤销
	function cancel_onClick() {
		if (typeof document.fm.radio == 'undefined')
			return;
		var pkValue = getCheckBoxValue(document.fm.radio);
		if (pkValue != "") {
			var topicCode = pkValue.split(",")[0];
			var status = pkValue.split(",")[1];
			if (status == 1) {
				if (confirm("您确定要撤销吗？")) {
					window.location.href = "./publishAction.jsp?action=unpublish&oid="
							+ topicCode;
				}
			}
			if (status == 0) {
				alert("该问卷尚未发布，无需撤销！");
				return;
			}
			if (status == 2) {
				alert("该问卷已终止评议，不能撤销！");
				return;
			}
		}

	}

	//终止评议
	function term_onClick() {
		if (typeof document.fm.radio == 'undefined')
			return;
		var pkValue = getCheckBoxValue(document.fm.radio);
		if (pkValue != "") {
			var topicCode = pkValue.split(",")[0];
			var status = pkValue.split(",")[1];
			if (status == 1) {
				if (confirm("您确定要终止评议吗？")) {
					window.location.href = "./publishAction.jsp?action=stop&oid="
							+ topicCode;
				}
			}
			if (status == 0) {
				alert("该问卷尚未发布！");
				return;
			}
			if (status == 2) {
				alert("该问卷已终止评议！");
				return;
			}
		}
	}

	//查看结果
	function showResult_onClick() {
		if (typeof document.fm.radio == 'undefined')
			return;
		var pkValue = getCheckBoxValue(document.fm.radio);
		if (pkValue != "") {
			var topicCode = pkValue.split(",")[0];
			var status = pkValue.split(",")[1];
			if (status == 1 || status == 2) {
				window.location.href = "./showResult2.jsp?oid=" + topicCode;
			} else {
				alert("该问卷尚未发布，不能查看结果!");
			}
		}
	}
</script>
</head>
<body leftmargin="8" topmargin="8" background='skin/images/allbg.gif'>

	<!--  快速转换位置按钮  -->
	<table width="98%" border="0" cellpadding="0" cellspacing="1"
		bgcolor="#D1DDAA" align="center">
		<tr>
			<td height="26" background="skin/images/newlinebg3.gif">
				<table width="98%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td align="center"><input type='button' class="coolbg np"
							onClick="Add_onClick();" value='新增问卷' /> <input type='button'
							class="coolbg np" onClick="Modify_onClick();" value='修改问卷' /> <input
							type='button' class='coolbg np' onClick="Delete_onClick();"
							value='删除问卷' /> <input type='button' class='coolbg np'
							onClick="QuestionEdit_onClick();" value='问卷内容编辑' /> <input
							type='button' class="coolbg np" onClick="publish_onClick();"
							value='发布' /> <input type='button' class="coolbg np"
							onClick="cancel_onClick();" value='撤销' /> <input type='button'
							class="coolbg np" onClick="term_onClick();" value='终止评议' /> <input
							type='button' class="coolbg np" onClick="preview_onClick();"
							value='预览' /> <input type='button' class="coolbg np"
							onClick="showResult_onClick();" value='查看结果' /></td>
					</tr>
				</table></td>
		</tr>
	</table>

	<!--  内容列表   -->
	<form name="fm" action="" method="post">
		<input type="hidden" name="doType" value="" />
		<table width="98%" border="0" cellpadding="2" cellspacing="1"
			bgcolor="#D1DDAA" align="center" style="margin-top:8px">
			<tr bgcolor="#E7E7E7">
				<td height="24" colspan="10" background="skin/images/tbg.gif">&nbsp;内容列表&nbsp;</td>
			</tr>
			<tr align="center" bgcolor="#FAFAF1" height="22">
				<td width="6%">序号</td>
				<td width="4%">选择</td>
				<td width="35%">标题</td>
				<td width="15%">状态</td>
				<td width="15%">更新时间</td>
				<td width="10%">发布人</td>
				<td width="20%">操作</td>
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
			<tr align='center' bgcolor="#FFFFFF"
				onMouseMove="javascript:this.bgColor='#FCFDEE';"
				onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
				<td><%=(i + 1)%></td>
				<td><input name="radio" type="radio" value="<%=oid + "," + state%>"
					class="np">
				</td>
				<td align="left"><a href="wjDetail.jsp?oid=<%=oid%>"><%=ob.getTitle()%></a>
				</td>
				<td><%=stateAlias%></td>
				<td><%=sdf.format(ob.getCreateTime())%></td>
				<td>admin</td>
				<td><a href="wjUpdate.jsp?oid=<%=oid%>">编辑</a> | <a href="#"
					onclick='preview_onClick2("<%=oid + "," + state%>")'>预览</a>
				</td>
			</tr>
			<%
				}
				}
			%>

			<tr bgcolor="#FAFAF1">
				<td height="28" colspan="10"></td>
			</tr>
			<tr align="right" bgcolor="#EEF4EA">
				<td height="36" colspan="10" align="center">
					<!--翻页代码 -->
				</td>
			</tr>
		</table>
	</form>
</body>
</html>