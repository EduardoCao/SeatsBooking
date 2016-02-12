<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="util.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>显示所有用户</title>
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
  	  
  	  <form action="DeleteUserServlet" method="post" onSubmit="return login(this);">
  	  
  	  删除用户
  	  
<%
	ArrayList<User> showallusers = (ArrayList<User>)session.getAttribute("showallusers");
	if (showallusers != null && showallusers.size() > 0)
	{
	for (int i = 0 ; i < showallusers.size() ; i ++)
	{
%>
		<table align="center" width="300" border="1" height="50" bordercolor="#E8F4CC">
			<tr>
	    		<td align="center" colspan="2">
	    			
	    			<span style="font-weight: bold;font-size: 18px;">
	    			
	    			<%=showallusers.get(i).getStudentnum() + "\t\t" + showallusers.get(i).getEmail() + "\t\t" + showallusers.get(i).getUserType()%>
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
		if (showallusers == null || showallusers.size() == 0)
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
			
	  </div>

</form>	

		<div align="center">
		违规用户关禁闭
		</div>
  	  <form action="CloseUserServlet" method="post" onSubmit="return login(this);">
<%
	//ArrayList<User> showallusers = (ArrayList<User>)session.getAttribute("showallusers");
	if (showallusers != null && showallusers.size() > 0)
	{
	for (int i = 0 ; i < showallusers.size() ; i ++)
	{
		if(showallusers.get(i).getUserType() >= 0){
%>
		<table align="center" width="300" border="1" height="50" bordercolor="#E8F4CC">
			<tr>
	    		<td align="center" colspan="2">
	    			
	    			<span style="font-weight: bold;font-size: 18px;">
	    			
	    			<%=showallusers.get(i).getStudentnum() + "\t\t" + showallusers.get(i).getEmail() + "\t\t" + showallusers.get(i).getUserType()%>
	    			<input type = "radio" name = "closeUser" id = <%=i %> value = <%=i %>>
	    			</span>
	    			
	    		</td>
	    	</tr>
		</table>
<%
	}
	}
	}
%>
	<%
		if (showallusers == null || showallusers.size() == 0)
		{
		%>
		<div id="table" style="display: none" >
		<%
		}
		%>
		<table align="center" width="300" border="0" class="tb1">
		<tr>
				<td colspan="2" align="center" height="50">
					<input type="submit" value="禁 足">
					<input type="reset" value="重 置">
				</td>
		</tr>
		</table>
			
	  </div>
</form>	

<div align="center">
		放出关禁闭用户
		</div>
		
  	  <form action="OpenUserServlet" method="post" onSubmit="return login(this);">
<%

	

	if (showallusers != null && showallusers.size() > 0)
	{
	for (int i = 0 ; i < showallusers.size() ; i ++)
	{
		if(showallusers.get(i).getUserType() < 0)
		{	
			HashMap<String , String> closetime = (HashMap<String , String>)session.getAttribute("closetime");
			
%>
		<table align="center" width="300" border="1" height="50" bordercolor="#E8F4CC">
			<tr>
	    		<td align="center" colspan="2">
	    			
	    			<span style="font-weight: bold;font-size: 18px;">
	    			
	    			<%=showallusers.get(i).getStudentnum() + "\t\t" + showallusers.get(i).getEmail() + "\t\t" + showallusers.get(i).getUserType() + "\t\t" + closetime.get(showallusers.get(i).getStudentnum())%>
	    			<input type = "radio" name = "openUser" id = <%=i %> value = <%=i %>>
	    			</span>
	    			
	    		</td>
	    	</tr>
		</table>
<%
		}
	}
	}
%>
	<%
		if (showallusers == null || showallusers.size() == 0)
		{
		%>
		<div id="table" style="display: none" >
		<%
		}
		%>
		<table align="center" width="300" border="0" class="tb1">
		<tr>
				<td colspan="2" align="center" height="50">
					<input type="submit" value="解 禁">
					<input type="reset" value="重 置">
				</td>
		</tr>
		</table>
		
			
	  </div>
<a href="admin_message.jsp">管理员界面</a>  
</form>	
<div align="center">
		
 <form action="CheckCloseUserServlet" method="post" onSubmit="return login(this);">
 	<input type="button" name="checkclose" value="检查禁足是否到期" onclick="form.submit()">
 </form>
</div>
	</div>
	</div>
</body>
</html>