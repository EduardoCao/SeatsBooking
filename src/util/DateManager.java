package util;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateManager {
	/**
	 * 返回格式化时间
	 * @param i 时间偏置，i=0表示今天，i=1表示明天，以此类推
	 * @return
	 */
	public static String getFormatDate(int i) {
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("MM月dd日");
		calendar.add(Calendar.DAY_OF_YEAR, i);
		Date date = calendar.getTime();
		return sdf.format(date);
	}
	
	public static String getFormatCompleteDate(int i) {
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy_MM_dd");
		calendar.add(Calendar.DAY_OF_YEAR, i);
		Date date = calendar.getTime();
		return sdf.format(date);
	}
	/**
	 * 返回时间段的形式化表达
	 * @param i 时间段编号
	 * @return
	 */
	public static String currentTime() { 
		SimpleDateFormat df = new SimpleDateFormat("HH:mm:ss");//设置日期格式
		return (df.format(new Date()));// new Date()为获取当前系统时间
		}

	public static String getPeroid(int i) {
		if (i == 0) {
			return "08:00-10:00";
		} else if (i == 1) {
			return "10:00-12:00";
		} else if (i == 2) {
			return "13:00-15:00";
		} else if (i==3) {
			return "15:00-17:00";
		} else if (i == 4) {
			return "19:00-21:00";
		}
		return "时间段";
	}
	public static String getDDL(int i) {
		if (i == 0) {
			return "07:00:00";
		} else if (i == 1) {
			return "09:00:00";
		} else if (i == 2) {
			return "12:00:00";
		} else if (i==3) {
			return "14:00:00";
		} else if (i == 4) {
			return "18:00:00";
		}
		return "时间段";
	}
	public static String getEndDDL(int i) {
		if (i == 0) {
			return "10:00:00";
		} else if (i == 1) {
			return "12:00:00";
		} else if (i == 2) {
			return "15:00:00";
		} else if (i==3) {
			return "17:00:00";
		} else if (i == 4) {
			return "21:00:00";
		}
		return "时间段";
	}
    public static int compareTime(String DATE1, String DATE2) {
        if (DATE1.compareTo(DATE2) > 0)
        	return 1;
        else
        	return -1;
        
    }
    public static int compareDate(String DATE1, String DATE2) {
        if (DATE1.compareTo(DATE2) > 0)
        	return 1;
        else if (DATE1.compareTo(DATE2) == 0)
        	return 0;
        else 
        	return -1;
        
    }
	public static void main(String args[]) {
		System.out.println(getFormatCompleteDate(0));
		System.out.println(currentTime());
		System.out.println(compareTime(currentTime(),"09:38:01"));
		System.out.println(compareDate(getFormatCompleteDate(0),"2016_03_21"));
		
	}
}
