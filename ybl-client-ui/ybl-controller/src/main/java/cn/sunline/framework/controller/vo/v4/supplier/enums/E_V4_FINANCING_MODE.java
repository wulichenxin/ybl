package cn.sunline.framework.controller.vo.v4.supplier.enums;

public enum E_V4_FINANCING_MODE {
	
	CONTRACTING_PARTY("签约资方",1),
	PLATFORM_RECOMMENDATION("平台推荐",2),
	BID("竞标",3);
	
	String name;
	int status;
	
	E_V4_FINANCING_MODE(String name,int status){
		this.name = name;
		this.status = status;
	}
	
	public static String getName(int optype) {
		for (E_V4_FINANCING_MODE op : values()) {
			if (op.getStatus() == optype) {
				return op.name;
			}
		}
		return "";
	}
	
	public static E_V4_FINANCING_MODE get(int optype) {
		for (E_V4_FINANCING_MODE op : values()) {
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
  