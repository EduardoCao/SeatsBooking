package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDao;
import util.User;
public class AdminUserServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = -803345674849947893L;
	public void doGet(HttpServletRequest request , HttpServletResponse response)
			throws ServletException, IOException
	{
		UserDao userDao = new UserDao();
		ArrayList<User> showallusers = userDao.showAllUsers();
		request.getSession().setAttribute("showallusers" , showallusers);
		HashMap<String , String> closetime = userDao.closeUserTime();
		request.getSession().setAttribute("closetime", closetime);
		request.getRequestDispatcher("./admindealuser.jsp").forward(request, response);
	}
}
