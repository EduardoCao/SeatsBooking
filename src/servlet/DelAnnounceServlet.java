package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.AnnouncementDao;

public class DelAnnounceServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 4877709652377185429L;
	public void doPost(HttpServletRequest request , HttpServletResponse response)
	throws ServletException, IOException
	{
		String deleteAnnounce = request.getParameter("deleteAnnounce");
		ArrayList<String> announcement = (ArrayList<String>) request.getSession().getAttribute("announcement");
		if (deleteAnnounce == null || announcement == null)
		{
			request.setAttribute("info",  "亲，没有指定删除哪条公告呢~ Delete announcement error!");
			request.getRequestDispatcher("message.jsp").forward(request, response);
			return;
		}
		else
		{
			String tmp = announcement.get(Integer.parseInt(deleteAnnounce));
			String pubtime = tmp.split("####")[0];
			String announce = tmp.split("####")[1];
			AnnouncementDao announcementDao = new AnnouncementDao();
			announcementDao.delAnnounce(pubtime, announce);
			ArrayList<String> announceArray = announcementDao.getAnnouncement();
			request.getSession().setAttribute("announcement", announceArray);
			request.getRequestDispatcher("adminannouncement.jsp").forward(request, response);
		}
	}
}
