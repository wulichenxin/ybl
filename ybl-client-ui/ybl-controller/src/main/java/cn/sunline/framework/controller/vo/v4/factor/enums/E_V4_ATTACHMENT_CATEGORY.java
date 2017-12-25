package cn.sunline.framework.controller.vo.v4.factor.enums;

/**
 * 附件大类枚举
 * @author LYY
 *
 */
public enum E_V4_ATTACHMENT_CATEGORY {
	ENTERPRISE_CERTIFICATION("企业认证",1),
	BUSINESS_AUTH("业务认证",2),
	RISK_FIRST_AUDIT("资方风控初审",3),
	RISK_FINAL_AUDIT("资方风控终审",4),
	CONTRACT_CATEGORY("合同",5),
	LOAN_APPLY("放款申请",6),
	LENDING_CLEARING("放款结算",7),
	REPAYMENTS_CATEGORY("还款",8),
	PLATFORM_CAPITAL_FLOW("平台资金流水",9),
	FINANCING_APPLY("融资申请",12),
	FINANCING_APPLICATION_SUBORDER("融资申请子订单",13),
	MANAGEMENT_MANAGEMENT_FINANCING("融资方收款管理",14),
	RIGHT_CAPITAL_ASSET("资方资产确权",15);
	String name;
	int status;
	
	E_V4_ATTACHMENT_CATEGORY(String name,int status){
		this.name = name;
		this.status = status;
	}
	
	public static String getName(int optype) {
		for (E_V4_ATTACHMENT_CATEGORY op : values()) {
			if (op.getStatus() == optype) {
				return op.name;
			}
		}
		return "";
	}
	
	public static E_V4_ATTACHMENT_CATEGORY get(int optype) {
		for (E_V4_ATTACHMENT_CATEGORY op : values()) {
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
  