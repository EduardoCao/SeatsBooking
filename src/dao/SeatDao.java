package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.Seats;

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
				seats[i].setPeroid0(rs.getInt("period0"));
				seats[i].setPeroid1(rs.getInt("period1"));
				seats[i].setPeroid2(rs.getInt("period2"));
				seats[i].setPeroid3(rs.getInt("period3"));
				seats[i].setPeroid4(rs.getInt("period4"));
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
				seats.setPeroid0(rs.getInt("period0"));
				seats.setPeroid1(rs.getInt("period1"));
				seats.setPeroid2(rs.getInt("period2"));
				seats.setPeroid3(rs.getInt("period3"));
				seats.setPeroid4(rs.getInt("period4"));
			}
			ArrayList<String> onesseats = getOnesSeats(owner);
			HashMap<String , ArrayList<String>> check = new HashMap< String , ArrayList<String>>();
			for (int i = 0 ; i < onesseats.size() ; i ++)
			{
				String cur = onesseats.get(i);
				String checkday = cur.trim().split(" ")[0].substring(3);
				String checkperiod = cur.trim().split(" ")[2].substring(6);
				if(check.containsKey(checkday))
				{
					ArrayList<String> tmp = check.get(checkday);
					tmp.add(checkperiod);
					check.put(checkday, tmp);
				}
				else
				{
					ArrayList<String> tmp = new ArrayList<String>();
					tmp.add(checkperiod);
					check.put(checkday, tmp);
				}
			}
			if(!check.containsKey(bookdate) && check.size() == 3)
			{
				rs.close();
				ps.close();
				return "Cannot book more than 3 days!";
			}
			if (check.containsKey(bookdate) && check.get(bookdate).contains(period))
			{
				rs.close();
				ps.close();
				return "Cannot book two same periods in a day!";
			}
			if ((period.equals("0") && seats.getPeroid0() == 0)||(period.equals("1") && seats.getPeroid1() == 0)||(period.equals("2") && seats.getPeroid2() == 0)||(period.equals("3") && seats.getPeroid3() == 0)||(period.equals("4") && seats.getPeroid4() == 0))
			{
				sql = "update seat_table_" + bookdate + " set period" + period + " = ? , ownerPeriod" + period + "= ? where seatnum = ?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, 1);
				ps.setString(2, owner);
				ps.setInt(3, Integer.parseInt(seatnum));
				ps.executeUpdate();
				
			}
			else
			{
				rs.close();
				ps.close();
				return "Error";
			}
			rs.close();
			ps.close();
			
			
		}catch (Exception e)
		{
			e.printStackTrace();
			return "Error";
		}finally
		{
			ConnectDB.closeConnection(conn);
		}
		return "Success";
	}
	public boolean deleteSeat(String owner , String bookdate , String seatnum , String period)
	{
		
		Connection conn = ConnectDB.getConnectionSeat();
		try{
			
			String sql = "select * from seat_table_" + bookdate + " where seatnum = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, Integer.parseInt(seatnum));
			ResultSet rs = ps.executeQuery();
			Seats seats = new Seats();
			if(rs.next())
			{
				seats.setPeroid0(rs.getInt("period0"));
				seats.setPeroid1(rs.getInt("period1"));
				seats.setPeroid2(rs.getInt("period2"));
				seats.setPeroid3(rs.getInt("period3"));
				seats.setPeroid4(rs.getInt("period4"));
				seats.setOwnerPeroid0(rs.getString("ownerPeriod0"));
				seats.setOwnerPeroid1(rs.getString("ownerPeriod1"));
				seats.setOwnerPeroid2(rs.getString("ownerPeriod2"));
				seats.setOwnerPeroid3(rs.getString("ownerPeriod3"));
				seats.setOwnerPeroid4(rs.getString("ownerPeriod4"));
			}
			if (period.equals("0"))
			{
				if (seats.getOwnerPeroid0().equals(owner) && seats.getPeroid0() == 1)
				{
					sql = "update seat_table_" + bookdate + " set period0" + " = ? , ownerPeriod0" + "= ? where seatnum = ?";
					ps = conn.prepareStatement(sql);
					ps.setInt(1, 0);
					ps.setString(2, null);
					ps.setInt(3, Integer.parseInt(seatnum));
					ps.executeUpdate();
				}
				else
				{
					return false;
				}
			}
			else if(period.equals("1"))
			{
				if (seats.getOwnerPeroid1().equals(owner) && seats.getPeroid1() == 1)
				{
					sql = "update seat_table_" + bookdate + " set period1" + " = ? , ownerPeriod1" + "= ? where seatnum = ?";
					ps = conn.prepareStatement(sql);
					ps.setInt(1, 0);
					ps.setString(2, null);
					ps.setInt(3, Integer.parseInt(seatnum));
					ps.executeUpdate();
				}
				else
				{
					return false;
				}
			}
			else if(period.equals("2"))
			{
				if (seats.getOwnerPeroid2().equals(owner) && seats.getPeroid2() == 1)
				{
					sql = "update seat_table_" + bookdate + " set period2" + " = ? , ownerPeriod2" + "= ? where seatnum = ?";
					ps = conn.prepareStatement(sql);
					ps.setInt(1, 0);
					ps.setString(2, null);
					ps.setInt(3, Integer.parseInt(seatnum));
					ps.executeUpdate();

				}
				else
				{
					return false;
				}
			}else if(period.equals("3"))
			{
				if (seats.getOwnerPeroid3().equals(owner) && seats.getPeroid3() == 1)
				{
					sql = "update seat_table_" + bookdate + " set period3" + " = ? , ownerPeriod3" + "= ? where seatnum = ?";
					ps = conn.prepareStatement(sql);
					ps.setInt(1, 0);
					ps.setString(2, null);
					ps.setInt(3, Integer.parseInt(seatnum));
					ps.executeUpdate();

				}
				else
				{
					return false;
				}
			}else if(period.equals("4"))
			{
				if (seats.getOwnerPeroid4().equals(owner) && seats.getPeroid4() == 1)
				{
					sql = "update seat_table_" + bookdate + " set period4" + " = ? , ownerPeriod4" + "= ? where seatnum = ?";
					ps = conn.prepareStatement(sql);
					ps.setInt(1, 0);
					ps.setString(2, null);
					ps.setInt(3, Integer.parseInt(seatnum));
					ps.executeUpdate();

				}
				else
				{
					return false;
				}
			}
			else
			{
				return false;
			}
			rs.close();
			ps.close();
			
			
		}catch (Exception e)
		{
			e.printStackTrace();
			return false;
			
		}finally
		{
			ConnectDB.closeConnection(conn);	
		}
		return true;
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
