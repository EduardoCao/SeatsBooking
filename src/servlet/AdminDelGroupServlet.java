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
			request.setAttribute("info",  "亲，别急，还没选择删除哪个座位呢~ Delete error.");
			request.getRequestDispatcher("message.jsp").forward(request, response);
		}
		else
		{
		int delete = Integer.parseInt(request.getParameter("deletegroup"));
		ArrayList<String> allGroupInfo = new ArrayList<String>();
	 	allGroupInfo = (ArrayList<String>) request.getSession().getAttribute("allGroupInfo");
	 	String args[] = allGroupInfo.get(delete).split("##");
	 	String flag = args[5].substring(5);
	 	String studentnum = args[3].substring(11);
	 	String bookdate = args[0].substring(9);
	 	String seat = args[2].substring(5);
	 	String period = args[1].substring(7);
	 	String reason = args[4].substring(7);
	 	GroupSeatDao groupseatDao = new GroupSeatDao();
	 	if (!flag.equals("1"))
	 	{
	 		request.setAttribute("info",  "亲，这个座位现在没人占用哦，不能删除~ Cannot delete this group seat!");
			request.getRequestDispatcher("message.jsp").forward(request, response);
	 	}
	 	else
	 	{
	 		int tag = groupseatDao.adminDelGroup(studentnum , bookdate , seat , period );
	 		if(tag == -4)
	 		{
	 			request.setAttribute("info",  "这个座位的主人已经不要这个座位了，不能删除~ This group seat have been deleted！");
				request.getRequestDispatcher("message.jsp").forward(request, response);
	 		}
	 		else if(tag == -2)
	 		{
	 			request.setAttribute("info",  "亲，这个座位目前没有删除成功~ This group cannot be deleted!");
	 			request.getRequestDispatcher("message.jsp").forward(request, response);
	 		}
	 		else if(tag == 0)
	 		{
	 			GroupSeatDao groupSeatDao = new GroupSeatDao();
	 			allGroupInfo = new ArrayList<String>();
	 			allGroupInfo = groupSeatDao.getAllGroupInfo();
	 			request.getSession().setAttribute("allGroupInfo", allGroupInfo);
	 			request.setAttribute("info",  "OK! This group deleted!");
	 			request.getRequestDispatcher("admingroupinfo.jsp").forward(request, response);
	 		}
	 	}
		}
	}

}
