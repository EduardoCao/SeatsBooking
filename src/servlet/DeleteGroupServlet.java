package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.GroupSeatDao;
import util.User;

public class DeleteGroupServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = -7486710411382109020L;
	public void doPost(HttpServletRequest request , HttpServletResponse response)
	throws ServletException, IOException
	{
		String delete = request.getParameter("deletegroup");
		if(delete == null)
		{
			request.setAttribute("info",  "亲，别急，还没指定删除哪个座位呢~ Delete seats error!");
			request.getRequestDispatcher("message.jsp").forward(request, response);
		}
		else
		{
			int deletenum = Integer.parseInt(delete);
			
			ArrayList<String> onesGroupInfo = (ArrayList<String>) request.getSession().getAttribute("onesGroupInfo");
			User user = (User) request.getSession().getAttribute("user");


			
			String args[] = onesGroupInfo.get(deletenum).split("##");
		 	String flag = args[5].substring(5);
		 	//String studentnum = args[2].substring(11);
		 	String bookdate = args[0].substring(9);
		 	String seatnum = args[3].substring(5);
		 	String period = args[1].substring(7);
		 	String reason = args[4].substring(7);
			
			//System.out.println(bookdate + " " + seatnum + " " + period + " " + reason);
			if (flag.equals("0"))
			{
				GroupSeatDao groupseatDao = new GroupSeatDao();
				if(groupseatDao.delBookingSeat(user.getStudentnum() , bookdate , seatnum , period) == 0)
				{
					request.setAttribute("info",  "OK! This group seat is deleted!");
					String studentnum = user.getStudentnum();
					GroupSeatDao groupSeatDao = new GroupSeatDao();
					groupseatDao.delReservedSeat(user.getStudentnum() , bookdate , seatnum , period);
					onesGroupInfo = groupSeatDao.getOnesGroupInfo(studentnum);
					request.getSession().setAttribute("onesGroupInfo", onesGroupInfo);
					request.getRequestDispatcher("groupseatsinfo.jsp").forward(request, response);
				}
				else
				{
					request.setAttribute("info",  "亲，对不起，这个座位好像已经删了呢~ Delete this group seat error!");
					request.getRequestDispatcher("message.jsp").forward(request, response);
				}
			}
			else if(flag.equals("1"))
			{
				GroupSeatDao groupseatDao = new GroupSeatDao();
				if(groupseatDao.delReservedSeat(user.getStudentnum() , bookdate , seatnum , period) == 0)
				{
					String studentnum = user.getStudentnum();
					if(groupseatDao.delBookingSeat(user.getStudentnum() , bookdate , seatnum , period) == -1)
					{
						request.setAttribute("info",  "亲，删除座位时错了点错哦~ 报告你们的CTO吧~ Delete this group seat error!");
						request.getRequestDispatcher("message.jsp").forward(request, response);
					}
					else
					{
						request.setAttribute("info",  "OK! This group seat is deleted!");
						GroupSeatDao groupSeatDao = new GroupSeatDao();
						onesGroupInfo = groupSeatDao.getOnesGroupInfo(studentnum);
						request.getSession().setAttribute("onesGroupInfo", onesGroupInfo);
						request.getRequestDispatcher("./groupseatsinfo.jsp").forward(request, response);
					}
					
				}
				else
				{
					request.setAttribute("info",  "亲，这个座位删除的时候出了点错误，请重新试一下吧~可能是这个座位已经被管理员删除了，也可能是离时间段开始不足一小时不允许删除了哦~ Delete this reserved group seat error!");
					request.getRequestDispatcher("message.jsp").forward(request, response);
				}
			}
			
		}
	}

}
