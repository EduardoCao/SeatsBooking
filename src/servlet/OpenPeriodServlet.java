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
			request.setAttribute("info",  "亲，还没说好打开哪一个时间段呢~ Open period error!");
			request.getRequestDispatcher("message.jsp").forward(request, response);
		}
		else
		{
			
			String day = close.split("_")[0];
			String period = close.split("_")[1];
			String seatType = close.split("_")[2];
			
			if(day == null || period == null)
			{
				request.setAttribute("info",  "亲，出了点错:( 请重试一下~ open period error!");
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
//					request.setAttribute("info",  "OK! Open this period!");
//					request.getRequestDispatcher("message.jsp").forward(request, response);
					ArrayList<String> seatAccess = seatDao.getSeatAccess();
					request.getSession().setAttribute("seataccess" , seatAccess);
					request.getSession().removeAttribute("seats");
					request.getSession().removeAttribute("allGroupInfo");
					request.getSession().removeAttribute("groupseats");
					request.getRequestDispatcher("./adminsetaccess.jsp").forward(request, response);
				}
				else if(tag == 2 && tag2 == 2)
				{
					request.setAttribute("info",  "这个时间段已经超时~ Cannot open timeout period!");
					request.getRequestDispatcher("message.jsp").forward(request, response);
				}
				else
				{
					request.setAttribute("info",  "这个时间段并不能被打开，请重试~ Cannot open this period!");
					request.getRequestDispatcher("message.jsp").forward(request, response);
				}
			}
		}
	}
}
