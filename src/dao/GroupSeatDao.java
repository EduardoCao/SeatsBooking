package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.Seats;

public class GroupSeatDao {
	public Seats[] getGroupSeats(String date)
	{
		Seats[] seats = new Seats[2];
		Connection conn = ConnectDB.getConnectionGroupSeat();
		try{
		for (int i = 0 ; i < 2 ; i ++)
		{
			String sql = "select * from group_seat_table_" + date + " where seatnum = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, i);
			ResultSet rs = ps.executeQuery();
			if(rs.next())
			{
				seats[i] = new Seats();
				seats[i].setPeroid0(rs.getInt("period0"));
				seats[i].setPeroid1(rs.getInt("period1"));
				seats[i].setPeroid2(rs.getInt("period2"));
				seats[i].setPeroid3(rs.getInt("period3"));
				seats[i].setPeroid4(rs.getInt("period4"));
				seats[i].setOwnerPeroid0(rs.getString("ownerPeriod0"));
				seats[i].setOwnerPeroid1(rs.getString("ownerPeriod1"));
				seats[i].setOwnerPeroid2(rs.getString("ownerPeriod2"));
				seats[i].setOwnerPeroid3(rs.getString("ownerPeriod3"));
				seats[i].setOwnerPeroid4(rs.getString("ownerPeriod4"));
			}
			rs.close();
			ps.close();
		}
			
		}catch (Exception e)
		{
			e.printStackTrace();
		}finally
		{
			ConnectDB.closeConnection(conn);
		}
		return seats;
	}
	public int reserveGroupSeat(String seat_period , String studentnum , int bookdate , String reason , int flag)
	{
		Connection conn = ConnectDB.getConnectionGroupSeat();
		try{

			String sql = "select * from reason_table where studentnum = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, studentnum);
			ResultSet rs = ps.executeQuery();
			while (rs.next())
			{
				if(rs.getInt("bookdate") == bookdate)
				{
				if(rs.getString("seat_period").equals(seat_period) && rs.getInt("flag") == 0)
				{
					ps.close();
					rs.close();
					ConnectDB.closeConnection(conn);
					return 1;
				}
				else if(rs.getString("seat_period").equals(seat_period) && rs.getInt("flag") == 1)
				{
					ps.close();
					rs.close();
					ConnectDB.closeConnection(conn);
					return 2;
				}
				}
			}
			rs.close();
			sql = "insert into reason_table values (? , ? , ? , ? , ?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, seat_period);
			ps.setString(2, studentnum);
			ps.setInt(3, bookdate);
			ps.setString(4, reason);
			ps.setInt(5, flag);
			ps.executeUpdate();
			ps.close();	
			
		}catch (Exception e)
		{
			e.printStackTrace();
			return -1;
		}
		ConnectDB.closeConnection(conn);
		return 0;
		
		
	}
	public ArrayList<String> getOnesGroupInfo(String studentnum) {
		ArrayList<String> res = new ArrayList<String>();
		Connection conn = ConnectDB.getConnectionGroupSeat();
		try{
		
			String sql = "select * from reason_table where studentnum = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, studentnum);
			ResultSet rs = ps.executeQuery();
			while (rs.next())
			{
				int flag = rs.getInt("flag");
				int bookdate = rs.getInt("bookdate");
				String seat = rs.getString("seat_period").split("_")[0];
				String period = rs.getString("seat_period").split("_")[1];
				String reason = rs.getString("reason");
				String tmp = flag + "##day_" + bookdate + "##seat_" + seat+ "##period_" + period + "##reason_" + reason;
				//System.out.println(tmp);
				res.add(tmp);
			}
			rs.close();
			ps.close();	
			
		}catch (Exception e)
		{
			e.printStackTrace();
			return null;
		}finally
		{
			ConnectDB.closeConnection(conn);
		}
		return res;
	}

}
