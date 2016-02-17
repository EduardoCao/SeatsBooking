package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.GroupSeatDao;
import util.Seats;

public class GroupSeatsServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1545183030858168779L;
	public void doPost(HttpServletRequest request , HttpServletResponse response)
	throws ServletException, IOException
	{
		String bookdate = request.getParameter("bookdate");
		GroupSeatDao groupSeatDao = new GroupSeatDao();
		
		Seats[] seats = new Seats[2];

		seats = groupSeatDao.getGroupSeats(bookdate);
		request.getSession().setAttribute("groupseats", seats);
		request.getSession().setAttribute("bookdate", bookdate);
		request.getRequestDispatcher("./groupbooking.jsp").forward(request, response);
	}

}
