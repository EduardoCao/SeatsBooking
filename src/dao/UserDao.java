package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import util.User;
public class UserDao {
	
	public int checkUserType(String studentnum , String password)
	{
		int result = -1;
		Connection conn = ConnectDB.getConnection();
		String sql = "select * from user_table where studentnum = ?";
		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, studentnum);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
			{
				result = rs.getInt("userType");
			}
			rs.close();
			ps.close();
		}catch(SQLException e)
		{
			e.printStackTrace();
		}finally{
			ConnectDB.closeConnection(conn);
		}
		return result;
	}
	
	public void saveUser(User user)
	{
		Connection conn = ConnectDB.getConnection();
		String sql = "insert into user_table(studentnum, password , email , userType) values(?, ?, ?, ?)";
		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, user.getStudentnum());
			ps.setString(2, user.getPassword());
			ps.setString(3, user.getEmail());
			ps.setInt(4, user.getUserType());
			ps.executeUpdate();
			ps.close();
		}catch (Exception e)
		{
			e.printStackTrace();
		}finally{
			ConnectDB.closeConnection(conn);
		}
	}
	public User login(String studentnum , String password)
	{
		User user = null;
		Connection conn = ConnectDB.getConnection();
		String sql = "select * from user_table where studentnum = ? and password = ?";
		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, studentnum);
			ps.setString(2, password);
			ResultSet rs = ps.executeQuery();
			if(rs.next())
			{
				user = new User();
				//user.setId(rs.getInt("id"));
				user.setStudentnum(rs.getString("studentnum"));
				user.setPassword(rs.getString("password"));
				user.setEmail(rs.getString("email"));
				user.setUserType(rs.getInt("userType"));
			}
			rs.close();
			ps.close();
		}catch (Exception e)
		{
			e.printStackTrace();
		}finally
		{
			ConnectDB.closeConnection(conn);
		}
		return user;
	}
	public boolean userIsExist(String username)
	{
		Connection conn = ConnectDB.getConnection();
		String sql = "select * from user_table where studentnum = ?";
		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			ResultSet rs = ps.executeQuery();
			if (! rs.next())
			{
				return true;
			}
			rs.close();
			ps.close();
		}catch(SQLException e)
		{
			e.printStackTrace();
		}finally{
			ConnectDB.closeConnection(conn);
		}
		return false;
	}
	
}
