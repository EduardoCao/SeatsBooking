package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDao;
import util.User;

public class ChangeEmailServlet extends HttpServlet{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -1326414780645766923L;

	public void doPost(HttpServletRequest request , HttpServletResponse response)
	throws ServletException, IOException
	{
		request.setCharacterEncoding("UTF-8");
		String email = request.getParameter("email");
		User user = (User)request.getSession().getAttribute("user");
		String studentnum = user.getStudentnum();
		UserDao userDao = new UserDao();
		if (studentnum != null && !studentnum.isEmpty())
		{
			if(!userDao.userIsExist(studentnum))
			{
				user.setEmail(email);
				userDao.changeName(user , email);
				
				
			}else
			{
				request.setAttribute("info", "请先登录！Sorry, please login first!" );
			}
		}
		request.getRequestDispatcher("checkprofile.jsp").forward(request, response);
	}

}
