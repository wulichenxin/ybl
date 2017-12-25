package cn.sunline.framework.controller.vo.v4.factor.enums;

/**
 * 放款申请状态枚举
 * 2.待资方办理 3.待确权 5.待放款
 * @author pc
 *
 */
public enum E_V4_STATUS {
	
	WAIT_LOAN("待放款",5),
	WAIT_FACTOR_AUDIT("待资方办理",2),
	WAIT_AUTHORIZE("待确权",3);
	
	
	String name;
	int status;
	
	E_V4_STATUS(String name,int status){
		this.name = name;
		this.status = status;
	}
	
	public static String getName(int optype) {
		for (E_V4_STATUS op : values()) {
			if (op.getStatus() == optype) {
				return op.name;
			}
		}
		return "";
	}
	
	public static E_V4_STATUS get(int optype) {
		for (E_V4_STATUS op : values()) {
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
  