package com.bpm.framework.utils.date;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Map;

import com.bpm.framework.utils.Assert;
import com.bpm.framework.utils.StringUtils;

public class DateUtils implements DateFormator {

	private DateUtils() {

	}

	public static Date now() {
		return new GregorianCalendar().getTime();
	}

	public static Date now(String pattern) {
		Date date = DateUtils.now();
		String str = DateUtils.toString(date, pattern);
		return DateUtils.toDate(str, pattern);
	}

	public static Date toDate(String time, String pattern) {
		Assert.notNull(time);
		Assert.notNull(pattern);
		return CalendarUtils.toCalendar(time, pattern).getTime();
	}

	/**
	 * 提供从String类型到Date类型的类型转化，目前自动支持 "yyyy-MM-dd"、"yyyy-MM"、 "yyyy-MM-dd
	 * HH:mm:ss"、"MM-dd"等4种日期格式的自动转化
	 * 
	 * @param time
	 * @return
	 */
	public static Date toDate(String time) {
		Assert.notNull(time);
		for (String key : defaultDateFormatMap.keySet()) {
			if (isDateFormat(time, key)) {
				return DateUtils.toDate(time, defaultDateFormatMap.get(key));
			}
		}
		throw new RuntimeException("just support format : "
				+ StringUtils.collectionToDelimitedString(defaultDateFormatMap
						.values(), ",") + " - " + time);
	}

	public static String toString(Date date, String pattern) {
		Assert.notNull(date);
		Assert.notNull(pattern);
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
		return sdf.format(date);
	}

	public static String toString(Date date) {
		Assert.notNull(date);
		return toString(date, YEAR_MONTH_DAY_HH_MM_SS);
	}

	/**
	 * 比较两个 Date 对象表示的时间值（从历元至现在的毫秒偏移量）。
	 * 
	 * @param d1
	 * @param d2
	 * @return 如果 d1 表示的时间等于 d2 表示的时间，则返回 0 值；如果此 d1 的时间在d2表示的时间之前，则返回小于 0 的值；如果
	 *         d1 的时间在 d2 表示的时间之后，则返回大于 0 的值。
	 * 
	 */
	public static int compare(Date d1, Date d2) {
		Assert.notNull(d1);
		Assert.notNull(d2);

		Calendar c1 = new GregorianCalendar();
		Calendar c2 = new GregorianCalendar();
		c1.setTime(d1);
		c2.setTime(d2);

		return c1.compareTo(c2);
	}

	/**
	 * 比较两个 Date 对象表示的日期值（仅仅比较日期,忽略时分秒）。 -wuwm
	 * 
	 * @param d1
	 * @param d2
	 * @return 如果 d1 表示的日期等于 d2 表示的日期，则返回 0 值；如果此 d1 的日期在d2表示的日期之前，则返回小于 0 的值；如果
	 *         d1 的日期在 d2 表示的日期之后，则返回大于 0 的值。
	 * 
	 */
	public static int compareDate(Date d1, Date d2) {
		Assert.notNull(d1);
		Assert.notNull(d2);

		d1 = DateUtils.toDate(DateUtils.toString(d1, DateUtils.YEAR_MONTH_DAY),
				DateUtils.YEAR_MONTH_DAY);
		d2 = DateUtils.toDate(DateUtils.toString(d2, DateUtils.YEAR_MONTH_DAY),
				DateUtils.YEAR_MONTH_DAY);
		Calendar c1 = new GregorianCalendar();
		Calendar c2 = new GregorianCalendar();
		c1.setTime(d1);
		c2.setTime(d2);

		return c1.compareTo(c2);
	}

	/**
	 * 根据年月获取一个月的开始时间（第一天的凌晨）
	 * 
	 * @param year
	 * @param month
	 * @return
	 */
	public static Date beginTimeOfMonth(int year, int month) {
		Calendar first = new GregorianCalendar(year, month - 1, 1, 0, 0, 0);
		return first.getTime();
	}

	/**
	 * 根据年月获取一个月的结束时间（最后一天的最后一毫秒）
	 * 
	 * @param year
	 * @param month
	 * @return
	 */
	public static Date endTimeOfMonth(int year, int month) {
		Calendar first = new GregorianCalendar(year, month, 1, 0, 0, 0);
		first.add(Calendar.MILLISECOND, -1);
		return first.getTime();
	}

