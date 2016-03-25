<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"
    import="util.User"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
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

    <title>管理团体座位时间段开放权限-教室预订系统</title>

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
            <li><a href="./adminaddgroup.jsp">添加团体座位预订</a></li>
            <li class="active"><a href="./SetGroupAccessServlet">团体座位时段开放权限</a></li>
            
          </ul>
          <ul class="nav navbar-nav navbar-right hidden-sm">
          	<%if (user != null) { %>
			<li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">用户 <span class="caret"></span></a>
              <ul class="dropdown-menu">
                <li style="text-align:center;"><a href="./admin_message.jsp"><%=user.getStudentnum()%></a></li>
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


    <!-- Main jumbotron for a primary marketing message or call to action -->
    <br><br><br>
    <%if (isAdmin){ %>
    <div class="container">
    <form action="CloseGroupPeriodServlet" method="post" onSubmit="return login(this);">
    <h1>关闭时间段</h1>

		<table class="table table-striped">
		   <thead>
		      <tr>
		      	 <th>日期</th>
		      	 <%-- <th ><%=DateManager.getPeroid(0) %></th>
		         <th><%=DateManager.getPeroid(1) %></th> --%>
		         <th><%=DateManager.getPeroid(2) %></th>
		         <th><%=DateManager.getPeroid(3) %></th>
		         <%-- <th><%=DateManager.getPeroid(4) %></th> --%>
		      </tr>
		   </thead>
		   <tbody>
		   
				<%
					ArrayList<String> seataccess = (ArrayList<String>)session.getAttribute("groupseataccess");
					int tmp = 0;
					if (seataccess != null && seataccess.size() > 0)
					{
					int row = 0;
					for (int i = 0 ; i < seataccess.size() ; i ++)
					{
						if(DateManager.compareDate(seataccess.get(i).split("#")[0] , DateManager.getFormatCompleteDate(0)) < 0)
						{
							continue;
						}
						if(DateManager.compareDate(seataccess.get(i).split("#")[0] , DateManager.getFormatCompleteDate(7)) == 0)
						{
							continue;
						}
						if(DateManager.getWeek(seataccess.get(i).split("#")[0]) != 1 &&  DateManager.getWeek(seataccess.get(i).split("#")[0]) != 3 && DateManager.getWeek(seataccess.get(i).split("#")[0]) != 4 )
						{
							
							continue;
							
						}
						if(seataccess.get(i).split("#")[2].equals("0"))
						{
							tmp += 1;
						if (i%2 == 0) {
				%>
		   
				      <tr>
				      	 <td><%=seataccess.get(i).split("#")[0].substring(5).replaceAll("_" , "-") %></td>
				      	 
				         <% 
				         row ++;
				         }
				         String str = seataccess.get(i);
				         str = str.trim();
				         String[] list = str.split("#");
				         String bd = list[0];
				         int pe = Integer.valueOf(list[1]); 
				         %>
				         <td bgcolor="#5cb85c"><input type = "radio" name = "closeSeat" id = <%=seataccess.get(i) %> value = <%=seataccess.get(i) %>></td>
				         <%
				         if (i % 2 == 1) {
				         %>
				         </tr>
		      <%} } else if(seataccess.get(i).split("#")[2].equals("2"))
				{
					tmp += 1;
				if (i%2 == 0)	 {
		%>
 
		      <tr>
		      	 <td><%=seataccess.get(i).split("#")[0].substring(5).replaceAll("_" , "-") %></td>
		      	 
		         <% 
		         row ++;
		         }
		         String str = seataccess.get(i);
		         str = str.trim();
		         String[] list = str.split("#");
		         String bd = list[0];
		         int pe = Integer.valueOf(list[1]); 
		         %>
		          <td bgcolor="#ffff99">已过时</td>
		         <%
		         if (i % 2 == 1) {
		         %>
		         </tr>
    <%} }      else {
		    	  if (i%2 == 0)	 {
				%>
		   
				      <tr>
				      	 <td><%=seataccess.get(i).split("#")[0].substring(5).replaceAll("_" , "-") %></td>
				      	 
				         <% 
				         row ++;
				         }
				         String str = seataccess.get(i);
				         str = str.trim();
				         String[] list = str.split("#");
				         String bd = list[0];
				         int pe = Integer.valueOf(list[1]); 
				         %>
				         <td bgcolor="#ffff99">已关闭</td>
				         <%
				         if (i % 2 == 1) {
				         %>
				         </tr>
		      <%}
		      } }%>
		   </tbody>
		</table>
		
		<input type="submit" class="btn btn-success" value="关 闭" onclick="if(!confirm('确定关闭该时间段？'))return false;">
		<input type="reset" class="btn btn-success" value="重 置">
		</form>
	  </div>
	  
	  
    <div class="container">
    <form action="OpenGroupPeriodServlet" method="post" onSubmit="return login(this);">
    <h1>开启时间段</h1>

		<table class="table table-striped">
		   <thead>
		      <tr>
		      	 <th>选择</th>
		      	 <th >日期</th>
		      	 <td>时间段</td>
		      </tr>
		   </thead>
		   <tbody>
<%
	//ArrayList<String> seataccess = (ArrayList<String>)session.getAttribute("seataccess");
	int tmp1 = 0;
	if (seataccess != null && seataccess.size() > 0)
	{
		
	for (int i = 0 ; i < seataccess.size() ; i ++)
	{
		if(seataccess.get(i).split("#")[2].equals("3"))
		{
			tmp1 = tmp1 + 1;
%>
		      <tr>
		        <td><input type = "radio" name = "openSeat" id = <%=seataccess.get(i) %> value = <%=seataccess.get(i) %>></td>
		         <%
		         String str = seataccess.get(i);
		         str = str.trim();
		         String[] list = str.split("#");
		         String bd = list[0];
		         int pe = Integer.valueOf(list[1]);
		         %>
		         <td><%=bd.replaceAll("_" , "-") %></td>
		         <td><%=DateManager.getPeroid(pe) %></td>
		      </tr>
		      <%} } } }%>
		   </tbody>
		</table>
		
		<input type="submit" class="btn btn-success" value="开 启" onclick="if(!confirm('确定开启该时间段？'))return false;">
		<input type="reset" class="btn btn-success" value="重 置">
		</form>
	  </div>
	  <%} else { %>
	<h1 align="center">您没有权限查看此页面。</h1>
	  <%} %>
	 
	  
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