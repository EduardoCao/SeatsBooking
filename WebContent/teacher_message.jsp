<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="util.User" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>Teacher</title>
		<link rel="stylesheet" type="text/css" href="images/styles.css">
	</head>

	<body>
  <div align="center">
  <div class="top">Teacher</div>
	  <div align="left">
		  	<div class="div1">
		  		
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
		else
		{
	%>
		当前用户：<%=user.getStudentnum() %>
	<% 
		}
	%>
		  		<div class="bottom">
					<div class="div2">
				  		<ul>
				  			<!-- <li><a href="reg.jsp">用户注册</a></li> -->
				  			<li><a href="login.jsp">用户登录</a></li>
				  			<li><a href="message.jsp">当前用户</a></li>
				  			<li><a href="ExitServlet">用户退出</a></li>
				  		</ul>
				  	</div>

				</div>
		  	</div>
	  </div>
	</body>
</html>
