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
  <div align="center">
  <div class="top">提示信息</div>
	  <div align="left">
		  	<div class="div1">
		  		
		  		<div class="bottom">
					<div class="div2">
				  		<ul>
				  			<!-- <li><a href="reg.jsp">用户注册</a></li> -->
				  			<li><a href="login.jsp">用户登录</a></li>
				  			<li><a href="message.jsp">当前用户</a></li>
				  			<li><a href="ExitServlet">用户退出</a></li>
				  		</ul>
				  	</div>
				  	<script language=javascript>
							String info = (String)request.getAttribute("info");
					    	// 如果提示信息不为空，则输出提示信息
							if(info != null){
								alert(info);
							}
					</script>
				  	 <div class="div3"> 
				  	 
					    <% 
					    	// 获取提示信息
							String info = (String)request.getAttribute("info");
					    	// 如果提示信息不为空，则输出提示信息
							if(info != null){
								out.println(info);
							} 


					    	// 获取登录的用户信息
							User user = (User)session.getAttribute("user");
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
							}else{
								out.println("<br>请登录！");
							}
					    	
						%>
				  	 </div>
				</div>
		  	</div>
	  </div>
	</body>
</html>