	/**
	 * 获取前preDays天的Date对象
	 * 
	 * @param date
	 * @param preDays
	 * @return
	 */
	public static Date preDays(Date date, int preDays) {
		GregorianCalendar c1 = new GregorianCalendar();
		c1.setTime(date);
		GregorianCalendar cloneCalendar = (GregorianCalendar) c1.clone();
		cloneCalendar.add(Calendar.DATE, -preDays);
		return cloneCalendar.getTime();
	}

	/**
	 * 获取后nextDays天的Date对象
	 * 
	 * @param date
	 * @param nextDays
	 * @return
	 */
	public static Date nextDays(Date date, int nextDays) {
		GregorianCalendar c1 = new GregorianCalendar();
		c1.setTime(date);
		GregorianCalendar cloneCalendar = (GregorianCalendar) c1.clone();
		cloneCalendar.add(Calendar.DATE, nextDays);
		return cloneCalendar.getTime();
	}

	public static Date nextMonths(Date date, int nextMonth) {
		GregorianCalendar c1 = new GregorianCalendar();
		c1.setTime(date);
		GregorianCalendar cloneCalendar = (GregorianCalendar) c1.clone();
		cloneCalendar.add(Calendar.MONTH, nextMonth);
		return cloneCalendar.getTime();
	}

	public static Date preMonths(Date date, int preMonth) {
		GregorianCalendar c1 = new GregorianCalendar();
		c1.setTime(date);
		GregorianCalendar cloneCalendar = (GregorianCalendar) c1.clone();
		cloneCalendar.add(Calendar.MONTH, -preMonth);
		return cloneCalendar.getTime();
	}

	public static long getDiffMillis(Date d1, Date d2) {
		Assert.notNull(d1);
		Assert.notNull(d2);

		long diff = d1.getTime() - d2.getTime();

		return diff;
	}

	/**
	 * 间隔天数
	 * 
	 * @param d1
	 * @param d2
	 * @return d1 - d2 实际天数,如果 d1 表示的时间等于 d2 表示的时间，则返回 0 值；如果此 d1
	 *         的时间在d2表示的时间之前，则返回小于 0 的值；如果 d1 的时间在 d2 表示的时间之后，则返回大于 0 的值。
	 */
	public static long dayDiff(Date d1, Date d2) {
		Assert.notNull(d1);
		Assert.notNull(d2);

		Calendar c1 = new GregorianCalendar();
		Calendar c2 = new GregorianCalendar();

		c1.setTime(d1);
		c2.setTime(d2);

		long diffDays = CalendarUtils.getDiffDays(c1, c2);

		return diffDays;
	}

	/**
	 * 获取间隔时间
	 * 
	 * @param d1
	 * @param d2
	 * @return HH:MM:SS,返回时间间隔的绝对值，没有负数
	 */
	public static String getDiffs(Date d1, Date d2) {
		long diffMillis = DateUtils.getDiffMillis(d1, d2);
		long diffHours = diffMillis / (60L * 60L * 1000L);
		long diffMinutes = diffMillis / (60L * 1000L) % 60;
		long diffSeconds = (diffMillis / 1000L) % 60;
		diffHours = Math.abs(diffHours);
		diffMinutes = Math.abs(diffMinutes);
		diffSeconds = Math.abs(diffSeconds);
		StringBuffer temp = new StringBuffer();
		temp.append(diffHours < 10 ? "0" + diffHours : diffHours);
		temp.append(":");
		temp.append(diffMinutes < 10 ? "0" + diffMinutes : diffMinutes);
		temp.append(":");
		temp.append(diffSeconds < 10 ? "0" + diffSeconds : diffSeconds);
		return temp.toString();
	}

	public static boolean isDateFormat(String date) {
		Assert.notNull(date);
		for (String key : defaultDateFormatMap.keySet()) {
			if (isDateFormat(date, key)) {
				return true;
			}
		}
		return false;
	}

	public static boolean isDateFormat(String date, String format) {
		Assert.notNull(date);
		return StringUtils.isDefinedPattern(date, format);
	}

	public static Date getNowDate() {
		Date now = new Date();
		return toDate(toString(now, YEAR_MONTH_DAY), YEAR_MONTH_DAY);
	}

	/**
	 * 根据日期返回日期中的年. wuwm
	 * 
	 * @param d
	 * @return int
	 */
	public static int getYear(Date d) {
		Assert.notNull(d);
		String dateStr = DateUtils.toString(d, DateUtils.YEAR_MONTH); // yyyy-MM
		return Integer.parseInt(dateStr.split(DateUtils.SPLIT_CHAR)[0]);
	}

