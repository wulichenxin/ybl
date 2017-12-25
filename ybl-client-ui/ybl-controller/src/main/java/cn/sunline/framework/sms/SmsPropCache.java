package cn.sunline.framework.sms;

import java.io.IOException;
import java.io.InputStream;
import java.io.Serializable;
import java.util.Properties;

/**
 * 
 * 
 * @author lixx
 * @since 1.0
 * @createDate 2016-08-18 18:59:00
 */
public class SmsPropCache implements Serializable {

	private static final long serialVersionUID = -8300017787244051698L;
	
	private static Properties prop = readFile();
	
	private final static SmsPropCache instance = init();
	
	private SmsPropCache() {}

	public static SmsPropCache getInstance() {
		return instance;
	}

	private static SmsPropCache init() {
		return new SmsPropCache();
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
			is = SmsPropCache.class.getResourceAsStream("/sms.properties");
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