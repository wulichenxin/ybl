package cn.sunline.framework.controller.vo.v4.supplier.enums;

/**
 * 还款状态枚举类型
 *   1-待还款2-已还款3-已逾期4-催收中5-坏账
 * @author xxx
 *
 */
public enum E_V4_PAY_STATE {
	
	TO_BE_REPAY("待还款",1),
	REPLAYED_NOT_CONFIRM("已还款",2),
	PAY_OVER_OFF("已逾期",3),
	TO_COLLECTIONING_PAY("催收中",4),
	BAD_BEDT("坏账",5);
	
	String name;
	int status;
	
	E_V4_PAY_STATE(String name,int status){
		this.name = name;
		this.status = status;
	}
	
	public static String getName(int optype) {
		for (E_V4_PAY_STATE op : values()) {
			if (op.getStatus() == optype) {
				return op.name;
			}
		}
		return "";
	}
	
	public static E_V4_PAY_STATE get(int optype) {
		for (E_V4_PAY_STATE op : values()) {
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
  