<%@ page language="java" contentType="text/html; charset=gb2312"
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
    <link rel="icon" href="../../favicon.ico">

    <title>登录-教室预定系统</title>

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
          <a class="navbar-brand" href="#">教室预定系统</a>
        </div>
        
		<div id="navbar" class="navbar-collapse collapse">
          <form class="navbar-form navbar-right">
            <div class="form-group">
            	<a style="font-size:22px;color:gray;font-weight:bold">登录页</a>
            </div>
          </form>
        </div><!--/.navbar-collapse -->        
        
      </div>
    </nav>
    </div>

    <!-- Main jumbotron for a primary marketing message or call to action -->
    <div class="container" style="width:300px"]>

      <form class="form-signin" action="LoginServlet" method="post" onSubmit="return login(this)">
        <h2 class="form-signin-heading"> </h2>
        <h2 class="form-signin-heading"> </h2>
        <h2 class="form-signin-heading"> </h2>
        <br>
        <br><br>
        <label for="inputEmail" class="sr-only">Email address</label>
        <input type="text"  placeholder="用户名" class="form-control" name="studentnum">
        <label for="inputPassword"  class="sr-only">Password</label>
        <input type="password" placeholder="密码" class="form-control" name="password">
        <%
	    	// 获取提示信息
			String info = (String)request.getAttribute("info");
	    	// 如果提示信息不为空，则输出提示信息
			if(info != null){
		%>
		<p>提示信息:<%=info%></p>
		<%} else {%>
        <br>
        <%} %>
        <button class="btn btn-lg btn-primary btn-block" type="submit">登录</button>
      </form>

    </div>
    

    <div class="container" style="position:fixed; bottom:0px;">

      <hr>

      <footer >
        <p align="center">&copy; 版权所有 教研院 2016</p>
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
