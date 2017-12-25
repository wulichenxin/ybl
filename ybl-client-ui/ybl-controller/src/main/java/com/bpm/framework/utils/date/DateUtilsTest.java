package com.bpm.framework.utils.date;

import java.util.Date;
import java.util.GregorianCalendar;

import junit.framework.TestCase;

public class DateUtilsTest extends TestCase {

	public void testToDate() {

		String time = "2004-12-2 12:22:33";
		String time1 = "2004-12-2";
		String pattern = DateUtils.YEAR_MONTH_DAY;

		Date d = DateUtils.toDate(time);
		d = DateUtils.toDate("2004/12/2");
		d = DateUtils.toDate("2004/12/2 12:22:33");
		Date d1 = DateUtils.toDate(time1, pattern);

		GregorianCalendar gc = new GregorianCalendar();
		gc.setTime(d);
		GregorianCalendar gc1 = new GregorianCalendar();
		gc1.setTime(d1);

		assertEquals(2004, gc.get(GregorianCalendar.YEAR));
		assertEquals(12, gc.get(GregorianCalendar.MONTH) + 1);
		assertEquals(02, gc.get(GregorianCalendar.DAY_OF_MONTH));
		assertEquals(12, gc.get(GregorianCalendar.HOUR_OF_DAY));
		assertEquals(22, gc.get(GregorianCalendar.MINUTE));
		assertEquals(33, gc.get(GregorianCalendar.SECOND));

		assertEquals(2004, gc1.get(GregorianCalendar.YEAR));
		assertEquals(12, gc1.get(GregorianCalendar.MONTH) + 1);
		assertEquals(02, gc1.get(GregorianCalendar.DAY_OF_MONTH));
		assertEquals(0, gc1.get(GregorianCalendar.HOUR_OF_DAY));
		assertEquals(0, gc1.get(GregorianCalendar.MINUTE));
		assertEquals(0, gc1.get(GregorianCalendar.SECOND));
	}

	public void testToString() {

		GregorianCalendar gc = new GregorianCalendar(2004, 11, 2, 12, 22, 33);
		Date date = gc.getTime();

		String time = "2004-12-02 12:22:33";
		String time1 = "2004-12-02";
		String pattern = CalendarUtils.YEAR_MONTH_DAY;

		String temp = DateUtils.toString(date);
		String temp1 = DateUtils.toString(date, pattern);

		assertEquals(time, temp);
		assertEquals(time1, temp1);

	}

	public void testCompare() {
		GregorianCalendar gc = new GregorianCalendar(2004, 11, 2, 12, 22, 33);
		GregorianCalendar gc1 = new GregorianCalendar(2004, 11, 12, 10, 22, 34);
		GregorianCalendar gc2 = new GregorianCalendar(2004, 11, 12, 10, 22, 34);

		Date d = gc.getTime();
		Date d1 = gc1.getTime();
		Date d2 = gc2.getTime();

		assertEquals(DateUtils.compare(d, d1), -1);
		assertEquals(DateUtils.compare(d1, d), 1);
		assertEquals(DateUtils.compare(d1, d2), 0);

	}

	@SuppressWarnings("deprecation")
	public void testTimeOfMonth() {

		Date begin = DateUtils.beginTimeOfMonth(2007, 1);
		Date end = DateUtils.endTimeOfMonth(2007, 1);

		assertEquals(1, begin.getMonth()+1);
		assertEquals(1, begin.getDate());
		assertEquals(0, begin.getSeconds());
		assertEquals(31, end.getDate());
		assertEquals(59, end.getSeconds());

	}
	
	public void testIsDateFormat(){
		Date d = DateUtils.toDate("201105131442235",
				DateUtils.yearMonthDayHHMMssSSS);
		System.out.println(DateUtils.toString(d,DateUtils.YEAR_MONTH_DAY_HH_MM_SS));
		
//		
//		this.assertTrue(DateUtils.isDateFormat("2009-10-10 10:10:10"));
//		this.assertTrue(DateUtils.isDateFormat("2009/10/10 10:10:10"));
//		this.assertTrue(DateUtils.isDateFormat("2009-10-10"));
//		this.assertTrue(DateUtils.isDateFormat("2009/10/10"));
//		this.assertTrue(DateUtils.isDateFormat("2009-10"));
//		this.assertTrue(DateUtils.isDateFormat("2009/10"));
	}
	
	public static void main(String[] args){
		Date d = DateUtils.toDate("201105131442235",
				DateUtils.yearMonthDayHHMMssSSS);
		System.out.println(DateUtils.toString(d,DateUtils.YEAR_MONTH_DAY_HH_MM_SS));
	}
}
