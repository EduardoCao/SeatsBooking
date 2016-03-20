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
		Seats[] seats = new Seats[12];
		Connection conn = ConnectDB.getSeatConnection();
		try{
		for (int i = 0 ; i < 12 ; i ++)
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
	public String bookSeat(String owner , String bookdate , String bookseat)
	{
		if (bookseat != null)
		{
		String seatnum = bookseat.split("_")[0];
		String period = bookseat.split("_")[1];
		Connection conn = ConnectDB.getSeatConnection();
		try{
			
			String sql = "select * from " + bookdate + " where seatnum = ?";
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
				return "不能太贪心哦，不能预定超过三天的座位哦~ Cannot book more than 3 days!";
			}
			if(check.containsKey(bookdate) && check.get(bookdate).size() == 2)
			{
				rs.close();
				ps.close();
				return "不能太贪心哦，同一天最多只能预定两个时间段哦~ Cannot book more than 2 period in a day!";
			}
			if (check.containsKey(bookdate) && check.get(bookdate).contains(period))
			{
				rs.close();
				ps.close();
				return "一天内同一个时间段只能预定一个哦~ Cannot book two same periods in a day!";
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
				return "这个座位刚刚被人抢了呢 :( Error.";
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
		else
		{
			return "这个座位刚刚被人抢了呢 :( Book seat error";
		}
	}
	public String bookSeatbyAdmin(String owner , String bookdate , String bookseat , int periodori)
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
			return "亲，最多为他预定三天的座位哦~ Cannot book more than 3 days!";
			}
			if(check.containsKey(bookdate) && check.get(bookdate).size() == 2)
			{
				rs.close();
				ps.close();
				return "亲，一天之内最多预定两个时间段哦~ Cannot book more than 2 period in a day!";
			}
			if (check.containsKey(bookdate) && check.get(bookdate).contains(period))
			{
				rs.close();
				ps.close();
				return "同一时间段只能预定一个哦~ Cannot book two same periods in a day!";
			}
		
				sql = "update seat_table_" + bookdate + " set period" + period + " = ? , ownerPeriod" + period + "= ? where seatnum = ? and period" + period + " != ? and period" + period + " != ?";
				ps = conn.prepareStatement(sql);
				if(periodori == 0)
					ps.setInt(1, 1);
				else if(periodori == 2)
					ps.setInt(1, 2);
				ps.setString(2, owner);
				ps.setInt(3, Integer.parseInt(seatnum));
				ps.setInt(4, 3);
				ps.setInt(5, 1);
				//ps.executeUpdate();
				if (ps.executeUpdate() == 0)
				{
					ps.close();	
					return "亲，这个座位刚刚被人抢了哦~ This seat is taken.";
				}
			rs.close();
			ps.close();
			
			
		}catch (Exception e)
		{
			e.printStackTrace();
			return ":( 重新试一试吧！Error.";
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
				if (seats.getOwnerPeroid0() != null && seats.getOwnerPeroid0().equals(owner) && seats.getPeroid0() == 1)
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
				if (seats.getOwnerPeroid1() != null && seats.getOwnerPeroid1().equals(owner) && seats.getPeroid1() == 1)
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
				if (seats.getOwnerPeroid2() != null && seats.getOwnerPeroid2().equals(owner) && seats.getPeroid2() == 1)
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
				if (seats.getOwnerPeroid3() != null && seats.getOwnerPeroid3().equals(owner) && seats.getPeroid3() == 1)
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
				if (seats.getOwnerPeroid4() != null && seats.getOwnerPeroid4().equals(owner) && seats.getPeroid4() == 1)
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
	public ArrayList<String> getSeatAccess() {
		ArrayList<String> result = new ArrayList<String>();
		
		Connection conn = ConnectDB.getConnectionSeat();
		try{
			PreparedStatement ps = null;
			ResultSet rs = null ;
			for (int i = 0 ; i < 7 ; i ++)
			{
				String sql = "select * from seat_table_" + i + " where seatnum = ?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, 0);
				rs = ps.executeQuery();
				if(rs.next())
				{
					for(int j = 0 ; j < 5 ; j ++)
					{
						int period = rs.getInt("period"+j);
						if (period == 0 || period == 1)
						{
							String tmp =  i + "_" + j +"_" + 0;
							result.add(tmp);
						}
						else if(period == 2)
						{
							String tmp =  i + "_" + j +"_" + 2;
							result.add(tmp);
						}
						else if(period == 3)
						{
							String tmp =  i + "_" + j +"_" + 3;
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
	public int closeSeat(String day, String period , String seatType) {
		// TODO Auto-generated method stub
		
		Connection conn = ConnectDB.getConnectionSeat();
		try{
			PreparedStatement ps = null;
			String sql = "update seat_table_" + day + " set period" + period + " = ?, ownerPeriod" + period + " = ?";
			
			ps = conn.prepareStatement(sql);
			if (seatType.equals("0") || seatType.equals("1") || seatType.equals("2"))
			{
				ps.setInt(1, 3);
				ps.setString(2, null);
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
	public boolean deleteSeat(String bookdate, int seatnum, int periodnum , int periodori) {
		// TODO Auto-generated method stub
		Connection conn = ConnectDB.getConnectionSeat();
		try{
			PreparedStatement ps = null;
			String sql = "update seat_table_" + bookdate + " set period" + periodnum + " = ? , ownerPeriod"+periodnum + " = ? where seatnum = ?";
			
			ps = conn.prepareStatement(sql);
			if (periodori == 0 || periodori == 1)
			{
				ps.setInt(1, 0);
				ps.setString(2, null);
				ps.setInt(3, seatnum);
				ps.executeUpdate();
				ps.close();
				ConnectDB.closeConnection(conn);
			}
			else if(periodori == 2)
			{
				ps.setInt(1, 2);
				ps.setString(2, null);
				ps.setInt(3, seatnum);
				ps.executeUpdate();
				ps.close();
				ConnectDB.closeConnection(conn);
			}
			else if(periodori == 3)
			{

				ps.close();
				ConnectDB.closeConnection(conn);
				return false;
			}
			else
			{
				return false;
			}
			
		}catch (Exception e)
		{
			e.printStackTrace();
			ConnectDB.closeConnection(conn);
			return false;
		}
		return true;
	}
	
	
}
