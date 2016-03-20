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
 * 更新数据库结构，直接初始化十年日期
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
	public static void createUserTable()
	{
		Connection conn = ConnectDB.getUserConnection();
		try{
		String sql = "create table if not exists user_table( studentnum varchar(20) ,name varchar(100) COLLATE utf8_unicode_ci NOT NULL , password varchar(30) , email varchar(30) default 'NULL' , userType int , UNIQUE (studentnum) )";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.executeUpdate();
		
		
//		sql = "insert into user_table values( 'admin' , '尼古拉斯·管理员', 'admin0' , 'ioe_thu@163.com' , 2  )";
//		ps = conn.prepareStatement(sql);
//		ps.executeUpdate();
		
//		sql = "insert into user_table values( '2015310580' , '尼古拉斯·测试员', '123' , 'caoyujieboy@163.com' , 0  )";
//		ps = conn.prepareStatement(sql);
//		ps.executeUpdate();
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
	public static void createSeatTable()
	{
		Connection conn = ConnectDB.getSeatConnection();
		try{
			Date d1 = new SimpleDateFormat("yyyy_MM_dd").parse("2016_03_20");//定义起始日期
			Date d2 = new SimpleDateFormat("yyyy_MM_dd").parse("2018_04_01");//定义结束日期
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
			Date d2 = new SimpleDateFormat("yyyy_MM_dd").parse("2018_04_01");//定义结束日期
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
	public static void getTenYear()
	{
		try{
			Date d1 = new SimpleDateFormat("yyyy-MM-dd").parse("2016-03-20");//定义起始日期
			Date d2 = new SimpleDateFormat("yyyy-MM-dd").parse("2026-04-01");//定义结束日期
			Calendar dd = Calendar.getInstance();//定义日期实例
			dd.setTime(d1);//设置日期起始时间
			while(dd.getTime().before(d2)){//判断是否到结束日期
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String str = sdf.format(dd.getTime());
			System.out.println(str);//输出日期结果
			dd.add(Calendar.DAY_OF_YEAR, 1);
			}
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
//		getTenYear();
//		createUserDB();
//		createUserTable();
//		createSeatDB();
//		createSeatTable();
//		createGroupSeatDB();
//		createGroupSeatTable();
	}

}
