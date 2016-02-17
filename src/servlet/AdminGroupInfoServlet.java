package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.GroupSeatDao;
import dao.UserDao;
import util.Seats;
import util.User;

public class AdminGroupInfoServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = -2609239253641648325L;
	public void doPost(HttpServletRequest request , HttpServletResponse response)
			throws ServletException, IOException
	{
		GroupSeatDao groupSeatDao = new GroupSeatDao();
		String bookdate = request.getParameter("bookdate");
		if(bookdate == null)
		{
			request.setAttribute("info",  "Error, please try again later!");
			request.getRequestDispatcher("message.jsp").forward(request, response);
		}
		else
		{
			Seats[] seats = new Seats[2];
			seats = groupSeatDao.getGroupSeats(bookdate);
			if(seats == null)
			{
				request.setAttribute("info",  "Error, please try again later!");
				request.getRequestDispatcher("message.jsp").forward(request, response);
			}
			else
			{
				UserDao userDao = new UserDao();
				ArrayList<User> showallusers = userDao.showAllUsers();
				request.getSession().setAttribute("showallusers", showallusers);
				request.getSession().setAttribute("groupseats", seats);
				request.getSession().setAttribute("bookdate", bookdate);
				request.getRequestDispatcher("./adminaddgroup.jsp").forward(request, response);
			}
		}
	}
	

}
