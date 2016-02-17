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
			String period = seat_period.split("_")[1];
			while (rs.next())
			{
				if(rs.getInt("bookdate") == bookdate)
				{
				if(rs.getString("seat_period").split("_")[1].equals(period) && rs.getInt("flag") == 0)
				{
					ps.close();
					rs.close();
					ConnectDB.closeConnection(conn);
					return 1;
				}
				else if(rs.getString("seat_period").split("_")[1].equals(period) && rs.getInt("flag") == 1)
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
	public int delBookingSeat(String studentnum, String bookdate, String seatnum, String period) {
		
		Connection conn = ConnectDB.getConnectionGroupSeat();
		try{
		
			String sql = "delete from reason_table where studentnum = ? and bookdate = ? and seat_period = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, studentnum);
			ps.setInt(2, Integer.parseInt(bookdate));
			ps.setString(3, seatnum + "_" + period);
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
	public int delReservedSeat(String studentnum, String bookdate, String seatnum, String period) {
		Connection conn = ConnectDB.getConnectionGroupSeat();
		try{
		
			String sql = "update group_seat_table_"+ bookdate + " set period" + period + " = ? , ownerPeriod" + period + " = ? where seatnum = ? and ownerPeriod" + period + " = ? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, 0);
			ps.setString(2, null);
			ps.setInt(3, Integer.parseInt(seatnum));
			ps.setString(4, studentnum);
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
	public ArrayList<String> getAllGroupInfo() {
		ArrayList<String> res = new ArrayList<String>();
		
		Connection conn = ConnectDB.getConnectionGroupSeat();
		try{
		
			String sql = "select * from reason_table";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next())
			{
				String tmp = rs.getInt("flag") + "";
				tmp += "##studentnum_" + rs.getString("studentnum");
				tmp += "##bookdate_" + rs.getInt("bookdate") ;
				tmp += "##seat_" + rs.getString("seat_period").split("_")[0];
				tmp += "##period_" + rs.getString("seat_period").split("_")[1];
				tmp += "##reason_" + rs.getString("reason");
				res.add(tmp);
			}
			rs.close();
			ps.close();	
			
		}catch (Exception e)
		{
			e.printStackTrace();
			return null;
		}
		
		ConnectDB.closeConnection(conn);
		return res;
	}
	public int proveGroup(String studentnum, String bookdate, String seat, String period) {
		Connection conn = ConnectDB.getConnectionGroupSeat();
		try{
		
			String sql = "update group_seat_table_"+ bookdate + " set period"+period+ " = 1 , ownerPeriod"+period+" = ? where seatnum = ? and period"+period +" = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1 , studentnum);
			ps.setString(2, seat);
			ps.setInt(3 , 0);
			if (ps.executeUpdate() == 0)
			{
				ps.close();	
				return -4;
			}
			else
			{
				sql = "update reason_table set flag = 1 where studentnum = ? and bookdate = ? and seat_period = ? and flag = 0";
				ps = conn.prepareStatement(sql);
				ps.setString(1, studentnum);
				ps.setInt(2 , Integer.parseInt(bookdate));
				ps.setString(3, seat+"_" + period);
				if (ps.executeUpdate() == 0)
				{
					ps.close();	
					return -2;
				}
				sql = "update reason_table set flag = -1 where bookdate = ? and seat_period = ? and flag = ?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1 , Integer.parseInt(bookdate));
				ps.setString(2, seat+"_" + period);
				ps.setInt(3 , 0);
				ps.executeUpdate();
				ps.close();
			}
			
		}catch (Exception e)
		{
			e.printStackTrace();
			return -1;
		}
		
		ConnectDB.closeConnection(conn);
		return 0;
	}
	public int adminDelGroup(String studentnum, String bookdate, String seat, String period) {
		Connection conn = ConnectDB.getConnectionGroupSeat();
		try{
		
			String sql = "update group_seat_table_"+ bookdate + " set period"+period+ " = 0 , ownerPeriod"+period+" = ? where seatnum = ? and ownerPeriod"+period+" = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1 , null);
			ps.setString(2, seat);
			ps.setString(3 , studentnum);
			
			if (ps.executeUpdate() == 0)
			{
				ps.close();	
				return -4;
			}
			else
			{
				sql = "update reason_table set flag = -1 where studentnum = ? and bookdate = ? and seat_period = ? and flag = ?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, studentnum);
				ps.setInt(2 , Integer.parseInt(bookdate));
				ps.setString(3, seat+"_" + period);
				ps.setInt(4, 1);
				if (ps.executeUpdate() == 0)
				{
					ps.close();	
					return -2;
				}
				
			}
			
		}catch (Exception e)
		{
			e.printStackTrace();
			return -1;
		}
		
		ConnectDB.closeConnection(conn);
		return 0;
	}
	public int declineGroup(String studentnum, String bookdate, String seat, String period) {
		Connection conn = ConnectDB.getConnectionGroupSeat();
		try{
		
			String sql = "update reason_table set flag = -1 where studentnum = ? and bookdate = ? and seat_period = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, studentnum);
			ps.setInt(2 , Integer.parseInt(bookdate));
			ps.setString(3, seat+"_" + period);
			if (ps.executeUpdate() == 0)
			{
				ps.close();	
				return -2;
			}	
			
		}catch (Exception e)
		{
			e.printStackTrace();
			return -1;
		}
		
		ConnectDB.closeConnection(conn);
		return 0;
	}
	public int addGroup(String studentnum , String bookdate , String seat , String period)
	{
		Connection conn = ConnectDB.getConnectionGroupSeat();
		try{
		
			String sql = "update group_seat_table_"+ bookdate + " set period"+period+ " = 1 , ownerPeriod"+period+" = ? where seatnum = ? and period"+period +" != ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1 , studentnum);
			ps.setString(2, seat);
			ps.setInt(3 , 1);
			if (ps.executeUpdate() == 0)
			{
				ps.close();	
				return -4;
			}
			else
			{
				sql = "insert into reason_table values (? , ? , ? , ? , ?)";
				ps = conn.prepareStatement(sql);
				ps.setString(1, seat+"_"+period);
				ps.setString(2 , studentnum);
				ps.setInt(3, Integer.parseInt(bookdate));
				ps.setString(4 , "ADD BY ADMIN");
				ps.setInt(5, 1);
				if (ps.executeUpdate() == 0)
				{
					ps.close();	
					return -2;
				}
				sql = "update reason_table set flag = -1 where bookdate = ? and seat_period = ? and flag = ?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1 , Integer.parseInt(bookdate));
				ps.setString(2, seat+"_" + period);
				ps.setInt(3 , 0);
				ps.executeUpdate();
				ps.close();
			}
			
		}catch (Exception e)
		{
			e.printStackTrace();
			return -1;
		}
		
		ConnectDB.closeConnection(conn);
		return 0;
	}
	public int closeSeat(String day, String period, String seatType) {
		Connection conn = ConnectDB.getConnectionGroupSeat();
		try{
			PreparedStatement ps = null;
			String sql = "update group_seat_table_" + day + " set period" + period + " = ?, ownerPeriod" + period + " = ?";
			
			ps = conn.prepareStatement(sql);
			if (seatType.equals("0") || seatType.equals("1") || seatType.equals("2"))
			{
				ps.setInt(1, 3);
				ps.setString(2, null);
				ps.executeUpdate();
				
				
				sql = "update reason_table set flag = -1 where seat_period = ? and flag != -1 ";
				ps = conn.prepareStatement(sql);
				ps.setString(1, "0_" + period);
				ps.executeUpdate();
				sql = "update reason_table set flag = -1 where seat_period = ? and flag != -1 ";
				ps = conn.prepareStatement(sql);
				ps.setString(1, "1_" + period);
				ps.executeUpdate();
				sql = "update reason_table set flag = -1 where seat_period = ? and flag != -1 ";
				ps = conn.prepareStatement(sql);
				ps.setString(1, "2_" + period);
				ps.executeUpdate();
				sql = "update reason_table set flag = -1 where seat_period = ? and flag != -1 ";
				ps = conn.prepareStatement(sql);
				ps.setString(1, "3_" + period);
				ps.executeUpdate();
				sql = "update reason_table set flag = -1 where seat_period = ? and flag != -1 ";
				ps = conn.prepareStatement(sql);
				ps.setString(1, "4_" + period);
				ps.executeUpdate();
				
				ps.close();
				ConnectDB.closeConnection(conn);
				return 0;
			}
//			else if(seatType.equals("2"))
//			{
//				ps.close();
//				ConnectDB.closeConnection(conn);
//				return 2;
//			}
			else if(seatType.equals("3"))
			{
				ps.setInt(1, 0);
				ps.setString(2, null);
				ps.executeUpdate();
				ps.close();
				ConnectDB.closeConnection(conn);
				return 0;
			}
			
		}catch (Exception e)
		{
			e.printStackTrace();
			ConnectDB.closeConnection(conn);
			return -1;
		}
		return -1;
	}

}
