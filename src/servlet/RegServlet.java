package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDao;
import util.User;

public class RegServlet extends HttpServlet{
	private static final long serialVersionUID = 5280356329609002908L;
	public void doPost(HttpServletRequest request , HttpServletResponse response)
	throws ServletException, IOException
	{
		request.setCharacterEncoding("UTF-8");
		String studentnum = request.getParameter("studentnum");
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String userType = request.getParameter("userType");

		UserDao userDao = new UserDao();
		if (studentnum != null && !studentnum.isEmpty())
		{
			if(userDao.userIsExist(studentnum))
			{
				User user = new User();
				user.setStudentnum(studentnum);
				user.setName(name);
				user.setPassword(password);
				user.setEmail(email);
				user.setUserType(Integer.parseInt(userType));
				userDao.saveUser(user);
				request.setAttribute("info", "恭喜你！成功注册！Congratulation! Registration succeed!");
				
			}else
			{
				request.setAttribute("info", "哎哎哎，这个用户名已经存在了呦喂！Sorry, the studentnum is oppucied!" );
				request.getRequestDispatcher("message.jsp").forward(request, response);
				return;
			}
		}
		
		request.getRequestDispatcher("AdminUserServlet").forward(request, response);
	}
}	
