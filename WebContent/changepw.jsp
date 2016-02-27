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
            <script type="text/javascript">
	    	function changepw(form){

	        	if(form.password.value == ""){
	        		alert("密码不能为空！");
	        		return false;
	        	}
	        	if(form.repassword.value == ""){
	        		alert("确认密码不能为空！");
	        		return false;
	        	}
	        	if(form.password.value != form.repassword.value){
	        		alert("两次密码输入不一致！");
	        		return false;
	        	}

	    	}
	    </script>
  </head>

  <body>
    <%
    User user = (User)session.getAttribute("user");
    %>
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
          <%
          if (user.getUserType() == 0 || user.getUserType() == -1) {
          %>
            <li><a href="./seatsbooking.jsp">个人座位预定</a></li>
            <li><a href="./groupbooking.jsp">集体座位预定</a></li>
            <li><a href="./InfoServlet">查看个人座位预定</a></li>
            <li><a href="./GroupInfoServlet">查看集体座位预定</a></li>
            <li class ="active"><a href="changepw.jsp">修改密码</a></li>
          <%
          } else if (user.getUserType() == 1 || user.getUserType() == -2) { 
          %>
            <li><a href="./groupbooking.jsp">集体座位预定</a></li>
            <li><a href="./GroupInfoServlet">查看集体座位预定</a></li>
            <li class ="active"><a href="changepw.jsp">修改密码</a></li>
          <%
          } else {
          %>
            <li><a href="./adminuser.jsp">管理用户</a></li>
            <li><a href="./adminseat.jsp">个人座位预定</a></li>
            <li><a href="./admingroup.jsp">团体预定</a></li>
            <li><a href="./SetAccessServlet">管理时间段开放权限</a></li>
            <li class ="active"><a href="changepw.jsp">修改密码</a></li>
          <%
          }
          %>
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
    </div>

    <!-- Main jumbotron for a primary marketing message or call to action -->
<br><br><br>
<div id="content">
	  <div class="container">
	    <form action="ChangepwServlet" method="post" onsubmit="return changepw(this);" class="form-horizontal">
	      <div class="row">
	        <h1 style="text-align:center; height:60px">修改密码</h1>
	      </div>
	      <div class="col-md-6 col-md-offset-3 col-xs-10 col-xs-offset-1 register">
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
	            <div class="form-group">
	              <label for="password" class="col-sm-3 control-label">确认密码：</label>
	              <div class="col-sm-8">
	                <div class="input-group">
	                <input type="password" class="form-control" name="repassword" placeholder="请确认密码">
	               <div class="input-group-addon">
	               <span class="glyphicon glyphicon-lock"></span>
	               </div>
	             </div>
	            </div>
	            </div>
	    <div class="row">
	        <div class="col-md-3 col-md-offset-3 col-xs-12">
	            <button type="reset" class="btn btn-default btn-block"><b> &nbsp; &nbsp; 重置 &nbsp;&nbsp;</b>
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
