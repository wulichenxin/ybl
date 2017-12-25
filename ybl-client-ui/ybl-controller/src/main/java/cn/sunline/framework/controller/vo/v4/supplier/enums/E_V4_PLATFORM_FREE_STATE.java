package cn.sunline.framework.controller.vo.v4.supplier.enums;

/**
 * 平台费用资金流水状态枚举
 *   1-平台费用未确认2-平台费用已确认
 * @author xxx
 *
 */
public enum E_V4_PLATFORM_FREE_STATE {
	
	PLATFORM_TO_BE_CONFIRM("平台费用未确认",1),
	PLATFORM_CONFIRMED("平台费用已确认",2);
	
	String name;
	int status;
	
	E_V4_PLATFORM_FREE_STATE(String name,int status){
		this.name = name;
		this.status = status;
	}
	
	public static String getName(int optype) {
		for (E_V4_PLATFORM_FREE_STATE op : values()) {
			if (op.getStatus() == optype) {
				return op.name;
			}
		}
		return "";
	}
	
	public static E_V4_PLATFORM_FREE_STATE get(int optype) {
		for (E_V4_PLATFORM_FREE_STATE op : values()) {
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
  