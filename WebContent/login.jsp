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

    <title>登录-教室预订系统</title>

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
          <img style="width:55px;height:51px;" src="./img/logo.jpg"/>
          <a class="navbar-brand" href="#">教室预订系统</a>
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
<br><br><br>
<div id="content">
	  <div class="container">
	    <form action="LoginServlet" method="post" onSubmit="return login(this)" class="form-horizontal">
	      <div class="row">
	        <h1 style="text-align:center; height:60px">登录</h1>
	      </div>
	      <div class="col-md-6 col-md-offset-3 col-xs-10 col-xs-offset-1 register">
	            <div class="form-group">
	              <label for="username" class="col-sm-3 control-label">学号：</label>
	              <div class="col-sm-8">
	                <div class="input-group">
	                <input type="text" class="form-control" name="studentnum" placeholder="请输入学号">
	               <div class="input-group-addon">
	               <span class="glyphicon glyphicon-user"></span>
	               </div>
	             </div>
	            </div>
	            </div>
	            <div class="form-group">
	              <label for="password" class="col-sm-3 control-label">密码：</label>
	              <div class="col-sm-8">
	                <div class="input-group">
	                <input type="password" class="form-control" name="password" placeholder="请输入密码">
	               <div class="input-group-addon">
	               <span class="glyphicon glyphicon-lock"></span>
	               </div>
	             </div>
	            </div>
	            </div>
	    <%
	    String info = (String)request.getAttribute("info");
	    if (info != null) {
	    %>
	    <p align="center"><%=info %></p>
	    <%} %>
	    <div class="row">
	        <div class="col-md-3 col-md-offset-3 col-xs-12">
	            <button type="reset" class="btn btn-default btn-block"><b> &nbsp; &nbsp; 清空 &nbsp;&nbsp;</b>
	              <span class="glyphicon glyphicon-remove"></span></button>
	        </div>
	        <div class="col-md-3 col-xs-12">
	            <button type="submit" class="btn btn-info btn-block"><b>&nbsp;&nbsp; 提交 &nbsp;&nbsp;</b>
	            <span class="glyphicon glyphicon-arrow-right"></span></button>
	        </div>
	      </div>
	    </form>
	  </div>
	</div>
    
	<br><br><br><br>
    <div class="container">
      <!-- Example row of columns -->
      <div class="row">
        <div class="col-md-4">
         <!--  <p>一段描述</p> -->
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
