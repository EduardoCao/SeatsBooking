package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.AnnouncementDao;
import util.DateManager;

public class SetAnnounceServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 8822355956573671728L;
	public void doPost(HttpServletRequest request , HttpServletResponse response)
	throws ServletException, IOException
	{
		request.setCharacterEncoding("UTF-8");
		String announceContent = request.getParameter("announceContent");
		String pubtime = DateManager.getFormatCompleteDate(0);
		if(announceContent == null || announceContent.length() == 0)
		{
			request.setAttribute("info",  "公告不能为空呢~ Announcement content is null!");
			request.getRequestDispatcher("message.jsp").forward(request, response);
			return;
		}
		else if(announceContent.length() > 500)
		{
			request.setAttribute("info",  "公告太长了呢~ Announcement content is too long!");
			request.getRequestDispatcher("message.jsp").forward(request, response);
			return;
		}
		else
		{
			AnnouncementDao announcementDao = new AnnouncementDao();
			announcementDao.addAnnounce(announceContent , pubtime);
			ArrayList<String> announceArray = announcementDao.getAnnouncement();
			request.getSession().setAttribute("announcement", announceArray);
			request.getRequestDispatcher("adminannouncement.jsp").forward(request, response);
		}	
	}
}
