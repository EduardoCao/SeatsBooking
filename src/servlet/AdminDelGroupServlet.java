package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.GroupSeatDao;

public class AdminDelGroupServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3487215285644488840L;
	
	public void doPost(HttpServletRequest request , HttpServletResponse response)
			throws ServletException, IOException
	{
		if(request.getParameter("deletegroup") == null)
		{
			request.setAttribute("info",  "delete error");
			request.getRequestDispatcher("message.jsp").forward(request, response);
		}
		else
		{
		int delete = Integer.parseInt(request.getParameter("deletegroup"));
		ArrayList<String> allGroupInfo = new ArrayList<String>();
	 	allGroupInfo = (ArrayList<String>) request.getSession().getAttribute("allGroupInfo");
	 	String args[] = allGroupInfo.get(delete).split("##");
	 	String flag = args[0];
	 	String studentnum = args[1].substring(11);
	 	String bookdate = args[2].substring(9);
	 	String seat = args[3].substring(5);
	 	String period = args[4].substring(7);
	 	String reason = args[5].substring(7);
	 	GroupSeatDao groupseatDao = new GroupSeatDao();
	 	if (!flag.equals("1"))
	 	{
	 		request.setAttribute("info",  "Cannot delete this group seat!");
			request.getRequestDispatcher("message.jsp").forward(request, response);
	 	}
	 	else
	 	{
	 		int tag = groupseatDao.adminDelGroup(studentnum , bookdate , seat , period );
	 		if(tag == -4)
	 		{
	 			request.setAttribute("info",  "This group seat have been deleted！");
				request.getRequestDispatcher("message.jsp").forward(request, response);
	 		}
	 		else if(tag == -2)
	 		{
	 			request.setAttribute("info",  "This group cannot be deleted!");
	 			request.getRequestDispatcher("message.jsp").forward(request, response);
	 		}
	 		else if(tag == 0)
	 		{
	 			request.setAttribute("info",  "OK! This group deleted!");
	 			request.getRequestDispatcher("message.jsp").forward(request, response);
	 		}
	 	}
		}
	}

}
