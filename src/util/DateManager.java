package util;

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
	
	/**
	 * 返回时间段的形式化表达
	 * @param i 时间段编号
	 * @return
	 */
	public static String getPeroid(int i) {
		if (i == 0) {
			return "8:00-10:00";
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
	
	public static void main(String args[]) {
		System.out.println(getFormatDate(2));
	}
}
