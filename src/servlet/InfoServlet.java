package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.SeatDao;
import dao.UserDao;
import util.User;

public class InfoServlet extends HttpServlet{

	private static final long serialVersionUID = 12L;
	
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
		HttpSession session = request.getSession();
		SeatDao seatDao = new SeatDao();
		//System.out.println(user.getStudentnum());
		ArrayList<String> onesSeat = seatDao.getOnesSeats(user.getStudentnum());
		request.getSession().setAttribute("seats", null);
		request.getSession().setAttribute("groupseats", null);
		request.getSession().setAttribute("onesSeats", onesSeat);
		request.getRequestDispatcher("./seatsinfo.jsp").forward(request, response);
	}

}

