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


public class BookServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 12L;

	public void doPost(HttpServletRequest request , HttpServletResponse response)
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
				String bookdate = (String)session.getAttribute("bookdate");
				String bookseat = request.getParameter("seat");

				String owner = user.getStudentnum();
				String pw = user.getPassword();
				int userType = userDao.checkUserType(owner,pw);
				if(userType < 0)
				{
					request.setAttribute("info", "亲爱的同学，由于你之前的违规行为，严格认真的管理员决定关你两周的禁闭哦~ You cannot book for you have been banned for 2 weeks!");
					request.getRequestDispatcher("./message.jsp").forward(request, response);
				}
				//System.out.println(owner + " " + bookdate + " "  + bookseat);
				else
				{
					if (owner == null)
					{
						String info = "Please login first!";
						request.setAttribute("info", info);
						request.getRequestDispatcher("./message.jsp").forward(request, response);
					}
					if (bookseat == null || bookdate == null)
					{
						String info = "亲，别急，还没选择好预定哪天的哪个座位呢！Please try to book the seat again!";
						request.setAttribute("info", info);
						request.getRequestDispatcher("./message.jsp").forward(request, response);
					}
					else
					{
						SeatDao seatDao = new SeatDao();
						
						String info = seatDao.bookSeat(owner , bookdate , bookseat);
						//System.out.println(info);
						if (!info.equals("Success"))
						{
							request.setAttribute("info", info);
							request.getRequestDispatcher("./message.jsp").forward(request, response);
						}
						else
						{
							ArrayList<String> onesSeat = seatDao.getOnesSeats(owner);
							request.getSession().setAttribute("seats" , null);
							request.getSession().setAttribute("onesSeats", onesSeat);
							request.getRequestDispatcher("./seatsinfo.jsp").forward(request, response);
							
						}
					}
				}
			}
}
