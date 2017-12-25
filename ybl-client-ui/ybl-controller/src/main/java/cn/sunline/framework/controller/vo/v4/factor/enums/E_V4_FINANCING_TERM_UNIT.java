package cn.sunline.framework.controller.vo.v4.factor.enums;

/**
 * 融资期限单位
 * @author pc
 *
 */
public enum E_V4_FINANCING_TERM_UNIT {
	
	DAY("天",1),
	MONTH("月",2);
	
	String name;
	int status;
	
	E_V4_FINANCING_TERM_UNIT(String name,int status){
		this.name = name;
		this.status = status;
	}
	
	public static String getName(int optype) {
		for (E_V4_FINANCING_TERM_UNIT op : values()) {
			if (op.getStatus() == optype) {
				return op.name;
			}
		}
		return "";
	}
	
	public static E_V4_FINANCING_TERM_UNIT get(int optype) {
		for (E_V4_FINANCING_TERM_UNIT op : values()) {
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
  