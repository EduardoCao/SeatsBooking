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

    <title>座位预订说明</title>

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
	<% 
		User user = (User)session.getAttribute("user");
	%>
  <body>
	<div>
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
            <li><a href="<%=ref%>"><%=tag %></a></li>
            
          </ul>
                  <%} %>
        <div class="navbar-collapse collapse" role="navigation">
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
              <li><a href="./login.jsp"><%="尚未登录" %></a></li>
              <%} %>
          </ul>
        </div>
      </div>
    </nav>
    </div>

    <!-- Main jumbotron for a primary marketing message or call to action -->

    <!-- Main jumbotron for a primary marketing message or call to action -->
   
    <div class="jumbotron" style="height:800px;">
      <div class="container">
       <br>
        <h3>个人座位预订说明</h3>
        
        <p>	1) 个人座位共12个，每天五个时间段，采取先到先得的预订办法，可预约一周内的座位。</p>
        <p>	2) 个人座位每个人每天最多预订两个（时间段已经过去的不算在内）；在七天以内，最多预约三天的个人座位。</p>
        <p>	3) 预约和取消预约，都需要在时间段开始1个小时以前进行。</p>
        <p>	4) 迟到15分钟以上的同学，会被管理员限制两周的使用权限。</p>
        <p>	5) 管理员由于特殊原因可能会临时关闭某些时间段的申请；已经预约上的同学的座位也会被取消。</p>
        <p>	6) 教师可以预约团体座位，不可以预约个人座位。</p>
        
        <h3>团体座位预订说明</h3>
        <p>	1) 团体座位共2个，采取提交预约申请，由管理员批准的办法。</p>
        <p>	2) 团体座位只可以预约周一、周三、周四下午13：00-15：00、15：00-17：00两个时间段的团体座位。</p>
        <p>	3) 团体座位申请需要写明用途，由管理员审批后方算预约成功。</p>
        <p>	4) 预约和取消预约，都需要在时间段开始1个小时以前进行。</p>
        <p>	5) 迟到15分钟以上的同学，会被管理员限制两周的使用权限。</p>
        <p>	6) 管理员由于特殊原因可能会临时关闭某些时间段的申请；已经预约上的同学的座位也会被取消。</p>
        
        
        <h3>如果您遇到了任何问题请发邮件给我们的管理员：</h3>
        <p>ioe_thu@163.com</p>
      </div>
    </div>



	<div class="container" bottom="0px">
	<hr>
      <!-- Example row of columns -->
      <!-- Example row of columns -->
      <div class="row">



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