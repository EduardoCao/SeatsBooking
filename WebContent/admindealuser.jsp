<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"
    import="util.User"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
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

    <title>用户状态-教室预订系统</title>

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
    
    
<div class="navbar navbar-inverse navbar-fixed-top">
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
        		isAdmin = true;
        		ref = "./admin_message.jsp";
        	}
        }
        		
       	%>
        <div class="navbar-collapse collapse" role="navigation">
          <ul class="nav navbar-nav">
            <li><a href="./admin_message.jsp">管理员界面</a></li>
            <li><a href="./reg.jsp">用户注册</a></li>
            <li class="active"><a href="./AdminUserServlet">用户状态</a></li>
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
    </div>
<%if (isAdmin) { %>
    <!-- Main jumbotron for a primary marketing message or call to action -->
    <br><br><br>
    <div class="container">
    <form name="form1" action="" method="post" onSubmit="return login(this);">
    <h1>用户列表</h1>

		<table class="table table-striped">
		   <thead>
		      <tr>
		      	 <th align="right">选择</th>
		      	 <th >用户名</th>
		      	 <th >姓名</th>
		         <th>邮箱</th>
		         <th>id</th>
		      </tr>
		   </thead>
		   <tbody>
		   
		       <%
					ArrayList<User> showallusers = (ArrayList<User>)session.getAttribute("showallusers");
					if (showallusers != null && showallusers.size() > 0)
					{
					for (int i = 0 ; i < showallusers.size() ; i ++)
					{
				%>
		   
		      <tr>
		      	 <td align="center"><input type = "radio" name = "delete" id = <%=i %> value = <%=i %>></td>
		         <td><%=showallusers.get(i).getStudentnum() %></td>
		         <td><%=showallusers.get(i).getName() %></td>
		         <td><%=showallusers.get(i).getEmail() %></td>
		         <td><%=showallusers.get(i).getUserType() %></td>
		      </tr>
		      <%} } %>
		   </tbody>
		</table>
		
		<input type="submit" class="btn btn-success" value="删 除" onclick="form1.action='DeleteUserServlet';if(!confirm('确定删除？'))return false;">
		<input type="submit" class="btn btn-success" value="禁 足" onclick="form1.action='CloseUserServlet';if(!confirm('确定禁足？'))return false;">
		<input type="reset" class="btn btn-success" value="重 置">
		</form>
	  </div>
	  
    <div class="container">
    <form action="OpenUserServlet" method="post" onSubmit="return login(this);">
    <h1>放出关禁闭用户</h1><p>(注意：关禁闭满两星期的用户会在管理员打开此页面后自动放出)</p>

		<table class="table table-striped">
		   <thead>
		      <tr>
		      	 <th align="right">选择</th>
		      	 <th >用户名</th>
		         <th>邮箱</th>
		         <th>id</th>
		         <th>关闭时间</th>
		      </tr>
		   </thead>
		   <tbody>
		   
		       <%
				   	if (showallusers != null && showallusers.size() > 0)
					{
					for (int i = 0 ; i < showallusers.size() ; i ++)
					{
						if(showallusers.get(i).getUserType() < 0)
						{	
							HashMap<String , String> closetime = (HashMap<String , String>)session.getAttribute("closetime");
				%>
		   
		      <tr>
		      	 <td align="center"><input type = "radio" name = "openUser" id = <%=i %> value = <%=i %>></td>
		         <td><%=showallusers.get(i).getStudentnum() %></td>
		         <td><%=showallusers.get(i).getEmail() %></td>
		         <td><%=showallusers.get(i).getUserType() %></td>
		         <td><%=closetime.get(showallusers.get(i).getStudentnum()) %></td>
		      </tr>
		      <%} }} %>
		   </tbody>
		</table>
		
		<input type="submit" class="btn btn-success" value="解 禁" onclick="if(!confirm('确定解禁该用户？'))return false;">
		<input type="reset" class="btn btn-success" value="重 置">
		</form>
	  </div>
	<br><br>
<!-- 	<div class = "container">
	 <form action="CheckCloseUserServlet" method="post" onSubmit="return login(this);">
 	<input type="button" name="checkclose" class="btn btn-success" value="检查禁足是否到期" onclick="form.submit()">
 </form>
	</div> -->
	  
    <div class="container">
      <!-- Example row of columns -->
      <div class="row">
        <div class="col-md-4">
        </div>
      </div>
      </div>
<%} else  {%>
<br><br><br>
<h1 align="center">您没有权限查看此页面。</h1>
<%} %>
    <div class="container">
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
