package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDao;
import util.User;

public class ChangepwServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 747236733059071724L;
	public void doPost(HttpServletRequest request , HttpServletResponse response)
	throws ServletException, IOException
	{

		String password = request.getParameter("password");

		User user = (User)request.getSession().getAttribute("user");
		String studentnum = user.getStudentnum();
		System.out.println(studentnum);
		UserDao userDao = new UserDao();
		if (studentnum != null && !studentnum.isEmpty())
		{
			if(!userDao.userIsExist(studentnum))
			{
				user.setPassword(password);
				userDao.changePw(user , password);
				request.setAttribute("info", "Congratulation! Password changed succeed!");
				
			}else
			{
				request.setAttribute("info", "Sorry, please login first!" );
			}
		}
		request.getRequestDispatcher("message.jsp").forward(request, response);
	}

}
