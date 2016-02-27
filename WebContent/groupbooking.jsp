<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="UTF-8"
    import="util.User"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="util.Seats" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

    <title>显示用户-教室预定系统</title>

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
    <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">教室预定系统</a>
          
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
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-6" style="float:left;">
          <ul class="nav navbar-nav">
            <li><a href="./seatsbooking.jsp">个人座位预定</a></li>
            <li class="active"><a href="./groupbooking.jsp">集体座位预定</a></li>
            <li><a href="./InfoServlet">查看个人座位预定</a></li>
            <li><a href="./GroupInfoServlet">查看集体座位预定</a></li>
          </ul>
        </div>
        
        <%} %>
        
        <div id="navbar" class="navbar-collapse collapse">
          <form class="navbar-form navbar-right">
            <div class="form-group">
              <%if (user != null) { %>
              <div style="float:right;">
                  <a style="font-size:22px;color:gray;font-weight:bold">当前用户:</a>
                  <a style="font-size:22px;color:gray">&nbsp;<%=user.getStudentnum() %></a>
                  &nbsp;
	              <button type="button" onclick="javascript:location.href='./ExitServlet'" class="btn btn-success">退出登录</button>
	          </div>
              <%} else { %>
              <a style="font-size:22px;color:gray;font-weight:bold">尚未登录</a>
              <button type="button" onclick="javascript:location.href='./login.jsp'" class="btn btn-success">用户登录</button>
              <%} %>
            </div>
          </form>
        </div><!--/.navbar-collapse -->
      </div>
    </nav>
        <br><br><br>
    <div class="container">
    <form action="./GroupSeatsServlet" method="post" onsubmit="return reg(this);">
	            <div class="form-group">
	              <label for="authcode" class="col-sm-3 control-label" style="width:100px;">查询日期：</label>
	              <div class="col-sm-5">
	                <div class="input-group">
	                  <select class = "form-control" name="bookdate">
		    				<option selected value = "6"> 第七天 </option>
		    				<option selected value = "5"> 第六天 </option>
		    				<option selected value = "4"> 第五天 </option>
		    				<option selected value = "3"> 第四天 </option>
		    				<option selected value = "2"> 第三天 </option>
		    				<option selected value = "1"> 第二天 </option>
		    				<option selected value = "0"> 今天 </option>
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
  	int ddate = 0;
  	if(date != null){
  	  ddate = Integer.parseInt(date);
  	 ddate += 1;
  	}
	if(seats != null && seats[0] != null && seats[1] != null){ 
	%>

    <div class="container">
	<form action="./GroupBookServlet" method="post" onsubmit="return reg(this);">
	
    <div ><h1>团体座位预定</h1></div>
    
    

		<table class="table table-striped">
		   <thead>
		      <tr>
		      	 <th align="right">座位号</th>
		      	 <th >时间段0</th>
		         <th>时间段1</th>
		         <th>时间段2</th>
		         <th>时间段3</th>
		         <th>时间段4</th>
		      </tr>
		   </thead>
		   <tbody>
			    <%

				for (int i = 0 ; i < 2 ; i ++)
				{
				%>
				
				<tr>
				
				<td><%="座位"+i%></td>
				<td>
				<input type = "radio" name = "groupSeat" id = '00' value = '0_0'>  
				<%
    			 	if (seats[i].getPeroid0() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[i].getPeroid0() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[i].getPeroid0() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	else if(seats[i].getPeroid0() == 3)
    			 	{
    			 	%>
    			 	关闭时间段
    			 	<%
    			 	}
    			 	%>
				</td>
				
								<td>
				<input type = "radio" name = "groupSeat" id = '00' value = '0_0'>  
				<%
    			 	if (seats[i].getPeroid1() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[i].getPeroid1() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[i].getPeroid1() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	else if(seats[i].getPeroid1() == 3)
    			 	{
    			 	%>
    			 	关闭时间段
    			 	<%
    			 	}
    			 	%>
				</td>
				
								<td>
				<input type = "radio" name = "groupSeat" id = '00' value = '0_0'>  
				<%
    			 	if (seats[i].getPeroid2() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[i].getPeroid2() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[i].getPeroid2() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	else if(seats[i].getPeroid2() == 3)
    			 	{
    			 	%>
    			 	关闭时间段
    			 	<%
    			 	}
    			 	%>
				</td>
				
								<td>
				<input type = "radio" name = "groupSeat" id = '00' value = '0_0'>  
				<%
    			 	if (seats[i].getPeroid3() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[i].getPeroid3() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[i].getPeroid3() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	else if(seats[i].getPeroid3() == 3)
    			 	{
    			 	%>
    			 	关闭时间段
    			 	<%
    			 	}
    			 	%>
				</td>
				
								<td>
				<input type = "radio" name = "groupSeat" id = '00' value = '0_0'>  
				<%
    			 	if (seats[i].getPeroid4() == 0)
    			 	{	
    			 	%>
    			 	可预约
    			 	<%
    			 	}
    			 	else if (seats[i].getPeroid4() == 1)
    			 	{
    			 	%>
    			 	已占用  
    			 	<%
					}
    			 	else if(seats[i].getPeroid4() == 2)
    			 	{
    			 	%>
    			 	已过时
    			 	<%
    			 	}
    			 	else if(seats[i].getPeroid4() == 3)
    			 	{
    			 	%>
    			 	关闭时间段
    			 	<%
    			 	}
    			 	%>
				</td>
				
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
		
		<input type="submit" class="btn btn-success" value="提 交">
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
        <p>&copy; 版权所有 教研院</p>
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
