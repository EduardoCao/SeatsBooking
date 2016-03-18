package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.GroupSeatDao;

public class ProveGroupServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 4469193644921876074L;
	public void doPost(HttpServletRequest request , HttpServletResponse response)
			throws ServletException, IOException
	{
		if(request.getParameter("provegroup") == null)
		{
			request.setAttribute("info",  "亲，还没指定好批准哪一个申请呢~ Prove group seat error");
			request.getRequestDispatcher("message.jsp").forward(request, response);
		}
		else
		{
		int provegroup = Integer.parseInt(request.getParameter("provegroup"));
		ArrayList<String> allGroupInfo = new ArrayList<String>();
	 	allGroupInfo = (ArrayList<String>) request.getSession().getAttribute("allGroupInfo");
//	 	System.out.println(allGroupInfo.get(provegroup));
	 	String args[] = allGroupInfo.get(provegroup).split("##");
	 	String flag = args[5].substring(5);
	 	String studentnum = args[2].substring(11);
	 	String bookdate = args[0].substring(9);
	 	String seat = args[3].substring(5);
	 	String period = args[1].substring(7);
	 	String reason = args[4].substring(7);
	 	GroupSeatDao groupseatDao = new GroupSeatDao();
	 	if (!flag.equals("0"))
	 	{
	 		request.setAttribute("info",  "亲，这个申请已经不需要审批了呢~ Cannot prove this group seat");
			request.getRequestDispatcher("message.jsp").forward(request, response);
	 	}
	 	else
	 	{
	 		int tag = groupseatDao.proveGroup(studentnum , bookdate , seat , period);
	 		if(tag == -4)
	 		{
	 			request.setAttribute("info",  "亲，这个座位好像被别人抢了，或者因为时间段已经超时了~ Cannot prove this group seat for this group seat have been taken or the time period is passed!");
				request.getRequestDispatcher("message.jsp").forward(request, response);
	 		}
	 		else if(tag == -2)
	 		{
	 			request.setAttribute("info",  "亲，这个座位并没有被成功批准~请重试~ Cannot prove this group seat!");
	 			request.getRequestDispatcher("message.jsp").forward(request, response);
	 		}
	 		else if(tag == 0)
	 		{
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
