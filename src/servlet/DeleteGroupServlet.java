package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeleteGroupServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = -7486710411382109020L;
	public void doPost(HttpServletRequest request , HttpServletResponse response)
	throws ServletException, IOException
	{
		String delete = request.getParameter("deletegroup");
		if(delete == null)
		{
			request.setAttribute("info",  "delete seats error!");
			request.getRequestDispatcher("message.jsp").forward(request, response);
		}
		else
		{
			int deletenum = Integer.parseInt(delete);
			ArrayList<String> onesGroupInfo = (ArrayList<String>) request.getSession().getAttribute("onesGroupInfo");
			String del = onesGroupInfo.get(deletenum);
			String[] args = del.trim().split("##");
			String flag = args[0];
			String bookdate = args[1].substring(4);
			String seatnum = args[2].substring(5);
			String period = args[3].substring(7);
			String reason = args[4].substring(7);
			System.out.println(bookdate + " " + seatnum + " " + period + " " + reason);
			if (flag.equals("0"))
			{
				
			}
			else if(flag.equals("1"))
			{
				
			}
			
		}
	}

}
