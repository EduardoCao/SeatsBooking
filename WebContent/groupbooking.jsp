<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="util.User" %>
<%@ page import="util.Seats" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>group booking</title>
</head>
<body>

<div align="center">
	团体座位预定
</div>


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
	<div class="div3"> 
	    <form action="./GroupSeatsServlet" method="post" onsubmit="return reg(this);">
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
	if(seats != null && seats[0] != null && seats[1] != null){ 
	%>
	<div align="center">
		第<%=ddate + "" %>天 
	</div>
	
	<form action="./GroupBookServlet" method="post" onsubmit="return reg(this);">
	<table align="center" width="650" border="1" height="100" bordercolor="#E8F4CC">
		<tr>
    		<td align="center" colspan="2">
    			 
    			 <input type = 'hidden' name = "bookdate" value = <%=ddate - 1%>>
    			 <input type = 'hidden' name = "owner" value = <%=user.getStudentnum() %>>
    			 
    			座位0是否被占用：
    			 <input type = "radio" name = "groupSeat" id = '00' value = '0_0'>  
    			 	<%
    			 	if (seats[0].getPeroid0() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[0].getPeroid0() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[0].getPeroid0() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	else if(seats[0].getPeroid0() == 3)
    			 	{
    			 	%>
    			 	关闭时间段
    			 	<%
    			 	}
    			 	%>
    			 	
    			 </input>
    			 <input type = "radio" name = "groupSeat" id = '01' value = '0_1'> 
    			 <%
    			 	if (seats[0].getPeroid1() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[0].getPeroid1() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[0].getPeroid1() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	else if(seats[0].getPeroid1() == 3)
    			 	{
    			 	%>
    			 	关闭时间段
    			 	<%
    			 	}
    			 	%>
    			 </input>
    			 <input type = "radio" name = "groupSeat" id = '02' value = '0_2'>  
    			 <%
    			 	if (seats[0].getPeroid2() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[0].getPeroid2() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[0].getPeroid2() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	else if(seats[0].getPeroid2() == 3)
    			 	{
    			 	%>
    			 	关闭时间段
    			 	<%
    			 	}
    			 	%>
    			 </input>
    			 <input type = "radio" name = "groupSeat" id = '03' value = '0_3'>  
				<%
    			 	if (seats[0].getPeroid3() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[0].getPeroid3() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[0].getPeroid3() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	else if(seats[0].getPeroid3() == 3)
    			 	{
    			 	%>
    			 	关闭时间段
    			 	<%
    			 	}
    			 	%>
				 </input>
    			 <input type = "radio" name = "groupSeat" id = '04' value = '0_4'>  
    			 <%
    			 	if (seats[0].getPeroid4() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[0].getPeroid4() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[0].getPeroid4() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	else if(seats[0].getPeroid4() == 3)
    			 	{
    			 	%>
    			 	关闭时间段
    			 	<%
    			 	}
    			 	%>
    			  </input>
    			 
				<script>
				var tag0 = <%=seats[0].getPeroid0()%>
				if(tag0 > 0)
					document.getElementById("00").disabled = true;
				
				var tag1 = <%=seats[0].getPeroid1()%>
				if(tag1 > 0)
					document.getElementById("01").disabled = true;
				
				var tag2 = <%=seats[0].getPeroid2()%>
				if(tag2 > 0)
					document.getElementById("02").disabled = true;
				
				var tag3 = <%=seats[0].getPeroid3()%>
				if(tag3 > 0)
					document.getElementById("03").disabled = true;
				
				var tag4 = <%=seats[0].getPeroid4()%>
				if(tag4 > 0)
					document.getElementById("04").disabled = true;
				</script>
				
				
 				<br>
 				座位1是否被占用：
    			 <input type = "radio" name = "groupSeat" id = '10' value = '1_0'>  
    			 	<%
    			 	if (seats[1].getPeroid0() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[1].getPeroid0() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[1].getPeroid0() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
    			 	
    			 </input>
    			 <input type = "radio" name = "groupSeat" id = '11' value = '1_1'> 
    			 <%
    			 	if (seats[1].getPeroid1() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[1].getPeroid1() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[1].getPeroid1() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
    			 </input>
    			 <input type = "radio" name = "groupSeat" id = '12' value = '1_2'>  
    			 <%
    			 	if (seats[1].getPeroid2() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[1].getPeroid2() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[1].getPeroid2() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
    			 </input>
    			 <input type = "radio" name = "groupSeat" id = '13' value = '1_3'>  
				<%
    			 	if (seats[1].getPeroid3() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[1].getPeroid3() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[1].getPeroid3() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
				 </input>
    			 <input type = "radio" name = "groupSeat" id = '14' value = '1_4'>  
    			 <%
    			 	if (seats[1].getPeroid4() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[1].getPeroid4() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[1].getPeroid4() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
    			  </input>
    			 
				<script>
				var tag0 = <%=seats[1].getPeroid0()%>
				document.getElementById("10").disabled = tag0;
				var tag1 = <%=seats[1].getPeroid1()%>
				document.getElementById("11").disabled = tag1;
				var tag2 = <%=seats[1].getPeroid2()%>
				document.getElementById("12").disabled = tag2;
				var tag3 = <%=seats[1].getPeroid3()%>
				document.getElementById("13").disabled = tag3;
				var tag4 = <%=seats[1].getPeroid4()%>
				document.getElementById("14").disabled = tag4;
				</script>
 				 <br>
    			  <br>
   				
    			 <br>
   </td>
   </tr>
   </table>
   <div align="center">
   		<input type="text" name="reason">
   </div>
   <div align="center">
   		
   		<br>
		 <input type="submit" value="提 交">
  		 <input type="reset" value="重 置"> 
	</div>
   
   </form>
   <%
   }
	%>

<a href="message.jsp">back</a> 
</body>
</html>