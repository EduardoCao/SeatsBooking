package dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
/**
 * 
 * @author Eduardo
 * @date 16-01-25
 *
 */
public class ConnectDB {
	public static String pw = "root";
	public static Connection getConnection_root()
	{
		Connection conn = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306";
			conn = DriverManager.getConnection(url, "root", pw);
		}catch (Exception e)
		{
			e.printStackTrace();
		}
		return conn;
	}
	public static Connection getUserConnection()
	{
		Connection conn = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/userDB";
			conn = DriverManager.getConnection(url, "root", pw);
		}catch (Exception e)
		{
			e.printStackTrace();
		}
		
		return conn;
	}

	public static Connection getSeatConnection()
	{
		Connection conn = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/seatDB";
			conn = DriverManager.getConnection(url, "root", pw);
		}catch (Exception e)
		{
			e.printStackTrace();
		}
		
		return conn;
	}
	public static Connection getGroupSeatConnection()
	{
		Connection conn = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/groupSeatDB";
			conn = DriverManager.getConnection(url, "root", pw);
		}catch (Exception e)
		{
			e.printStackTrace();
		}
		
		return conn;
	}
	public static Connection getAnnouncementConnection()
	{
		Connection conn = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/announcementDB";
			conn = DriverManager.getConnection(url, "root", pw);
		}catch (Exception e)
		{
			e.printStackTrace();
		}
		
		return conn;
	}
	public static void closeConnection(Connection conn)
	{
		if(conn != null)
		{
			try{
				conn.close();
			}catch(SQLException e)
			{
				e.printStackTrace();
			}
		}
	}
	
}