	/**
	 * 根据日期返回日期中的年. wuwm
	 * 
	 * @param d
	 * @return int
	 */
	public static int getMonth(Date d) {
		Assert.notNull(d);
		String dateStr = DateUtils.toString(d, DateUtils.YEAR_MONTH); // yyyy-MM
		return Integer.parseInt(dateStr.split(DateUtils.SPLIT_CHAR)[1]);
	}

	/**
	 * 根据日期返回日期中的日. wuwm
	 * 
	 * @param d
	 * @return int
	 */
	public static int getDay(Date d) {
		Assert.notNull(d);
		String dateStr = DateUtils.toString(d, DateUtils.YEAR_MONTH_DAY); // yyyy-MM-dd
		return Integer.parseInt(dateStr.split(DateUtils.SPLIT_CHAR)[2]);
	}

	private static Map<String, String> defaultDateFormatMap = new HashMap<String, String>();
	static {
		defaultDateFormatMap.put("[0-9]{4}-[0-9]{1,2}-[0-9]{1,2}",
				DateUtils.YEAR_MONTH_DAY);
		defaultDateFormatMap
				.put("[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}", "yyyy/MM/dd");
		defaultDateFormatMap
				.put(
						"[0-9]{4}-[0-9]{1,2}-[0-9]{1,2} [0-9]{1,2}:[0-9]{1,2}:[0-9]{1,2}",
						DateUtils.YEAR_MONTH_DAY_HH_MM_SS);
		defaultDateFormatMap
				.put(
						"[0-9]{4}/[0-9]{1,2}/[0-9]{1,2} [0-9]{1,2}:[0-9]{1,2}:[0-9]{1,2}",
						"yyyy/MM/dd HH:mm:ss");
		defaultDateFormatMap.put("[0-9]{4}-[0-9]{1,2}", DateUtils.YEAR_MONTH);
		defaultDateFormatMap.put("[0-9]{4}/[0-9]{1,2}", "yyyy/MM");
		defaultDateFormatMap.put("[0-9]{4}-[0-9]{1,2}-[0-9]{1,2} [0-9]{1,2}:[0-9]{1,2}", "yyyy-MM-dd HH:mm");
	}
	
	/**
	 * 
	 * 判断两个日期是否是同年同月
	 * 
	 * @param d1
	 * @param d2
	 * @return
	 */
	public static boolean isSameYearMonth(Date d1, Date d2) {
		if(null == d1 || null == d2) return false;
		GregorianCalendar g1 = new GregorianCalendar();
		g1.setTime(d1);
		GregorianCalendar cloneCalendar = (GregorianCalendar) g1.clone();
		cloneCalendar.setTime(d2);
		if(g1.get(Calendar.YEAR) != cloneCalendar.get(Calendar.YEAR)) {
			return false;
		}
		if(g1.get(Calendar.MONTH) != cloneCalendar.get(Calendar.MONTH)) {
			return false;
		}
		return true;
	}



	/**
	 获取当前时间所在年的周数
	  */
	public static int getWeekOfYear(Date date) {
		Calendar c = new GregorianCalendar();
		c.setFirstDayOfWeek(Calendar.MONDAY);
		c.setMinimalDaysInFirstWeek(7);
		c.setTime(date);

		return c.get(Calendar.WEEK_OF_YEAR);
	}

	/**
	 获取当前时间所在年的最大周数
	  */
	public static int getMaxWeekNumOfYear(int year) {
		Calendar c = new GregorianCalendar();
		c.set(year, Calendar.DECEMBER, 31, 23, 59, 59);

		return getWeekOfYear(c.getTime());
	}

	/**
	 获取某年的第几周的开始日期
	  */
	public static Date getFirstDayOfWeek(int year, int week) {
		Calendar c = new GregorianCalendar();
		c.set(Calendar.YEAR, year);
		c.set(Calendar.MONTH, Calendar.JANUARY);
		c.set(Calendar.DATE, 1);

		Calendar cal = (GregorianCalendar) c.clone();
		cal.add(Calendar.DATE, week * 7);

		return getFirstDayOfWeek(cal.getTime());
	}

	/**
	 * 	获取某年的第几周的结束日期
 	 */

	public static Date getLastDayOfWeek(int year, int week) {
		Calendar c = new GregorianCalendar();
		c.set(Calendar.YEAR, year);
		c.set(Calendar.MONTH, Calendar.JANUARY);
		c.set(Calendar.DATE, 1);

		Calendar cal = (GregorianCalendar) c.clone();
		cal.add(Calendar.DATE, week * 7);

		return getLastDayOfWeek(cal.getTime());
	}

