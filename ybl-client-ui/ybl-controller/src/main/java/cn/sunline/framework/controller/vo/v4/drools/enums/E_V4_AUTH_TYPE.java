package cn.sunline.framework.controller.vo.v4.drools.enums;

public enum E_V4_AUTH_TYPE {
	
	FINANCINGPARTY("融资方",1),
	FUNDSIDE("资金方",2),
	COREENTERPRISE("核心企业",3),
	MEMBER("门户端",4);
	
	String name;
	int status;
	
	E_V4_AUTH_TYPE(String name,int status){
		this.name = name;
		this.status = status;
	}
	
	public static String getName(int optype) {
		for (E_V4_AUTH_TYPE op : values()) {
			if (op.getStatus() == optype) {
				return op.name;
			}
		}
		return "";
	}
	
	public static E_V4_AUTH_TYPE get(int optype) {
		for (E_V4_AUTH_TYPE op : values()) {
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
  