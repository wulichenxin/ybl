package cn.sunline.framework.controller.vo.v4.drools;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * 身份认证VO
 * @author pc
 *
 */
public class V4EnterpriseVO extends AbstractEntity{
	/**
	 * 
	 */
	private static final long serialVersionUID = 8792577839027391909L;
	/**
	 * 企业全称
	 */
	@JSONField(name = "enterprise_name")
	private String enterpriseName;
	/**
	 * 企业简称
	 */
	@JSONField(name = "enterprise_short_name")
	private String enterpriseShortName;
	/**
	 * 社会信用代码
	 */
	@JSONField(name = "social_credit_code")
	private String socialCreditCode;
	/***
	 * 法人姓名
	 */
	@JSONField(name = "legal_name")
	private String legalName;
	/**
	 * 法人身份证 号
	 */
	@JSONField(name = "legal_card_id")
	private String legalCardId;
	/**
	 * 法人手机号
	 */
	@JSONField(name = "legal_phone")
	private String legalPhone;
	/**
	 * 申请人姓名
	 */
	@JSONField(name = "applicant_name")
	private String applicantName;
	/**
	 * 申请人手机号
	 */
	@JSONField(name = "applicant_phone")
	private String applicantPhone;
	/**
	 * 申请人身份证号
	 */
	@JSONField(name = "applicant_card_id")
	private String applicantCardId;
	/**
	 * 申请人邮箱
	 */
	@JSONField(name = "applicant_email")
	private String applicantEmail;
	/**
	 * 认证状态1-审核中2-审核成功3-审核失败
	 */
	@JSONField(name = "auth_status")
	private int authStatus;
	/**
	 * 平台备注
	 */
	@JSONField(name = "platform_remark")
	private String platformRemark;
	
	public String getEnterpriseName() {
		return enterpriseName;
	}
	public void setEnterpriseName(String enterpriseName) {
		this.enterpriseName = enterpriseName;
	}
	public String getEnterpriseShortName() {
		return enterpriseShortName;
	}
	public void setEnterpriseShortName(String enterpriseShortName) {
		this.enterpriseShortName = enterpriseShortName;
	}
	public String getSocialCreditCode() {
		return socialCreditCode;
	}
	public void setSocialCreditCode(String socialCreditCode) {
		this.socialCreditCode = socialCreditCode;
	}
	public String getLegalName() {
		return legalName;
	}
	public void setLegalName(String legalName) {
		this.legalName = legalName;
	}
	public String getLegalCardId() {
		return legalCardId;
	}
	public void setLegalCardId(String legalCardId) {
		this.legalCardId = legalCardId;
	}
	public String getLegalPhone() {
		return legalPhone;
	}
	public void setLegalPhone(String legalPhone) {
		this.legalPhone = legalPhone;
	}
	public String getApplicantName() {
		return applicantName;
	}
	public void setApplicantName(String applicantName) {
		this.applicantName = applicantName;
	}
	public String getApplicantPhone() {
		return applicantPhone;
	}
	public void setApplicantPhone(String applicantPhone) {
		this.applicantPhone = applicantPhone;
	}
	public String getApplicantCardId() {
		return applicantCardId;
	}
	public void setApplicantCardId(String applicantCardId) {
		this.applicantCardId = applicantCardId;
	}
	public String getApplicantEmail() {
		return applicantEmail;
	}
	public void setApplicantEmail(String applicantEmail) {
		this.applicantEmail = applicantEmail;
	}
	public int getAuthStatus() {
		return authStatus;
	}
	public void setAuthStatus(int authStatus) {
		this.authStatus = authStatus;
	}
	public String getPlatformRemark() {
		return platformRemark;
	}
	public void setPlatformRemark(String platformRemark) {
		this.platformRemark = platformRemark;
	}
}
