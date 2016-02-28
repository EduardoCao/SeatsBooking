<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="UTF-8"
    import="util.User"%>
<%@ page import="java.util.ArrayList" %>
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

    <title>团体座位管理-教室预定系统</title>

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

<div class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button class="navbar-toggle collapsed" type="button" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand hidden-sm" href="./index.jsp">教室预订系统</a>
        </div>
        <div class="navbar-collapse collapse" role="navigation">
          <ul class="nav navbar-nav">
          	<li><a href="./student_message.jsp">学生界面</a></li>
            <li><a href="./seatsbooking.jsp">个人座位预定</a></li>
            <li><a href="./groupbooking.jsp">集体座位预定</a></li>
            <li><a href="./InfoServlet">查看个人座位预定</a></li>
            <li class="active"><a href="./GroupInfoServlet">查看集体座位预定</a></li>
            <li><a href="changepw.jsp">修改密码</a></li>
          </ul>
          <ul class="nav navbar-nav navbar-right hidden-sm">
          <li>
          <a>
          	<%if (user != null) { %>
			  <%="当前用户：" + user.getStudentnum()%>
              <%} else { %>
              <%="尚未登录" %>
              <%} %>
          </a>
          </li>
          </ul>
        </div>
      </div>
    </div>

    <br><br><br>
    <!-- Main jumbotron for a primary marketing message or call to action -->

    <div class="container">
    <form action="DeleteGroupServlet" method="post" onSubmit="return login(this);">
    <h1>已预约</h1>

		<table class="table table-striped">
		   <thead>
		      <tr>
		      <th>选择</th>
		  	  <th>日期</th>
		  	  <th>座位号</th>
		  	  <th>时间段</th>
		  	  <th>申请理由</th>
		      </tr>
		   </thead>
		   <tbody>
<%
	ArrayList<String> onesGroupInfo = (ArrayList<String>)session.getAttribute("onesGroupInfo");
	if (onesGroupInfo != null && onesGroupInfo.size() > 0)
	{
	for (int i = 0 ; i < onesGroupInfo.size() ; i ++)
	{
		String flag = onesGroupInfo.get(i).split("##")[0];
		if (flag.equals("1"))
		{
%>
			
				<tr>
				<td><input type = "radio" name = "deletegroup" id = <%=i %> value = <%=i %>></td>
	    		<%
	    		String str = onesGroupInfo.get(i);
	    		String[] list = str.split("##");
	    		int bookd = Integer.valueOf(list[1].substring(list[1].length()-1, list[1].length()));
	    		String seats = list[2].substring(5, list[2].length());
	    		int per = Integer.valueOf(list[3].substring(7, 8));
	    		String reason = list[4].substring(7, list[4].length());
	    		%>
	    		<td><%=DateManager.getFormatDate(bookd) %></td>
	    		<td><%=seats %></td>
	    		<td><%=DateManager.getPeroid(per) %>
	    		<td><%=reason %></td>
	    	</tr>
			
			
			<%
			}
		}
	}
	%>
		   </tbody>
		</table>
		
	  </div>
	  
    <div class="container">
    <h1>待审批</h1>

		<table class="table table-striped">
		   <thead>
		      <tr>
		      <th>选择</th>
		  	  <th>日期</th>
		  	  <th>座位号</th>
		  	  <th>时间段</th>
		  	  <th>申请理由</th>
		      </tr>
		   </thead>
		   <tbody>
<%
	//ArrayList<String> onesGroupInfo = (ArrayList<String>)session.getAttribute("onesGroupInfo");
	if (onesGroupInfo != null && onesGroupInfo.size() > 0)
	{
	for (int i = 0 ; i < onesGroupInfo.size() ; i ++)
	{
		String flag = onesGroupInfo.get(i).split("##")[0];
		if (flag.equals("0"))
		{
%>
			
				<tr>
				<td><input type = "radio" name = "deletegroup" id = <%=i %> value = <%=i %>></td>
	    		<%
	    		String str = onesGroupInfo.get(i);
	    		String[] list = str.split("##");
	    		int bookd = Integer.valueOf(list[1].substring(list[1].length()-1, list[1].length()));
	    		String seats = list[2].substring(5, list[2].length());
	    		int per = Integer.valueOf(list[3].substring(7, 8));
	    		String reason = list[4].substring(7, list[4].length());
	    		%>
	    		<td><%=DateManager.getFormatDate(bookd) %></td>
	    		<td><%=seats %></td>
	    		<td><%=DateManager.getPeroid(per) %>
	    		<td><%=reason %></td>
	    	</tr>
			
			
			<%}}} %>
		   </tbody>
		</table>
		
	  </div>
	  
    <div class="container">
    <h1>被拒绝</h1>

		<table class="table table-striped">
		   <thead>
		      <tr>
		  	  <th>日期</th>
		  	  <th>座位号</th>
		  	  <th>时间段</th>
		  	  <th>申请理由</th>
		      </tr>
		   </thead>
		   <tbody>
<%
	//ArrayList<String> onesGroupInfo = (ArrayList<String>)session.getAttribute("onesGroupInfo");
	if (onesGroupInfo != null && onesGroupInfo.size() > 0)
	{
	for (int i = 0 ; i < onesGroupInfo.size() ; i ++)
	{
		String flag = onesGroupInfo.get(i).split("##")[0];
		if (flag.equals("-1"))
		{
%>
			
				<tr>
	    		<%
	    		String str = onesGroupInfo.get(i);
	    		String[] list = str.split("##");
	    		int bookd = Integer.valueOf(list[1].substring(list[1].length()-1, list[1].length()));
	    		String seats = list[2].substring(5, list[2].length());
	    		int per = Integer.valueOf(list[3].substring(7, 8));
	    		String reason = list[4].substring(7, list[4].length());
	    		%>
	    		<td><%=DateManager.getFormatDate(bookd) %></td>
	    		<td><%=seats %></td>
	    		<td><%=DateManager.getPeroid(per) %>
	    		<td><%=reason %></td>
	    	</tr>
			
			
			<%}}} %>
		   </tbody>
		</table>
		
		<input type="submit" class="btn btn-success" value="删 除" onclick="if(!confirm('确定删除？'))return false;">
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
