package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.UserDao;
import util.User;
public class LoginServlet extends HttpServlet{
	private static final long serialVersionUID = -3009431503363456775L;
	public void doPost(HttpServletRequest request , HttpServletResponse response)
	throws ServletException , IOException
	{
		String studentnum = request.getParameter("studentnum");
		String password = request.getParameter("password");
		UserDao userDao = new UserDao();
		User user = userDao.login(studentnum, password);
		
		if (user != null)
		{
			int userType = userDao.checkUserType(studentnum, password);
			request.getSession().setAttribute("user", user);
			if (userType == 2)
			{		
				request.getRequestDispatcher("admin_message.jsp").forward(request, response);
			}
			if (userType == 1)
			{
				request.getRequestDispatcher("teacher_message.jsp").forward(request, response);
			}
			if (userType == 0)
			{
				request.getRequestDispatcher("student_message.jsp").forward(request, response);
			}
		}
		else
		{
			request.getSession().setAttribute("user", user);
			request.setAttribute("info", "The student number or the password is wrong!");
			request.getRequestDispatcher("message.jsp").forward(request, response);
			
		}
		
	}
}