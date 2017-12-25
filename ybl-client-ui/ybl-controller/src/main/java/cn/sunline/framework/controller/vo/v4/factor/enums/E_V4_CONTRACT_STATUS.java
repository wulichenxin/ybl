package cn.sunline.framework.controller.vo.v4.factor.enums;
/**
 * 合同状态
 * @author WIN
 *
 */
public enum E_V4_CONTRACT_STATUS {

	FACTOR_SIGN("资金方签署",1),
	SUPPLIER_SIGN("融资方签署",2);
	
	String name;
	int status;
	
	E_V4_CONTRACT_STATUS(String name,int status){
		this.name = name;
		this.status = status;
	}
	
	public static String getName(int optype) {
		for (E_V4_CONTRACT_STATUS op : values()) {
			if (op.getStatus() == optype) {
				return op.name;
			}
		}
		return "";
	}
	
	public static E_V4_CONTRACT_STATUS get(int optype) {
		for (E_V4_CONTRACT_STATUS op : values()) {
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
