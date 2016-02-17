package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.GroupSeatDao;
import util.User;

public class AdminGroupServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 133365428967044931L;
	public void doGet(HttpServletRequest request , HttpServletResponse response)
			throws ServletException, IOException
	{
		GroupSeatDao groupSeatDao = new GroupSeatDao();
		ArrayList<String> allGroupInfo = new ArrayList<String>();
		allGroupInfo = groupSeatDao.getAllGroupInfo();
		request.getSession().setAttribute("allGroupInfo", allGroupInfo);
		request.getRequestDispatcher("./admingroupinfo.jsp").forward(request, response);
	}

}
