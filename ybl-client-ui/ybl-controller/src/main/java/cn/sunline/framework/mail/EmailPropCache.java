package cn.sunline.framework.mail;

import java.io.IOException;
import java.io.InputStream;
import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import com.bpm.framework.cache.redis.RedisCache;
import com.bpm.framework.utils.CollectionUtils;

/**
 * 
 * 
 * @author lixx
 * @since 1.0
 */
public class EmailPropCache implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 722459658319065495L;

	
	
	/*private static Map<String, String> oMap = null;*/
	
	/*private static final String BASE_KEY = "redis_key_";
	private static final String REDIS_KEY = BASE_KEY + EmailPropCache.class.getName();*/
	
	private static Properties prop = readFile();
	
	private final static EmailPropCache instance = init();
	
	private EmailPropCache() {}

	public static EmailPropCache getInstance() {
		return instance;
	}

	private static EmailPropCache init() {
		return new EmailPropCache();
	}
	
	private static Properties readFile() {
		InputStream is = null;
		try {
			Properties p = new Properties();
			is = EmailPropCache.class.getResourceAsStream("/email.properties");
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
