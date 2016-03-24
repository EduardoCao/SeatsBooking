package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.GroupSeatDao;
import dao.SeatDao;


public class CloseGroupPeriodServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = -7859309146345808848L;
	public void doPost(HttpServletRequest request , HttpServletResponse response)
			throws ServletException, IOException
	{

		String close = request.getParameter("closeSeat");
		if(close == null)
		{
			request.setAttribute("info",  "亲，别急，还没选择好关哪一段时间段呢~ Close period error!");
			request.getRequestDispatcher("message.jsp").forward(request, response);
		}
		else
		{
			
			String bookdate = close.split("#")[0];
			String period = close.split("#")[1];
			String seatType = close.split("#")[2];
			
			if(bookdate == null || period == null)
			{
				request.setAttribute("info",  "亲，好像出了点问题，请重新来过试一试~ Close period error!");
				request.getRequestDispatcher("message.jsp").forward(request, response);
			}
			else
			{
				GroupSeatDao groupSeatDao = new GroupSeatDao();
				int tag = groupSeatDao.closeSeat(bookdate , period , seatType);
				
				if(tag == 0)
				{

					ArrayList<String> seatAccess = groupSeatDao.getGroupSeatAccess();
					request.getSession().setAttribute("groupseataccess" , seatAccess);
					request.getSession().removeAttribute("seats");
					request.getSession().removeAttribute("allGroupInfo");
					request.getSession().removeAttribute("groupseats");
					request.getRequestDispatcher("./adminsetgroupaccess.jsp").forward(request, response);
				}
				else if(tag == 2)
				{
					request.setAttribute("info",  "这个时间段已经过去了呢，放过它吧~ Cannot close timeout period!");
					request.getRequestDispatcher("message.jsp").forward(request, response);
				}
				else
				{
					request.setAttribute("info",  "关闭时间段错了哦，请重试~ Close this period error! Please check!");
					request.getRequestDispatcher("message.jsp").forward(request, response);
				}
				
			}
		}
	}

}
