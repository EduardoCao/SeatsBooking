<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="util.User" %>
<%@ page import="util.Seats" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>add group</title>
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
<div class="div3"> 
	    <form action="./AdminGroupInfoServlet" method="post" onsubmit="return reg(this);">
		    <table align="center" width="450" border="0">
		    	
		    		<td align="right">日期：</td>
		    		<td>
		    			<select name="bookdate">
		    				<option selected value = "6"> 第七天 </option>
		    				<option selected value = "5"> 第六天 </option>
		    				<option selected value = "4"> 第五天 </option>
		    				<option selected value = "3"> 第四天 </option>
		    				<option selected value = "2"> 第三天 </option>
		    				<option selected value = "1"> 第二天 </option>
		    				<option selected value = "0"> 今天 </option>
		    			</select>
		    			
		    		</td>

		    	</tr>
		    	<tr>
		    		<td colspan="2" align="center">
		    			<input type="submit" value="查 询">
		    			<input type="reset" value="重 置">
		    		</td>
		    	</tr>
		    </table>
	    </form>
  	 </div>
<%
 	 Seats[] seats = new Seats[2];
  	 seats = (Seats[])session.getAttribute("groupseats");
  	 String date = (String) session.getAttribute("bookdate");
  	int ddate = 0;
  	if(date != null){
  	  ddate = Integer.parseInt(date);
  	 ddate += 1;
  	}

if(seats != null){ 
%>
<div align="center">
		添加团体座位的预定
</div>
<table align="center" width="80" border="1" height="40" bordercolor="#E8F4CC">
		<tr>
    		<td align="center" colspan="2">
    			 第<%=ddate + "" %>天 
    			 <input type = 'hidden' name = "bookdate" value = <%=ddate - 1%>>
    		</td>
    	</tr>
    </table>
<div align="center">
<form action="./AddGroupServlet" method="post" onsubmit="return reg(this);">
<table align="center" width="300" border="1" height="50" bordercolor="#E8F4CC">
<td align="right">用户：</td>
   		<td>
   			<select name="bookuser">
   			<%
   			ArrayList<User> showallusers = (ArrayList<User>)session.getAttribute("showallusers");
   			for (int j = 0 ; j < showallusers.size() ; j ++)
   			{
   				if(showallusers.get(j).getUserType() == 0 || showallusers.get(j).getUserType() == 1)
   				{
   			%>
   				<option selected value = <%=showallusers.get(j).getStudentnum() %>> <%=showallusers.get(j).getStudentnum() %> </option>
   				
   			
   			<%
   				}
   			}
   			%>
   			</select>
   			
   		</td>
<%

	for (int i = 0 ; i < seats.length ; i ++)
	{
		%>
		<tr>
  		<td align="center" colspan="2">
  			<span style="font-weight: bold;font-size: 18px;">
		<% 
		if(seats[i].getPeroid0() == 0 || (seats[i].getPeroid0() == 2 && seats[i].getOwnerPeroid0() == null))
		{
		
%>
		
  			
  			<%="seat" + i + " period0"  + " " + seats[i].getPeroid0() + " " + seats[i].getOwnerPeroid0()%>
  			<input type = "radio" name = "addGroup" id = <%=i + "_0" %> value = <%=i + "_0" %>>
  			<br>
  		<%
  		}
		if(seats[i].getPeroid1() == 0 || (seats[i].getPeroid1() == 2 && seats[i].getOwnerPeroid1() == null))
		{
		%>
		
  			<%="seat" + i + " period1"  + " " + seats[i].getPeroid1() + " " + seats[i].getOwnerPeroid1()%>
  			<input type = "radio" name = "addGroup" id = <%=i + "_1" %> value = <%=i + "_1" %>>
  			<br>
  		<%
		}
		if(seats[i].getPeroid2() == 0 || (seats[i].getPeroid2() == 2 && seats[i].getOwnerPeroid2() == null))
		{
  		%>
  			
  			<%="seat" + i + " period2"  + " " + seats[i].getPeroid2() + " " + seats[i].getOwnerPeroid2()%>
  			<input type = "radio" name = "addGroup" id = <%=i + "_2" %> value = <%=i + "_2" %>>
  			<br>
  	<%
		}
		if(seats[i].getPeroid3() == 0 || (seats[i].getPeroid3() == 2 && seats[i].getOwnerPeroid3() == null))
		{
  	%>
  			<%="seat" + i + " period3"  + " " + seats[i].getPeroid3() + " " + seats[i].getOwnerPeroid3()%>
  			<input type = "radio" name = "addGroup" id = <%=i + "_3" %> value = <%=i + "_3" %>>
  			<br>
  		<%
		}
		if(seats[i].getPeroid4() == 0 || (seats[i].getPeroid4() == 2 && seats[i].getOwnerPeroid4() == null))
		{
  		%>
  			<%="seat" + i + " period4"  + " " + seats[i].getPeroid4() + " " + seats[i].getOwnerPeroid4()%>
  			<input type = "radio" name = "addGroup" id = <%=i + "_4" %> value = <%=i + "_4" %>>
  			<br>
  			<%
		}
  			%>
  			</span>
  		</td>
<%
		
	
	}
%>
</table>

<%
		if (seats == null || seats.length == 0)
		{
		%>
		<div id="table" style="display: none" >
		<%
		}
		%>
		<table align="center" width="300" border="0" class="tb1">
		<tr>
				<td colspan="2" align="center" height="50">
					<input type="submit" value="添加用户预定">
					<input type="reset" value="重 置">
				</td>
		</tr>
		</table>
			
	  </div>

</form>

	<%
	}
	%>
<a href="admin_message.jsp"> back </a>
</body>
</html>