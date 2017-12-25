package cn.sunline.framework.controller.vo.v4.factor.enums;

public enum E_V4_REPAYMENT_STATUS {
	
	PENDING_REPAYMENT("待还款",1),
	REPAYMENTED("已还款",2),
	OVERDUE("已逾期",3),
	BAD_DEBT("坏账",5),
	REPAYMENTED_CONFIRMED("已还款已确认",6);
	
	
	String name;
	int status;
	
	E_V4_REPAYMENT_STATUS(String name,int status){
		this.name = name;
		this.status = status;
	}
	
	public static String getName(int optype) {
		for (E_V4_REPAYMENT_STATUS op : values()) {
			if (op.getStatus() == optype) {
				return op.name;
			}
		}
		return "";
	}
	
	public static E_V4_REPAYMENT_STATUS get(int optype) {
		for (E_V4_REPAYMENT_STATUS op : values()) {
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
  