package com.bpm.framework.utils.date;

import java.util.GregorianCalendar;

import junit.framework.TestCase;

public class CalendarUtilsTest extends TestCase {

	public void testNow() {
		try{
			CalendarUtils.now(Long.class);
			fail("Should have thrown IllegalArgumentException");
		}catch(IllegalArgumentException expected){
		}
	}

	public void testToCalendar() {

		String time = "2004-12-02 12:22:33";
		String time1 = "2004-12-02";
		String pattern = CalendarUtils.YEAR_MONTH_DAY;

		GregorianCalendar gc = CalendarUtils.toCalendar(time);
		GregorianCalendar gc1 = CalendarUtils.toCalendar(time1, pattern);

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


	
	public void testGetDiffMillis(){
		
		GregorianCalendar gc = new GregorianCalendar(2004, 11, 2, 12, 22, 33);
		GregorianCalendar gc1 = new GregorianCalendar(2004, 11, 1, 12, 22, 33);
		
		long diff = CalendarUtils.getDiffMillis(gc,gc1);
		long diff1 = CalendarUtils.getDiffMillis(gc1,gc);
		
		assertEquals(diff,24*60*60*1000);
		assertEquals(-diff1,24*60*60*1000);
		
	}
	
	public void testGetDiffDays(){

		GregorianCalendar gc = new GregorianCalendar(2004, 11, 2, 12, 22, 33);
		GregorianCalendar gc1 = new GregorianCalendar(2004, 11, 3, 0, 22, 34);
		
		long diff = CalendarUtils.getDiffDays(gc,gc1);
		long diff1 = CalendarUtils.getDiffDays(gc1,gc);

		assertEquals(diff,-1);
		assertEquals(diff1,1);
	}
	
	public void testCompare(){
		GregorianCalendar gc = new GregorianCalendar(2004, 11, 2, 12, 22, 33);
		GregorianCalendar gc1 = new GregorianCalendar(2004, 11, 12, 10, 22, 34);
		GregorianCalendar gc2 = new GregorianCalendar(2004, 11, 12, 10, 22, 34);
		
		assertEquals(CalendarUtils.compare(gc,gc1),-1);
		assertEquals(CalendarUtils.compare(gc1,gc),1);
		assertEquals(CalendarUtils.compare(gc1,gc2),0);
		
	}
	
	public void testToString(){
		
		GregorianCalendar gc = new GregorianCalendar(2004, 11, 2, 12, 22, 33);
		
		String pattern = CalendarUtils.YEAR_MONTH_DAY;
		
		assertEquals(CalendarUtils.toString(gc),"2004-12-02 12:22:33");
		assertEquals(CalendarUtils.toString(gc,pattern),"2004-12-02");
	}
	
	
	public void testCalculator(){
		
		GregorianCalendar gc = new GregorianCalendar(2004, 11, 2, 12, 22, 33);
		GregorianCalendar now = new GregorianCalendar(); 
		GregorianCalendar gc1 = CalendarUtils.calculator(1);
		
		assertEquals(CalendarUtils.getDiffDays(gc1, now),1);

		gc1 = CalendarUtils.calculator(-2);
		
		assertEquals(CalendarUtils.getDiffDays(gc1, now),-2);
		
		gc1 = CalendarUtils.calculator(gc,1);
		
		assertEquals(2004, gc1.get(GregorianCalendar.YEAR));
		assertEquals(12, gc1.get(GregorianCalendar.MONTH) + 1);
		assertEquals(03, gc1.get(GregorianCalendar.DAY_OF_MONTH));
		
		
		
	}
}
