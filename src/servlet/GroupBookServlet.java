package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.GroupSeatDao;
import dao.UserDao;
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
		User user = (User) request.getSession().getAttribute("user");
		UserDao userDao = new UserDao();
		if(user == null)
		{
			request.setAttribute("info",  "登录超时，请重新登录。Wait time out.");
			request.getRequestDispatcher("message.jsp").forward(request, response);
			return ;
		}
		if(userDao.userIsExist(user.getStudentnum()))
		{
			request.setAttribute("info",  "该用户已经被删除了... User deleted...");
			request.getRequestDispatcher("message.jsp").forward(request, response);
			return ;
		}
		request.setCharacterEncoding("UTF-8");
		String bookdate = (String)request.getSession().getAttribute("bookdate");
		String groupSeat = request.getParameter("groupSeat");
		String reason = request.getParameter("reason");
		//System.out.println("reason: " + reason + "; bookdate: " + bookdate);
		
		int userType = userDao.checkUserType(user.getStudentnum() , user.getPassword());
		if(userType < 0)
		{
			request.setAttribute("info", "亲爱的同学，由于你之前的违规行为，严格认真的管理员决定关你两周的禁闭哦~ You cannot book for you have been banned for 2 weeks!");
			request.getRequestDispatcher("./message.jsp").forward(request, response);
			return;
		}
		
		if(bookdate == null) 
		{
			request.setAttribute("info",  "亲，别急呀，还没说好订哪一天的座位呢~ Bookdate error!");
			request.getRequestDispatcher("message.jsp").forward(request, response);
		}

		else if(groupSeat == null)
		{
			request.setAttribute("info",  "亲，你还没告诉我订哪个座位呢~ GroupSeat error!");
			request.getRequestDispatcher("message.jsp").forward(request, response);
		}
		else if(reason == null)
		{
			request.setAttribute("info",  "亲，申请的理由也要写哦~ Reason error!");
			request.getRequestDispatcher("message.jsp").forward(request, response);
		}
		else
		{
			GroupSeatDao groupSeatDao = new GroupSeatDao();
			reason = reason.replaceAll("##", "_");
			int tag = groupSeatDao.reserveGroupSeat(groupSeat, user.getStudentnum(), bookdate , reason, 0);
			if(tag == 1)
			{
				request.setAttribute("info",  "亲，你已经申请了同一时间段的座位了，正在审批，不要着急哦~ You have been booking the same seat already. Please wait...");
				request.getRequestDispatcher("message.jsp").forward(request, response);
			}
			else if(tag == 2)
			{
				request.setAttribute("info",  "亲，你已经预定好了这个时间段的座位了呢！！ You have got this seat already.");
				request.getRequestDispatcher("message.jsp").forward(request, response);
			}
			else if(tag == -1)
			{
				request.setAttribute("info",  "亲，出了点错:( 重新试一下~ Book error!");
				request.getRequestDispatcher("message.jsp").forward(request, response);
			}
			else if(tag == 3)
			{
				request.setAttribute("info",  "这个座位刚刚被人抢了呢，不可预定，刷新试试看！ Group seat taken just now!");
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
