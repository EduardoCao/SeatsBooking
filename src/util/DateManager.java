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
	
	public static void main(String args[]) {
		System.out.println(getFormatDate(2));
	}
}
