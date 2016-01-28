package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.Seats;
import util.User;

public class SeatDao {
	public Seats[] getSeats(String date)
	{
		Seats[] seats = new Seats[10];
		Connection conn = ConnectDB.getConnectionSeat();
		try{
		for (int i = 0 ; i < 10 ; i ++)
		{
			String sql = "select * from seat_table_" + date + " where seatnum = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, i);
			ResultSet rs = ps.executeQuery();
			if(rs.next())
			{
				seats[i] = new Seats();
				seats[i].setPeroid0(rs.getBoolean("period0"));
				seats[i].setPeroid1(rs.getBoolean("period1"));
				seats[i].setPeroid2(rs.getBoolean("period2"));
				seats[i].setPeroid3(rs.getBoolean("period3"));
				seats[i].setPeroid4(rs.getBoolean("period4"));
				
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
	public String bookSeat(String owner , String bookdate , String bookseat)
	{
		
		String seatnum = bookseat.split("_")[0];
		String period = bookseat.split("_")[1];
		Connection conn = ConnectDB.getConnectionSeat();
		try{
			
			String sql = "select * from seat_table_" + bookdate + " where seatnum = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, Integer.parseInt(seatnum));
			ResultSet rs = ps.executeQuery();
			Seats seats = new Seats();
			if(rs.next())
			{
				seats.setPeroid0(rs.getBoolean("period0"));
				seats.setPeroid1(rs.getBoolean("period1"));
				seats.setPeroid2(rs.getBoolean("period2"));
				seats.setPeroid3(rs.getBoolean("period3"));
				seats.setPeroid4(rs.getBoolean("period4"));
			}
			if ((period.equals("0") && !seats.getPeroid0())||(period.equals("1") && !seats.getPeroid1())||(period.equals("2") && !seats.getPeroid2())||(period.equals("3") && !seats.getPeroid3())||(period.equals("4") && !seats.getPeroid4()))
			{
				sql = "update seat_table_" + bookdate + " set period" + period + " = ? , ownerPeriod" + period + "= ? where seatnum = ?";
				ps = conn.prepareStatement(sql);
				ps.setBoolean(1, true);
				ps.setString(2, owner);
				ps.setInt(3, Integer.parseInt(seatnum));
				ps.executeUpdate();
				
			}
			else
			{
				return null;
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
		return owner;
	}
	public ArrayList<String> getOnesSeats(String user)
	{
		ArrayList<String> result = new ArrayList<String>();
		Connection conn = ConnectDB.getConnectionSeat();
		try{
			PreparedStatement ps = null;
			ResultSet rs = null ;
			for (int i = 0 ; i < 7 ; i ++)
			{
				for (int j = 0 ; j < 5 ; j ++)
				{
					String sql = "select * from seat_table_" + i + " where ownerPeriod" + j + " = ?";
					ps = conn.prepareStatement(sql);
					ps.setString(1, user);
					rs = ps.executeQuery();
					while(rs.next())
					{
						String seatStr = rs.getString("seatnum");
						String tmp = "Day" + i + " seatnum" + seatStr + " peroid" + j;
						result.add(tmp);
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
