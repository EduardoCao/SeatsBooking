<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="UTF-8"
    import="util.User"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="util.Seats" %>
<%@ page import="util.DateManager" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link href="favicon.ico" mce_href="favicon.ico" rel="bookmark" type="image/x-icon" /> 
	<link href="favicon.ico" mce_href="favicon.ico" rel="icon" type="image/x-icon" /> 
	<link href="favicon.ico" mce_href="favicon.ico" rel="shortcut icon" type="image/x-icon" /> 

    <title>显示用户-教室预订系统</title>

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
          <img style="width:55px;height:51px;" src="./img/logo.jpg"/>
          <a class="navbar-brand hidden-sm" href="./index.jsp">教室预订系统</a>
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
        <div class="navbar-collapse collapse" role="navigation">
          <ul class="nav navbar-nav">
          	<li><a href="<%=ref%>"><%=tag %></a></li>
            <li class="active"><a href="./seatsbooking.jsp">个人座位预订</a></li>
            <li><a href="./groupbooking.jsp">集体座位预订</a></li>
            <li><a href="./InfoServlet">查看个人座位预订</a></li>
            <li><a href="./GroupInfoServlet">查看集体座位预订</a></li>
            
          </ul>
          <ul class="nav navbar-nav navbar-right hidden-sm">
          	<%if (user != null) { %>
			<li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">用户 <span class="caret"></span></a>
              <ul class="dropdown-menu">
                <li style="text-align:center;"><a href="#"><%=user.getStudentnum()%></a></li>
                <li style="text-align:center;"><a href="changepw.jsp">修改密码</a></li>
                <li style="text-align:center;"><a href="./ExitServlet">退出</a></li>
              </ul>
               <%} %>
            </li>
              <%} else { %>
              <li><a><%="尚未登录" %></a></li>
              <%} %>
          </ul>
        </div>
      </div>
    </div>
    
    
    
        <br><br><br>
    <div class="container">
    <form action="./SeatsServlet" method="post" onsubmit="return reg(this);" class="form-horizontal">
	            <div class="form-group">
	              <label for="authcode" class="col-sm-3 control-label" style="width:100px;">日期：</label>
	              <div class="col-sm-5">
	                <div class="input-group">
	                  <select class = "form-control" name="bookdate">
		    				<option selected value = "6"> <%=DateManager.getFormatDate(6) %> </option>
		    				<option selected value = "5"> <%=DateManager.getFormatDate(5) %> </option>
		    				<option selected value = "4"> <%=DateManager.getFormatDate(4) %> </option>
		    				<option selected value = "3"> <%=DateManager.getFormatDate(3) %> </option>
		    				<option selected value = "2"> <%=DateManager.getFormatDate(2) %> </option>
		    				<option selected value = "1"> <%=DateManager.getFormatDate(1) %> </option>
		    				<option selected value = "0"> <%=DateManager.getFormatDate(0) %> </option>
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
    <div class="container">
    <form action="./BookServlet" method="post" onsubmit="return reg(this);">
	<%
	int a = Integer.valueOf((String)session.getAttribute("bookdate"));
	%>
    <h1>个人座位预订&nbsp;<%=DateManager.getFormatDate(a) %></h1>

		<table class="table table-striped">
		   <thead>
		      <tr>
    			 <input type = 'hidden' name = "bookdate" value = <%=ddate - 1%>>
    			 <input type = 'hidden' name = "owner" value = <%=user.getStudentnum() %>>
		      	 <th align="right">座位号</th>
		      	 <th ><%=DateManager.getPeroid(0) %></th>
		         <th><%=DateManager.getPeroid(1) %></th>
		         <th><%=DateManager.getPeroid(2) %></th>
		         <th><%=DateManager.getPeroid(3) %></th>
		         <th><%=DateManager.getPeroid(4) %></th>
		      </tr>
		   </thead>
		   <tbody>
		   
