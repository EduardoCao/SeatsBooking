<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="util.User" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>change your password</title>
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
	    // 判断用户是否登录
		if(user == null){
			user = new User();
			user.setStudentnum(null);
			//session.invalidate(); 
	%>
		<a href="login.jsp">请登录！</a>
		<div id="div" style="display: none" >
	<%
		}
		else if (user.getUserType() == 0)
		{
	%>
		当前用户：<%=user.getStudentnum() %>
		<li><a href="student_message.jsp">学生界面</a></li>
		
	<% 
		}
		else if (user.getUserType() == 1)
		{
	%>
		当前用户：<%=user.getStudentnum() %>
		<li><a href="teacher_message.jsp">教师界面</a></li>
	<% 
		}
		else if (user.getUserType() == 2)
		{
	%>
		当前用户：<%=user.getStudentnum() %>
		<li><a href="teacher_message.jsp">管理员界面</a></li>
	<% 
		}
	%>
<div align="center">
  <div class="top">修改密码</div>
	  <div align="left">
		  	<div class="div1">
		  		
		  		<div class="bottom">
					<div class="div2">
				  		<ul>
				  			<li><a href="login.jsp">用户登录</a></li>
				  			<li><a href="message.jsp">当前用户</a></li>
				  			<li><a href="ExitServlet">用户退出</a></li>
				  		</ul>
				  	</div>
				  	 <div class="div3"> 
					    <form action="ChangepwServlet" method="post" onsubmit="return changepw(this);">
						    <table align="center" width="450" border="0">
						    	<tr>
						    		<td align="right">密 码：</td>
						    		<td>
						    			<input type="password" name="password">
						    		</td>
						    	</tr>
						    	<tr>
						    		<td align="right">确认密码：</td>
						    		<td>
						    			<input type="password" name="repassword">
						    		</td>
						    	</tr>						    	
						    	<tr>
						    		<td colspan="2" align="center">
						    			<input type="submit" value="提 交">
						    			<input type="reset" value="重 置">
						    		</td>
						    	</tr>
						    </table>
					    </form>
				  	 </div>
				</div>
		  	</div>
	  </div>
  </body>
</html>
