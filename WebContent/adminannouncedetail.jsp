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

    <title>公告详情-教室预订系统</title>

    <!-- Bootstrap core CSS -->
    <link href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->

           

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
        }

       	%>
         <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <!-- <li><a href="./admin_message.jsp">管理员界面</a></li> -->
            <!-- <li><a href="./AdminGroupServlet">团体座位管理</a></li>
            <li><a href="./adminaddgroup.jsp">添加团体座位预订</a></li> -->
            
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

	
	
	<br><br><br>
    <div class="container">
    
    <h1 align="center">公告详细信息</h1>
    <br>
    <%
			 
    		ArrayList<String> announce = (ArrayList<String>)session.getAttribute("announcement");
		 	String sid = request.getParameter("groupid");
		 	int id = Integer.valueOf(sid);
		 	String str = announce.get(id);
    		String[] list = str.split("####");
    		String announceContent = list[1];
    		String pubtime = list[0];
    		
	%>
		<table class="table table-striped">
		   <thead>
		   </thead>
		   <tbody>
		   
		   <tr>
		   	 <td width = "8%">公告内容</td>
		   	 <td width = "50%"><%=announceContent %></td>
		   </tr>
	
		   <tr>
		   	 <td width = "8%">发布日期</td>
		   	 <td width = "50%"><%=pubtime %></td>
		   </tr>
		  
		  
		   </tbody>
		</table>
		
		 <a class="btn btn-primary btn-lg" href="./AdminAnnouncementServlet" role="button">返回 &raquo;</a>

	  </div>
	
	
	
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
