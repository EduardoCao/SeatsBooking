<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="util.Seats" %>
<%@ page import="util.User" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SeatsBooking</title>
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
		else if (  user.getUserType() == -1) 
		{
	%>
		您已经被管理员限制权限。
		<a href="message.jsp">back</a>
		<div id="div" style="display: none" >
	<% 
		}	
		else if (  user.getUserType() != 0) 
		{
	%>
		您无权查看该页面，仅可由学生预定座位。
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
	    <form action="./SeatsServlet" method="post" onsubmit="return reg(this);">
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
	
	<form action="./BookServlet" method="post" onsubmit="return reg(this);">
	<table align="center" width="650" border="1" height="400" bordercolor="#E8F4CC">
		<tr>
    		<td align="center" colspan="2">
    			 第<%=ddate + "" %>天 
    			 <input type = 'hidden' name = "bookdate" value = <%=ddate - 1%>>
    			  <input type = 'hidden' name = "owner" value = <%=user.getStudentnum() %>>
    			  
    			  
    			 <br>
    			 座位0是否被占用：
    			 <input type = "radio" name = "seat" id = '00' value = '0_0'>  
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
    			 	%>
    			 	
    			 </input>
    			 <input type = "radio" name = "seat" id = '01' value = '0_1'> 
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
    			 	%>
    			 </input>
    			 <input type = "radio" name = "seat" id = '02' value = '0_2'>  
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
    			 	%>
    			 </input>
    			 <input type = "radio" name = "seat" id = '03' value = '0_3'>  
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
    			 	%>
				 </input>
    			 <input type = "radio" name = "seat" id = '04' value = '0_4'>  
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
    			 <input type = "radio" name = "seat" id = '10' value = '1_0'>  
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
    			 <input type = "radio" name = "seat" id = '11' value = '1_1'> 
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
    			 <input type = "radio" name = "seat" id = '12' value = '1_2'>  
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
    			 <input type = "radio" name = "seat" id = '13' value = '1_3'>  
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
    			 <input type = "radio" name = "seat" id = '14' value = '1_4'>  
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
 				座位2是否被占用：
     			<input type = "radio" name = "seat" id = '20' value = '2_0'>  
    			 	<%
    			 	if (seats[2].getPeroid0() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[2].getPeroid0() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[2].getPeroid0() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
    			 	
    			 </input>
    			 <input type = "radio" name = "seat" id = '21' value = '2_1'> 
    			 <%
    			 	if (seats[2].getPeroid1() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[2].getPeroid1() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[2].getPeroid1() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
    			 </input>
    			 <input type = "radio" name = "seat" id = '22' value = '2_2'>  
    			 <%
    			 	if (seats[2].getPeroid2() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[2].getPeroid2() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[2].getPeroid2() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
    			 </input>
    			 <input type = "radio" name = "seat" id = '23' value = '2_3'>  
				<%
    			 	if (seats[2].getPeroid3() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[2].getPeroid3() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[2].getPeroid3() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
				 </input>
    			 <input type = "radio" name = "seat" id = '24' value = '2_4'>  
    			 <%
    			 	if (seats[2].getPeroid4() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[2].getPeroid4() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[2].getPeroid4() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
    			  </input>
    			 
				<script>
				var tag0 = <%=seats[2].getPeroid0()%>
				document.getElementById("20").disabled = tag0;
				var tag1 = <%=seats[2].getPeroid1()%>
				document.getElementById("21").disabled = tag1;
				var tag2 = <%=seats[2].getPeroid2()%>
				document.getElementById("22").disabled = tag2;
				var tag3 = <%=seats[2].getPeroid3()%>
				document.getElementById("23").disabled = tag3;
				var tag4 = <%=seats[2].getPeroid4()%>
				document.getElementById("24").disabled = tag4;
				</script>
 				 <br>
 				座位3是否被占用：
     			<input type = "radio" name = "seat" id = '30' value = '3_0'>  
    			 	<%
    			 	if (seats[3].getPeroid0() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[3].getPeroid0() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[3].getPeroid0() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
    			 	
    			 </input>
    			 <input type = "radio" name = "seat" id = '31' value = '3_1'> 
    			 <%
    			 	if (seats[3].getPeroid1() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[3].getPeroid1() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[3].getPeroid1() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
    			 </input>
    			 <input type = "radio" name = "seat" id = '32' value = '3_2'>  
    			 <%
    			 	if (seats[3].getPeroid2() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[3].getPeroid2() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[3].getPeroid2() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
    			 </input>
    			 <input type = "radio" name = "seat" id = '33' value = '3_3'>  
				<%
    			 	if (seats[3].getPeroid3() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[3].getPeroid3() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[3].getPeroid3() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
				 </input>
    			 <input type = "radio" name = "seat" id = '34' value = '3_4'>  
    			 <%
    			 	if (seats[3].getPeroid4() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[3].getPeroid4() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[3].getPeroid4() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
    			  </input>
    			 
				<script>
				var tag0 = <%=seats[3].getPeroid0()%>
				document.getElementById("30").disabled = tag0;
				var tag1 = <%=seats[3].getPeroid1()%>
				document.getElementById("31").disabled = tag1;
				var tag2 = <%=seats[3].getPeroid2()%>
				document.getElementById("32").disabled = tag2;
				var tag3 = <%=seats[3].getPeroid3()%>
				document.getElementById("33").disabled = tag3;
				var tag4 = <%=seats[3].getPeroid4()%>
				document.getElementById("34").disabled = tag4;
				</script>
 				 <br>
 				座位4是否被占用：
     			<input type = "radio" name = "seat" id = '40' value = '4_0'>  
    			 	<%
    			 	if (seats[4].getPeroid0() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[4].getPeroid0() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[4].getPeroid0() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
    			 	
    			 </input>
    			 <input type = "radio" name = "seat" id = '41' value = '4_1'> 
    			 <%
    			 	if (seats[4].getPeroid1() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[4].getPeroid1() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[4].getPeroid1() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
    			 </input>
    			 <input type = "radio" name = "seat" id = '42' value = '4_2'>  
    			 <%
    			 	if (seats[4].getPeroid2() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[4].getPeroid2() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[4].getPeroid2() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
    			 </input>
    			 <input type = "radio" name = "seat" id = '43' value = '4_3'>  
				<%
    			 	if (seats[4].getPeroid3() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[4].getPeroid3() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[4].getPeroid3() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
				 </input>
    			 <input type = "radio" name = "seat" id = '44' value = '4_4'>  
    			 <%
    			 	if (seats[4].getPeroid4() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[4].getPeroid4() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[4].getPeroid4() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
    			  </input>
    			 
				<script>
				var tag0 = <%=seats[4].getPeroid0()%>
				document.getElementById("40").disabled = tag0;
				var tag1 = <%=seats[4].getPeroid1()%>
				document.getElementById("41").disabled = tag1;
				var tag2 = <%=seats[4].getPeroid2()%>
				document.getElementById("42").disabled = tag2;
				var tag3 = <%=seats[4].getPeroid3()%>
				document.getElementById("43").disabled = tag3;
				var tag4 = <%=seats[4].getPeroid4()%>
				document.getElementById("44").disabled = tag4;
				</script>
 				 <br>
 				座位5是否被占用：
     			<input type = "radio" name = "seat" id = '50' value = '5_0'>  
    			 	<%
    			 	if (seats[5].getPeroid0() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[5].getPeroid0() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[5].getPeroid0() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
    			 	
    			 </input>
    			 <input type = "radio" name = "seat" id = '51' value = '5_1'> 
    			 <%
    			 	if (seats[5].getPeroid1() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[5].getPeroid1() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[5].getPeroid1() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
    			 </input>
    			 <input type = "radio" name = "seat" id = '52' value = '5_2'>  
    			 <%
    			 	if (seats[5].getPeroid2() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[5].getPeroid2() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[5].getPeroid2() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
    			 </input>
    			 <input type = "radio" name = "seat" id = '53' value = '5_3'>  
				<%
    			 	if (seats[5].getPeroid3() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[5].getPeroid3() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[5].getPeroid3() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
				 </input>
    			 <input type = "radio" name = "seat" id = '54' value = '5_4'>  
    			 <%
    			 	if (seats[5].getPeroid4() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[5].getPeroid4() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[5].getPeroid4() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
    			  </input>
    			 
				<script>
				var tag0 = <%=seats[5].getPeroid0()%>
				document.getElementById("50").disabled = tag0;
				var tag1 = <%=seats[5].getPeroid1()%>
				document.getElementById("51").disabled = tag1;
				var tag2 = <%=seats[5].getPeroid2()%>
				document.getElementById("52").disabled = tag2;
				var tag3 = <%=seats[5].getPeroid3()%>
				document.getElementById("53").disabled = tag3;
				var tag4 = <%=seats[5].getPeroid4()%>
				document.getElementById("54").disabled = tag4;
				</script>
 				 <br>
 				座位6是否被占用：
     			<input type = "radio" name = "seat" id = '60' value = '6_0'>  
    			 	<%
    			 	if (seats[6].getPeroid0() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[6].getPeroid0() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[6].getPeroid0() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
    			 	
    			 </input>
    			 <input type = "radio" name = "seat" id = '61' value = '6_1'> 
    			 <%
    			 	if (seats[6].getPeroid1() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[6].getPeroid1() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[6].getPeroid1() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
    			 </input>
    			 <input type = "radio" name = "seat" id = '62' value = '6_2'>  
    			 <%
    			 	if (seats[6].getPeroid2() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[6].getPeroid2() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[6].getPeroid2() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
    			 </input>
    			 <input type = "radio" name = "seat" id = '63' value = '6_3'>  
				<%
    			 	if (seats[6].getPeroid3() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[6].getPeroid3() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[6].getPeroid3() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
				 </input>
    			 <input type = "radio" name = "seat" id = '64' value = '6_4'>  
    			 <%
    			 	if (seats[6].getPeroid4() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[6].getPeroid4() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[6].getPeroid4() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
    			  </input>
    			 
				<script>
				var tag0 = <%=seats[6].getPeroid0()%>
				document.getElementById("60").disabled = tag0;
				var tag1 = <%=seats[6].getPeroid1()%>
				document.getElementById("61").disabled = tag1;
				var tag2 = <%=seats[6].getPeroid2()%>
				document.getElementById("62").disabled = tag2;
				var tag3 = <%=seats[6].getPeroid3()%>
				document.getElementById("63").disabled = tag3;
				var tag4 = <%=seats[6].getPeroid4()%>
				document.getElementById("64").disabled = tag4;
				</script>
 				 <br>
 				座位7是否被占用：
     			<input type = "radio" name = "seat" id = '70' value = '7_0'>  
    			 	<%
    			 	if (seats[7].getPeroid0() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[7].getPeroid0() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[7].getPeroid0() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
    			 	
    			 </input>
    			 <input type = "radio" name = "seat" id = '71' value = '7_1'> 
    			 <%
    			 	if (seats[7].getPeroid1() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[7].getPeroid1() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[7].getPeroid1() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
    			 </input>
    			 <input type = "radio" name = "seat" id = '72' value = '7_2'>  
    			 <%
    			 	if (seats[7].getPeroid2() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[7].getPeroid2() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[7].getPeroid2() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
    			 </input>
    			 <input type = "radio" name = "seat" id = '73' value = '7_3'>  
				<%
    			 	if (seats[7].getPeroid3() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[7].getPeroid3() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[7].getPeroid3() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
				 </input>
    			 <input type = "radio" name = "seat" id = '74' value = '7_4'>  
    			 <%
    			 	if (seats[7].getPeroid4() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[7].getPeroid4() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[7].getPeroid4() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
    			  </input>
    			 
				<script>
				var tag0 = <%=seats[7].getPeroid0()%>
				document.getElementById("70").disabled = tag0;
				var tag1 = <%=seats[7].getPeroid1()%>
				document.getElementById("71").disabled = tag1;
				var tag2 = <%=seats[7].getPeroid2()%>
				document.getElementById("72").disabled = tag2;
				var tag3 = <%=seats[7].getPeroid3()%>
				document.getElementById("73").disabled = tag3;
				var tag4 = <%=seats[7].getPeroid4()%>
				document.getElementById("74").disabled = tag4;
				</script>
 				 <br>
 				座位8是否被占用：
     			<input type = "radio" name = "seat" id = '80' value = '8_0'>  
    			 	<%
    			 	if (seats[8].getPeroid0() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[8].getPeroid0() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[8].getPeroid0() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
    			 	
    			 </input>
    			 <input type = "radio" name = "seat" id = '81' value = '8_1'> 
    			 <%
    			 	if (seats[8].getPeroid1() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[8].getPeroid1() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[8].getPeroid1() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
    			 </input>
    			 <input type = "radio" name = "seat" id = '82' value = '8_2'>  
    			 <%
    			 	if (seats[8].getPeroid2() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[8].getPeroid2() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[8].getPeroid2() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
    			 </input>
    			 <input type = "radio" name = "seat" id = '83' value = '8_3'>  
				<%
    			 	if (seats[8].getPeroid3() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[8].getPeroid3() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[8].getPeroid3() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
				 </input>
    			 <input type = "radio" name = "seat" id = '84' value = '8_4'>  
    			 <%
    			 	if (seats[8].getPeroid4() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[8].getPeroid4() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[8].getPeroid4() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
    			  </input>
    			 
				<script>
				var tag0 = <%=seats[8].getPeroid0()%>
				document.getElementById("80").disabled = tag0;
				var tag1 = <%=seats[8].getPeroid1()%>
				document.getElementById("81").disabled = tag1;
				var tag2 = <%=seats[8].getPeroid2()%>
				document.getElementById("82").disabled = tag2;
				var tag3 = <%=seats[8].getPeroid3()%>
				document.getElementById("83").disabled = tag3;
				var tag4 = <%=seats[8].getPeroid4()%>
				document.getElementById("84").disabled = tag4;
				</script>
 				 <br>
 				座位9是否被占用：
     			<input type = "radio" name = "seat" id = '90' value = '9_0'>  
    			 	<%
    			 	if (seats[9].getPeroid0() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[9].getPeroid0() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[9].getPeroid0() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
    			 	
    			 </input>
    			 <input type = "radio" name = "seat" id = '91' value = '9_1'> 
    			 <%
    			 	if (seats[9].getPeroid1() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[9].getPeroid1() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[9].getPeroid1() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
    			 </input>
    			 <input type = "radio" name = "seat" id = '92' value = '9_2'>  
    			 <%
    			 	if (seats[9].getPeroid2() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[9].getPeroid2() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[9].getPeroid2() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
    			 </input>
    			 <input type = "radio" name = "seat" id = '93' value = '9_3'>  
				<%
    			 	if (seats[9].getPeroid3() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[9].getPeroid3() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[9].getPeroid3() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
				 </input>
    			 <input type = "radio" name = "seat" id = '94' value = '9_4'>  
    			 <%
    			 	if (seats[9].getPeroid4() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[9].getPeroid4() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[9].getPeroid4() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	%>
    			  </input>
    			 
				<script>
				var tag0 = <%=seats[9].getPeroid0()%>
				document.getElementById("90").disabled = tag0;
				var tag1 = <%=seats[9].getPeroid1()%>
				document.getElementById("91").disabled = tag1;
				var tag2 = <%=seats[9].getPeroid2()%>
				document.getElementById("92").disabled = tag2;
				var tag3 = <%=seats[9].getPeroid3()%>
				document.getElementById("93").disabled = tag3;
				var tag4 = <%=seats[9].getPeroid4()%>
				document.getElementById("94").disabled = tag4;
				</script>
				<br>
   				<input type="submit" value="提 交">
   				<input type="reset" value="重 置">

    		</td>
    	</tr>

	</table>
	</form>
	<%
	} 
	%>
	<a href="message.jsp">back</a> 
	</div>
</body>
</html>