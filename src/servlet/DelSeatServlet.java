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

public class DelSeatServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 853436901939197965L;
	public void doPost(HttpServletRequest request , HttpServletResponse response)
	throws ServletException, IOException
	{
		String bookdate = request.getParameter("bookdate");
		String delete = request.getParameter("delSeat");
		if(delete == null)
		{
			request.setAttribute("info",  "delete seat error!");
			request.getRequestDispatcher("message.jsp").forward(request, response);
		}
		else
		{
			
			
			if(delete.split("_").length != 3 || delete.split("_")[0] == null || delete.split("_")[1] == null || delete.split("_")[2] == null )
			{
				request.setAttribute("info",  "delete seat error!");
				request.getRequestDispatcher("message.jsp").forward(request, response);
			}
			else
			{
				int seatnum = Integer.parseInt(delete.split("_")[0]);
				int periodnum = Integer.parseInt(delete.split("_")[1]);
				int periodori = Integer.parseInt(delete.split("_")[2]);
				SeatDao seatDao = new SeatDao();
				if(seatDao.deleteSeat(bookdate , seatnum , periodnum , periodori))
				{
					
					Seats[] seats = new Seats[10];
					seats = seatDao.getSeats(bookdate);
					request.getSession().setAttribute("seats", seats);
					request.getRequestDispatcher("adminseat.jsp").forward(request, response);
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
