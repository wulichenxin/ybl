package cn.sunline.framework.controller.vo.common;
/**
 * 定义需要使用Redis缓存的Key值
 * @author jzx
 *
 */
public class RedisKeyConstant {

	public static String ADDRESS_PROVINCE = "ADDRESS_PROVINCE";	//省份集合key
	public static String ADDRESS_CITY = "ADDRESS_CITY";	//地市集合key
	public static String ADDRESS_AREA = "ADDRESS_AREA";	//区县集合key
	public static String MEMBER_OPERATE_PERMISSION = "MEMBER_OPERATE_PERMISSION";	//会员操作权限集合Key
	
	public static String REDIS_CONFIG = "REDIS_CONFIG_";	//基础数据类型前缀key
}