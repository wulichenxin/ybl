package cn.sunline.framework.controller.vo.v4.drools.enums;

/**
 * @author win7
 *
 */
public enum E_V4_ISHOT {
	ISHOT("热门产品",1),
	NOTHOT("不是热门产品",2);
	
	String name;
	int status;
	
	E_V4_ISHOT(String name, int status) {
		this.name = name;
		this.status = status;
	}
	
	public static String getName(int optype) {
		for (E_V4_ISHOT op : values()) {
			if (op.getStatus() == optype) {
				return op.name;
			}
		}
		return "";
	}
	
	public static E_V4_ISHOT get(int optype) {
		for (E_V4_ISHOT op : values()) {
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
