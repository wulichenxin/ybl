package cn.sunline.framework.controller.vo.v4.supplier.enums;

public enum E_V4_FINANCING_STATE {
	
	TO_BE_SUBMITTED("待提交",1),
	WAITINGPARTY_FIRSTINSTANCE("待平台初审",2),
	PLATFORM_FIRSTTRIAL("待资方初审",3),
	TOCHOOSECAPITAL("待选择资方",4),
	FINALAPPEAL_PENDINGPARTY("待资方复审",5),
	DECIDED_PARTY("待确定资方",6),
	PLATFORM_REVIEW("待提交",7),
	SIGNED_CONTRACT("待签署合同",8),
	FINANCING_COMPLETED("融资完成",9),
	FINANCING_FAILURE("融资失败",99),
	FINANCING_REJECT("资金方驳回",10),
	PLATFORM_REJECT("平台方驳回",11);
	
	String name;
	int status;
	
	E_V4_FINANCING_STATE(String name,int status){
		this.name = name;
		this.status = status;
	}
	
	public static String getName(int optype) {
		for (E_V4_FINANCING_STATE op : values()) {
			if (op.getStatus() == optype) {
				return op.name;
			}
		}
		return "";
	}
	
	public static E_V4_FINANCING_STATE get(int optype) {
		for (E_V4_FINANCING_STATE op : values()) {
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
  