package cn.sunline.framework.controller.vo.v2;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

public class AccountsReceivableVo extends AbstractEntity{

	/**
	 * 账款表实体类
	 */
	private static final Long serialVersionUID = 5784066131697003047L;
	//标题
	private String title;
	//内容
	private String content;
	//供应商会员id
	private Long supplierMemberId;
	//供应商id
	private Long supplierEnterpriseId;
	//保理商id
	private Long factoringEnterpriseId;
	//核心企业id
	private Long coreEnterpriseId;
	//合同id
	private Long contractId;
	//状态   草稿(供应商)：draft； 提交待确认(核心企业)：submit；待分配(平台):distribution；
	//账款审核(保理商)：audit；拒绝：refuse；待结算：pending_payment；结算中paying;完成：end；
	private String status;
	//编号
	private String number;
	//提交时间
	private String submissionTime;
	//企业id
	private Long enterpriseId;
	
	@JSONField(name="title_")
	public String getTitle() {
		return title;
	}
	@JSONField(name="title_")
	public void setTitle(String title) {
		this.title = title;
	}
	@JSONField(name="content_")
	public String getContent() {
		return content;
	}
	@JSONField(name="content_")
	public void setContent(String content) {
		this.content = content;
	}
	@JSONField(name="supplier_member_id")
	public Long getSupplierMemberId() {
		return supplierMemberId;
	}
	@JSONField(name="supplier_member_id")
	public void setSupplierMemberId(Long supplierMemberId) {
		this.supplierMemberId = supplierMemberId;
	}
	@JSONField(name="supplier_enterprise_id")
	public Long getSupplierEnterpriseId() {
		return supplierEnterpriseId;
	}
	@JSONField(name="supplier_enterprise_id")
	public void setSupplierEnterpriseId(Long supplierEnterpriseId) {
		this.supplierEnterpriseId = supplierEnterpriseId;
	}
	@JSONField(name="factoring_enterprise_id")
	public Long getFactoringEnterpriseId() {
		return factoringEnterpriseId;
	}
	@JSONField(name="factoring_enterprise_id")
	public void setFactoringEnterpriseId(Long factoringEnterpriseId) {
		this.factoringEnterpriseId = factoringEnterpriseId;
	}
	@JSONField(name="core_enterprise_id")
	public Long getCoreEnterpriseId() {
		return coreEnterpriseId;
	}
	@JSONField(name="core_enterprise_id")
	public void setCoreEnterpriseId(Long coreEnterpriseId) {
		this.coreEnterpriseId = coreEnterpriseId;
	}
	@JSONField(name="contract_id")
	public Long getContractId() {
		return contractId;
	}
	@JSONField(name="contract_id")
	public void setContractId(Long contractId) {
		this.contractId = contractId;
	}
	@JSONField(name="status_")
	public String getStatus() {
		return status;
	}
	@JSONField(name="status_")
	public void setStatus(String status) {
		this.status = status;
	}
	@JSONField(name="number_")
	public String getNumber() {
		return number;
	}
	@JSONField(name="number_")
	public void setNumber(String number) {
		this.number = number;
	}
	@JSONField(name="enterprise_id")
	public Long getEnterpriseId() {
		return enterpriseId;
	}
	@JSONField(name="enterprise_id")
	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}
	@JSONField(name="submission_time")
	public String getSubmissionTime() {
		return submissionTime;
	}
	@JSONField(name="submission_time")
	public void setSubmissionTime(String submissionTime) {
		this.submissionTime = submissionTime;
	}
	
	
}
