<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.vote.service.*"%>
<%@page import="com.vote.bean.*"%>
<%
	String errMsg="";
	String replayCode = "";
    String replayIp = Func.getIpAddr(request);
    System.out.println("replayIp "+replayIp);
    String id = request.getParameter("oid");//主题Id
	int oid = Integer.parseInt(id);
	ObjectBean ob = ObjectBeanService.findObjectBeanByID(oid);
	if("1".equals(ob.getAnonymousFlag()))
	{
		replayCode = "anonymous";//匿名
	}
	if("0".equals(ob.getAnonymousFlag()))
	{
		String userName = Func.getString(session.getAttribute("userName"));
		if("".equals(userName)){
		     String errmsg="error2";
		     response.sendRedirect("login.jsp?errmsg="+errmsg);
		     return;
		   }
		else{
			replayCode = userName;
		}
	}
	int status = ob.getState();
	System.out.println("问卷状态: "+status);
	if(status==2)
	{
		errMsg = "该问卷已终止评议，不能提交!";
		errMsg = java.net.URLEncoder.encode(errMsg,"UTF-8");
		response.sendRedirect("voteFail.jsp?errMsg="+errMsg);
		return;
	}
	if(ReplayService.exit(oid,replayIp,replayCode))
    {
		errMsg = "您的答案已提交，不能重复提交!";
		errMsg = java.net.URLEncoder.encode(errMsg,"UTF-8");
		response.sendRedirect("voteFail.jsp?errMsg="+errMsg);
		System.out.println(errMsg);
		return;
	}
    
	Enumeration e = request.getParameterNames();
	List lname = new LinkedList();
	List<Answer> answers = new ArrayList<Answer>();
	Map map = new HashMap();
	while (e.hasMoreElements()) {//取得所有参数名
		String key = (String) e.nextElement();
		if (key.startsWith("sub") || key.startsWith("oid"))
			key = (String) e.nextElement();
		String ln2 = key.substring(key.length() - 2);//截取参数的后两个字符，以利于参数的正确排序
		map.put(ln2, key);
		lname.add(ln2);
		Collections.sort(lname);
	}
	
	//回复信息
	Replay replay = new Replay();
	replay.setReplayCode(replayCode);
	replay.setReplayIp(replayIp);
	replay.setoId(oid);
	replay.setRemark("");
	
	//取得参数的值
	for (int i = 0; i < lname.size(); i++) {
		
		String name = (String) map.get(lname.get(i));
		//System.out.println("name:" + name);
		
		//判断是否为复选框
		if (name.startsWith("check")) {
			String checkbox[] = request.getParameterValues(name);
			if (checkbox != null) {
				int size = checkbox.length;
				String s = "";
				for (int j = 0; j < size; j++) {
				Answer answer = new Answer();
				answer.setOid(oid);
				answer.setqSeq(Integer.parseInt(name.substring(name.lastIndexOf("_")+1)));
				String cValue = checkbox[j];
				//System.out.println(checkbox[j] +cValue);
				int seSeq = Integer.parseInt(cValue);
				answer.setSeSeq(seSeq);
				answer.setSeValue(cValue);
				answers.add(answer);
			  }
			}
		} else if(name.startsWith("radio") || name.startsWith("select")) {
			Answer answer = new Answer();
			answer.setOid(oid);
			answer.setqSeq(Integer.parseInt(name.substring(name.lastIndexOf("_")+1)));
			String value = request.getParameter(name);
			//System.out.println(value);
			int seSeq = Integer.parseInt(value);
			answer.setSeSeq(seSeq);
			answer.setSeValue(value);
			answers.add(answer);
		}else if(name.startsWith("txt")) {
			Answer answer = new Answer();
			answer.setOid(oid);
			answer.setqSeq(Integer.parseInt(name.substring(name.lastIndexOf("_")+1)));
			String value = request.getParameter(name);
			//System.out.println(value);
			answer.setSeSeq(1);
			answer.setSeValue(value);
			answers.add(answer);
		}
	}
	
	boolean falg = ReplayService.save(replay,answers);
	if(falg) System.out.println("提交答案成功！");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>提示信息</title>
<style>
body {margin:0;padding:0;font-size:12px;color:#0c6868;background:#ecf8f5;}
/* Link */
a:link {color: #09797b; text-decoration:none;}
a:visited {color: #09797b;text-decoration:none;}
a:hover {color: #d9964d; text-decoration:underline;}
a:active {color: #09797b;}
</style>
<script type="text/javascript" src=""></script>
</head>
<body style="text-align:center">
<div style="width:50%;margin:0 auto;margin-top:15%;">
<div style="font-weight:bold;background:url(images/tishi_title_bg.gif) repeat-x;height:32px;">
<div style="background:url(images/corner2.gif) no-repeat;width:4px;float:right;height:32px;"></div>
<div style="background:url(images/corner1.gif) no-repeat;width:100px;height:23px;padding:9px 0 0 10px;text-align:center;"></div></div>
<div style="background:#fff;border-left:1px solid #b5e1d6;border-right:1px solid #b5e1d6;text-align:center;height:120px;padding-top:20px;"><span style="font-size:18px;font-family:黑体;">感谢参与</span>
<p style="margin:5px;text-align:left;padding:0 20px;text-indent:2em;line-height:1.6em;font-size:14px;">感谢您在百忙之中，能抽出时间参与本次调研活动，您的宝贵意见将会为我们日后工作提供很大帮助，非常感谢您的参与和对我们工作的支持。
<br/>
</p>
</div>
<div style="background:url(images/tishi_bottom_bg.gif);height:5px;font-size:0;">
<div style="background:url(images/corner4.gif) no-repeat;width:4px;float:right;height:4px;"></div>
<div style="background:url(images/corner3.gif) no-repeat;width:4px;height:4px;"></div>
</div>
</div>
</body>
</html>