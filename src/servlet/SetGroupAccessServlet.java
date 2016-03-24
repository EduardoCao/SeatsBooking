package servlet;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.GroupSeatDao;

public class SetGroupAccessServlet extends HttpServlet{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -7388629547683176724L;

	public void doGet(HttpServletRequest request , HttpServletResponse response)
			throws ServletException, IOException
	{
		GroupSeatDao groupSeatDao = new GroupSeatDao();
		ArrayList<String> groupSeatAccess = groupSeatDao.getGroupSeatAccess();
		request.getSession().setAttribute("groupseataccess" , groupSeatAccess);
		request.getRequestDispatcher("./adminsetgroupaccess.jsp").forward(request, response);
	}

}
