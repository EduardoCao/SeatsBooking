package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.GroupSeatDao;
import util.User;

public class GroupInfoServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 4273564362939915066L;
	
	public void doGet(HttpServletRequest request , HttpServletResponse response)
	throws ServletException, IOException
	{
		GroupSeatDao groupSeatDao = new GroupSeatDao();
		ArrayList<String> onesGroupInfo = new ArrayList<String>();
		
		User user = (User) request.getSession().getAttribute("user");
		String studentnum = user.getStudentnum();
		onesGroupInfo = groupSeatDao.getOnesGroupInfo(studentnum);
		request.getSession().setAttribute("onesGroupInfo", onesGroupInfo);
		request.getRequestDispatcher("./groupseatsinfo.jsp").forward(request, response);
		
		
	}

}
