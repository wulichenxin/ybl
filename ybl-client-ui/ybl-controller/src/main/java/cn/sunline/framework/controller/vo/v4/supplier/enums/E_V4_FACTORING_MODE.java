package cn.sunline.framework.controller.vo.v4.supplier.enums;

public enum E_V4_FACTORING_MODE {
	
	FACTORING_OUT("明保理",1),
	DARK_FACTORING("暗保理",2);
	
	String name;
	int status;
	
	E_V4_FACTORING_MODE(String name,int status){
		this.name = name;
		this.status = status;
	}
	
	public static String getName(int optype) {
		for (E_V4_FACTORING_MODE op : values()) {
			if (op.getStatus() == optype) {
				return op.name;
			}
		}
		return "";
	}
	
	public static E_V4_FACTORING_MODE get(int optype) {
		for (E_V4_FACTORING_MODE op : values()) {
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
  