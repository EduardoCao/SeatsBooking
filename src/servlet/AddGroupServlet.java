package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.GroupSeatDao;

public class AddGroupServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = -1018879423994078024L;
	public void doPost(HttpServletRequest request , HttpServletResponse response)
	throws ServletException, IOException
	{
		String bookuser = request.getParameter("bookuser");
		String add = request.getParameter("addGroup");
		String bookdate = (String) request.getSession().getAttribute("bookdate");
		if (bookuser == null || add == null || add.split("_").length != 2 || bookdate == null)
		{
			
			request.setAttribute("info", "亲，没有指定清楚为谁，添加哪个座位呢，请重新来过~ Add group seat by admin error, please try again...");
			request.getRequestDispatcher("message.jsp").forward(request, response);
		}
		else
		{
			String seat = add.split("_")[0];
			String period = add.split("_")[1];
			GroupSeatDao groupseatDao = new GroupSeatDao();
			int tag = groupseatDao.addGroup(bookuser, bookdate, seat, period) ;
			if(tag == -4)
	 		{
	 			request.setAttribute("info",  "亲，这个团体座位刚刚被占了哦~再试试别的座位吧！Sorry, the group seat haven been taken already! Please try other group seats!");
				request.getRequestDispatcher("message.jsp").forward(request, response);
	 		}
			else if(tag == -3)
	 		{
	 			request.setAttribute("info",  "该同学已经预订过这一时段的团体座位了，不能重复预订哦~ Sorry, this user has booked a group seat in the same period!");
				request.getRequestDispatcher("message.jsp").forward(request, response);
	 		}
	 		else if(tag == -2)
	 		{
	 			request.setAttribute("info",  "亲，这个团体座位没有成功预订上哦，请重试~ Sorry, the group seat haven't been added successfully!");
	 			request.getRequestDispatcher("message.jsp").forward(request, response);
	 		}
	 		else if(tag == 0)
	 		{
	 			//request.setAttribute("info",  "OK! This group seat is added!");
	 			//request.getRequestDispatcher("message.jsp").forward(request, response);
	 			GroupSeatDao groupSeatDao = new GroupSeatDao();
	 			ArrayList<String> allGroupInfo = new ArrayList<String>();
	 			allGroupInfo = groupSeatDao.getAllGroupInfo();
	 			request.getSession().setAttribute("allGroupInfo", allGroupInfo);
	 			request.getSession().removeAttribute("groupseats");
	 			request.getRequestDispatcher("./admingroupinfo.jsp").forward(request, response);
	 		}
		}
	}

}
