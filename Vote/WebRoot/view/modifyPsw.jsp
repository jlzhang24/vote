<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="check.jsp"%>
<%@page import="com.vote.service.*"%>
<%@page import="com.vote.bean.*"%>
<%
	String userName = (String)session.getAttribute("userName");
	String oldpassword = Func.getString(request.getAttribute("oldpassword"));
    boolean isSame = true;
    if(request.getAttribute("isSame")!=null)
    	isSame = (Boolean)request.getAttribute("isSame");
    //System.out.println(isSame);
%>
<html>
	<head>
		<title>问卷管理系统</title>
		<link type="text/css" rel="stylesheet" href="/vote/view/css/main.css" />
<script type="text/javascript">
   //提交
function submit(){
		if (validCheck()) {
			document.fm.action="./modifyPswAction.jsp";
		document.fm.submit();
		return;
	}
}
   //校验原密码
function checkOldPsw(oldpassword)
  {
  if(oldpassword.length == 0) return;
  fm.action = "./checkOldPswAction.jsp";
  fm.submit();
  }
   
   //有效性校验
   function validCheck()
   {
   	var oldpassword = document.fm.oldpassword.value;
   	var newpassword = document.fm.newpassword.value;
   	var confirmpassword = document.fm.confirmpassword.value;

	if (oldpassword == "" || oldpassword.length == 0) {
		alert("请输入原密码。");
		document.all("oldpassword").focus();
		return false;
	}
	else
	{
		if(document.getElementById("pswError").innerHTML!="")
			return false;
	}
	if (newpassword == "" || newpassword.length == 0) {
		alert("请输入新密码。");
		document.all("newpassword").focus();
		return false;
	}
	if (confirmpassword == "" || confirmpassword.length == 0) {
		alert("请输入确认密码。");
		document.all("confirmpassword").focus();
		return false;
	}
	if (confirmpassword != "" && newpassword != "") {
		if(confirmpassword != newpassword)
		{
			alert("新密码与确认密码输入不一致，请检查。");
			document.all("confirmpassword").focus();
			return false;
		}
	}
	return true;
   }

//返回
function back() {
	window.location.href="./main.jsp";
}

//Ajax请求
	var http_request = false;
	
	//初始化、指定处理函数、发送请求的函数
	function send_request(url) {
		http_request = false;
		//开始初始化XMLHttpRequest对象
		if (window.XMLHttpRequest) { //Mozilla 浏览器
			http_request = new XMLHttpRequest();
			if (http_request.overrideMimeType) {//设置MiME类别
				http_request.overrideMimeType('text/xml');
			}
		} else if (window.ActiveXObject) { //IE浏览器
			try {
				http_request = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				try {
					http_request = new ActiveXObject("Microsoft.XMLHTTP");
				} catch (e) {
				}
			}
		}
		if (!http_request) { // 异常，创建对象实例失败
			window.alert("不能创建XMLHttpRequest对象实例.");
			return false;
		}
		http_request.onreadystatechange = processRequest;
		// 确定发送请求的方式和URL以及是否同步执行下段代码
		http_request.open("GET", url, true);
		http_request.send(null);
	}
	
	//处理返回信息的函数
	function processRequest() {
		if (http_request.readyState == 4) { // 判断对象状态
			if (http_request.status == 200) { // 信息已经成功返回，开始处理信息
				//alert(http_request.responseText);
			    var responseText = http_request.responseText;
			    if(responseText !="")
			    {
			    	document.getElementById("pswError").innerHTML = responseText;
			    }
			} else {//页面不正常
				alert("您所请求的页面有异常。");
			}
		}
	}

	//显示提示信息
	function showInfo(str) {
		if (str.length == 0) {
			document.getElementById("pswError").innerHTML = "";
			return;
		}

		var url = "checkOldPsw.jsp";
		url = url + "?oldpassword=" + str;
		url = url + "&sid=" + Math.random();
		
		send_request(url);
	}
</script>
</head>
<body topmargin="2">
<br/><br/>
		<form action="" name="fm" method="post">
		    <input type="hidden" name="userName" value=<%=userName%> />
			<table width="500" border="0" align="center" cellpadding="2"  cellspacing="1" id="myTable" class="tab">
				<tr>
					<td width="60px">
						原密码：
					</td>
					<td>
						<input value="<%=oldpassword%>" type="password" name="oldpassword" onblur="showInfo(this.value)" style="width:150px;" maxLength='20'/>
						<%--
						<input value="<%=oldpassword%>" type="password" name="oldpassword" onblur="checkOldPsw(this.value);" onkeyup="showHint(this.value)" style="width:150px;" maxLength='20'/>
						<font color='red'><span id="pswError"><%if(!isSame) out.println("原密码输入错误");%></span></font> 
						--%>
						<font color='red'><span id="pswError"></span></font>
					</td>
				</tr>
				<tr>
					<td valign="top">
						新密码：
					</td>
					<td>
						<input type="password" name="newpassword"  style="width:150px;" maxLength='20'/>
					</td>
				</tr>
				<tr>
					<td valign="top">
						确认密码：
					</td>
					<td>
						<input type="password" name="confirmpassword"  style="width:150px;" maxLength='20'/>
					</td>
				</tr>
			</table>
		</form>
		<table width="500" border="0" align="center" cellpadding="2"  cellspacing="1" id="myTable" >
		<tr align="left">
			<td id="td1">
				<input type="button" value="确定 " name="add" onclick="submit();" class="btn"/>&nbsp;&nbsp;
				<input type="button" value="取消" onclick="back();" class="btn"/>
			 </td>
		</tr>
		</table>
	</body>
</html>