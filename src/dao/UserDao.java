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

import util.DateManager;
import util.User;
public class UserDao {
	
	public int checkUserType(String studentnum , String password)
	{
		int result = -1;
		Connection conn = ConnectDB.getUserConnection();
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
		Connection conn = ConnectDB.getUserConnection();
		String sql = "insert into user_table(studentnum,name, password , email , userType) values(?, ?, ?, ?, ?)";
		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, user.getStudentnum());
			ps.setString(2, user.getName());
			ps.setString(3, user.getPassword());
			ps.setString(4, user.getEmail());
			ps.setInt(5, user.getUserType());
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
		Connection conn = ConnectDB.getUserConnection();
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
		Connection conn = ConnectDB.getUserConnection();
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
		
		sql = "delete from close_user_table where studentnum = ?";
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
		Connection connSeat = ConnectDB.getSeatConnection();
		try{	
			for (int i = 0 ; i < 7 ; i ++)
			{
				for (int j = 0 ; j < 5 ; j ++)
				{
					String date = DateManager.getFormatCompleteDate(i);
					String sql2 = "update "+ date + " set period" + j + " = 0 where ownerPeriod" + j + " = ?";
					PreparedStatement ps = connSeat.prepareStatement(sql2);
					ps.setString(1, studentnum);
					ps.executeUpdate();
					ps.close();
					sql2 = "update "+ date + " set ownerPeriod" + j + " = ? where ownerPeriod" + j + " = ?";
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
		Connection connGroupSeat = ConnectDB.getGroupSeatConnection();
		try{	
			for (int i = 0 ; i < 7 ; i ++)
			{
				for (int j = 0 ; j < 5 ; j ++)
				{
					String date = DateManager.getFormatCompleteDate(i);
					String sql2 = "update "+ date + " set period" + j + " = 0, ownerPeriod"+j + " = ? where ownerPeriod" + j + " = ?";
					PreparedStatement ps = connGroupSeat.prepareStatement(sql2);
					ps.setString(1, null);
					ps.setString(2, studentnum);
					ps.executeUpdate();
					ps.close();
					
				}
			}
			String sql2 = "delete from reason_table where studentnum = ?";
			PreparedStatement ps = connGroupSeat.prepareStatement(sql2);
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
			ConnectDB.closeConnection(connGroupSeat);
		}
		return true;
	}
	public boolean closeUser(String studentnum , int userType)
	{
		if (userType < 0)
			return false;
		Connection conn = ConnectDB.getUserConnection();
		try{
			
			String sql = "update user_table set userType = ? where studentnum = ? and userType = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			int newuserType = userType;
			if(userType == 0)
				newuserType = -1;
			else if(userType == 1)
				newuserType = -2;

			ps.setInt(1, newuserType);
			ps.setString(2, studentnum);
			ps.setInt(3, userType);
			if (ps.executeUpdate() > 0)
			{

				if(newuserType < 0)
				{
					sql = "insert into close_user_table value(? , ?)";
					ps = conn.prepareStatement(sql);
					ps.setString(1 , studentnum);
					
					String date = DateManager.getFormatCompleteDate(0);
				    
				    ps.setString(2 , date);
				    
					ps.executeUpdate();
					ps.close();
				}
			}
			else
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
		return true;
	}
	
	public boolean openUser(String studentnum , int userType)
	{
		if(userType > 0)
			return false;
		Connection conn = ConnectDB.getUserConnection();
		try{
			
			String sql = "update user_table set userType = ? where studentnum = ? and userType = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			int newuserType = userType;
			if(userType == -1)
				newuserType = 0;
			else if(userType == -2)
				newuserType = 1;

			ps.setInt(1, newuserType);
			ps.setString(2, studentnum);
			ps.setInt(3, userType);
			if(ps.executeUpdate()>0)
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
		Connection conn = ConnectDB.getUserConnection();
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
		Connection conn = ConnectDB.getUserConnection();
		String sql = "select * from user_table where studentnum = ? and password = ?";
		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, studentnum);
			ps.setString(2, password);
			ResultSet rs = ps.executeQuery();
			if(rs.next())
			{
				user = new User();
				user.setName(rs.getString("name"));
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
		/**
		 *  true this user not exists
		 */
		Connection conn = ConnectDB.getUserConnection();
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
		Connection conn = ConnectDB.getUserConnection();
		String sql = "select * from user_table";
		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next())
			{
				if(rs.getInt("userType") == 2)
					continue;
				User user = new User();
				user.setName(rs.getString("name"));
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
