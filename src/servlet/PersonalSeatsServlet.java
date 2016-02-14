package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.SeatDao;
import dao.UserDao;
import util.Seats;
import util.User;

public class PersonalSeatsServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 3534512195725283467L;
	public void doPost(HttpServletRequest request , HttpServletResponse response)
			throws ServletException, IOException
			{
				String bookdate = request.getParameter("bookdate");

				
				SeatDao seatDao = new SeatDao();
				
				Seats[] seats = new Seats[10];

				seats = seatDao.getSeats(bookdate);
				request.getSession().setAttribute("seats", seats);
				request.getSession().setAttribute("bookdate", bookdate);
				
				UserDao userDao = new UserDao();
				ArrayList<User> showallusers = userDao.showAllUsers();
				request.getSession().setAttribute("showallusers", showallusers);
				request.getRequestDispatcher("./adminseat.jsp").forward(request, response);
			}
			

}
