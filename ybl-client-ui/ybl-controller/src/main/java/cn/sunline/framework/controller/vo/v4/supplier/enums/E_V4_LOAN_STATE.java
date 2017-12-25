package cn.sunline.framework.controller.vo.v4.supplier.enums;

/**
 * 放款状态枚举类型
 *  1-待提交2-待资方办理3-待确权4-待平台审核5-待放款 8-待放款确认(等待融资方确认收款)9-已确认收款99-放款失败
 * @author xxx
 *
 */
public enum E_V4_LOAN_STATE {
	
	TO_BE_SUBMITTED("待提交",1),
	TO_FUNDER_AUDI("待资方办理",2),
	TO_FUNDER_CONFIRE("待确权",3),
	TO_PLATFORM_AUDI("待平台审核",4),
	TO_LOAN_NOT_PAY("待放款 ",5),
	LOANED_AND_PAYED("待放款确认",8),
	FINANCER_CONFIRM("已确认收款",9),
	LOAN_FAILURE("放款失败",99);
	
	String name;
	int status;
	
	E_V4_LOAN_STATE(String name,int status){
		this.name = name;
		this.status = status;
	}
	
	public static String getName(int optype) {
		for (E_V4_LOAN_STATE op : values()) {
			if (op.getStatus() == optype) {
				return op.name;
			}
		}
		return "";
	}
	
	public static E_V4_LOAN_STATE get(int optype) {
		for (E_V4_LOAN_STATE op : values()) {
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
  