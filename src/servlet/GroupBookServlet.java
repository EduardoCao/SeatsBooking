package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.GroupSeatDao;
import util.Seats;
import util.User;

public class GroupBookServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 8628865150922607909L;
	public void doPost(HttpServletRequest request , HttpServletResponse response)
	throws ServletException, IOException
	{
		request.setCharacterEncoding("UTF-8");
		String bookdate = request.getParameter("bookdate");
		String groupSeat = request.getParameter("groupSeat");
		String reason = request.getParameter("reason");
		System.out.println("reason: " + reason + "; bookdate: " + bookdate);
		User user = (User) request.getSession().getAttribute("user");
		
		if(bookdate == null) 
		{
			request.setAttribute("info",  "bookdate error!");
			request.getRequestDispatcher("message.jsp").forward(request, response);
		}
		else if(user.getUserType() < 0)
		{
			request.setAttribute("info",  "You cannot book for you have been banned for 2 weeks!");
			request.getRequestDispatcher("message.jsp").forward(request, response);
		}
		else if(groupSeat == null)
		{
			request.setAttribute("info",  "groupSeat error!");
			request.getRequestDispatcher("message.jsp").forward(request, response);
		}
		else if(reason == null)
		{
			request.setAttribute("info",  "reason error!");
			request.getRequestDispatcher("message.jsp").forward(request, response);
		}
		else
		{
			GroupSeatDao groupSeatDao = new GroupSeatDao();
			reason = reason.replaceAll("##", "_");
			int tag = groupSeatDao.reserveGroupSeat(groupSeat, user.getStudentnum(), Integer.parseInt(bookdate) , reason, 0);
			if(tag == 1)
			{
				request.setAttribute("info",  "You have been booking the same seat already. Please wait...");
				request.getRequestDispatcher("message.jsp").forward(request, response);
			}
			else if(tag == 2)
			{
				request.setAttribute("info",  "You have got this seat already.");
				request.getRequestDispatcher("message.jsp").forward(request, response);
			}
			else if(tag == -1)
			{
				request.setAttribute("info",  "Book error!");
				request.getRequestDispatcher("message.jsp").forward(request, response);
			}
			else if(tag == 0)
			{
//				request.setAttribute("info",  "OK! Book the seat!");
//				request.getRequestDispatcher("message.jsp").forward(request, response);
				ArrayList<String> onesGroupInfo = new ArrayList<String>();
				onesGroupInfo = groupSeatDao.getOnesGroupInfo(user.getStudentnum());
				request.getSession().setAttribute("onesGroupInfo", onesGroupInfo);
				request.getRequestDispatcher("./groupseatsinfo.jsp").forward(request, response);
			}
		}
	}

}
