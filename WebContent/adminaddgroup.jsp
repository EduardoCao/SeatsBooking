<%@ page language="java" contentType="text/html; charset=utf-8"
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

    <title>添加团体座位预定-教室预订系统</title>

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
    		boolean isAdmin = false;
    		%>
    
    
<nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
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
        		isAdmin = true;
        	}
        		
       	%>
        <div class="navbar-collapse collapse" role="navigation">
          <ul class="nav navbar-nav">
            <li><a href="./admin_message.jsp">管理员界面</a></li>
            <li><a href="./AdminGroupServlet">团体座位管理</a></li>
            <li class="active"><a href="./adminaddgroup.jsp">添加团体座位预订</a></li>
          </ul>
          <ul class="nav navbar-nav navbar-right hidden-sm">
          	<%if (user != null) { %>
			<li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">用户 <span class="caret"></span></a>
              <ul class="dropdown-menu">
                <li style="text-align:center;"><a href="./admin_message.jsp"><%=user.getStudentnum()%></a></li>
                <li style="text-align:center;"><a href="./ExitServlet">退出</a></li>
              </ul>
            </li>
              <%} else { %>
              <li><a href="./login.jsp"><%="尚未登录" %></a></li>
              <%} %>
          </ul>
        </div>
      </div>
    </nav>
    
        <br><br><br>
    <%if (isAdmin) { %>
    <div class="container">
    <form action="./AdminGroupInfoServlet" method="post" onsubmit="return reg(this);" class="form-horizontal">
	            <div class="form-group">
	              <label for="authcode" class="col-sm-3 control-label" style="width:100px;">查询日期：</label>
	              <div class="col-sm-5">
	                <div class="input-group">
	                  <select class = "form-control" name="bookdate">
		    				<option selected value = <%=DateManager.getFormatCompleteDate(6) %>> <%=DateManager.getFormatDate(6) %> </option>
		    				<option selected value = <%=DateManager.getFormatCompleteDate(5) %>> <%=DateManager.getFormatDate(5) %> </option>
		    				<option selected value = <%=DateManager.getFormatCompleteDate(4) %>> <%=DateManager.getFormatDate(4) %> </option>
		    				<option selected value = <%=DateManager.getFormatCompleteDate(3) %>> <%=DateManager.getFormatDate(3) %> </option>
		    				<option selected value = <%=DateManager.getFormatCompleteDate(2) %>> <%=DateManager.getFormatDate(2) %> </option>
		    				<option selected value = <%=DateManager.getFormatCompleteDate(1) %>> <%=DateManager.getFormatDate(1) %> </option>
		    				<option selected value = <%=DateManager.getFormatCompleteDate(0) %>> <%=DateManager.getFormatDate(0) %> </option>
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
	 String bookdate = (String) session.getAttribute("bookdate"); 
  	if(date != null){
  	  date = date.substring(5).replace("_" , "-");
  	}

if(seats != null){ 
%>    

    <div class="container">
	<form action="./AddGroupServlet" method="post" onsubmit="return reg(this);" >

    <div ><h1>添加团体座位预订&nbsp;<%=date %></h1></div>
    
    
	<div class="form-group" style="float:left;">
	              <label for="authcode" class="col-sm-3 control-label" style="width:230px;font-size:19px" >用户：</label>
	              <div class="col-sm-5">
	                <div class="input-group">
   			<select name="bookuser" class = "form-control" style="width:110px;">
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
	            	</div>
	            	</div>
	            	</div>
		<table class="table table-striped">
		   <thead>
		      <tr>
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

				for (int i = 0 ; i < seats.length ; i ++)
				{
				%>
				
				<tr>
				
				<td><%="座位"+i%></td>
	  			<%
	  			if( bookdate.equals(DateManager.getFormatCompleteDate(0)) && DateManager.compareTime(DateManager.currentTime() , DateManager.getDDL(0)) > 0 && DateManager.compareTime(DateManager.currentTime() , DateManager.getEndDDL(0)) < 0 && seats[i].getPeroid0() != 3 )
			 	{
			 	%>
  				<td bgcolor="yellow">
	  				<%
	  				if (seats[i].getOwnerPeroid0() != null)
	  				{
	  				%>
		  			<%=seats[i].getOwnerPeroid0() %>
	  				<%
	  				}
	  				else
	  				{
	  				%>
	  				<input type = "radio" name = "addGroup" id = <%=i + "_0" %> value = <%=i + "_0" %>>已过期
	  				<%
	  				}
	  				%>
	  				</td>
			 	<%
			 	}
	  			else if( bookdate.equals(DateManager.getFormatCompleteDate(0)) && DateManager.compareTime(DateManager.currentTime() , DateManager.getEndDDL(0)) > 0 && seats[i].getPeroid0() != 3 )
			 	{
			 	%>
  				<td bgcolor="yellow">
	  				<%
	  				if (seats[i].getOwnerPeroid0() != null)
	  				{
	  				%>
		  			<%=seats[i].getOwnerPeroid0() %>
	  				<%
	  				}
	  				else
	  				{
	  				%>已过期<%
	  				}
	  				%>
	  				</td>
			 	<%
			 	}
	  			else if( seats[i].getPeroid0()==1 )
	  			{
		  			%>
		  			<td bgcolor="yellow"><%=seats[i].getOwnerPeroid0() %></td>
		  			<%
	  			} 
	  			else if ( seats[i].getPeroid0()==0 ){
	  				%><td bgcolor="green">
	  				<input type = "radio" name = "addGroup" id = <%=i + "_0" %> value = <%=i + "_0" %>>
	  				空闲
	  				</td><%
	  			}
	  			else if ( seats[i].getPeroid0()==3 ) {
	  				%><td bgcolor="yellow">座位被关闭</td><%
	  			}
	  			%>


	  			<%
	  			if( bookdate.equals(DateManager.getFormatCompleteDate(0)) && DateManager.compareTime(DateManager.currentTime() , DateManager.getDDL(1)) > 0 && DateManager.compareTime(DateManager.currentTime() , DateManager.getEndDDL(1)) < 0 && seats[i].getPeroid1() != 3 )
			 	{
			 	%>
  				<td bgcolor="yellow">
	  				<%
	  				if (seats[i].getOwnerPeroid1() != null)
	  				{
	  				%>
		  			<%=seats[i].getOwnerPeroid1() %>
	  				<%
	  				}
	  				else
	  				{
	  				%>
	  				<input type = "radio" name = "addGroup" id = <%=i + "_1" %> value = <%=i + "_1" %>>已过期
	  				<%
	  				}
	  				%>
	  				</td>
			 	<%
			 	}
	  			else if( bookdate.equals(DateManager.getFormatCompleteDate(0)) && DateManager.compareTime(DateManager.currentTime() , DateManager.getEndDDL(1)) > 0 && seats[i].getPeroid1() != 3 )
			 	{
			 	%>
  				<td bgcolor="yellow">
	  				<%
	  				if (seats[i].getOwnerPeroid1() != null)
	  				{
	  				%>
		  			<%=seats[i].getOwnerPeroid1() %>
	  				<%
	  				}
	  				else
	  				{
	  				%>
	  				已过期
	  				<%
	  				}
	  				%>
	  				</td>
			 	<%
			 	}
	  			else if( seats[i].getPeroid1()==1 )
	  			{
		  			%>
		  			<td bgcolor="yellow"><%=seats[i].getOwnerPeroid1() %></td>
		  		<%
	  			} 
	  			else if ( seats[i].getPeroid1()==0 ){
	  				%><td bgcolor="green">
	  				<input type = "radio" name = "addGroup" id = <%=i + "_1" %> value = <%=i + "_1" %>>
	  				空闲
	  				</td><%
	  			}
	  			else if ( seats[i].getPeroid1()==3 ) {
	  				%><td bgcolor="yellow">座位被关闭</td><%
	  			}
	  			%>
				
				
	  			<%
	  			if( bookdate.equals(DateManager.getFormatCompleteDate(0)) && DateManager.compareTime(DateManager.currentTime() , DateManager.getDDL(2)) > 0 && DateManager.compareTime(DateManager.currentTime() , DateManager.getEndDDL(2)) < 0 && seats[i].getPeroid2() != 3 )
			 	{
			 	%>
  				<td bgcolor="yellow">
	  				<%
	  				if (seats[i].getOwnerPeroid2() != null)
	  				{
	  				%>
		  			<%=seats[i].getOwnerPeroid2() %>
	  				<%
	  				}
	  				else
	  				{
	  				%>
	  				<input type = "radio" name = "addGroup" id = <%=i + "_2" %> value = <%=i + "_2" %>>已过期
	  				<%
	  				}
	  				%>
	  				</td>
			 	<%
			 	}
	  			else if( bookdate.equals(DateManager.getFormatCompleteDate(0)) && DateManager.compareTime(DateManager.currentTime() , DateManager.getEndDDL(2)) > 0 && seats[i].getPeroid2() != 3 )
			 	{
			 	%>
  				<td bgcolor="yellow">
	  				<%
	  				if (seats[i].getOwnerPeroid2() != null)
	  				{
	  				%>
		  			<%=seats[i].getOwnerPeroid2() %>
	  				<%
	  				}
	  				else
	  				{
	  				%>
	  				已过期
	  				<%
	  				}
	  				%>
	  				</td>
			 	<%
			 	}
	  			else if( seats[i].getPeroid2()==1 )
	  			{
		  			%>
		  			<td bgcolor="yellow"><%=seats[i].getOwnerPeroid2() %></td>
		  		<%
	  			} 
	  			else if ( seats[i].getPeroid2()==0 ){
	  				%><td bgcolor="green">
	  				<input type = "radio" name = "addGroup" id = <%=i + "_2" %> value = <%=i + "_2" %>>
	  				空闲
	  				</td><%
	  			}
	  			else if ( seats[i].getPeroid2()==3 ) {
	  				%><td bgcolor="yellow">座位被关闭</td><%
	  			}
	  			%>
				
				
	  			<%
	  			if( bookdate.equals(DateManager.getFormatCompleteDate(0)) && DateManager.compareTime(DateManager.currentTime() , DateManager.getDDL(3)) > 0 && DateManager.compareTime(DateManager.currentTime() , DateManager.getEndDDL(3)) < 0 && seats[i].getPeroid3() != 3 )
			 	{
			 	%>
  				<td bgcolor="yellow">
	  				<%
	  				if (seats[i].getOwnerPeroid3() != null)
	  				{
	  				%>
		  			<%=seats[i].getOwnerPeroid3() %>
	  				<%
	  				}
	  				else
	  				{
	  				%>
	  				<input type = "radio" name = "addGroup" id = <%=i + "_3" %> value = <%=i + "_3" %>>已过期
	  				<%
	  				}
	  				%>
	  				</td>
			 	<%
			 	}
	  			else if( bookdate.equals(DateManager.getFormatCompleteDate(0)) && DateManager.compareTime(DateManager.currentTime() , DateManager.getEndDDL(3)) > 0 && seats[i].getPeroid3() != 3 )
			 	{
			 	%>
  				<td bgcolor="yellow">
	  				<%
	  				if (seats[i].getOwnerPeroid3() != null)
	  				{
	  				%>
		  			<%=seats[i].getOwnerPeroid3() %>
	  				<%
	  				}
	  				else
	  				{
	  				%>
	  				已过期
	  				<%
	  				}
	  				%>
	  				</td>
			 	<%
			 	}
	  			else if( seats[i].getPeroid3()==1 )
	  			{
		  			%>
		  			<td bgcolor="yellow"><%=seats[i].getOwnerPeroid3() %></td>
		  		<%
	  			} 
	  			else if ( seats[i].getPeroid3()==0 ){
	  				%><td bgcolor="green">
	  				<input type = "radio" name = "addGroup" id = <%=i + "_3" %> value = <%=i + "_3" %>>
	  				空闲
	  				</td><%
	  			}
	  			else if ( seats[i].getPeroid3()==3 ) {
	  				%><td bgcolor="yellow">座位被关闭</td><%
	  			}
	  			%>
				
				
	  			<%
	  			if( bookdate.equals(DateManager.getFormatCompleteDate(0)) && DateManager.compareTime(DateManager.currentTime() , DateManager.getDDL(4)) > 0 && DateManager.compareTime(DateManager.currentTime() , DateManager.getEndDDL(4)) < 0 && seats[i].getPeroid4() != 3 )
			 	{
			 	%>
  				<td bgcolor="yellow">
	  				<%
	  				if (seats[i].getOwnerPeroid4() != null)
	  				{
	  				%>
		  			<%=seats[i].getOwnerPeroid4() %>
	  				<%
	  				}
	  				else
	  				{
	  				%>
	  				<input type = "radio" name = "addGroup" id = <%=i + "_4" %> value = <%=i + "_4" %>>已过期
	  				<%
	  				}
	  				%>
	  				</td>
			 	<%
			 	}
	  			else if( bookdate.equals(DateManager.getFormatCompleteDate(0)) && DateManager.compareTime(DateManager.currentTime() , DateManager.getEndDDL(4)) > 0 && seats[i].getPeroid4() != 3 )
			 	{
			 	%>
  				<td bgcolor="yellow">
	  				<%
	  				if (seats[i].getOwnerPeroid4() != null)
	  				{
	  				%>
		  			<%=seats[i].getOwnerPeroid4() %>
	  				<%
	  				}
	  				else
	  				{
	  				%>
	  				已过期
	  				<%
	  				}
	  				%>
	  				</td>
			 	<%
			 	}
	  			else if( seats[i].getPeroid4()==1 )
	  			{
		  			%>
		  			<td bgcolor="yellow"><%=seats[i].getOwnerPeroid4() %></td>
		  		<%
	  			} else if ( seats[i].getPeroid4()==0 ){
	  				%><td bgcolor="green">
	  				<input type = "radio" name = "addGroup" id = <%=i + "_4" %> value = <%=i + "_4" %>>
	  				空闲
	  				</td><%
	  			}
	  			else if ( seats[i].getPeroid4()==3 ) {
	  				%><td bgcolor="yellow">座位被关闭</td><%
	  			}
	  			%>
				
				</tr>
				<%
				}
			    %>
				
		   </tbody>
		</table>
		
		<input type="submit" class="btn btn-success" value="添加预订" onclick="if(!confirm('确定添加？'))return false;">
		<input type="reset" class="btn btn-success" value="重 置">
		</form>
	  </div>
	  <%  
	  }  } else {%>
	  <h1 align="center">您没有权限查看此页面。</h1>
	  <%
	  } }
	  %>



	  
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
