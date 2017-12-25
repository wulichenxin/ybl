package cn.sunline.framework.controller.vo.v4.factor.enums;

public enum E_V4_AUDIT_TYPE {
	
	AUDIT_BEGIN("初审",1),
	AUDIT_AGAIN("复审",2);
	
	String name;
	int status;
	
	E_V4_AUDIT_TYPE(String name,int status){
		this.name = name;
		this.status = status;
	}
	
	public static String getName(int optype) {
		for (E_V4_AUDIT_TYPE op : values()) {
			if (op.getStatus() == optype) {
				return op.name;
			}
		}
		return "";
	}
	
	public static E_V4_AUDIT_TYPE get(int optype) {
		for (E_V4_AUDIT_TYPE op : values()) {
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
  