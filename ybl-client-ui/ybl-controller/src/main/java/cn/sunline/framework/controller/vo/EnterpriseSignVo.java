package cn.sunline.framework.controller.vo;

import java.math.BigDecimal;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

public class EnterpriseSignVo extends AbstractEntity {

	private static final long serialVersionUID = 1L;
	/* 加密id */
	private String sign;
	/* 企业表名称 */
	private String enterpriseName;
	/* 固定电话 */
	private String fixedPhone;
	/* 营业执照注册号 */
	private String licenseNo;
	/* 所属行业 */
	private String type;
	/* 注册资本 */
	private BigDecimal registerAmount;
	/* 注册省份id */
	private Integer provinceId;
	/* 营业状态 */
	private String businessStatus;
	/* 签约状态 */
	private String signStatus;
	/* 注册省份 */
	private String provinceName;
	/* 签约会员id */
	private Long memberId;
	/* 企业id */
	private Long enterpriseId;
	
	/*企业id 被签约（保理商企业id）*/
	private Long enterprise2Id;
	
	/*主营业务*/
	private String bussinessScope;
	
	
	
	/* 被签约会员id */
	/*private long member2Id;
	
	@JSONField(name = "member2_id")
	public long getMember2Id() {
		return member2Id;
	}
	@JSONField(name = "member2_id")
	public void setMember2Id(long member2Id) {
		this.member2Id = member2Id;
	}*/
	@JSONField(name="bussiness_scope")
	public String getBussinessScope() {
		return bussinessScope;
	}
	@JSONField(name="bussiness_scope")
	public void setBussinessScope(String bussinessScope) {
		this.bussinessScope = bussinessScope;
	}

	@JSONField(name = "enterprise_id")
	public Long getEnterpriseId() {
		return enterpriseId;
	}

	public Long getEnterprise2Id() {
		return enterprise2Id;
	}

	public void setEnterprise2Id(Long enterprise2Id) {
		this.enterprise2Id = enterprise2Id;
	}

	@JSONField(name = "enterprise_id")
	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

	@JSONField(name = "sign_")
	public String getSign() {
		return sign;
	}

	@JSONField(name = "sign_")
	public void setSign(String sign) {
		this.sign = sign;
	}

	@JSONField(name = "member_id")
	public Long getMemberId() {
		return memberId;
	}

	public void setMemberId(Long memberId) {
		this.memberId = memberId;
	}

	@JSONField(name = "name_")
	public String getProvinceName() {
		return provinceName;
	}

	@JSONField(name = "name_")
	public void setProvinceName(String provinceName) {
		this.provinceName = provinceName;
	}

	@JSONField(name = "business_status")
	public String getBusinessStatus() {
		return businessStatus;
	}

	@JSONField(name = "business_status")
	public void setBusinessStatus(String businessStatus) {
		this.businessStatus = businessStatus;
	}

	@JSONField(name = "sign_status")
	public String getSignStatus() {
		return signStatus;
	}

	@JSONField(name = "sign_status")
	public void setSignStatus(String signStatus) {
		this.signStatus = signStatus;
	}

	@JSONField(name = "enterprise_name")
	public String getEnterpriseName() {
		return enterpriseName;
	}

	@JSONField(name = "enterprise_name")
	public void setEnterpriseName(String enterpriseName) {
		this.enterpriseName = enterpriseName;
	}

	@JSONField(name = "fixed_phone")
	public String getFixedPhone() {
		return fixedPhone;
	}

	@JSONField(name = "fixed_phone")
	public void setFixedPhone(String fixedPhone) {
		this.fixedPhone = fixedPhone;
	}

	@JSONField(name = "license_no")
	public String getLicenseNo() {
		return licenseNo;
	}

	@JSONField(name = "license_no")
	public void setLicenseNo(String licenseNo) {
		this.licenseNo = licenseNo;
	}

	@JSONField(name = "type_")
	public String getType() {
		return type;
	}

	@JSONField(name = "type_")
	public void setType(String type) {
		this.type = type;
	}

	@JSONField(name = "register_amount")
	public BigDecimal getRegisterAmount() {
		return registerAmount;
	}

	@JSONField(name = "register_amount")
	public void setRegisterAmount(BigDecimal registerAmount) {
		this.registerAmount = registerAmount;
	}

	@JSONField(name = "province_id")
	public Integer getProvinceId() {
		return provinceId;
	}

	@JSONField(name = "province_id")
	public void setProvinceId(Integer provinceId) {
		this.provinceId = provinceId;
	}
}
