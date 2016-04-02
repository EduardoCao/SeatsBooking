package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.AnnouncementDao;
import util.User;

public class AnnouncementServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = -5838896095244820429L;
	public void doPost(HttpServletRequest request , HttpServletResponse response)
			throws ServletException , IOException
			{
				AnnouncementDao announcementDao = new AnnouncementDao();
				ArrayList<String> announce = announcementDao.getAnnouncement();
				
				
				request.getSession().setAttribute("announcement", announce);
//					System.out.println(announce);
				request.getRequestDispatcher("announcement.jsp").forward(request, response);
				
			}
			public void doGet(HttpServletRequest request , HttpServletResponse response)
			throws ServletException , IOException
			{
				doPost(request,response);
			}
}
