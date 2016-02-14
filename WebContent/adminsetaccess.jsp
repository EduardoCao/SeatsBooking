<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="util.User" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>开放和关闭指定时段的预约权限</title>

</head>
<body>
<% 
		User user = (User)session.getAttribute("user");
	    // 判断用户是否登录
		if(user == null){
			user = new User();
			user.setStudentnum(null);
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
  	  
  	  <form action="ClosePeriodServlet" method="post" onSubmit="return login(this);">
  	  
  	  关闭时间段
  	  
  	  <table align="center" width="300" border="1" height="50" bordercolor="#E8F4CC">
<%
	ArrayList<String> seataccess = (ArrayList<String>)session.getAttribute("seataccess");
	int tmp = 0;
	if (seataccess != null && seataccess.size() > 0)
	{
		
	for (int i = 0 ; i < seataccess.size() ; i ++)
	{
		if(!seataccess.get(i).split("_")[2].equals("3"))
		{
			tmp += 1;
%>
			<tr>
   			<td align="center" colspan="2">
   			<span style="font-weight: bold;font-size: 18px;">
   			
   			<%=seataccess.get(i)%>
   			<input type = "radio" name = "closeSeat" id = <%=seataccess.get(i) %> value = <%=seataccess.get(i) %>>
   			</span>
   			</td>
<%
		}	
	}
	}
%>
</table>
<%
		if (tmp == 0)
		{
		%>
		<div id="table" style="display: none" >
		<%
		}
		%>
		<table align="center" width="300" border="0" class="tb1">
		<tr>
				<td colspan="2" align="center" height="50">
					<input type="submit" value="关 闭">
					<input type="reset" value="重 置">
				</td>
		</tr>
		</table>
			
	  </div>
</form>	

  	  <form action="OpenPeriodServlet" method="post" onSubmit="return login(this);">
  	  
<div align="center">
		开放时间段
		</div>
  	  
  	  <table align="center" width="300" border="1" height="50" bordercolor="#E8F4CC">
<%
	//ArrayList<String> seataccess = (ArrayList<String>)session.getAttribute("seataccess");
	int tmp1 = 0;
	if (seataccess != null && seataccess.size() > 0)
	{
		
	for (int i = 0 ; i < seataccess.size() ; i ++)
	{
		if(seataccess.get(i).split("_")[2].equals("3"))
		{
			tmp1 = tmp1 + 1;
%>
			<tr>
   			<td align="center" colspan="2">
   			<span style="font-weight: bold;font-size: 18px;">
   			
   			<%=seataccess.get(i)%>
   			<input type = "radio" name = "openSeat" id = <%=seataccess.get(i) %> value = <%=seataccess.get(i) %>>
   			</span>
   			</td>
<%
		}	
	}
	}
%>
</table>
<%
		if (tmp1 == 0)
		{
		%>
		<div id="table" style="display: none" >
		<%
		}
		%>
		<table align="center" width="300" border="0" class="tb1">
		<tr>
				<td colspan="2" align="center" height="50">
					<input type="submit" value="开 启">
					<input type="reset" value="重 置">
				</td>
		</tr>
		</table>
			
	  </div>
</form>	

</div>
<br>
<a href="admin_message.jsp">管理员界面</a> 
</body>
 
</html>