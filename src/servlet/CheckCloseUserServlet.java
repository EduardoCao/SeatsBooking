package servlet;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDao;
import util.User;

public class CheckCloseUserServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = -6329487900373798357L;
	public void doPost(HttpServletRequest request , HttpServletResponse response)
			throws ServletException, IOException
	{
		HashMap <String , String> ct = (HashMap<String, String>) request.getSession().getAttribute("closetime");
		ArrayList<User> showallusers = (ArrayList<User>) request.getSession().getAttribute("showallusers");
		if(ct.size() == 0)
		{
			UserDao userDao = new UserDao();
    		showallusers = userDao.showAllUsers();
    		request.getSession().setAttribute("showallusers", showallusers);
    		request.getRequestDispatcher("admindealuser.jsp").forward(request, response);
		}
		else
		{
		Iterator iter = ct.entrySet().iterator();
		while (iter.hasNext()) {
			HashMap.Entry entry = (HashMap.Entry) iter.next();
			String studentnum = entry.getKey().toString();
			User u = new User();
			for (int i = 0 ; i < showallusers.size() ; i++)
			{
				if(showallusers.get(i).getStudentnum().equals(studentnum))
				{
					u = showallusers.get(i);
					break;
				}
			}
			
			//System.out.println(entry.getKey() + " " + entry.getValue());
			
			Date dNow = new Date( );
		    SimpleDateFormat ft = new SimpleDateFormat ("yyyy-MM-dd");	    
			String end = ft.format(dNow);
	        String begin = entry.getValue().toString();
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	        try {
	            //间隔天数
	            double days = (double)(sdf.parse(end).getTime()-sdf.parse(begin).getTime())/(double)(24*60*60*1000);
	            //System.out.println(end + " " + begin + " " + days);
	            if (days >= 14)
	            {
	            	UserDao userDao = new UserDao();
	            	//System.out.println(u.getStudentnum());
					if(userDao.closeUser(entry.getKey().toString(), u.getUserType()))
					{
						showallusers = userDao.showAllUsers();
						request.getSession().setAttribute("showallusers", showallusers);
						request.getRequestDispatcher("admindealuser.jsp").forward(request, response);
					}
					else
					{
						request.setAttribute("info",  "Cannot open this user!");
						request.getRequestDispatcher("message.jsp").forward(request, response);
					}
	            }
	            else
	            {
	            	UserDao userDao = new UserDao();
	        		showallusers = userDao.showAllUsers();
	        		request.getSession().setAttribute("showallusers", showallusers);
	        		request.getRequestDispatcher("admindealuser.jsp").forward(request, response);
	            }
	             
	        } catch (ParseException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        }
		}
		}
		
	}

}
