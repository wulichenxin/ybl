package cn.sunline.framework.controller.vo;

import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * 银行账号信息实体
 * 
 * @author MaiBenBen
 *
 */
public class BankAccountVo extends AbstractEntity {

	private static final long serialVersionUID = 6490883433680449016L;
	/* 企业表id */
	private Long enterpriseId=-1L;
	/* 所属会员id */
	private Long memberId=-1L;
	/* 账号 */
	private String accountNo;
	/* 证件类型:身份证：01，港澳通行证：02 */
	private String certType;
	/* 证件号码 */
	private String certNo;
	/* 支行 */
	private String branchBankName;
	/* 开户名 */
	private String openName;
	/* 银行预留手机号码 */
	private String bankPhone;
	/* 状态:绑卡中：binding，已绑定：binded，未绑定：unbind */
	private String status;
	/*所属银行id*/
	private Long bankId;

	@JSONField(name = "enterprise_id")
	public Long getEnterpriseId() {
		return enterpriseId;
	}

	@JSONField(name = "enterprise_id")
	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

	@JSONField(name = "member_id")
	public Long getMemberId() {
		return memberId;
	}

	@JSONField(name = "member_id")
	public void setMemberId(Long memberId) {
		this.memberId = memberId;
	}

	@JSONField(name = "account_no")
	public String getAccountNo() {
		return accountNo;
	}

	@JSONField(name = "account_no")
	public void setAccountNo(String accountNo) {
		this.accountNo = accountNo;
	}

	@JSONField(name = "cert_type")
	public String getCertType() {
		return certType;
	}

	@JSONField(name = "cert_type")
	public void setCertType(String certType) {
		this.certType = certType;
	}

	@JSONField(name = "cert_no")
	public String getCertNo() {
		return certNo;
	}

	@JSONField(name = "cert_no")
	public void setCertNo(String certNo) {
		this.certNo = certNo;
	}

	@JSONField(name = "branch_bank_name")
	public String getBranchBankName() {
		return branchBankName;
	}

	@JSONField(name = "branch_bank_name")
	public void setBranchBankName(String branchBankName) {
		this.branchBankName = branchBankName;
	}

	@JSONField(name = "open_name")
	public String getOpenName() {
		return openName;
	}

	@JSONField(name = "open_name")
	public void setOpenName(String openName) {
		this.openName = openName;
	}

	@JSONField(name = "bank_phone")
	public String getBankPhone() {
		return bankPhone;
	}

	@JSONField(name = "bank_phone")
	public void setBankPhone(String bankPhone) {
		this.bankPhone = bankPhone;
	}

	@JSONField(name = "status_")
	public String getStatus() {
		return status;
	}

	@JSONField(name = "status_")
	public void setStatus(String status) {
		this.status = status;
	}
	
	@JSONField(name = "bank_id")
	public Long getBankId() {
		return bankId;
	}

	@JSONField(name = "bank_id")
	public void setBankId(Long bankId) {
		this.bankId = bankId;
	}

}
