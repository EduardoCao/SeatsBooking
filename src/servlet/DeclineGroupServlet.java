package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.GroupSeatDao;

public class DeclineGroupServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 9104889341587837306L;
	public void doPost(HttpServletRequest request , HttpServletResponse response)
			throws ServletException, IOException
	{
		if(request.getParameter("declinegroup") == null)
		{
			request.setAttribute("info",  "decline group seat error");
			request.getRequestDispatcher("message.jsp").forward(request, response);
		}
		else
		{
		int declinegroup = Integer.parseInt(request.getParameter("declinegroup"));
		ArrayList<String> allGroupInfo = new ArrayList<String>();
	 	allGroupInfo = (ArrayList<String>) request.getSession().getAttribute("allGroupInfo");
	 	String args[] = allGroupInfo.get(declinegroup).split("##");
	 	String flag = args[0];
	 	String studentnum = args[1].substring(11);
	 	String bookdate = args[2].substring(9);
	 	String seat = args[3].substring(5);
	 	String period = args[4].substring(7);
	 	String reason = args[5].substring(7);
	 	GroupSeatDao groupseatDao = new GroupSeatDao();
	 	if (!flag.equals("0"))
	 	{
	 		request.setAttribute("info",  "Cannot decline this group seat!");
			request.getRequestDispatcher("message.jsp").forward(request, response);
	 	}
	 	else
	 	{
	 		int tag = groupseatDao.declineGroup(studentnum , bookdate , seat , period);
	 		if(tag == -4)
	 		{
	 			request.setAttribute("info",  "Cannot decline this group seat!");
				request.getRequestDispatcher("message.jsp").forward(request, response);
	 		}
	 		else if(tag == -2)
	 		{
	 			request.setAttribute("info",  "Cannot decline this group seat!");
	 			request.getRequestDispatcher("message.jsp").forward(request, response);
	 		}
	 		else if(tag == 0)
	 		{
//	 			request.setAttribute("info",  "OK! This group is declined!");
//	 			request.getRequestDispatcher("message.jsp").forward(request, response);
	 			GroupSeatDao groupSeatDao = new GroupSeatDao();
	 			allGroupInfo = new ArrayList<String>();
	 			allGroupInfo = groupSeatDao.getAllGroupInfo();
	 			request.getSession().setAttribute("allGroupInfo", allGroupInfo);
	 			request.getRequestDispatcher("./admingroupinfo.jsp").forward(request, response);
	 		}
	 		
	 	}
		}
	 	
	}



}
