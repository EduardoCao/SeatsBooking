package servlet;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.SeatDao;

public class SetAccessServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 2886615919672432500L;
	public void doGet(HttpServletRequest request , HttpServletResponse response)
			throws ServletException, IOException
	{
		SeatDao seatDao = new SeatDao();
		ArrayList<String> seatAccess = seatDao.getSeatAccess();
		request.getSession().setAttribute("seataccess" , seatAccess);
		request.getRequestDispatcher("./adminsetaccess.jsp").forward(request, response);
	}

}
