<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="util.User" %>
<%@ page import="util.Seats" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>show personal seats</title>
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
	    <form action="./PersonalSeatsServlet" method="post" onsubmit="return reg(this);">
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
 	 Seats[] seats = new Seats[10];
  	 seats = (Seats[])session.getAttribute("seats");
  	 String date = (String) session.getAttribute("bookdate");
  	int ddate = 0;
  	if(date != null){
  	  ddate = Integer.parseInt(date);
  	 ddate += 1;
  	}
	if(seats != null){ 
	%>
	<div align="center">
	<form action="./DelSeatServlet" method="post" onsubmit="return reg(this);">
	<table align="center" width="50" border="1" height="40" bordercolor="#E8F4CC">
		<tr>
    		<td align="center" colspan="2">
    			 第<%=ddate + "" %>天 
    			 <input type = 'hidden' name = "bookdate" value = <%=ddate - 1%>>
    		</td>
    	</tr>
    </table>
    
   
  	  
  	  取消个人座位的预定
  	  
  	  <table align="center" width="300" border="1" height="50" bordercolor="#E8F4CC">
<%

	for (int i = 0 ; i < seats.length ; i ++)
	{
		
%>
		<tr>
  		<td align="center" colspan="2">
  			<span style="font-weight: bold;font-size: 18px;">
  			
  			<%
  			if( seats[i].getOwnerPeroid0() != null )
  			{
  			%>
  			
  			<%="seat" + i + " period0"  + " " + seats[i].getPeroid0() + " " + seats[i].getOwnerPeroid0()%>
  			<input type = "radio" name = "delSeat" id = <%=i + "_0" %> value = <%=i + "_0_" + seats[i].getPeroid0()  %>>
  			<br>
  			
  			<%
  			}
  			if( seats[i].getOwnerPeroid1() != null)
  			{
  			%>
  			
  			<%="seat" + i + " period1"  + " " + seats[i].getPeroid1() + " " + seats[i].getOwnerPeroid1()%>
  			<input type = "radio" name = "delSeat" id = <%=i + "_1" %> value = <%=i + "_1_" + seats[i].getPeroid1() %>>
  			<br>
  			
  			<%
  			}
  			if( seats[i].getOwnerPeroid2() != null)
  			{
  			%>
  			
  			<%="seat" + i + " period2"  + " " + seats[i].getPeroid2() + " " + seats[i].getOwnerPeroid2()%>
  			<input type = "radio" name = "delSeat" id = <%=i + "_2" %> value = <%=i + "_2_" + seats[i].getPeroid2()%>>
  			<br>
  			
  			<%
  			}
  			if( seats[i].getOwnerPeroid3() != null)
  			{
  			%>
  			
  			<%="seat" + i + " period3"  + " " + seats[i].getPeroid3() + " " + seats[i].getOwnerPeroid3()%>
  			<input type = "radio" name = "delSeat" id = <%=i + "_3" %> value = <%=i + "_3_" + seats[i].getPeroid3()  %>>
  			<br>
  			
  			<%
  			}
  			if( seats[i].getOwnerPeroid4() != null)
  			{
  			%>
  			
  			<%="seat" + i + " period4"  + " " + seats[i].getPeroid4() + " " + seats[i].getOwnerPeroid4()%>
  			<input type = "radio" name = "delSeat" id = <%=i + "_4" %> value = <%=i + "_4_" + seats[i].getPeroid4() %>>
  			<br>
  			
  			<%
  			}
  			%>
  			</span>
  		</td>
<%
		
	}
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
					<input type="submit" value="取消用户预定">
					<input type="reset" value="重 置">
				</td>
		</tr>
		</table>
			
	  </div>
</form>	
<% 
if(seats != null){ 
%>
<div align="center">
		添加个人座位的预定
</div>
<div align="center">
<form action="./AddSeatServlet" method="post" onsubmit="return reg(this);">
<table align="center" width="300" border="1" height="50" bordercolor="#E8F4CC">
<td align="right">用户：</td>
   		<td>
   			<select name="bookuser">
   			<%
   			ArrayList<User> showallusers = (ArrayList<User>)session.getAttribute("showallusers");
   			for (int j = 0 ; j < showallusers.size() ; j ++)
   			{
   				if(showallusers.get(j).getUserType() == 0)
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
		if(seats[i].getPeroid0() == 0)
		{
		
%>
		
  			
  			<%="seat" + i + " period0"  + " " + seats[i].getPeroid0() + " " + seats[i].getOwnerPeroid0()%>
  			<input type = "radio" name = "addSeat" id = <%=i + "_0" %> value = <%=i + "_0_" + seats[i].getPeroid0()  %>>
  			<br>
  		<%
  		}
		if(seats[i].getPeroid1() == 0)
		{
		%>
		
  			<%="seat" + i + " period1"  + " " + seats[i].getPeroid1() + " " + seats[i].getOwnerPeroid1()%>
  			<input type = "radio" name = "addSeat" id = <%=i + "_1" %> value = <%=i + "_1_" + seats[i].getPeroid1() %>>
  			<br>
  		<%
		}
		if(seats[i].getPeroid2() == 0)
		{
  		%>
  			
  			<%="seat" + i + " period2"  + " " + seats[i].getPeroid2() + " " + seats[i].getOwnerPeroid2()%>
  			<input type = "radio" name = "addSeat" id = <%=i + "_2" %> value = <%=i + "_2_" + seats[i].getPeroid2() %>>
  			<br>
  	<%
		}
		if(seats[i].getPeroid3() == 0)
		{
  	%>
  			<%="seat" + i + " period3"  + " " + seats[i].getPeroid3() + " " + seats[i].getOwnerPeroid3()%>
  			<input type = "radio" name = "addSeat" id = <%=i + "_3" %> value = <%=i + "_3_" + seats[i].getPeroid3()  %>>
  			<br>
  		<%
		}
		if(seats[i].getPeroid4() == 0)
		{
  		%>
  			<%="seat" + i + " period4"  + " " + seats[i].getPeroid4() + " " + seats[i].getOwnerPeroid4()%>
  			<input type = "radio" name = "addSeat" id = <%=i + "_4" %> value = <%=i + "_4_" + seats[i].getPeroid4() %>>
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
</div>

<%
}
%>

</div> 			 

<a href="admin_message.jsp">管理员界面</a>   	 
</body>
</html>