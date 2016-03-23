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
public class AdminUserServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = -803345674849947893L;
	public void doGet(HttpServletRequest request , HttpServletResponse response)
			throws ServletException, IOException
	{
		UserDao userDao = new UserDao();
		ArrayList<User> showallusers = userDao.showAllUsers();
		request.getSession().setAttribute("showallusers" , showallusers);
		HashMap<String , String> closetime = userDao.closeUserTime();
		request.getSession().setAttribute("closetime", closetime);
		
		Iterator iter = closetime.entrySet().iterator();
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
			
			
			Date dNow = new Date();
		    SimpleDateFormat ft = new SimpleDateFormat ("yyyy-MM-dd");	    
			String end = ft.format(dNow);
	        String begin = entry.getValue().toString().replaceAll("_", "-");
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	        try {
	            //间隔天数
	            double days = (double)(sdf.parse(end).getTime()-sdf.parse(begin).getTime())/(double)(24*60*60*1000);
//	            System.out.println(end + " " + begin + " " + days);
	            if (days >= 13)
	            {
	            	
					userDao.openUser(entry.getKey().toString(), u.getUserType());
	            }
	             
	        } catch (ParseException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        }
		}
		
		
		
		showallusers = userDao.showAllUsers();
		request.getSession().setAttribute("showallusers" , showallusers);
		closetime = userDao.closeUserTime();
		request.getSession().setAttribute("closetime", closetime);
		request.getRequestDispatcher("./admindealuser.jsp").forward(request, response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

			doGet(request,response);
			}
}
