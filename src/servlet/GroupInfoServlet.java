package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.GroupSeatDao;
import dao.UserDao;
import util.User;

public class GroupInfoServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 4273564362939915066L;
	
	public void doGet(HttpServletRequest request , HttpServletResponse response)
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
		GroupSeatDao groupSeatDao = new GroupSeatDao();
		ArrayList<String> onesGroupInfo = new ArrayList<String>();
		String studentnum = user.getStudentnum();
		onesGroupInfo = groupSeatDao.getOnesGroupInfo(studentnum);
		request.getSession().setAttribute("seats", null);
		request.getSession().setAttribute("groupseats", null);
		request.getSession().setAttribute("onesGroupInfo", onesGroupInfo);
		request.getRequestDispatcher("./groupseatsinfo.jsp").forward(request, response);
		
		
	}

}
