package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDao;
import util.User;

public class ChangeNameServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 7784115306750313112L;

	
	public void doPost(HttpServletRequest request , HttpServletResponse response)
	throws ServletException, IOException
	{
		request.setCharacterEncoding("UTF-8");
		String name = request.getParameter("name");
		User user = (User)request.getSession().getAttribute("user");
		String studentnum = user.getStudentnum();
		UserDao userDao = new UserDao();
		if (studentnum != null && !studentnum.isEmpty())
		{
			if(!userDao.userIsExist(studentnum))
			{
				user.setName(name);
				userDao.changeName(user , name);
				request.setAttribute("info", "恭喜修改密码成功！记住你的密码哦~不过忘了也可以咨询管理员哦~ Congratulation! Password changed succeed!");
				
			}else
			{
				request.setAttribute("info", "请先登录！Sorry, please login first!" );
			}
		}
		request.getRequestDispatcher("checkprofile.jsp").forward(request, response);
	}

}
