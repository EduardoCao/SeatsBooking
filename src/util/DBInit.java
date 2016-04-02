package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import dao.ConnectDB;

/**
 * 
 * @author Eduardo
 * 更新数据库结构，直接初始化两年日期
 *
 */

public class DBInit {
	
		
	public static void createUserDB()
	{
		Connection conn = ConnectDB.getConnection_root();
		
		try{
			
			String sql="create database if not exists userDB";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.executeUpdate();
			ps.close();
			
		}catch (Exception e)
		{
			e.printStackTrace();
		}
		ConnectDB.closeConnection(conn);
		return;
	}
	public static void createAnnouncementDB()
	{
		Connection conn = ConnectDB.getConnection_root();
		
		try{
			
			String sql="create database if not exists announcementDB";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.executeUpdate();
			ps.close();
			
		}catch (Exception e)
		{
			e.printStackTrace();
		}
		ConnectDB.closeConnection(conn);
		return;
	}
	public static void createCloseUser()
	{
		Connection conn = ConnectDB.getUserConnection();
		try{
			String sql = "create table if not exists close_user_table(studentnum varchar(20) , closetime varchar(12) , UNIQUE (studentnum) )";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.executeUpdate();
			ps.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		ConnectDB.closeConnection(conn);
		return;
	}
	public static void createAnnouncement()
	{
		Connection conn = ConnectDB.getAnnouncementConnection();
		try{
			String sql = "create table if not exists announcement_table(announcement varchar(1000) COLLATE utf8_unicode_ci NOT NULL , pubtime varchar(12)) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.executeUpdate();
			
			sql = "insert into announcement_table values('欢迎大家使用教研院教室预订系统' , '2016_03_29')";
			ps = conn.prepareStatement(sql);
			ps.executeUpdate();
			
			sql = "insert into announcement_table values('再次欢迎大家使用教研院教室预订系统' , '2016_03_28')";
			ps = conn.prepareStatement(sql);
			ps.executeUpdate();
			
			sql = "insert into announcement_table values('热烈欢迎大家使用教研院教室预订系统' , '2016_03_30')";
			ps = conn.prepareStatement(sql);
			ps.executeUpdate();
			
			ps.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		ConnectDB.closeConnection(conn);
		return;
	}
	public static void createUserTable()
	{
		Connection conn = ConnectDB.getUserConnection();
		try{
			
			String sql = "drop table if exists user_table";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.executeUpdate();	
			
		sql = "create table if not exists user_table( studentnum varchar(20) ,name varchar(100) COLLATE utf8_unicode_ci NOT NULL , password varchar(30) , email varchar(30) default 'NULL' , userType int , UNIQUE (studentnum) )ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci";
		ps = conn.prepareStatement(sql);
		ps.executeUpdate();
		
		
		sql = "insert into user_table values( 'admin' , '尼古拉斯管理员', 'admin0' , 'ioe_thu@163.com' , 2  )";
		ps = conn.prepareStatement(sql);
		ps.executeUpdate();
		
		sql = "insert into user_table values( '2015310580' , '尼古拉斯测试员', '123' , 'caoyujieboy@163.com' , 0  )";
		ps = conn.prepareStatement(sql);
		ps.executeUpdate();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		ConnectDB.closeConnection(conn);
		return;
	}
	public static void createSeatDB()
	{
		Connection conn = ConnectDB.getConnection_root();
		
		try{
			
			String sql="create database if not exists seatDB";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.executeUpdate();
			ps.close();
			
		}catch (Exception e)
		{
			e.printStackTrace();
		}
		ConnectDB.closeConnection(conn);
		return;
	}
	public static void createReasonTable()
	{
		Connection conn = ConnectDB.getGroupSeatConnection();
		try{
				String sql = "drop table if exists reason_table";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.executeUpdate();
				sql = "create table if not exists reason_table (seat varchar(2) , period varchar(2) ,  studentnum varchar(20) , bookdate varchar(12) , reason varchar(100) COLLATE utf8_unicode_ci NOT NULL, flag int) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci";
				ps = conn.prepareStatement(sql);
				ps.executeUpdate();

				ps.close();
		
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		ConnectDB.closeConnection(conn);
		return;
		
	}
	public static void createSeatTable()
	{
		Connection conn = ConnectDB.getSeatConnection();
		try{
			Date d1 = new SimpleDateFormat("yyyy_MM_dd").parse("2016_03_20");//定义起始日期
			Date d2 = new SimpleDateFormat("yyyy_MM_dd").parse("2021_04_01");//定义结束日期
			Calendar dd = Calendar.getInstance();//定义日期实例
			dd.setTime(d1);//设置日期起始时间
			while(dd.getTime().before(d2)){//判断是否到结束日期
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy_MM_dd");
				String date = sdf.format(dd.getTime());
				System.out.println(date);//输出日期结果
				String sql = "create table if not exists " + date +"( seatnum int , period0 int , period1 int , period2 int , period3 int , period4 int , ownerPeriod0 varchar(20) , ownerPeriod1 varchar(20) ,ownerPeriod2 varchar(20) ,ownerPeriod3 varchar(20) ,ownerPeriod4 varchar(20))";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.executeUpdate();
				for (int i = 0 ; i < 12 ; i ++)
				{
					sql = "insert into " + date + " values('" + i + "', 0 , 0,  0 , 0, 0 , NULL , NULL , NULL , NULL , NULL )";
					ps = conn.prepareStatement(sql);
					ps.executeUpdate();
				}
				dd.add(Calendar.DAY_OF_YEAR, 1);
				ps.close();
			}
		
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		ConnectDB.closeConnection(conn);
		return;
	}
	
	public static void createGroupSeatDB()
	{
		Connection conn = ConnectDB.getConnection_root();
		
		try{
			
			String sql="create database if not exists groupSeatDB";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.executeUpdate();
			ps.close();
			
		}catch (Exception e)
		{
			e.printStackTrace();
		}
		ConnectDB.closeConnection(conn);
		return;
	}
	public static void createGroupSeatTable()
	{
		Connection conn = ConnectDB.getGroupSeatConnection();
		try{
			Date d1 = new SimpleDateFormat("yyyy_MM_dd").parse("2016_03_20");//定义起始日期
			Date d2 = new SimpleDateFormat("yyyy_MM_dd").parse("2021_04_01");//定义结束日期
			Calendar dd = Calendar.getInstance();//定义日期实例
			dd.setTime(d1);//设置日期起始时间
			while(dd.getTime().before(d2)){//判断是否到结束日期
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy_MM_dd");
				String date = sdf.format(dd.getTime());
				System.out.println(date);//输出日期结果
				String sql = "create table if not exists " + date +"( seatnum int , period0 int , period1 int , period2 int , period3 int , period4 int , ownerPeriod0 varchar(20) , ownerPeriod1 varchar(20) ,ownerPeriod2 varchar(20) ,ownerPeriod3 varchar(20) ,ownerPeriod4 varchar(20))";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.executeUpdate();
				for (int i = 0 ; i < 2 ; i ++)
				{
					sql = "insert into " + date + " values('" + i + "', 0 , 0,  0 , 0, 0 , NULL , NULL , NULL , NULL , NULL )";
					ps = conn.prepareStatement(sql);
					ps.executeUpdate();
				}
				dd.add(Calendar.DAY_OF_YEAR, 1);
				ps.close();
			}
		
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		ConnectDB.closeConnection(conn);
		return;
	}
	public static void createReasonTableUpdate()
	{
		Connection conn = ConnectDB.getGroupSeatConnection();
		try{
				String sql = "create event if not exists cleanReason on schedule every 1 day starts '2016-03-21 00:00:00' do delete from reason_table where flag = -1 ;";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.executeUpdate();
				ps.close();
		
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		ConnectDB.closeConnection(conn);
		return;
		
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
//		createUserDB();
//		createUserTable();
//		createCloseUser();
//		createSeatDB();
//		createSeatTable();
//		createGroupSeatDB();
//		createGroupSeatTable();
//		createReasonTable();
//		createReasonTableUpdate();
//		createAnnouncementDB();
//		createAnnouncement();
	}

}
