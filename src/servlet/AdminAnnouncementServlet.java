package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.AnnouncementDao;
import util.User;



public class AdminAnnouncementServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7896916176524804034L;
	
	public void doPost(HttpServletRequest request , HttpServletResponse response)
	throws ServletException , IOException
	{
		AnnouncementDao announcementDao = new AnnouncementDao();
		ArrayList<String> announce = announcementDao.getAnnouncement();
		
		User user = (User) request.getSession().getAttribute("user");
		if(user.getUserType() != 2)
		{
			request.getSession().setAttribute("user", null);
			request.setAttribute("info", "不是管理员，无权查看该页面");
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
		else{
			request.getSession().setAttribute("announcement", announce);
//			System.out.println(announce);
			request.getRequestDispatcher("adminannouncement.jsp").forward(request, response);
		}
	}
	public void doGet(HttpServletRequest request , HttpServletResponse response)
			throws ServletException , IOException
			{
				doPost(request,response);
			}

}
