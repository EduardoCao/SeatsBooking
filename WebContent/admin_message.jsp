<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"
    import="util.User"%>
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

    <title>管理员界面-教室预订系统</title>

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
    		}
    	
        
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
          <img style="width:55px;height:51px;" src="./img/logo.jpg"/>
          <a class="navbar-brand hidden-sm" href=#>教室预订系统</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li><a href="./reg.jsp">管理用户</a></li>
            <li><a href="./adminseat.jsp">个人座位预订</a></li>
            <li><a href="./AdminGroupServlet">团体预订</a></li>
            <li><a href="./SetAccessServlet">管理时间段开放权限</a></li>
            
          </ul>
			<ul class="nav navbar-nav navbar-right hidden-sm">
          	<%if (user != null) { %>
			<li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">用户 <span class="caret"></span></a>
              <ul class="dropdown-menu">
                <li style="text-align:center;"><a><%=user.getStudentnum()%></a></li>
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
    </nav>
<%if (isAdmin) { %>
    <!-- Main jumbotron for a primary marketing message or call to action -->
    <div class="jumbotron" style="height:500px;background:url('./img/classroom.jpg') no-repeat center top; background-size: cover;">
      <div class="container">
        <h1>你好</h1>
        <p>欢迎进入管理员界面</p>
        <!-- <p>一段描述</p> -->
      </div>
    </div>

    <div class="container">
      <!-- Example row of columns -->
      <!-- Example row of columns -->
      <div class="row">
        <div class="col-md-4">
          <h2>座位预订说明</h2>
          
          <p><a class="btn btn-default" href="./description.jsp" role="button">View details &raquo;</a></p>
        </div>

        <div class="col-md-4">
          <h2>寻求帮助</h2>
          
          <p><a class="btn btn-default" href="./help.jsp" role="button">View details &raquo;</a></p>
        </div>
      </div>
	<%} else { %>
		<br><br><br>
		<h1 align="center">您没有权限查看此页面。</h1>
	<%} %>


        

  	<div class="container">
      <hr>      
      </div>
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
