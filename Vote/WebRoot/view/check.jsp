<% 
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");
%><%
  if((String)session.getAttribute("Enter")!="true"){
     String errmsg="error2";
     response.sendRedirect("login.jsp?errmsg="+errmsg);
     return;
   }
%>