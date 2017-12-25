package com.bpm.framework.constant;

/**
 * 云保理常量类
 *
 */
public class Constant {

	/**
	 * 产品审核状态常量
	 */

	// 风控初审中
	public static final String FIRST_AUDITING = "1000_auditing";

	// 风控复审中
	public static final String RE_AUDITING = "1020_reauditing";

	// 财务审核
	public static final String FINANCE_AUDIT = "1030_finance_audit";

	// 出账审核
	public static final String PAY_AUDIT = "1040_pay_audit";

	// 终止审核
	public static final String END_AUDIT = "2000_end";

	// 审核操作
	// 同意
	public static final String AUDIT_OPERATION_AREE = "agree";

	// 不同意
	public static final String AUDIT_OPERATION_DISAGREE = "disagree";

	// 驳回
	public static final String AUDIT_OPERATION_REJECT = "reject";

	// 等待中
	public static final String AUDIT_OPERATION_WAITING = "waiting";

	// 竞标状态
	// 未中标
	public static final String LOAN_SIGN_BID_UNBID = "unbid";
	// 已中标
	public static final String LOAN_SIGN_BID_BIDED = "bided";
	// 竞标中
	public static final String LOAN_SIGN_BID_BIDING = "biding";

	// 标的状态
	// 草稿
	public static final String SUBJECT_DRAFT = "draft";
	// 拒绝
	public static final String SUBJECT_REJECT = "reject";
	// 已发布/竞标中
	public static final String SUBJECT_BIDING = "biding";
	// 回款中
	public static final String SUBJECT_PAYMENTING = "paymenting";
	// 流标
	public static final String SUBJECT_FAIL_SUBJECT = "fail_subject";
	// 已完成
	public static final String SUBJECT_BEN = "end";

	// 用户类型
	// 未认证企业
	public static final String USER_MEMBER = "member";
	// 核心企业
	public static final String USER_CORE_ENTERPRISE = "enterprise";
	// 保理商
	public static final String USER_FACTOR = "factor";
	// 供应商
	public static final String USER_SUPPLIER = "supplier";

	// 角色认证
	// 认证通过
	public static final String USER_AUTH_AGREE = "agree";
	// 认证中
	public static final String USER_AUTH_AUTHING = "authing";
	// 认证失败
	public static final String USER_AUTH_DISAGREE = "disagree";

	// 凭证状态
	// 已认证
	public static final String VOUCHER_CERTIFIED = "certified";
	// 未认证
	public static final String VOUCHER_NOT_CERTIFIED = "not_certified";
	// 认证失败
	public static final String VOUCHER_CERTIFY_FAIL = "certify_fail";

	// 当前找回密码的手机
	public static final String FORGET_PWD_TARGET = "forget_pwd_target";
	public static final String FORGET_PWD_TYPE_SMS = "sms";

	// 凭证状态
	// 可使用
	public static final String VOUCHER_AVAILABLE = "available";
	// 已使用
	public static final String VOUCHER_USED = "used";
	// 使用中
	public static final String VOUCHER_USING = "using";
	
	//账款状态accounts_receivable
	//草稿(供应商)：draft；
	public static final String ACCOUNT_RECEIVABLE_DRAFT = "draft";
	//提交待确认(核心企业)：submit；
	public static final String ACCOUNT_RECEIVABLE_SUBMIT = "submit";
	//待分配(平台)：distribution；
	public static final String ACCOUNT_RECEIVABLE_DISTRIBUTION = "distribution";
	//账款审核(保理商)：audit；
	public static final String ACCOUNT_RECEIVABLE_AUDIT = "audit";
	//拒绝：refuse；
	public static final String ACCOUNT_RECEIVABLE_REFUSE = "refuse";
	//待结算：pending_payment；
	public static final String ACCOUNT_RECEIVABLE_PENDING_PAYMENT = "pending_payment";
	//结算中paying;
	public static final String ACCOUNT_RECEIVABLE_PAYING = "paying";
	//完成：end；
	public static final String ACCOUNT_RECEIVABLE_END= "end";
	
	/**
	 * 用户菜单信息
	 */
	public static final String USER_MENU = "user_menu";

}
