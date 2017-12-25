package cn.sunline.framework.task;

import java.io.IOException;
import java.io.InputStream;
import java.io.Serializable;
import java.util.Properties;

public class SchedulePropCache implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1641799183061470187L;


	private final static SchedulePropCache instance = init();
	
	private static Properties prop = readFile();
	
	private SchedulePropCache() {}

	public static SchedulePropCache getInstance() {
		return instance;
	}

	private static SchedulePropCache init() {
		return new SchedulePropCache();
	}
	
	private static Properties readFile() {
		InputStream is = null;
		try {
//			ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
//			is = classLoader.getResourceAsStream("/application.properties");
//
//			if(is == null) {
//				is = Application.class.getClassLoader().getResourceAsStream("/application.properties");
//			}
			Properties p = new Properties();
			is = SchedulePropCache.class.getResourceAsStream("/schedule.properties");
			p.load(is);
			return p;
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		} finally {
			if(null != is) {
				try {
					is.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
				is = null;
			}
		}
	}

	public Properties getProp() {
		return prop;
	}
	
	public String getByKey(String key) {
		return prop.getProperty(key);
	}
}
