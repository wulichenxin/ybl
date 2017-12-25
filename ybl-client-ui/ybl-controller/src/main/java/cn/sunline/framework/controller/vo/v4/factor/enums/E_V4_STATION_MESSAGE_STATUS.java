package cn.sunline.framework.controller.vo.v4.factor.enums;
/**
 * 站内信状态
 * @author WIN
 *
 */
public enum E_V4_STATION_MESSAGE_STATUS {

	READ("已读",1),
	UNREAD("未读",2);
	
	String name;
	int status;
	
	E_V4_STATION_MESSAGE_STATUS(String name,int status){
		this.name = name;
		this.status = status;
	}
	
	public static String getName(int optype) {
		for (E_V4_STATION_MESSAGE_STATUS op : values()) {
			if (op.getStatus() == optype) {
				return op.name;
			}
		}
		return "";
	}
	
	public static E_V4_STATION_MESSAGE_STATUS get(int optype) {
		for (E_V4_STATION_MESSAGE_STATUS op : values()) {
			if (op.getStatus() == optype) {
				return op;
			}
		}
		return null;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
}
