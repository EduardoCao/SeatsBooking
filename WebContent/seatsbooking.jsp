<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="util.Seats" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SeatsBooking_today</title>
</head>


<body>
	
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
	
	<table align="center" width="550" border="1" height="400" bordercolor="#E8F4CC">
		<tr>
    		<td align="center" colspan="2">
    			 第<%=ddate+ "" %>天 
    			 <br>
    			 座位0是否被占用：
     			<span style="font-weight: bold;font-size: 18px;"><%=seats[0].getPeroid0() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[0].getPeroid1() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[0].getPeroid2() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[0].getPeroid3() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[0].getPeroid4() %></span>
 				<br>
 				座位1是否被占用：
     			<span style="font-weight: bold;font-size: 18px;"><%=seats[1].getPeroid0() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[1].getPeroid1() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[1].getPeroid2() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[1].getPeroid3() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[1].getPeroid4() %></span>
 				 <br>
 				座位2是否被占用：
     			<span style="font-weight: bold;font-size: 18px;"><%=seats[2].getPeroid0() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[2].getPeroid1() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[2].getPeroid2() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[2].getPeroid3() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[2].getPeroid4() %></span>
 				 <br>
 				座位3是否被占用：
     			<span style="font-weight: bold;font-size: 18px;"><%=seats[3].getPeroid0() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[3].getPeroid1() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[3].getPeroid2() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[3].getPeroid3() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[3].getPeroid4() %></span>
 				 <br>
 				座位4是否被占用：
     			<span style="font-weight: bold;font-size: 18px;"><%=seats[4].getPeroid0() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[4].getPeroid1() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[4].getPeroid2() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[4].getPeroid3() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[4].getPeroid4() %></span>
 				 <br>
 				座位5是否被占用：
     			<span style="font-weight: bold;font-size: 18px;"><%=seats[5].getPeroid0() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[5].getPeroid1() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[5].getPeroid2() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[5].getPeroid3() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[5].getPeroid4() %></span>
 				 <br>
 				座位6是否被占用：
     			<span style="font-weight: bold;font-size: 18px;"><%=seats[6].getPeroid0() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[6].getPeroid1() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[6].getPeroid2() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[6].getPeroid3() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[6].getPeroid4() %></span>
 				 <br>
 				座位7是否被占用：
     			<span style="font-weight: bold;font-size: 18px;"><%=seats[7].getPeroid0() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[7].getPeroid1() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[7].getPeroid2() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[7].getPeroid3() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[7].getPeroid4() %></span>
 				 <br>
 				座位8是否被占用：
     			<span style="font-weight: bold;font-size: 18px;"><%=seats[8].getPeroid0() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[8].getPeroid1() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[8].getPeroid2() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[8].getPeroid3() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[8].getPeroid4() %></span>
 				 <br>
 				座位9是否被占用：
     			<span style="font-weight: bold;font-size: 18px;"><%=seats[9].getPeroid0() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[9].getPeroid1() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[9].getPeroid2() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[9].getPeroid3() %></span>
 				<span style="font-weight: bold;font-size: 18px;"><%=seats[9].getPeroid4() %></span>
 				
 				 <br>
    		</td>
    	</tr>

	</table>
	<%
	} 
	%>
	<a href="message.jsp">back</a> 
</body>
</html>