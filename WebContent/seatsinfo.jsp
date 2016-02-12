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
		else if (  user.getUserType() != 0 &&  user.getUserType() != -1) 
		{
	%>
		您无权查看个人座位预定页面。
		<a href="message.jsp"> back </a>
		<div id="div" style="display: none" >
	<% 
		}	
		else 
		{
	%>
		当前用户：<%=user.getStudentnum() %>
		<li><a href="student_message.jsp">学生界面</a></li>
	<% 
		}
	%>
<li><a href="login.jsp">用户登录</a></li>
<li><a href="message.jsp">当前用户</a></li>
<li><a href="ExitServlet">用户退出</a></li>

<div class="div3"> 
<form action="DeleteServlet" method="post" onSubmit="return login(this);">
<%
	ArrayList<String> onesseats = (ArrayList<String>)session.getAttribute("onesSeats");
	if (onesseats != null && onesseats.size() > 0)
	{
	for (int i = 0 ; i < onesseats.size() ; i ++)
	{
%>
		<table align="center" width="300" border="1" height="50" bordercolor="#E8F4CC">
			<tr>
	    		<td align="center" colspan="2">
	    			
	    			<span style="font-weight: bold;font-size: 18px;">
	    			<%=onesseats.get(i) %>
	    			<input type = "radio" name = "delete" id = <%=i %> value = <%=i %>>
	    			</span>
	    			
	    		</td>
	    	</tr>
		</table>
<%
	}
	}
%>

		
		<%
		if (onesseats == null || onesseats.size() == 0)
		{
		%>
		<div id="table" style="display: none" >
		<%
		}
		%>
		<table align="center" width="300" border="0" class="tb1">
		<tr>
				<td colspan="2" align="center" height="50">
					<input type="submit" value="删 除">
					<input type="reset" value="重 置">
				</td>
		</tr>
		</table>
		
</form>
</div>
</body>
</html>