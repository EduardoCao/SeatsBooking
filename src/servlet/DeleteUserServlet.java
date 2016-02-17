package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDao;
import util.User;

public class DeleteUserServlet extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = -6160587371647520846L;

	public void doPost(HttpServletRequest request , HttpServletResponse response)
	throws ServletException, IOException
	{
		String delete = request.getParameter("delete");
		if(delete == null)
		{
			request.setAttribute("info",  "Delete user error!");
			request.getRequestDispatcher("message.jsp").forward(request, response);
		}
		else
		{
			int deletenum = Integer.parseInt(delete);
			ArrayList<User> delusers = (ArrayList<User>) request.getSession().getAttribute("showallusers");
			User deluser = delusers.get(deletenum);
			String studentnum = deluser.getStudentnum();
			
			if(studentnum == null)
			{
				request.setAttribute("info",  "Delete user error!");
				request.getRequestDispatcher("message.jsp").forward(request, response);
			}
			else
			{
				UserDao userDao = new UserDao();
				if(userDao.deleteUser(studentnum))
				{
					request.setAttribute("info",  "OK! Delete the user: " + studentnum + " !");
					request.getRequestDispatcher("message.jsp").forward(request, response);
				}
				else
				{
					request.setAttribute("info",  "Cannot delete this user!");
					request.getRequestDispatcher("message.jsp").forward(request, response);
				}
				
			}
		}
	}
}
