<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="util.User" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>用户注册</title>
<!--     	<link rel="stylesheet" type="text/css" href="images/styles.css"> -->
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
		else if (  user.getUserType() != 2) 
		{
	%>
		您无权查看该页面，仅可由管理员注册用户。
		<a href="message.jsp"> back</a>
		<div id="div" style="display: none" >
	<% 
		}	
		else 
		{
	%>
		当前用户：<%=user.getStudentnum() %>
	<% 
		}
	%>
  
<div align="center">
  <div class="top">用户注册</div>
	  <div align="left">
		  	<div class="div1">
		  		
		  		<div class="bottom">
					<div class="div2">
				  		<ul>
<!-- 				  			<li><a href="reg.jsp">用户注册</a></li> -->
				  			<li><a href="login.jsp">用户登录</a></li>
				  			<li><a href="message.jsp">当前用户</a></li>
				  			<li><a href="ExitServlet">用户退出</a></li>
				  		</ul>
				  	</div>
				  	 <div class="div3"> 
					    <form action="RegServlet" method="post" onsubmit="return reg(this);">
						    <table align="center" width="450" border="0">
						    	<tr>
						    		<td align="right">学生证号：</td>
						    		<td>
						    			<input type="text" name="studentnum">
						    		</td>
						    	</tr>
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
						    		<td align="right">电子邮箱：</td>
						    		<td>
						    			<input type="text" name="email">
						    		</td>
						    	</tr>
						    	<tr>
						    		<td align="right">用户类别：</td>
						    		<td>
						    			<select name="userType">
						    				<option selected value = "1"> 教师 </option>
						    				<option selected value = "0"> 学生 </option>
						    			</select>
						    		</td>
						    	</tr>
						    	<tr>
						    		<td colspan="2" align="center">
						    			<input type="submit" value="注 册">
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
