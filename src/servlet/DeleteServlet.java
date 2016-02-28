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
					request.setAttribute("info",  "亲，别急，还没说好删哪个座位呢~ Delete seats error!");
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
						request.setAttribute("info",  "其实已经没的可删了，重新试试看~ Delete seats error!");
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
							ArrayList<String> onesSeat = seatDao.getOnesSeats(user.getStudentnum());
							request.getSession().setAttribute("onesSeats", onesSeat);
							//request.setAttribute("info",  "OK! Delete this seat!");
							request.getRequestDispatcher("seatsinfo.jsp").forward(request, response);
						}
						else
						{
							request.setAttribute("info",  "亲，这个座位好像已经删了呢~或者时间段开始不足一小时不能删除了呢~重新查看一下吧~ Cannot delete this seat!");
							request.getRequestDispatcher("message.jsp").forward(request, response);
						}
						
					}
				}
			}

}
