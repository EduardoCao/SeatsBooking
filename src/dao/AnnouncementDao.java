package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collections;


public class AnnouncementDao {
	public ArrayList<String> getAnnouncement()
	{
		ArrayList<String> res = new ArrayList<String>();
		
		Connection conn = ConnectDB.getAnnouncementConnection();
		
		String sql = "select * from announcement_table";
		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next())
			{
				String announcement = rs.getString("announcement");
				String pubtime = rs.getString("pubtime");
				String tmp =  pubtime+ "####" + announcement;
				res.add(tmp);
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return null;
		}
		finally{
			ConnectDB.closeConnection(conn);
		}
		Collections.sort(res); 
		Collections.reverse(res);
		return res;
		
	}

	public void delAnnounce(String pubtime, String announce) {
		// TODO Auto-generated method stub
		Connection conn = ConnectDB.getAnnouncementConnection();
		
		String sql = "delete from announcement_table where announcement = ? and pubtime = ?";
		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, announce);
			ps.setString(2, pubtime);
			ps.executeUpdate();
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
			
		}
		finally{
			ConnectDB.closeConnection(conn);
		}
		
	}

	public void addAnnounce(String announceContent, String pubtime) {
		// TODO Auto-generated method stub
		
		Connection conn = ConnectDB.getAnnouncementConnection();
		
		String sql = "insert into announcement_table values (?,?)";
		try{
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, announceContent);
			ps.setString(2, pubtime);
			ps.executeUpdate();
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
			
		}
		finally{
			ConnectDB.closeConnection(conn);
		}
	}
}
