<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="util.User" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>提示信息</title>
		<link rel="stylesheet" type="text/css" href="images/styles.css">
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
		<br>
		
		 <%
    	// 获取提示信息
		String info = (String)request.getAttribute("info");
    	// 如果提示信息不为空，则输出提示信息
		if(info != null){
			%>
			提示信息:<%=info%>
		<%
		}
    	%>
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
		else if (user.getUserType() == 2)
		{
	%>
		当前用户：<%=user.getStudentnum() %>
		<li><a href="teacher_message.jsp">管理员界面</a></li>
	<% 
		}
	%>
  <div align="center">
  <div class="top">提示信息</div>
	  <div align="left">
		  	<div class="div1">
		  		
		  		<div class="bottom">
					<div class="div2">
				  		<ul>
				  			<li><a href="changepw.jsp">修改密码</a></li>
				  			<li><a href="login.jsp">用户登录</a></li>
				  			<li><a href="message.jsp">当前用户</a></li>
				  			<li><a href="ExitServlet">用户退出</a></li>
				  		</ul>
				  	</div>

				  	 <br>
				  	 <br>
				  	 <div class="div3"> 
				  	 
					    <% 



					    	// 判断用户是否登录
							if(user != null){
						%>
						
						<table align="center" width="350" border="1" height="200" bordercolor="#E8F4CC">
							<tr>
					    		<td align="center" colspan="2">
					    			当前用户：
					    			<span style="font-weight: bold;font-size: 18px;"><%=user.getStudentnum() %></span>
					    			
					    		</td>
					    	</tr>
					    	<tr>
					    		<td align="right">电子邮箱：</td>
					    		<td><%=user.getEmail()%></td>
					    	</tr>
						</table>
						<%								
							}
					    %>
		<%
    	// 获取提示信息
		String info = (String)request.getAttribute("info");
    	// 如果提示信息不为空，则输出提示信息
		if(info != null){
			//System.out.print(info);
			%>
			提示信息:<%=info%>
		<%
		}
    	%>
					
						
				  	 </div>
				</div>
		  	</div>
	  </div>
	</body>
</html>
