package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.SeatDao;
import util.User;
import util.Seats;

public class DeleteServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 5888011699070498226L;
	public void doPost(HttpServletRequest request , HttpServletResponse response)
			throws ServletException, IOException
			{

				String delete = request.getParameter("delete");
				if(delete == null)
				{
					request.setAttribute("info",  "Delete seats error!");
					request.getRequestDispatcher("message.jsp").forward(request, response);
				}
				else
				{
					int deletenum = Integer.parseInt(delete);
					ArrayList<String> onesseats = (ArrayList<String>) request.getSession().getAttribute("onesSeats");
					String[] args = onesseats.get(deletenum).trim().split(" ");
					String bookdate = args[0].substring(3);
					String seatnum = args[1].substring(7);
					String period = args[2].substring(6);
					User user = (User) request.getSession().getAttribute("user");
					if(onesseats.size() == 0 || user == null)
					{
						request.setAttribute("info",  "Delete seats error!");
						request.getRequestDispatcher("message.jsp").forward(request, response);
					}
					else
					{
						System.out.println();
						SeatDao seatDao = new SeatDao();
						if(seatDao.deleteSeat(user.getStudentnum(), bookdate, seatnum, period))
						{

							Seats[] seats = new Seats[10];
							seats = seatDao.getSeats(bookdate);
							request.getSession().setAttribute("seats", seats);
							//request.setAttribute("info",  "OK! Delete this seat!");
							request.getRequestDispatcher("seatsbooking.jsp").forward(request, response);
						}
						else
						{
							request.setAttribute("info",  "Cannot delete this seat!");
							request.getRequestDispatcher("message.jsp").forward(request, response);
						}
						
					}
				}
			}

}
