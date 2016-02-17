package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.GroupSeatDao;
import dao.SeatDao;

public class OpenPeriodServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1610127488188425822L;
	public void doPost(HttpServletRequest request , HttpServletResponse response)
			throws ServletException, IOException
	{

		String close = request.getParameter("openSeat");
		if(close == null)
		{
			request.setAttribute("info",  "open period error!");
			request.getRequestDispatcher("message.jsp").forward(request, response);
		}
		else
		{
			
			String day = close.split("_")[0];
			String period = close.split("_")[1];
			String seatType = close.split("_")[2];
			
			if(day == null || period == null)
			{
				request.setAttribute("info",  "open period error!");
				request.getRequestDispatcher("message.jsp").forward(request, response);
			}
			else
			{
				SeatDao seatDao = new SeatDao();
				int tag = seatDao.closeSeat(day , period , seatType);
				GroupSeatDao groupseatDao = new GroupSeatDao();
				int tag2 = groupseatDao.closeSeat(day , period , seatType);
				if(tag == 0 && tag2 == 0)
				{
					request.setAttribute("info",  "OK! Open this period!");
					request.getRequestDispatcher("message.jsp").forward(request, response);
				}
				else if(tag == 2 && tag2 == 2)
				{
					request.setAttribute("info",  "Cannot open timeout period!");
					request.getRequestDispatcher("message.jsp").forward(request, response);
				}
				else
				{
					request.setAttribute("info",  "Cannot open this period!");
					request.getRequestDispatcher("message.jsp").forward(request, response);
				}
			}
		}
	}
}
