<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//清IE缓存，防止用户注销后点IE后退进入系统
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<%
	String errmsg = request.getParameter("errmsg");
	request.getSession(true);
	String chk = "false";
	session.setAttribute("Enter", chk);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>用户登录</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<LINK href="images/public.css" type=text/css rel=stylesheet>
<LINK href="images/login.css" type=text/css rel=stylesheet>
<script>
    
	function OK_onClick() {
		if (chkForm()) {
			document.all("logform").submit();
			return;
		}
	}

	function chkForm() {
		var chkName = document.all("username").value;
		var chkPassword = document.all("password").value;

		if (chkName == "" || chkName.length == 0) {
			alert("请输入用户名。");
			document.all("username").focus();
			return false;
		} else if (chkPassword == "" || chkPassword.length == 0) {
			alert("请输入密码。");
			document.all("password").focus();
			return false;
		}
		return true;
	}

	//通过点击回车键提交表单
	function entersubmit(e) {
		var charCode = (navigator.appName == "Netscape") ? e.which : e.keyCode;
		if (charCode == 13) {
			OK_onClick();
		}
	}

	//重置
	function resetForm() {
		document.all("logform").reset();
		return;
	}
</script>
<META content="MSHTML 6.00.2900.5848" name=GENERATOR>
</HEAD>
<BODY>
<DIV id=div1>
<form id="logform" action="user/loginAction.jsp" method="post" onKeyDown="entersubmit(event)">
  <TABLE id=login height="100%" cellSpacing=0 cellPadding=0 width=800 align=center>
    <TBODY>
      <TR id=main>
        <TD>
          <TABLE height="100%" cellSpacing=0 cellPadding=0 width="100%">
            <TBODY>
              <TR>
                <TD colSpan=4>&nbsp;</TD>
              </TR>
              <TR height=30>
                <TD width=380>&nbsp;</TD>
                <TD>&nbsp;</TD>
                <TD>&nbsp;
                <font size=4 style="font-size:12px;color: red;">
                 <%
                    if (errmsg != null && errmsg.equals("error1"))
                          out.print("您输入的用户名或者密码不正确!");
					else if (errmsg != null && errmsg.equals("error2"))
						out.print("请先登陆!");
 				%> 
                </font>
                </TD>
                <TD>&nbsp;</TD>
              </TR>
				<TR height=40>
                <TD rowSpan=4>&nbsp;</TD>
                <TD>用户名：</TD>
                <TD>
                  <INPUT class=textbox id=txtUserName name=username>
                </TD>
                <TD width=120>&nbsp;</TD>
              </TR>
              <TR height=40>
                <TD>密　码：</TD>
                <TD>
                  <INPUT class=textbox id=txtUserPassword type=password name=password>
                </TD>
                <TD width=120>&nbsp;</TD>
              </TR>
              <!--
              <TR height=40>
                <TD>验证码：</TD>
                <TD vAlign=center colSpan=2>
                  <INPUT id=txtSN size=4 name=txtSN class=textbox>
                  &nbsp; <IMG  border=0> <A id=LinkButton1 href="#">不清楚，再来一张</A></TD>
              </TR>
              -->
              <TR height=40>
              </TR>
              <TR height=40>
                <TD>
                </TD>
                <TD align=left>
                  <INPUT class=btnLogin id=btnLogin type=button value="登   录" name=btnLogin onclick="javascript:OK_onClick()">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  <INPUT class=btnLogin type=reset value="重   置" name=reset>
                </TD>
                <TD width=120>&nbsp;</TD>
              </TR>
              <TR height=110>
                <TD colSpan=4>&nbsp;</TD>
              </TR>
            </TBODY>
          </TABLE>
        </TD>
      </TR>
      <TR id=root height=104>
        <TD>&nbsp;
        </TD>
      </TR>
    </TBODY>
  </TABLE>
  </form>
</DIV>
<DIV id=div2 style="DISPLAY: none"></DIV>
</CONTENTTEMPLATE>
</BODY>
</HTML>
