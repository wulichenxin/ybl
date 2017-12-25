package cn.sunline.framework.controller.vo.v4.factor.enums;
/**
 * 合同模板类型
 * @author WIN
 *
 */
public enum E_V4_CONTRACT_COMPLATE {
	TEMPLATE_MASTER("应收账款转让协议","1");
	
	String name;
	String status;
	
	E_V4_CONTRACT_COMPLATE(String name,String status){
		this.name = name;
		this.status = status;
	}
	
	public static String getName(String optype) {
		for (E_V4_CONTRACT_COMPLATE op : values()) {
			if (op.getStatus() == optype) {
				return op.name;
			}
		}
		return "";
	}
	
	public static E_V4_CONTRACT_COMPLATE get(String optype) {
		for (E_V4_CONTRACT_COMPLATE op : values()) {
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
}
