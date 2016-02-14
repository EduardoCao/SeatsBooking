package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;

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
	public void changePw(User user , String pw)
	{
		Connection conn = ConnectDB.getConnection();
		String sql = "update user_table set password = '" + pw + "' where studentnum = '" + user.getStudentnum() + "'";
		
		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.executeUpdate();
			ps.close();
		}catch (Exception e)
		{
			e.printStackTrace();
		}finally{
			ConnectDB.closeConnection(conn);
		}
	}
	public boolean deleteUser(String studentnum)
	{
		Connection conn = ConnectDB.getConnection();
		String sql = "delete from user_table where studentnum = ?";
		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, studentnum);
			ps.executeUpdate();
			ps.close();
			
		}catch (Exception e)
		{
			e.printStackTrace();
			return false;
		}
		finally
		{
			ConnectDB.closeConnection(conn);
		}
		Connection connSeat = ConnectDB.getConnectionSeat();
		try{	
			for (int i = 0 ; i < 7 ; i ++)
			{
				for (int j = 0 ; j < 5 ; j ++)
				{
					String sql2 = "update seat_table_"+ i + " set period" + j + " = 0 where ownerPeriod" + j + " = ?";
					PreparedStatement ps = connSeat.prepareStatement(sql2);
					ps.setString(1, studentnum);
					ps.executeUpdate();
					ps.close();
					sql2 = "update seat_table_"+ i + " set ownerPeriod" + j + " = ? where ownerPeriod" + j + " = ?";
					ps = connSeat.prepareStatement(sql2);
					ps.setString(1, null);
					ps.setString(2, studentnum);
					ps.executeUpdate();
					ps.close();
				}
			}
		}catch (Exception e)
		{
			e.printStackTrace();
			return false;
		}
		finally
		{
			ConnectDB.closeConnection(connSeat);
		}
		return true;
	}
	public boolean closeUser(String studentnum , int userType)
	{
		Connection conn = ConnectDB.getConnection();
		try{
			
			String sql = "update user_table set userType = ? where studentnum = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			if(userType == 0)
				userType = -1;
			else if(userType == -1)
				userType = 0;
			else if(userType == 1)
				userType = -2;
			else if(userType == -2)
				userType = 1;
			ps.setInt(1, userType);
			ps.setString(2, studentnum);
			ps.executeUpdate();
			ps.close();
			if(userType < 0)
			{
				sql = "insert into close_user_table value(? , ?)";
				ps = conn.prepareStatement(sql);
				ps.setString(1 , studentnum);
				
				
				Date dNow = new Date( );
			    SimpleDateFormat ft = 
			      new SimpleDateFormat ("yyyy-MM-dd");
			    //System.out.println("Current Date: " + ft.format(dNow));
			    
			    ps.setString(2 , ft.format(dNow));
			    
				ps.executeUpdate();
				ps.close();
			}
			else
			{
				sql = "delete from close_user_table where studentnum = ?";
				ps = conn.prepareStatement(sql);
				ps.setString(1 , studentnum);			    
				ps.executeUpdate();
				ps.close();
			}
			
		}catch (Exception e)
		{
			e.printStackTrace();
			return false;
		}
		finally
		{
			ConnectDB.closeConnection(conn);
		}
		return true;
	}
	public HashMap<String , String> closeUserTime ()
	{
		HashMap<String , String> hm = new HashMap<String , String>();
		Connection conn = ConnectDB.getConnection();
		try{
			
			String sql = "select * from  close_user_table";
			PreparedStatement ps = conn.prepareStatement(sql);
			
			ResultSet rs = ps.executeQuery();
			while (rs.next())
			{
				hm.put(rs.getString("studentnum"), rs.getString("closetime")) ;
			}
			rs.close();
			ps.close();
			
			
		}catch (Exception e)
		{
			e.printStackTrace();
			return null;
		}
		finally
		{
			ConnectDB.closeConnection(conn);
		}
		return hm;
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
	public ArrayList<User> showAllUsers()
	{
		ArrayList<User> res = new ArrayList<User>();
		Connection conn = ConnectDB.getConnection();
		String sql = "select * from user_table";
		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next())
			{
				if(rs.getInt("userType") == 2)
					continue;
				User user = new User();
				//user.setId(rs.getInt("id"));
				user.setStudentnum(rs.getString("studentnum"));
				user.setPassword(rs.getString("password"));
				user.setEmail(rs.getString("email"));
				user.setUserType(rs.getInt("userType"));
				res.add(user);
			}
			rs.close();
			ps.close();
		}catch(SQLException e)
		{
			e.printStackTrace();
		}finally{
			ConnectDB.closeConnection(conn);
		}
		Collections.sort(res, new Comparator(){
			public int compare(Object o1 , Object o2)
			{
				return ((User)o1).getStudentnum().compareTo(((User)o2).getStudentnum());
			}
		});
		return res;
	}

	
}
