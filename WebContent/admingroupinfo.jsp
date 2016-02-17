<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="util.User" %>
<%@ page import="util.Seats" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>admin group info</title>
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
<form action="AdminDelGroupServlet" method="post" onSubmit="return login(this);">
<div align="center">
		已批准 
</div>
<table align="center" width="1000" border="1" height="50" bordercolor="#E8F4CC">
 <%
 	 ArrayList<String> allGroupInfo = new ArrayList<String>();
 	 allGroupInfo = (ArrayList<String>) session.getAttribute("allGroupInfo");
  	 
	if(allGroupInfo != null && allGroupInfo.size() > 0){
		for (int i = 0 ; i < allGroupInfo.size() ; i ++)
		{
			if(allGroupInfo.get(i).subSequence(0, 1).equals("1"))
			{
	%>
		<tr>
	    		<td align="center" colspan="2">
	    			
	    			<span style="font-weight: bold;font-size: 18px;">
	    			<%=allGroupInfo.get(i)%>
	    			<input type = "radio" name = "deletegroup" id = <%=i %> value = <%=i %>>
	    			</span>
	    			
	    		</td>
	    	</tr>
	<%
			}
		}
	}

	%>
</table>
<table align="center" width="300" border="0" class="tb1">
		<tr>
				<td colspan="2" align="center" height="50">
					<input type="submit" value="删 除">
					<input type="reset" value="重 置">
				</td>
		</tr>
</table>

</form>
<form action="ProveGroupServlet" method="post" onSubmit="return login(this);">
<div align="center">
		待审批批准
</div>
<table align="center" width="1000" border="1" height="50" bordercolor="#E8F4CC">
 <%
 	 //ArrayList<String> allGroupInfo = new ArrayList<String>();
 	 allGroupInfo = (ArrayList<String>) session.getAttribute("allGroupInfo");
  	 
	if(allGroupInfo != null && allGroupInfo.size() > 0){
		for (int i = 0 ; i < allGroupInfo.size() ; i ++)
		{
			if(allGroupInfo.get(i).subSequence(0, 1).equals("0"))
			{
	%>
		<tr>
	    		<td align="center" colspan="2">
	    			
	    			<span style="font-weight: bold;font-size: 18px;">
	    			<%=allGroupInfo.get(i)%>
	    			<input type = "radio" name = "provegroup" id = <%=i %> value = <%=i %>>
	    			</span>
	    			
	    		</td>
	    	</tr>
	<%
			}
		}
	}

	%>
</table>	

<table align="center" width="300" border="0" class="tb1">
		<tr>
				<td colspan="2" align="center" height="50">
					<input type="submit" value="批 准">
					<input type="reset" value="重 置">
				</td>
		</tr>
</table>

</form>

<form action="DeclineGroupServlet" method="post" onSubmit="return login(this);">
<div align="center">
		待审批拒绝
</div>
<table align="center" width="1000" border="1" height="50" bordercolor="#E8F4CC">
 <%
 	 //ArrayList<String> allGroupInfo = new ArrayList<String>();
 	 allGroupInfo = (ArrayList<String>) session.getAttribute("allGroupInfo");
  	 
	if(allGroupInfo != null && allGroupInfo.size() > 0){
		for (int i = 0 ; i < allGroupInfo.size() ; i ++)
		{
			if(allGroupInfo.get(i).subSequence(0, 1).equals("0"))
			{
	%>
		<tr>
	    		<td align="center" colspan="2">
	    			
	    			<span style="font-weight: bold;font-size: 18px;">
	    			<%=allGroupInfo.get(i)%>
	    			<input type = "radio" name = "declinegroup" id = <%=i %> value = <%=i %>>
	    			</span>
	    			
	    		</td>
	    	</tr>
	<%
			}
		}
	}

	%>
</table>	

<table align="center" width="300" border="0" class="tb1">
		<tr>
				<td colspan="2" align="center" height="50">
					<input type="submit" value="拒 绝">
					<input type="reset" value="重 置">
				</td>
		</tr>
</table>

</form>


<a href="admin_message.jsp"> back </a>

</body>
</html>