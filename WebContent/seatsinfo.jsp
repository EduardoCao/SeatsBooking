<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.ArrayList" %>
<%@ page import="util.User" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>seats info</title>
</head>
<body>
SEATS INFO
<li><a href="login.jsp">用户登录</a></li>
<li><a href="message.jsp">当前用户</a></li>
<li><a href="ExitServlet">用户退出</a></li>


	<% 
		User user = (User)session.getAttribute("user");
	    // 判断用户是否登录
		if(user == null){
			user = new User();
			user.setStudentnum(null);
			//session.invalidate(); 
	%>
		<a href="login.jsp">请登录！</a>
		<div id="div" style="display: none" >
	<%
		}
		else if (user.getUserType() == 0)
		{
	%>
		当前用户：<%=user.getStudentnum() %>
		<li><a href="student_message.jsp">学生界面</a></li>
	<% 
		}
		else if (user.getUserType() == 1)
		{
	%>
		当前用户：<%=user.getStudentnum() %>
		<li><a href="teacher_message.jsp">教师界面</a></li>
	<% 
		}
	%>
<%
	ArrayList<String> seats = (ArrayList<String>)session.getAttribute("onesSeats");
	for (int i = 0 ; i < seats.size() ; i ++)
	{
%>
		<table align="center" width="300" border="1" height="50" bordercolor="#E8F4CC">
			<tr>
	    		<td align="center" colspan="2">
	    			
	    			<span style="font-weight: bold;font-size: 18px;"><%=seats.get(i) %></span>
	    			
	    		</td>
	    	</tr>
		</table>
<%
	}
%>


</body>
</html>