<%@ page language="java" contentType="text/html" pageEncoding="GBK"%>
<%@ page import="util.User" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>Administration</title>
		<link rel="stylesheet" type="text/css" href="images/styles.css">
	</head>

	<body>
	  	<% 
		User user = (User)session.getAttribute("user");
	    // �ж��û��Ƿ��¼
		if(user == null){
			user = new User();
			user.setStudentnum(null);
			//session.invalidate(); 
	%>
		<a href="login.jsp">���¼��</a>
		<div id="div" style="display: none" >
	
	<%
		}
		else if (  user.getUserType() != 2) 
		{
	%>
		����Ȩ�鿴����Աҳ�档
		<a href="message.jsp"> back </a>
		<div id="div" style="display: none" >
	<% 
		}	
		else 
		{
	%>
		��ǰ�û���<%=user.getStudentnum() %>
	<% 
		}
	%>
  <div align="center">
  <div class="top">Administrator</div>
	  <div align="left">
		  	<div class="div1">
		  		
		  		<div class="bottom">
					<div class="div2">
				  		<ul>
				  			<li><a href="login.jsp">�û���¼</a></li>
				  			<li><a href="message.jsp">��ǰ�û�</a></li>
				  			<li><a href="ExitServlet">�û��˳�</a></li>
				  		</ul>
				  	</div>

				</div>
		  	</div>
	  </div>
	  	  <div align="center">

					<div class="div5">
				  		<ul>

				  			<a href="./adminuser.jsp">�����û�</a>
				  			<br>
				  			<a href="./AdminSeatServlet">������λԤ��</a>
				  			<br>
				  			<a href="./AdminGroupServlet">����Ԥ��</a>

				  		</ul>
				  	</div>

		  	
	  </div>
	  </div>
	</body>
</html>
