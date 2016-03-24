<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="util.User"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="util.Seats" %>
<%@ page import="util.DateManager" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="">
    <meta name="author" content="">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="favicon.ico" mce_href="favicon.ico" rel="bookmark" type="image/x-icon" /> 
	<link href="favicon.ico" mce_href="favicon.ico" rel="icon" type="image/x-icon" /> 
	<link href="favicon.ico" mce_href="favicon.ico" rel="shortcut icon" type="image/x-icon" /> 

    <title>集体座位预订-教室预订系统</title>

    <!-- Bootstrap core CSS -->
    <link href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="../../assets/js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

  <body>
	<% 
		User user = (User)session.getAttribute("user");
	%>
	
	
<div class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <img style="width:55px;height:51px;" src="./img/logo.jpg"/>
          <a class="navbar-brand hidden-sm" href=#>教室预订系统</a>
        </div>
        <%
        if (user != null) { 
        	String tag = "";
        	String ref = "";
        	if (user.getUserType() == 0 || user.getUserType() == -1) {
        		tag = "学生界面";
        		ref = "./student_message.jsp";
        	} else if (user.getUserType() == 1 || user.getUserType() == -2) {
        		tag = "教师界面";
        		ref = "./teacher_message.jsp";
        	} else {
        		tag = "管理员界面";
        		ref = "./admin_message.jsp";
        	}
        		
       	%>
         <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
<%
          if (user.getUserType() == 0 || user.getUserType() == -1) {
          %>
          	<li><a href="<%=ref%>"><%=tag %></a></li>
            <!-- <li><a href="./seatsbooking.jsp">个人座位预订</a></li> -->
            <li class="active"><a href="./groupbooking.jsp">集体座位预订</a></li>
            <!-- <li><a href="./InfoServlet">查看个人座位预订</a></li> -->
            <li><a href="./GroupInfoServlet">查看集体座位预订</a></li>
          <%
          } else { 
          %>
          	<li><a href="<%=ref%>"><%=tag %></a></li>
            <li class="active"><a href="./groupbooking.jsp">集体座位预订</a></li>
            <li><a href="./GroupInfoServlet">查看集体座位预订</a></li>
          <%
          } }
          %>
            
          </ul>
          <ul class="nav navbar-nav navbar-right hidden-sm">
          	<%if (user != null) { %>
			<li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">用户 <span class="caret"></span></a>
              <ul class="dropdown-menu">
                <li style="text-align:center;"><a href="#"><%=user.getStudentnum()%></a></li>
                <li style="text-align:center;"><a href="changepw.jsp">修改个人信息</a></li>
                <li style="text-align:center;"><a href="./ExitServlet">退出</a></li>
              </ul>
            </li>
              <%} else { %>
              <li><a href="login.jsp"><%="尚未登录" %></a></li>
              <%} %>
          </ul>
        </div>
      </div>
    </div>
	
	
 
        <br><br><br>
    <div class="container">
    <form action="./GroupSeatsServlet" method="post" onsubmit="return reg(this);" class="form-horizontal">
	            <div class="form-group">
	              <label for="authcode" class="col-sm-3 control-label" style="width:120px;">查询日期：</label>
	              <div class="col-sm-5">
	                <div class="input-group">
	                  <select class = "form-control" name="bookdate">
	                   <% if (DateManager.getWeekOfDate(6) == 1 || DateManager.getWeekOfDate(6) == 3 || DateManager.getWeekOfDate(6) == 4)
	                   {%>
		    				<option selected value = <%=DateManager.getFormatCompleteDate(6) %>> <%=DateManager.getFormatDate(6) %> </option>
		    				
		    			<%}
	                   if (DateManager.getWeekOfDate(5) == 1 || DateManager.getWeekOfDate(5) == 3 || DateManager.getWeekOfDate(5) == 4)
		    			{
	                   %>
		    				<option selected value = <%=DateManager.getFormatCompleteDate(5) %>> <%=DateManager.getFormatDate(5) %> </option>
		    			<%}
	                   if (DateManager.getWeekOfDate(4) == 1 || DateManager.getWeekOfDate(4) == 3 || DateManager.getWeekOfDate(4) == 4)
		    			{
	                   %>
		    				<option selected value = <%=DateManager.getFormatCompleteDate(4) %>> <%=DateManager.getFormatDate(4) %> </option>
		    			<%}
	                   if (DateManager.getWeekOfDate(3) == 1 || DateManager.getWeekOfDate(3) == 3 || DateManager.getWeekOfDate(3) == 4)
		    			{
	                   %>
		    				<option selected value = <%=DateManager.getFormatCompleteDate(3) %>> <%=DateManager.getFormatDate(3) %> </option>
		    			<%}
	                   if (DateManager.getWeekOfDate(2) == 1 || DateManager.getWeekOfDate(2) == 3 || DateManager.getWeekOfDate(2) == 4)
		    			{
	                   %>
		    				<option selected value = <%=DateManager.getFormatCompleteDate(2) %>> <%=DateManager.getFormatDate(2) %> </option>
		    			<%}
	                   if (DateManager.getWeekOfDate(1) == 1 || DateManager.getWeekOfDate(1) == 3 || DateManager.getWeekOfDate(1) == 4)
		    			{
	                   %>
		    				<option selected value = <%=DateManager.getFormatCompleteDate(1) %>> <%=DateManager.getFormatDate(1) %> </option>
		    			<%}
	                   if (DateManager.getWeekOfDate(0) == 1 || DateManager.getWeekOfDate(0) == 3 || DateManager.getWeekOfDate(0) == 4)
		    			{
	                   %>
		    				<option selected value = <%=DateManager.getFormatCompleteDate(0) %>> <%=DateManager.getFormatDate(0) %> </option>
		    			<%} %>
					  </select>
	            	</div>
	              </div>
	              </div>
	              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	              <input type="submit" class="btn btn-success" value="查 询">
		          <input type="reset" class="btn btn-success" value="重 置">
	 </form>	
	 </div>

    <!-- Main jumbotron for a primary marketing message or call to action -->
    
	<%
 	 Seats[] seats = new Seats[2];
  	 seats = (Seats[])session.getAttribute("groupseats");
  	 String date = (String) session.getAttribute("bookdate");
  	 String weekX = "";
  	 String bookdate = (String) session.getAttribute("bookdate"); 
  	if(date != null){
	  	  date = date.substring(5).replace("_" , "-");
	  	  weekX = DateManager.getWeekX(DateManager.getWeek(bookdate) - 1);
  	}
	if(seats != null && seats[0] != null && seats[1] != null && bookdate != null && (DateManager.getWeek(bookdate) == 1 || DateManager.getWeek(bookdate) == 3  || DateManager.getWeek(bookdate) == 4)) { 
	%>

    <div class="container">
	<form action="./GroupBookServlet" method="post" onsubmit="return reg(this);">

    <div ><h1>团体座位预订&nbsp;<%=date + " " + weekX%></h1></div>
    
    

		<table class="table table-striped">
		   <thead>
		      <tr>
		      	 <th align="right">座位号</th>
		      	 <%-- <th ><%=DateManager.getPeroid(0) %></th>
		         <th><%=DateManager.getPeroid(1) %></th> --%>
		         <th><%=DateManager.getPeroid(2) %></th>
		         <th><%=DateManager.getPeroid(3) %></th>
		         <%-- <th><%=DateManager.getPeroid(4) %></th> --%>
		      </tr>
		   </thead>
		   <tbody>
			    <%

				for (int i = 0 ; i < 2 ; i ++)
				{
				%>
				
				<tr>
				
				<td><%="座位"+(i+1)%></td>
				  
				<%-- <%
					if( bookdate.equals(DateManager.getFormatCompleteDate(0)) && DateManager.compareTime(DateManager.currentTime() , "07:00:00") > 0 && seats[i].getPeroid0() != 3 )
				 	{
				 	%>
	  				<td bgcolor="yellow">
						<input type = "radio" name = "seat" id = '<%=i %><%=x %>' value = '<%=i %>_<%=x %>'> 
							已过时
						</input>
	  				</td>
				 	<%
				 	}
					else if (seats[i].getPeroid0() == 0)
    			 	{	
    			 	%>
    			 	<td bgcolor="green"><input type = "radio" name = "groupSeat" id = '<%=i %>>0' value = '<%=i %>_0'>可预约</td>
    			 	<%
    			 	}
    			 	else if (seats[i].getPeroid0() == 1)
    			 	{
    			 	%>
    			 	<td bgcolor="yellow">已占用</td>  
    			 	<%
					}
    			 	else if(seats[i].getPeroid0() == 3)
    			 	{
    			 	%>
    			 	<td bgcolor="yellow">关闭时间段</td>
    			 	<%
    			 	}
    			 	%> --%>
				<%-- 
				<%
					if( bookdate.equals(DateManager.getFormatCompleteDate(0)) && DateManager.compareTime(DateManager.currentTime() , "09:00:00") > 0 && seats[i].getPeroid1() != 3 )
				 	{
				 	%>
	  				<td bgcolor="yellow">
						<input type = "radio" name = "seat" id = '<%=i %><%=x %>' value = '<%=i %>_<%=x %>'> 
							已过时
						</input>
	  				</td>
				 	<%
				 	}
					else if (seats[i].getPeroid1() == 0)
    			 	{	
    			 	%>
    			 	<td bgcolor="green"><input type = "radio" name = "groupSeat" id = '<%=i %>1' value = '<%=i %>_1'>可预约</td>
    			 	<%
    			 	}
    			 	else if (seats[i].getPeroid1() == 1)
    			 	{
    			 	%>
    			 	<td bgcolor="yellow">已占用</td>  
    			 	<%
					}
    			 	else if(seats[i].getPeroid1() == 3)
    			 	{
    			 	%>
    			 	<td bgcolor="yellow">关闭时间段</td>
    			 	<%
    			 	}
    			 	%> --%>
				
				<%
					if( bookdate.equals(DateManager.getFormatCompleteDate(0)) && DateManager.compareTime(DateManager.currentTime() , "12:00:00") > 0 && seats[i].getPeroid2() != 3 )
				 	{
				 	%>
	  				<td bgcolor="#ffff99">
					<%-- 	<input type = "radio" name = "seat" id = '<%=i %><%=x %>' value = '<%=i %>_<%=x %>'>  --%>
							已过时
						</input>
	  				</td>
				 	<%
				 	}
					else if (seats[i].getPeroid2() == 0)
    			 	{	
    			 	%>
    			 	<td bgcolor="#5cb85c"><input type = "radio" name = "groupSeat" id = '<%=i %>2' value = '<%=i %>_2'>可预约</td>
    			 	<%
    			 	}
    			 	else if (seats[i].getPeroid2() == 1)
    			 	{
    			 	%>
    			 	<td bgcolor="#ffff99">已占用</td>  
    			 	<%
					}
    			 	else if(seats[i].getPeroid2() == 3)
    			 	{
    			 	%>
    			 	<td bgcolor="#ffff99">关闭时间段</td>
    			 	<%
    			 	}
    			 	%>
				
				<%
					if( bookdate.equals(DateManager.getFormatCompleteDate(0)) && DateManager.compareTime(DateManager.currentTime() , "14:00:00") > 0 && seats[i].getPeroid3() != 3 )
				 	{
				 	%>
	  				<td bgcolor="#ffff99">
<%-- 					 	<input type = "radio" name = "groupSeat" id = '<%=i %>3' value = '<%=i %>_3'>  --%>
							已过时
						</input>
	  				</td>
				 	<%
				 	}
					else if (seats[i].getPeroid3() == 0)
    			 	{	
    			 	%>
    			 	<td bgcolor="#5cb85c"><input type = "radio" name = "groupSeat" id = '<%=i %>3' value = '<%=i %>_3'>可预约</td>
    			 	<%
    			 	}
    			 	else if (seats[i].getPeroid3() == 1)
    			 	{
    			 	%>
    			 	<td bgcolor="#ffff99">已占用</td>  
    			 	<%
					}
    			 	else if(seats[i].getPeroid3() == 3)
    			 	{
    			 	%>
    			 	<td bgcolor="#ffff99">关闭时间段</td>
    			 	<%
    			 	}
    			 	%>
				
				<%-- <%
					if( bookdate.equals(DateManager.getFormatCompleteDate(0)) && DateManager.compareTime(DateManager.currentTime() , "18:00:00") > 0 && seats[i].getPeroid4() != 3 )
				 	{
				 	%>
	  				<td bgcolor="yellow">
  						<input type = "radio" name = "groupSeat" id = '<%=i %>4' value = '<%=i %>_4'> 
							已过时
						</input>
	  				</td>
				 	<%
				 	}
					else if (seats[i].getPeroid4() == 0)
    			 	{	
    			 	%>
    			 	<td bgcolor="green"><input type = "radio" name = "groupSeat" id = '<%=i %>4' value = '<%=i %>_4'>可预约</td>
    			 	<%
    			 	}
    			 	else if (seats[i].getPeroid4() == 1)
    			 	{
    			 	%>
    			 	<td bgcolor="yellow">已占用</td>  
    			 	<%
					}
    			 	else if(seats[i].getPeroid4() == 3)
    			 	{
    			 	%>
    			 	<td bgcolor="yellow">关闭时间段</td>
    			 	<%
    			 	}
    			 	%> --%>
				
				</tr>
				 <%} %>
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
		   </tbody>
		</table>
		  <div class="form-group">
		    <label for="name">申请原因(50字以内)：</label>
		    <textarea name = "reason" class="form-control" rows="3"></textarea>
		  </div>
		<input type="submit" class="btn btn-success" value="提 交" onclick="if(!confirm('确定提交申请？'))return false;">
		<input type="reset" class="btn btn-success" value="重 置">
		</form>
	  </div>
	  <%  }%>


	  
    <div class="container">
      <!-- Example row of columns -->
      <div class="row">
        <div class="col-md-4">
        </div>
      </div>

      <hr>

      <footer>
        <p align="center">&copy; 2016 IOE, Tsinghua University</p>
      </footer>
    </div> <!-- /container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
    <script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>
