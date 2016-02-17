<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="util.User" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>groupSeatsInfo</title>
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
		else if (  user.getUserType() < 0) 
		{
	%>
		您已经被管理员限制权限。
		<a href="message.jsp">back</a>
		<div id="div" style="display: none" >
	<% 
		}	
		else if (user.getUserType() != 0 && user.getUserType() != 1) 
		{
	%>
		您无权查看该页面，仅可由师生预定座位。
		<a href="message.jsp">back</a>
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
	
	
<form action="DeleteGroupServlet" method="post" onSubmit="return login(this);">

	<div align="center">
		已经预约成功 
	</div>
	<table align="center" width="1000" border="1" height="50" bordercolor="#E8F4CC">
<%
	ArrayList<String> onesGroupInfo = (ArrayList<String>)session.getAttribute("onesGroupInfo");
	if (onesGroupInfo != null && onesGroupInfo.size() > 0)
	{
	for (int i = 0 ; i < onesGroupInfo.size() ; i ++)
	{
		String flag = onesGroupInfo.get(i).split("##")[0];
		if (flag.equals("1"))
		{
%>
		
			<tr>
	    		<td align="center" colspan="2">
	    			
	    			<span style="font-weight: bold;font-size: 18px;">
	    			<%=onesGroupInfo.get(i) %>
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
<div align="center">
		正在审批
</div>
<table align="center" width="1000" border="1" height="50" bordercolor="#E8F4CC">
<%
	//ArrayList<String> onesGroupInfo = (ArrayList<String>)session.getAttribute("onesGroupInfo");
	if (onesGroupInfo != null && onesGroupInfo.size() > 0)
	{
	for (int i = 0 ; i < onesGroupInfo.size() ; i ++)
	{
		String flag = onesGroupInfo.get(i).split("##")[0];
		if (flag.equals("0"))
		{
%>
		
			<tr>
	    		<td align="center" colspan="2">
	    			
	    			<span style="font-weight: bold;font-size: 18px;">
	    			<%=onesGroupInfo.get(i) %>
	    			<input type = "radio" name = "deletegroup" id = <%=i %> value = <%=i %>>
	    			</span>
	    			
	    		</td>
	    	</tr>
		
<%
		}
	}
	}
%>
<br>
<br>
</table>
<div align="center">
		已被拒绝（被拒绝信息保留一天）
</div>
<table align="center" width="1000" border="1" height="50" bordercolor="#E8F4CC">
<%
	//ArrayList<String> onesGroupInfo = (ArrayList<String>)session.getAttribute("onesGroupInfo");
	if (onesGroupInfo != null && onesGroupInfo.size() > 0)
	{
	for (int i = 0 ; i < onesGroupInfo.size() ; i ++)
	{
		String flag = onesGroupInfo.get(i).split("##")[0];
		if (flag.equals("-1"))
		{
%>
		
			<tr>
	    		<td align="center" colspan="2">
	    			
	    			<span style="font-weight: bold;font-size: 18px;">
	    			<%=onesGroupInfo.get(i) %>
	    			<%-- <input type = "radio" name = "deletegroup" id = <%=i %> value = <%=i %>> --%>
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

<a href="message.jsp">back</a>
<br>
<a href="GroupInfoServlet">查看结果</a>

</body>
</html>