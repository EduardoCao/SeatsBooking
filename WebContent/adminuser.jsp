<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="util.User" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户管理</title>
</head>
<body>
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
		else if (  user.getUserType() != 2) 
		{
	%>
		您无权查看管理员页面。
		<a href="message.jsp"> back </a>
		<div id="div" style="display: none" >
	<% 
		}	
		else 
		{
	%>
		当前用户：<%=user.getStudentnum() %>
	<% 
		}
	%>
  	  <div align="center">

			<div class="div5">
		  		<ul>
		  			<a href="reg.jsp">用户注册</a>
		  			<br>
		  			<a href="./AdminUserServlet">显示所有用户状态</a>
		  			<br>


		  		</ul>
		  	</div>

			
	  </div>
<a href="admin_message.jsp">管理员界面</a>  	
	</div>
	</div>
</body>
</html>