package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.SeatDao;
import dao.UserDao;
import util.Seats;

public class AddSeatServlet extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 907840772466432057L;
	public void doPost(HttpServletRequest request , HttpServletResponse response)
			throws ServletException, IOException
			{
				String bookuser = request.getParameter("bookuser");
				String delete = request.getParameter("addSeat");
				String bookdate = (String) request.getSession().getAttribute("bookdate");
				if(delete == null|| bookuser == null)
				{
					request.setAttribute("info",  "add seat error!");
					request.getRequestDispatcher("message.jsp").forward(request, response);
				}
				else
				{
					UserDao userDao = new UserDao();
					if(userDao.userIsExist(bookuser))
					{
						request.setAttribute("info",  "add seat error , user not exist!");
						request.getRequestDispatcher("message.jsp").forward(request, response);
					}
					else
					{
					
					if(delete.split("_").length != 3 || delete.split("_")[0] == null || delete.split("_")[1] == null || delete.split("_")[2] == null )
					{
						request.setAttribute("info",  "add seat error!");
						request.getRequestDispatcher("message.jsp").forward(request, response);
					}
					else
					{
						int seatnum = Integer.parseInt(delete.split("_")[0]);
						int periodnum = Integer.parseInt(delete.split("_")[1]);
						int periodori = Integer.parseInt(delete.split("_")[2]);
						if(periodori == 0 || periodori == 2)
						{
							SeatDao seatDao = new SeatDao();
							String bookseat = seatnum + "_" + periodnum;
							String bookres = seatDao.bookSeatbyAdmin(bookuser, bookdate, bookseat , periodori);
							if(bookres.equals("Success"))
							{
								
								Seats[] seats = new Seats[10];
								seats = seatDao.getSeats(bookdate);
								request.getSession().setAttribute("seats", seats);
								request.getRequestDispatcher("adminseat.jsp").forward(request, response);
							}
							else
							{
								request.setAttribute("info",  bookres);
								request.getRequestDispatcher("message.jsp").forward(request, response);
							}
						}
						else
						{
							request.setAttribute("info",  "Cannot add this seat, the seat is occupied!");
							request.getRequestDispatcher("message.jsp").forward(request, response);
						}
						
					}
				 }
				}
			}

}
