package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
			
			System.out.println(sql);
			
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setInt(1, i);
				System.out.println(ps.toString());
				ResultSet rs = ps.executeQuery();
//				int cnt = 0;
				if(rs.next())
				{
					System.out.println(rs.toString());
					seats[i] = new Seats();
					//user.setId(rs.getInt("id"));
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
}
