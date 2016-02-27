<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="UTF-8"
    import="util.User"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="util.Seats" %>
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
    <link rel="icon" href="../../favicon.ico">

    <title>显示用户-教室预定系统</title>

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
            <li><a href="./seatsbooking.jsp">个人座位预定</a></li>
            <li><a href="./groupbooking.jsp">集体座位预定</a></li>
            <li class="active"><a href="./InfoServlet">查看个人座位预定</a></li>
            <li><a href="./GroupInfoServlet">查看集体座位预定</a></li>
            <li><a href="changepw.jsp">修改密码</a></li>
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
        <br><br><br>


    <!-- Main jumbotron for a primary marketing message or call to action -->

    <div class="container">
    <form action="DeleteServlet" method="post" onSubmit="return login(this);">

    <h1>个人座位预订</h1>

		<table class="table table-striped">
		   <thead>
		      <tr>
		      	 <th align="right">选择</th>
		      	 <th >预订日期</th>
		      	 <th>座位号</th>
		      	 <th>时间段</th>
		      </tr>
		   </thead>
		   <tbody>
		   
<%
	ArrayList<String> onesseats = (ArrayList<String>)session.getAttribute("onesSeats");
	if (onesseats != null && onesseats.size() > 0)
	{
	for (int i = 0 ; i < onesseats.size() ; i ++)
	{
%>
			<tr>
	    		<td><input type = "radio" name = "delete" id = <%=i %> value = <%=i %>></td>
	    		<%
	    		String s = onesseats.get(i);
	    		String[] slist = s.split(" ");
	    		String days = slist[0].substring(3, 4);
	    		int day = Integer.valueOf(days);
	    		String seats = slist[1].substring(7, 8);
	    		int seat = Integer.valueOf(seats);
	    		String times = slist[2].substring(6, 7);
	    		int time = Integer.valueOf(times);
	    		%>
	    		<td><%=DateManager.getFormatDate(day) %></td>
	    		<td><%=seat %></td>
	    		<td><%=DateManager.getPeroid(time) %></td>
	    	</tr>
	    <%}}%>
		</table>
		</table>
		
		<input type="submit" class="btn btn-success" value="删 除">
		<input type="reset" class="btn btn-success" value="重 置">
		</form>
	  </div>

    <div class="container">
      <!-- Example row of columns -->
      <div class="row">
        <div class="col-md-4">
        </div>
      </div>

      <hr>

      <footer>
        <p>&copy; 版权所有 教研院</p>
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
