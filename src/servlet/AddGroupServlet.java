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
			
			request.setAttribute("info", "Add group seat by admin error, please try again...");
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
	 			request.setAttribute("info",  "Sorry, the group seat haven been taken already! Please try other group seats!");
				request.getRequestDispatcher("message.jsp").forward(request, response);
	 		}
	 		else if(tag == -2)
	 		{
	 			request.setAttribute("info",  "Sorry, the group seat haven't been added successfully!");
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
	 			request.getRequestDispatcher("./admingroupinfo.jsp").forward(request, response);
	 		}
		}
	}

}
