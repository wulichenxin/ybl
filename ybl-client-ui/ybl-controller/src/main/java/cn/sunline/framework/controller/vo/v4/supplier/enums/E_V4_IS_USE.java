package cn.sunline.framework.controller.vo.v4.supplier.enums;

public enum E_V4_IS_USE {

	ALREADYUSED("已使用",1),
	NOTUSED("未使用",2),
	OCCUPY("占用",3);
	
	String name;
	int status;
	
	E_V4_IS_USE(String name,int status){
		this.name = name;
		this.status = status;
	}
	
	public static String getName(int optype) {
		for (E_V4_IS_USE op : values()) {
			if (op.getStatus() == optype) {
				return op.name;
			}
		}
		return "";
	}
	
	public static E_V4_IS_USE get(int optype) {
		for (E_V4_IS_USE op : values()) {
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
  