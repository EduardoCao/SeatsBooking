package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.SeatDao;
import util.User;

public class InfoServlet extends HttpServlet{

	private static final long serialVersionUID = 12L;
	
	public void doGet(HttpServletRequest request , HttpServletResponse response)
	throws ServletException, IOException
	{
		HttpSession session = request.getSession();
		SeatDao seatDao = new SeatDao();
		User user = (User)session.getAttribute("user");
		System.out.println(user.getStudentnum());
		ArrayList<String> onesSeat = seatDao.getOnesSeats(user.getStudentnum());
		request.getSession().setAttribute("user", user);
		request.getSession().setAttribute("onesSeats", onesSeat);
		request.getRequestDispatcher("./seatsinfo.jsp").forward(request, response);
	}

}

