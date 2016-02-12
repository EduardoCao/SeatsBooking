package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.SeatDao;
import dao.UserDao;
import util.User;

public class CloseUserServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 7054436619737202995L;
	public void doPost(HttpServletRequest request , HttpServletResponse response)
			throws ServletException, IOException
	{

		String close = request.getParameter("closeUser");
		if(close == null)
		{
			request.setAttribute("info",  "close user error!");
			request.getRequestDispatcher("message.jsp").forward(request, response);
		}
		else
		{
			int closenum = Integer.parseInt(close);
			ArrayList<User> showallusers = (ArrayList<User>) request.getSession().getAttribute("showallusers");
			String studentnum = showallusers.get(closenum).getStudentnum();
			int userType = showallusers.get(closenum).getUserType();
			if(studentnum == null)
			{
				request.setAttribute("info",  "close user error!");
				request.getRequestDispatcher("message.jsp").forward(request, response);
			}
			else
			{
				UserDao userDao = new UserDao();
				if(userDao.closeUser(studentnum , userType))
				{
					showallusers = userDao.showAllUsers();
					HashMap<String , String> closetime = new HashMap<String , String>();
					closetime = userDao.closeUserTime();
					request.getSession().setAttribute("closetime", closetime);
					request.getSession().setAttribute("showallusers", showallusers);
					request.getRequestDispatcher("admindealuser.jsp").forward(request, response);
				}
				else
				{
					request.setAttribute("info",  "Cannot close this user!");
					request.getRequestDispatcher("message.jsp").forward(request, response);
				}
				
			}
		}
	}

}
