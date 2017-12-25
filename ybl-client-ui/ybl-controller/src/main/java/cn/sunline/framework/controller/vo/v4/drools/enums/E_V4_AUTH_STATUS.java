package cn.sunline.framework.controller.vo.v4.drools.enums;

/**
 * @author win7
 *
 */
public enum E_V4_AUTH_STATUS {
	AUDITING("审核中",1),
	AUDITSUCCESS("审核成功",2),
	AUDITFAIL("审核失败",3);
	
	String name;
	int status;
	
	E_V4_AUTH_STATUS(String name, int status) {
		this.name = name;
		this.status = status;
	}
	
	public static String getName(int optype) {
		for (E_V4_AUTH_STATUS op : values()) {
			if (op.getStatus() == optype) {
				return op.name;
			}
		}
		return "";
	}
	
	public static E_V4_AUTH_STATUS get(int optype) {
		for (E_V4_AUTH_STATUS op : values()) {
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
