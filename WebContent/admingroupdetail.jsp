<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="util.User"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="util.DateManager" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>

    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link href="favicon.ico" mce_href="favicon.ico" rel="bookmark" type="image/x-icon" /> 
	<link href="favicon.ico" mce_href="favicon.ico" rel="icon" type="image/x-icon" /> 
	<link href="favicon.ico" mce_href="favicon.ico" rel="shortcut icon" type="image/x-icon" /> 

    <title>待处理团体预定信息-教室预订系统</title>

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
        		isAdmin = true;
        	}
        }

       	%>
         <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li><a href="./admin_message.jsp">管理员界面</a></li>
            <li><a href="./AdminGroupServlet">团体座位管理</a></li>
            <li><a href="./adminaddgroup.jsp">添加团体座位预定</a></li>
            
          </ul>
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
    </div>

	<%if(isAdmin) {%>
	
	<br><br><br>
    <div class="container">
    <form action="AdminDelGroupServlet" method="post" onSubmit="return login(this);">
    <h1 align="center">待处理团体预定信息</h1>
    <br>
    <%
			 ArrayList<String> allGroupInfo = new ArrayList<String>();
		 	 allGroupInfo = (ArrayList<String>) session.getAttribute("allGroupInfo");
		 	ArrayList<User> showallusers = (ArrayList<User>) session.getAttribute("showallusers");
		 	 String sid = request.getParameter("groupid");
		 	 int id = Integer.valueOf(sid);
		 	 String[] list = allGroupInfo.get(id).trim().split("##");
    		String users = list[3].substring(11, list[3].length());
    		String name = "";
    		String bookd = list[0].substring(9).replaceAll("_", "-");
    		String seats = list[2].substring(5, list[2].length());
    		int per = Integer.valueOf(list[1].substring(7, 8));
    		String reason = list[4].substring(7, list[4].length());
    		for (User u : showallusers)
    		{
    			if (u.getStudentnum().equals(users))
    			{
    				name = u.getName();
    				break;
    			}
    		}
	%>
		<table class="table table-striped">
		   <thead>
		   </thead>
		   <tbody>
		   <tr>
		   	 <td align="right" width="100px">学号</td>
		   	 <td align="left" width="100px"><%=users %></td>
		   <tr>
		   <tr>
		   	 <td align="right">姓名</td>
		   	 <td align="left"><%=name %></td>
		   <tr>
		   <tr>
		   	 <td align="right">日期</td>
		   	 <td align="left"><%=bookd %></td>
		   <tr>
		   <tr>
		   	 <td align="right">座位号</td>
		   	 <td align="left"><%=seats %></td>
		   <tr>
		   <tr>
		   	 <td align="right">时间段</td>
		   	 <td align="left"><%=DateManager.getPeroid(per) %></td>
		   <tr>
		   <tr>
		   	 <td align="right" height="50px">申请理由</td>
		   	 <td align="left" height="50px"><%=reason %></td>
		   <tr>
		   </tbody>
		</table>
		
		<input type="submit" class="btn btn-success" value="删除预订" onclick="if(!confirm('确定删除？'))return false;">
		<input type="reset" class="btn btn-success" value="重 置">
		</form>
	  </div>
	
	
	<%} else {%>
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
