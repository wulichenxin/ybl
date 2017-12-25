package cn.sunline.framework.controller.vo.v4.factor.enums;

/**
 * 附件类型枚举
 * @author LUOYY
 *
 */
public enum E_V4_ATTACHMENT_TYPE {
	FACE_LEGAL_PERSON("法人身份证正面","1"),
	REVERSE_LEGAL_PERSON_CARD("法人身份证反面","2"),
	APPLICATICANTS_IDENTITY_CARD("申请人身份证正面","3"),
	APPLICATICANTS_IDENTITY_CARD_ANTI("申请人身份证反面","4"),
	COMPANY_AUTHORIZATION_LETTER("公司授权书","5"),
	HAND_IDENTITY_CARD("手持身份证正面","6"),
	HAND_IDENTITY_CARD_ANTI("手持身份证反面","7"),
	ORGANIZATION_CODE("组织机构代码","8"),
	BUSINESS_LICENSE("营业执照","9"),
	TAX_REGISTRATION_CERTIFICATE("税务登记证","10"),
	FINANCING_APPLICATION_FORM("融资申请表","11"),
	BUSINESS_LICENSE_THIRD("营业执照（三证合一）","12"),
	ACCOUNT_OPENING_PERMIT("开户许可证","13"),
	AGENCY_CREDIT_CODE("机构信用代码","14"),
	LEGAL_REPRESENTATIVE_IDENTITY("法人代表身份证","15"),
	COMPANYS_ARTICLES_ASSOCIATION("公司章程","16"),
	CAPITAL_VERFICATION_REPORT("验资报告","17"),
	ENTERPRISE_CREDIT_REPORT("企业信用报告","18"),
	LOAN_QUERY_AUTHORIZATION("贷款卡查询授权","19"),
	LEASE_CONTRACT_PAYMENT_NEARLY_THREE_MONTHS("租赁合同及近三个月缴费单据","20"),
	INTRODUCTION_COMPANY_SHAREHOLDERS("公司股东介绍（包含实际控制人、股东关系、股权结构）","21"),
	COMPANY_EXECUTIVES("公司高管介绍（包含董事长、总经理、财务总监等）","22"),
	COMPANY_BUSINESS_INTRODUCTION("公司业务介绍（说明公司的主要经营业务、营收情况等）","23"),
	FINANCIAL_STATEMENTS_LAST_THREE_YEARS_RECENT_SIX_MONTHS("最近三年经审计的财务报告及最近六个月财务报表","24"),
	BANK_CREDIT_LOAN_DETAILS("银行授信及贷款明细","25"),
	DESCRIPTION_EXTERNAL("对外担保情况说明","26"),
	NEARLY_YEAR_BANK_ACCOUNT_RUNNING_WARTER("近一年的银行账户流水","27"),
	VALUE_ADDED_TAX_NEARLY_SIX_MONTHS("近六个月的增值纳税申报表","28"),
	FINNACING_PURCHASE_SALE_CONTRACT("购销合同(融资申请)","29"),
	FINNACING_SALES_INVOICE("销售发票(融资申请)（含清单）","30"),
	FINNACING_PURCHASE_STOCK_ORDER("采购订单、出入库清单、库存清单（融资）","31"),
	OTHER_IMPORTANT_MATERIALS_RELATED_FINANCING("其他与融资相关的重要材料","32"),
	OTHER_SUPPLEMENTARY_INFORMATION("其他补充资料","33"),
	REJECTION_SUPPLEMENTARY_INFORMATION("驳回补充资料","34"),
	MANAGEMENT_RISK_CONTROL_PRELIMINARY_HEARING_FORM("资方风控初审意见表","35"),
	MANAGEMENT_RISK_CONTROL_FINAL_OPTION("资方风控终审意见表","36"),
	CONTRACT_ATTACHMENT("合同附件","37"),
	LOAN_APPLICATION_RECEIVABLE_UNDERLYING_ASSET_ATTACHMENT("放款申请应收底层资产附件","38"),
	LOAN_APPLICATION_UNDERLYING_ASSET_ATTACHMENT("放款申请应付底层资产附件","39"),
	LOAN_APPLICATION_NOTES_UNDERLYING_ASSET_ATTACHMENT("放款申请票据底层资产附件","40"),
	LOAN_PURCHASE_SALE_CONTRACT("购销合同(放款申请)","41"),
	LOAN_SALES_INVOICE("销售发票(放款申请)（含清单）","42"),
	LOAN_PURCHASE_STOCK_ORDER("采购订单、出入库清单、库存清单（放款）","43"),
	LOAN_OTHER_IMPORTANT_MATERIALS_RELATED_FINANCING("其他与融资相关的重要材料(放款)","44"),
	RECEIVABLE_ELEMENTS("保理要素表（应收账款）风控措施","45"),
	PAYABLE_ELEMENTS("保理要素表（应付账款）风控措施","46"),
	BILL_ELEMENTS("保理要素表（票据）风控措施","47"),
	ASSET_TRANSFER_LETTER("资产转让函","48"),
	CREDIT_INVESTIGATION_REPORT("征信调查报表","49"),
	LOAN_SETTLEMENT_PAYMENT_VOUCHER("放款结算支付凭证","50"),
	SETTLEMENT_VOUCHER("还款结算凭证","51"),
	PLATFORM_RECEIPT_VOUCHER("平台收款凭证","52"),
	INITIAL_JUDGMENT_FUND("资金方初审意见表","53"),
	FUND_FINAL_OPINION_FORM("资金方终审意见表","54"),
	ACCOUNTS_RECEIVABLE_ACCOUNTS_RECEIVABLE("应收账款总账及明细账","55"),
	ACCOUNTS_PAYABLE_ACCOUNTS_PAYABLE("应付账款总账及明细账","56"),
	ADDITIONAL_INFORMATION("补充资料","57"),
	FINANCIAL_RECEIPT_CONFIRMATION("融资方收款确认","58"),
	FINANCIAL_PARTY_REPAYMENTS("融资方还款","59"),
	RISK_CONTROL_MEASURES_MANAGEMENT_RISK_CONTROL("资方风控终审风控措施","60"),
	LOAN_ASSETS("放款申请底层资产附件","61");
	
	String name;
	String status;
	
	E_V4_ATTACHMENT_TYPE(String name,String status){
		this.name = name;
		this.status = status;
	}
	
	public static String getName(String optype) {
		for (E_V4_ATTACHMENT_TYPE op : values()) {
			if (op.getStatus() == optype) {
				return op.name;
			}
		}
		return "";
	}
	
	public static E_V4_ATTACHMENT_TYPE get(String optype) {
		for (E_V4_ATTACHMENT_TYPE op : values()) {
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
  