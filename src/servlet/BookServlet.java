package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.SeatDao;


public class BookServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 12L;

	public void doPost(HttpServletRequest request , HttpServletResponse response)
			throws ServletException, IOException
			{
				String bookdate = request.getParameter("bookdate");
				String bookseat = request.getParameter("seat");
				String owner = request.getParameter("owner");
				System.out.println(owner + " " + bookdate + " "  + bookseat);
				
				if (owner == null)
				{
					String info = "Please login first!";
					request.getSession().setAttribute("info", info);
					request.getRequestDispatcher("./message.jsp").forward(request, response);
				}
				if (bookseat == null || bookdate == null)
				{
					String info = "Please try to book the seat again!";
					request.getSession().setAttribute("info", info);
					request.getRequestDispatcher("./message.jsp").forward(request, response);
				}
				
				SeatDao seatDao = new SeatDao();
				
				String user = seatDao.bookSeat(owner , bookdate , bookseat);
				System.out.println(user);
				if (user == null)
				{
					request.getSession().setAttribute("info", "Please book again!");
					request.getRequestDispatcher("./message.jsp").forward(request, response);
				}
				else
				{
					ArrayList<String> onesSeat = seatDao.getOnesSeats(user);
					request.getSession().setAttribute("owner", user);
					request.getSession().setAttribute("onesSeats", onesSeat);
					request.getRequestDispatcher("./seatsinfo.jsp").forward(request, response);
				}
			}
}
