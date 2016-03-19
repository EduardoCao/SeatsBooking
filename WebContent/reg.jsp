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
    <link href="favicon.ico" mce_href="favicon.ico" rel="bookmark" type="image/x-icon" /> 
	<link href="favicon.ico" mce_href="favicon.ico" rel="icon" type="image/x-icon" /> 
	<link href="favicon.ico" mce_href="favicon.ico" rel="shortcut icon" type="image/x-icon" /> 

    <title>用户注册-教室预订系统</title>

    <!-- Bootstrap core CSS -->
    <link href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="../../assets/js/ie-emulation-modes-warning.js"></script>
            <script type="text/javascript">
	    	function reg(form){
	        	if(form.studentnum.value == ""){
	        		alert("学生证号不能为空！");
	        		return false;
	        	}
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
	        	if(form.email.value == ""){
	        		alert("电子邮箱不能为空！");
	        		return false;
	        	}

	    	}
	    </script>

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
        		ref = "./admin_message.jsp";
        		isAdmin = true;
        	}
        }
        if(isAdmin)
        {
       	%>
        <div class="navbar-collapse collapse" role="navigation">
          <ul class="nav navbar-nav">
            <li><a href="./admin_message.jsp">管理员界面</a></li>
            <li class="active"><a href="./reg.jsp">用户注册</a></li>
            <li><a href="./AdminUserServlet">用户状态</a></li>
          </ul>
          <ul class="nav navbar-nav navbar-right hidden-sm">
          	<%if (user != null) { %>
			<li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">用户 <span class="caret"></span></a>
              <ul class="dropdown-menu">
                <li style="text-align:center;"><a href="#"><%=user.getStudentnum()%></a></li>
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


    <div class="container">
      <!-- Example row of columns -->
      <div class="row">
        <div class="col-md-4">
         <!--  <p>一段描述</p> -->
        </div>
      </div>

	<br>

	<div id="content">
	  <div class="container">
	    <form action="RegServlet" method="post" onsubmit="return reg(this);" class="form-horizontal">
	      <div class="row">
	        <h1 style="text-align:center; height:60px">注册</h1>
	      </div>
	      <div class="col-md-6 col-md-offset-3 col-xs-10 col-xs-offset-1 register">
	            <div class="form-group">
	              <label for="username" class="col-sm-3 control-label">学生证号：</label>
	              <div class="col-sm-8">
	                <div class="input-group">
	                <input type="text" class="form-control" name="studentnum" placeholder="请输入学生证号">
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
	            <div class="form-group">
	              <label for="chkpwd" class="col-sm-3 control-label">确认密码：</label>
	              <div class="col-sm-8">
	                <div class="input-group">
	                <input type="password" class="form-control" name="repassword" placeholder="请确认密码">
	               <div class="input-group-addon">
	               <span class="glyphicon glyphicon-exclamation-sign"></span>
	               </div>
	             </div>
	            </div>
	            </div>
	            <div class="form-group">
	              <label for="email" class="col-sm-3 control-label">电子邮箱：</label>
	              <div class="col-sm-8">
	                <div class="input-group">
	                <input type="text" class="form-control" name="email" placeholder="请输入有效邮箱">
	               <div class="input-group-addon">
	               <span class="glyphicon glyphicon-envelope"></span>
	               </div>
	             </div>
	            </div>
	            </div>
	            <div class="form-group">
	              <label for="authcode" class="col-sm-3 control-label">用户类别：</label>
	              <div class="col-sm-5">
	                <div class="input-group">
	                  <select class = "form-control" name="userType">
						<option selected value = "1"> 教师 </option>
						<option selected value = "0"> 学生 </option>
					  </select>
	            	</div>
	              </div>

	            </div>
	    <div class="row">
	        <div class="col-md-3 col-md-offset-3 col-xs-12">
	            <button type="reset" class="btn btn-default btn-block"><b> &nbsp; &nbsp; 清空 &nbsp;&nbsp;</b>
	              <span class="glyphicon glyphicon-remove"></span></button>
	        </div>
	        <div class="col-md-3 col-xs-12">
	            <button type="submit" class="btn btn-info btn-block" onclick="if(!confirm('确定注册？'))return false;"><b>&nbsp;&nbsp; 提交 &nbsp;&nbsp;</b>
	            <span class="glyphicon glyphicon-arrow-right"></span></button>
	        </div>
	      </div>
	    </form>
	  </div>
	</div>

    <div class="container">
      <hr>
      <footer>
        <p align="center">&copy; 2016 IOE, Tsinghua University</p>
      </footer>
    </div> <!-- /container -->

<%} %>
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
    <script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>
