package cn.sunline.framework.controller.vo.v4.factor.enums;

/**
 * 确权方式
 * @author pc
 *
 */
public enum E_V4_RIGHT_MODE {
	
	RIGHT_DOWN("线下确权",1),
	RIGHT_ONLINE("线上确权",2);
	
	String name;
	int status;
	
	E_V4_RIGHT_MODE(String name,int status){
		this.name = name;
		this.status = status;
	}
	
	public static String getName(int optype) {
		for (E_V4_RIGHT_MODE op : values()) {
			if (op.getStatus() == optype) {
				return op.name;
			}
		}
		return "";
	}
	
	public static E_V4_RIGHT_MODE get(int optype) {
		for (E_V4_RIGHT_MODE op : values()) {
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
  