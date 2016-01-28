package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.SeatDao;
import util.User;


public class BookServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 12L;

	public void doPost(HttpServletRequest request , HttpServletResponse response)
			throws ServletException, IOException
			{
				HttpSession session = request.getSession();
				String bookdate = request.getParameter("bookdate");
				String bookseat = request.getParameter("seat");
				User user = (User)session.getAttribute("user");
				String owner = user.getStudentnum();
				System.out.println(owner + " " + bookdate + " "  + bookseat);
				
				if (owner == null)
				{
					String info = "Please login first!";
					request.setAttribute("info", info);
					request.getRequestDispatcher("./message.jsp").forward(request, response);
				}
				if (bookseat == null || bookdate == null)
				{
					String info = "Please try to book the seat again!";
					request.setAttribute("info", info);
					request.getRequestDispatcher("./message.jsp").forward(request, response);
				}
				
				SeatDao seatDao = new SeatDao();
				
				String bookeduser = seatDao.bookSeat(owner , bookdate , bookseat);
				//System.out.println(bookeduser);
				if (bookeduser == null)
				{
					request.setAttribute("info", "The seat has been taken. Please book again!");
					request.getRequestDispatcher("./message.jsp").forward(request, response);
				}
				else
				{
					ArrayList<String> onesSeat = seatDao.getOnesSeats(bookeduser);
					request.getSession().setAttribute("onesSeats", onesSeat);
					request.getRequestDispatcher("./seatsinfo.jsp").forward(request, response);
				}
			}
}