	/**
	 获取当前时间所在周的开始日期
	  */
	public static Date getFirstDayOfWeek(Date date) {
		Calendar c = new GregorianCalendar();
		c.setFirstDayOfWeek(Calendar.MONDAY);
		c.setTime(date);
		c.set(Calendar.DAY_OF_WEEK, c.getFirstDayOfWeek()); // Monday
		return c.getTime();
	}

	/**
	 * 获取当前时间所在周的结束日期
	 *
	 * @param date
	 * @return
	 */
	public static Date getLastDayOfWeek(Date date) {
		Calendar c = new GregorianCalendar();
		c.setFirstDayOfWeek(Calendar.MONDAY);
		c.setTime(date);
		c.set(Calendar.DAY_OF_WEEK, c.getFirstDayOfWeek() + 6); // Sunday
		return c.getTime();
	}

	/**
	 *  获取改时间是星期几
	 * @param date
	 * @return
	 */
	public static int getWeekByDate(Date date){
		return CalendarUtils.getWeekByDate(toString(date, YEAR_MONTH_DAY));
	}

	/**
	 * 设置时间的年份
	 * @param date
	 * @param year
	 */
	public static Date setYear(Date date,int year){
		// 新建Calendar对象
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.set(Calendar.YEAR, year);
		// 获取Calendar对应的Date
		date = cal.getTime();

		return date;
	}

	/**
	 * 设置时间的月份
	 * @param date
	 * @param month
	 */
	public static Date setMonth(Date date,int month){
		// 新建Calendar对象
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.set(Calendar.MONTH,month);
		// 获取Calendar对应的Date
		date = cal.getTime();
		return date;
	}

	/**
	 * 设置时间日期
	 * @param date
	 * @param day
	 */
	public static Date setDay(Date date,int day){
		// 新建Calendar对象
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.set(Calendar.DAY_OF_MONTH,day);
		// 获取Calendar对应的Date
		date = cal.getTime();
		return date;
	}

	/**
	 * 设置日期小时
	 * @param date
	 * @param hour
	 */
	public static Date setHour(Date date,int hour){
		// 新建Calendar对象
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.set(Calendar.HOUR_OF_DAY,hour);
		// 获取Calendar对应的Date
		date = cal.getTime();
		return date;
	}

	/**
	 * 设置日期分钟
	 * @param date
	 * @param minute
	 */
	public static Date setMinute(Date date,int minute){
		// 新建Calendar对象
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.set(Calendar.MINUTE,minute);
		// 获取Calendar对应的Date
		date = cal.getTime();
		return date;
	}


	/**
	 获取当前时间所在月的开始日期
	 */
	public static Date getFirstDayOfMonth(Date date) {
		Calendar ca = new GregorianCalendar();
		ca.setTime(date);
		ca.add(Calendar.MONTH, 0);
		ca.set(Calendar.DAY_OF_MONTH,1);//设置为1号,当前日期既为本月第一天
		return ca.getTime();
	}

	/**
	 * 获取当前时间所在月的结束日期
	 *
	 * @param date
	 * @return
	 */
	public static Date getLastDayOfMonth(Date date) {
		Calendar ca = new GregorianCalendar();
		ca.setTime(date);
		ca.set(Calendar.DAY_OF_MONTH, ca.getActualMaximum(Calendar.DAY_OF_MONTH));
		return ca.getTime();
	}
	
	 /**
    *
    * @param 要转换的毫秒数
    * @return 该毫秒数转换为 * days * hours * minutes * seconds 后的格式
    * @author fy.zhang
    */
   public static String formatDuring(long mss) {
       long days = mss / (1000 * 60 * 60 * 24);
       long hours = (mss % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60);
       long minutes = (mss % (1000 * 60 * 60)) / (1000 * 60);
       long seconds = (mss % (1000 * 60)) / 1000;
       return days + " days " + hours + " hours " + minutes + " minutes "
               + seconds + " seconds ";
   }
   /**
    *
    * @param begin 时间段的开始
    * @param end   时间段的结束
    * @return  输入的两个Date类型数据之间的时间间格用* days * hours * minutes * seconds的格式展示
    * @author fy.zhang
    */
   public static String formatDuring(Date begin, Date end) {
       return formatDuring(end.getTime() - begin.getTime());
   }

}
