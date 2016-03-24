package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import util.DateManager;
import util.Seats;

public class GroupSeatDao {
	public Seats[] getGroupSeats(String date)
	{
		Seats[] seats = new Seats[2];
		Connection conn = ConnectDB.getGroupSeatConnection();
		try{
		for (int i = 0 ; i < 2 ; i ++)
		{
			String sql = "select * from " + date + " where seatnum = ?";
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
	public int reserveGroupSeat(String seat_period , String studentnum , String bookdate , String reason , int flag)
	{
		Connection conn = ConnectDB.getGroupSeatConnection();
		try{
				String seat = seat_period.split("_")[0];
				String period = seat_period.split("_")[1];
				String sql = "select * from reason_table where bookdate = ? and period = ? and seat = ? and flag = 1";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1, bookdate);
				ps.setString(2, period);
				ps.setString(3, seat);
				ResultSet rs = ps.executeQuery();
				if(rs.next())
				{
					return 3;
				}
				
				sql = "select * from reason_table where studentnum = ?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, studentnum);
				rs = ps.executeQuery();

				while (rs.next())
				{
					if(rs.getString("bookdate").equals(bookdate))
					{
						if(rs.getString("period").equals(period) && rs.getInt("flag") == 0)
						{
							ps.close();
							rs.close();
							ConnectDB.closeConnection(conn);
							return 1;
						}
						else if(rs.getString("period").equals(period) && rs.getInt("flag") == 1)
						{
							ps.close();
							rs.close();
							ConnectDB.closeConnection(conn);
							return 2;
						}
					}
				}
				rs.close();
				sql = "insert into reason_table values (? , ? , ? , ? , ? , ?)";
				ps = conn.prepareStatement(sql);
				ps.setString(1, seat);
				ps.setString(2, period);
				ps.setString(3, studentnum);
				ps.setString(4, bookdate);
				ps.setString(5, reason);
				ps.setInt(6, flag);
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
		Connection conn = ConnectDB.getGroupSeatConnection();
		try{
			for(int i = 0 ; i < 7 ; i ++)
			{
				for (int j = 0 ; j < 5 ; j ++)
				{
					if (i == 0)
					{
						if (j == 0 && DateManager.compareTime(DateManager.currentTime(),"10:00:00") > 0)
						{
							continue;
						}
						else if (j == 1 && DateManager.compareTime(DateManager.currentTime(),"12:00:00") > 0)
						{
							continue;
						}
						else if (j == 2 && DateManager.compareTime(DateManager.currentTime(),"15:00:00") > 0)
						{
							continue;
						}
						else if (j == 3 && DateManager.compareTime(DateManager.currentTime(),"17:00:00") > 0)
						{
							continue;
						}
						else if (j == 4 && DateManager.compareTime(DateManager.currentTime(),"21:00:00") > 0)
						{
							continue;
						}
					}
					String bookdate = DateManager.getFormatCompleteDate(i);
					String sql = "select * from reason_table where studentnum = ? and bookdate = ? and period = ?";
					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setString(1, studentnum);
					ps.setString( 2 , bookdate);
					ps.setString( 3 , j + "");
					ResultSet rs = ps.executeQuery();
					while (rs.next())
					{
						String tmp = "bookdate_" + rs.getString("bookdate");
						
						tmp += "##period_" + rs.getString("period");
						
						tmp += "##studentnum_" + rs.getString("studentnum");
						
						tmp += "##seat_" + rs.getString("seat");
						
						tmp += "##reason_" + rs.getString("reason");
						
						tmp += "##flag_" + rs.getInt("flag");
						 
						res.add(tmp);
					}
					
					rs.close();
					ps.close();
				}
			}
			
		}catch (Exception e)
		{
			e.printStackTrace();
			return null;
		}finally
		{
			ConnectDB.closeConnection(conn);
		}
		Collections.sort(res); 
		return res;
	}
	public int delBookingSeat(String studentnum, String bookdate, String seatnum, String period) {
		
		Connection conn = ConnectDB.getGroupSeatConnection();
		try{
		
			String sql = "delete from reason_table where studentnum = ? and bookdate = ? and seat = ? and period = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, studentnum);
			ps.setString(2, bookdate);
			ps.setString(3, seatnum );
			ps.setString(4, period);
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
		Connection conn = ConnectDB.getGroupSeatConnection();
		try{
		
			String sql = "update "+ bookdate + " set period" + period + " = ? , ownerPeriod" + period + " = ? where seatnum = ? and ownerPeriod" + period + " = ? ";
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
		
		Connection conn = ConnectDB.getGroupSeatConnection();
		try{
			
			String currentdate = DateManager.getFormatCompleteDate(0);
			
			String sql = "";
			
			sql = "select * from reason_table";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			HashSet<String> delDate = new HashSet<String>();
			while(rs.next())
			{
				String tmp = rs.getString("bookdate") ;
				if (DateManager.compareDate(currentdate , tmp ) > 0)
				{
					delDate.add(tmp);
				}
			}
			Iterator<String> iterator=delDate.iterator();
			while(iterator.hasNext()){
				sql = "delete from reason_table where bookdate = ?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, iterator.next());
				ps.executeUpdate();
			}
			
			sql = "select * from reason_table";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next())
			{
				if(rs.getString("bookdate").equals(DateManager.getFormatCompleteDate(0)))
				{
					int j = Integer.parseInt(rs.getString("period"));
					
					if (j == 0 && DateManager.compareTime(DateManager.currentTime(),"10:00:00") > 0)
					{
						continue;
					}
					else if (j == 1 && DateManager.compareTime(DateManager.currentTime(),"12:00:00") > 0)
					{
						continue;
					}
					else if (j == 2 && DateManager.compareTime(DateManager.currentTime(),"15:00:00") > 0)
					{
						continue;
					}
					else if (j == 3 && DateManager.compareTime(DateManager.currentTime(),"17:00:00") > 0)
					{
						continue;
					}
					else if (j == 4 && DateManager.compareTime(DateManager.currentTime(),"21:00:00") > 0)
					{
						continue;
					}
				}
				String tmp = "bookdate_" + rs.getString("bookdate") ;
				
				tmp += "##period_" + rs.getString("period");
				
				tmp += "##seat_" + rs.getString("seat");
				
				tmp += "##studentnum_" + rs.getString("studentnum");
				
				tmp += "##reason_" + rs.getString("reason");
				
				tmp += "##flag_" + rs.getInt("flag");

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
		Collections.sort(res); 
//		for (String s : res)
//		{
//			System.out.println(s);
//		}
		return res;
	}
	public int proveGroup(String studentnum, String bookdate, String seat, String period) {
		Connection conn = ConnectDB.getGroupSeatConnection();
		try{
		
			String sql = "update "+ bookdate + " set period"+period+ " = 1 , ownerPeriod"+period+" = ? where seatnum = ? and period"+period +" = ? ";
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
				sql = "update reason_table set flag = 1 where studentnum = ? and bookdate = ? and seat = ? and period = ? and flag = 0";
				ps = conn.prepareStatement(sql);
				ps.setString(1, studentnum);
				ps.setString(2 , bookdate);
				ps.setString(3, seat);
				ps.setString(4, period);
				if (ps.executeUpdate() == 0)
				{
					sql = "update "+ bookdate + " set period"+period+ " = 0 , ownerPeriod"+period+" = ? where seatnum = ?";
					ps = conn.prepareStatement(sql);
					ps.setString(1 , null);
					ps.setString(2, seat);
					ps.executeUpdate();
					ps.close();	
					return -2;
				}
				sql = "update reason_table set flag = -1 where bookdate = ? and seat = ? and period = ? and flag = ?";
				ps = conn.prepareStatement(sql);
				ps.setString(1 , bookdate);
				ps.setString(2, seat);
				ps.setString(3, period);
				ps.setInt(4 , 0);
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
		Connection conn = ConnectDB.getGroupSeatConnection();
		try{
		
			String sql = "update "+ bookdate + " set period"+period+ " = 0 , ownerPeriod"+period+" = ? where seatnum = ? and ownerPeriod"+period+" = ?";
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
				sql = "update reason_table set flag = -1 where studentnum = ? and bookdate = ? and seat = ? and period = ? and flag = ?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, studentnum);
				ps.setString(2 , bookdate);
				ps.setString(3, seat );
				ps.setString(4, period);
				ps.setInt(5 , 1);
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
		Connection conn = ConnectDB.getGroupSeatConnection();
		try{
		
			String sql = "update reason_table set flag = -1 where studentnum = ? and bookdate = ? and seat = ? and period = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, studentnum);
			ps.setString(2 , bookdate);
			ps.setString(3, seat);
			ps.setString(4, period);
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
		Connection conn = ConnectDB.getGroupSeatConnection();
		try{
			String sql = "select * from reason_table where studentnum = ? and period = ? and bookdate = ? and flag = 1";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, studentnum);
			ps.setString(2, period);
			ps.setString(3, bookdate);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
			{
				rs.close();
				ps.close();
				ConnectDB.closeConnection(conn);
				return -3;
			}
			
			
			sql = "update "+ bookdate + " set period"+period+ " = 1 , ownerPeriod"+period+" = ? where seatnum = ? and period"+period +" != ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1 , studentnum);
			ps.setString(2, seat);
			ps.setInt(3 , 1);
			if (ps.executeUpdate() == 0)
			{
				ps.close();	
				ConnectDB.closeConnection(conn);
				return -4;
			}
			else
			{
				sql = "insert into reason_table values (? ,?, ? , ? , ? , ?)";
				ps = conn.prepareStatement(sql);
				ps.setString(1, seat);
				ps.setString(2, period);
				ps.setString(3 , studentnum);
				ps.setString(4 , bookdate);
				ps.setString(5 , "ADD BY ADMIN");
				ps.setInt(6 , 1);
				if (ps.executeUpdate() == 0)
				{
					ps.close();	
					sql = "update "+ bookdate + " set period"+period+ " = 0 , ownerPeriod"+period+" = ? where seatnum = ? and period"+period +" = ?";
					ps = conn.prepareStatement(sql);
					ps.setString(1 , null);
					ps.setString(2, seat);
					ps.setInt(3 , 1);
					ps.executeUpdate();
					ps.close();	
					ConnectDB.closeConnection(conn);
					return -2;
				}
				sql = "update reason_table set flag = -1 where bookdate = ? and seat = ? and period = ?  and flag = ?";
				ps = conn.prepareStatement(sql);
				ps.setString(1 , bookdate);
				ps.setString(2, seat);
				ps.setString(3, period);
				ps.setInt(4 , 0);
				ps.executeUpdate();
				
				sql = "update reason_table set flag = -1 where bookdate = ? and studentnum = ? and period = ?  and flag = ?";
				ps = conn.prepareStatement(sql);
				ps.setString(1 , bookdate);
				ps.setString(2, studentnum);
				ps.setString(3, period);
				ps.setInt(4 , 0);
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
	public int closeSeat(String bookdate, String period, String seatType) {
		Connection conn = ConnectDB.getGroupSeatConnection();
		try{
			PreparedStatement ps = null;
			String sql = "update " + bookdate + " set period" + period + " = ?, ownerPeriod" + period + " = ?";
			
			ps = conn.prepareStatement(sql);
			if (seatType.equals("0") || seatType.equals("1") || seatType.equals("2"))
			{
				ps.setInt(1, 3);
				ps.setString(2, null);
				ps.executeUpdate();
				
				
				sql = "update reason_table set flag = -1 where period = ? and bookdate = ? and flag != -1 ";
				ps = conn.prepareStatement(sql);
				ps.setString(1, period);
				ps.setString(2, bookdate);
				ps.executeUpdate();
				
				ps.close();
				ConnectDB.closeConnection(conn);
				return 0;
			}
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
	
	public ArrayList<String> getGroupSeatAccess() {
		ArrayList<String> result = new ArrayList<String>();
		
		Connection conn = ConnectDB.getGroupSeatConnection();
		try{
			PreparedStatement ps = null;
			ResultSet rs = null ;
			for (int i = 0 ; i < 8 ; i ++)
			{
				String bookdate = DateManager.getFormatCompleteDate(i);
				String sql = "select * from " + bookdate + " where seatnum = ?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, 0);
				rs = ps.executeQuery();
				if(rs.next())
				{
					for(int j = 2 ; j < 4 ; j ++)
					{
						int period = rs.getInt("period"+j);
						if(period == 3)
						{
							String tmp =  bookdate + "#" + j +"#" + 3;
							result.add(tmp);
						}
						else if (i == 0 &&  DateManager.compareTime(DateManager.currentTime() , DateManager.getEndDDL(j)) > 0)
						{
							String tmp =  bookdate + "#" + j +"#" + 2;
							result.add(tmp);
						}
						else if (period == 0 || period == 1)
						{
							String tmp =  bookdate + "#" + j +"#" + 0;
							result.add(tmp);
						}
						 
					}
				}	
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
		return result;
	}

}