<%
	

	for (int i = 0 ; i < 10 ; i ++)
	{
%>
		      <tr>
		      	<td><%="座位"+i %></td>
 
	    			 	<%
	    			 	int x = 0;
	    			 	if (seats[i].getPeroid0() == 0)
	    			 	{	
	    			 	%>
		  				<td bgcolor="green">
							<input type = "radio" name = "seat" id = '<%=i %><%=x %>' value = '<%=i %>_<%=x %>'> 
								可预约
							</input>
		  				</td>
	    			 	<%
	    			 	}
	    			 	else if (seats[i].getPeroid0() == 1)
	    			 	{
	    			 	%>
		  				<td bgcolor="yellow">
						<%-- 	<input type = "radio" name = "seat" id = '<%=i %><%=x %>' value = '<%=i %>_<%=x %>'>  --%>
								已占用 
							</input>
		  				</td>
	    			 	<%
						}
	    			 	else if(seats[i].getPeroid0() == 2)
	    			 	{
	    			 	%>
		  				<td bgcolor="yellow">
						<%-- 	<input type = "radio" name = "seat" id = '<%=i %><%=x %>' value = '<%=i %>_<%=x %>'>  --%>
								已过时
							</input>
		  				</td>
	    			 	<%
	    			 	}
	    			 	else if(seats[i].getPeroid0() == 3)
	    			 	{
	    			 	%>
		  				<td bgcolor="yellow">
						<%-- 	<input type = "radio" name = "seat" id = '<%=i %><%=x %>' value = '<%=i %>_<%=x %>'>  --%>
								关闭时间段
							</input>
		  				</td>
	    			 	<%
	    			 	}
	    			 	%>


	  				
 
	    			 	<%
	    			 	x = 1;
	    			 	if (seats[i].getPeroid1() == 0)
	    			 	{	
	    			 	%>
		  				<td bgcolor="green">
							<input type = "radio" name = "seat" id = '<%=i %><%=x %>' value = '<%=i %>_<%=x %>'> 
								可预约
							</input>
		  				</td>
	    			 	<%
	    			 	}
	    			 	else if (seats[i].getPeroid1() == 1)
	    			 	{
	    			 	%>
		  				<td bgcolor="yellow">
							<%-- <input type = "radio" name = "seat" id = '<%=i %><%=x %>' value = '<%=i %>_<%=x %>'>  --%>
								已占用 
							</input>
		  				</td>
	    			 	<%
						}
	    			 	else if(seats[i].getPeroid1() == 2)
	    			 	{
	    			 	%>
		  				<td bgcolor="yellow">
							<%-- <input type = "radio" name = "seat" id = '<%=i %><%=x %>' value = '<%=i %>_<%=x %>'>  --%>
								已过时
							</input>
		  				</td>
	    			 	<%
	    			 	}
	    			 	else if(seats[i].getPeroid1() == 3)
	    			 	{
	    			 	%>
		  				<td bgcolor="yellow">
							<%-- <input type = "radio" name = "seat" id = '<%=i %><%=x %>' value = '<%=i %>_<%=x %>'>  --%>
								关闭时间段
							</input>
		  				</td>
	    			 	<%
	    			 	}
	    			 	%>
	    			 	
	    			 	
	    			 	<%
	    			 	x = 2;
	    			 	if (seats[i].getPeroid2() == 0)
	    			 	{	
	    			 	%>
		  				<td bgcolor="green">
							<input type = "radio" name = "seat" id = '<%=i %><%=x %>' value = '<%=i %>_<%=x %>'> 
								可预约
							</input>
		  				</td>
	    			 	<%
	    			 	}
	    			 	else if (seats[i].getPeroid2() == 1)
	    			 	{
	    			 	%>
		  				<td bgcolor="yellow">
							<%-- <input type = "radio" name = "seat" id = '<%=i %><%=x %>' value = '<%=i %>_<%=x %>'>  --%>
								已占用 
							</input>
		  				</td>
	    			 	<%
						}
	    			 	else if(seats[i].getPeroid2() == 2)
	    			 	{
	    			 	%>
		  				<td bgcolor="yellow">
							<%-- <input type = "radio" name = "seat" id = '<%=i %><%=x %>' value = '<%=i %>_<%=x %>'>  --%>
								已过时
							</input>
		  				</td>
	    			 	<%
	    			 	}
	    			 	else if(seats[i].getPeroid2() == 3)
	    			 	{
	    			 	%>
		  				<td bgcolor="yellow">
							<%-- <input type = "radio" name = "seat" id = '<%=i %><%=x %>' value = '<%=i %>_<%=x %>'>  --%>
								关闭时间段
							</input>
		  				</td>
	    			 	<%
	    			 	}
	    			 	%>
	    			 	
	    			 	
	    			 	<%
	    			 	x = 3;
	    			 	if (seats[i].getPeroid3() == 0)
	    			 	{	
	    			 	%>
		  				<td bgcolor="green">
							<input type = "radio" name = "seat" id = '<%=i %><%=x %>' value = '<%=i %>_<%=x %>'> 
								可预约
							</input>
		  				</td>
	    			 	<%
	    			 	}
	    			 	else if (seats[i].getPeroid3() == 1)
	    			 	{
	    			 	%>
		  				<td bgcolor="yellow">
							<%-- <input type = "radio" name = "seat" id = '<%=i %><%=x %>' value = '<%=i %>_<%=x %>'>  --%>
								已占用 
							</input>
		  				</td>
	    			 	<%
						}
	    			 	else if(seats[i].getPeroid3() == 2)
	    			 	{
	    			 	%>
		  				<td bgcolor="yellow">
							<%-- <input type = "radio" name = "seat" id = '<%=i %><%=x %>' value = '<%=i %>_<%=x %>'>  --%>
								已过时
							</input>
		  				</td>
	    			 	<%
	    			 	}
	    			 	else if(seats[i].getPeroid3() == 3)
	    			 	{
	    			 	%>
		  				<td bgcolor="yellow">
							<%-- <input type = "radio" name = "seat" id = '<%=i %><%=x %>' value = '<%=i %>_<%=x %>'>  --%>
								关闭时间段
							</input>
		  				</td>
	    			 	<%
	    			 	}
	    			 	%>
	    			 	
	    			 	
	    			 	<%
	    			 	x = 4;
	    			 	if (seats[i].getPeroid4() == 0)
	    			 	{	
	    			 	%>
		  				<td bgcolor="green">
							<input type = "radio" name = "seat" id = '<%=i %><%=x %>' value = '<%=i %>_<%=x %>'> 
								可预约
							</input>
		  				</td>
	    			 	<%
	    			 	}
	    			 	else if (seats[i].getPeroid4() == 1)
	    			 	{
	    			 	%>
		  				<td bgcolor="yellow">
							<%-- <input type = "radio" name = "seat" id = '<%=i %><%=x %>' value = '<%=i %>_<%=x %>'>  --%>
								已占用 
							</input>
		  				</td>
	    			 	<%
						}
	    			 	else if(seats[i].getPeroid4() == 2)
	    			 	{
	    			 	%>
		  				<td bgcolor="yellow">
							<%-- <input type = "radio" name = "seat" id = '<%=i %><%=x %>' value = '<%=i %>_<%=x %>'>  --%>
								已过时
							</input>
		  				</td>
	    			 	<%
	    			 	}
	    			 	else if(seats[i].getPeroid4() == 3)
	    			 	{
	    			 	%>
		  				<td bgcolor="yellow">
							<%-- <input type = "radio" name = "seat" id = '<%=i %><%=x %>' value = '<%=i %>_<%=x %>'> --%> 
								关闭时间段
							</input>
		  				</td>
	    			 	<%
	    			 	}
	    			 	%>


		      </tr>
		      	
 <%
 }%>
		   </tbody>
		</table>
		
		<input type="submit" class="btn btn-success" value="提 交" onclick="if(!confirm('确定预订该座位？'))return false;">
		<input type="reset" class="btn btn-success" value="重 置">
		</form>
	  </div>
	  <%} %>

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
