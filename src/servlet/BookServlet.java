package servlet;

import java.io.IOException;

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
				SeatDao seatDao = new SeatDao();
//				
//				Seats[] seats = new Seats[10];
//				
//				seats = seatDao.getSeats(bookdate);
//						
//				request.getSession().setAttribute("seats", seats);
//				request.getSession().setAttribute("bookdate", bookdate);		
				request.getRequestDispatcher("./message.jsp").forward(request, response);
			}
}
