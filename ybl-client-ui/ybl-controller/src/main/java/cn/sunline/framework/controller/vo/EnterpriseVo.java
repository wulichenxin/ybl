package cn.sunline.framework.controller.vo;

import java.math.BigDecimal;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;
/**
 * 企业表实体类
 * @author MaiBenBen
 *
 */
public class EnterpriseVo extends AbstractEntity {

	private static final long serialVersionUID = 70581823017359150L;
	/*企业表名称*/
	private String enterpriseName;
	/*固定电话*/	
	private String fixedPhone;
	/*营业执照注册号*/
	private String licenseNo;
	/*是否三证合一企业*/
	private String isThreeInOne;
	/*机构代码证号*/
	private String orgCodeNo;
	/*税务登记号*/
	private String taxNo;
	/*财务登记证号*/
	private String financeNo;
	/*机构信用证号*/
	private String orgCreditNo;
	/*开户许可证号*/
	private String openAccountNo;
	/*所属行业*/
	private String type;
	/*注册资本*/
	private BigDecimal registerAmount; 
	/*实缴资本 */
	private BigDecimal factAmount;
	/*注册省份*/
	private Long provinceId;
	/*注册城市*/
	private Long cityId;	
	/*注册区县*/
	private Long areaId;	
	/*注册地址*/
	private String address;	
	/*经营范围*/
	private String bussinessScope;
	/*有效经营开始日期*/
	private String beginDate;
	/*有效经营结束日期*/
	private String endDate;
	/*法人姓名*/
	private String legalName;
	/*法人身份证*/
	private String legalCardId;
	/*法人联系电话*/
	private String legalPhone;
	/*开户银行*/
	private String openBank;	
	/*账号注册省份*/
	private Long accountProvinceId;
	/*账号注册城市*/
	private Long accountCityId;
	/*账号注册区县*/
	private Long accountAreaId;
	/*开户银行账号*/
	private String accountNo;
	/*支行名称*/
	private String branchName;
	/*备注*/
	private String remark;
	/*公司简介*/
	private String companyProfile;
	/*认证状态：同意：agree 不同意：disagree*/
	private String status;
	
	@JSONField(name="enterprise_name")
	public String getEnterpriseName() {
		return enterpriseName;
	}
	@JSONField(name="enterprise_name")
	public void setEnterpriseName(String enterpriseName) {
		this.enterpriseName = enterpriseName;
	}
	@JSONField(name="fixed_phone")
	public String getFixedPhone() {
		return fixedPhone;
	}
	@JSONField(name="fixed_phone")
	public void setFixedPhone(String fixedPhone) {
		this.fixedPhone = fixedPhone;
	}
	@JSONField(name="license_no")
	public String getLicenseNo() {
		return licenseNo;
	}
	@JSONField(name="license_no")
	public void setLicenseNo(String licenseNo) {
		this.licenseNo = licenseNo;
	}
	@JSONField(name="is_three_in_one")
	public String getIsThreeInOne() {
		return isThreeInOne;
	}
	@JSONField(name="is_three_in_one")
	public void setIsThreeInOne(String isThreeInOne) {
		this.isThreeInOne = isThreeInOne;
	}
	@JSONField(name="org_code_no")
	public String getOrgCodeNo() {
		return orgCodeNo;
	}
	@JSONField(name="org_code_no")
	public void setOrgCodeNo(String orgCodeNo) {
		this.orgCodeNo = orgCodeNo;
	}
	@JSONField(name="tax_no")
	public String getTaxNo() {
		return taxNo;
	}
	@JSONField(name="tax_no")
	public void setTaxNo(String taxNo) {
		this.taxNo = taxNo;
	}
	@JSONField(name="finance_no")
	public String getFinanceNo() {
		return financeNo;
	}
	@JSONField(name="finance_no")
	public void setFinanceNo(String financeNo) {
		this.financeNo = financeNo;
	}
	@JSONField(name="org_credit_no")
	public String getOrgCreditNo() {
		return orgCreditNo;
	}
	@JSONField(name="org_credit_no")
	public void setOrgCreditNo(String orgCreditNo) {
		this.orgCreditNo = orgCreditNo;
	}
	@JSONField(name="open_account_no")
	public String getOpenAccountNo() {
		return openAccountNo;
	}
	@JSONField(name="open_account_no")
	public void setOpenAccountNo(String openAccountNo) {
		this.openAccountNo = openAccountNo;
	}
	@JSONField(name="type_")
	public String getType() {
		return type;
	}
	@JSONField(name="type_")
	public void setType(String type) {
		this.type = type;
	}
	@JSONField(name="register_amount")
	public BigDecimal getRegisterAmount() {
		return registerAmount;
	}
	@JSONField(name="register_amount")
	public void setRegisterAmount(BigDecimal registerAmount) {
		this.registerAmount = registerAmount;
	}
	@JSONField(name="fact_amount")
	public BigDecimal getFactAmount() {
		return factAmount;
	}
	@JSONField(name="fact_amount")
	public void setFactAmount(BigDecimal factAmount) {
		this.factAmount = factAmount;
	}
	@JSONField(name="province_id")
	public Long getProvinceId() {
		return provinceId;
	}
	@JSONField(name="province_id")
	public void setProvinceId(Long provinceId) {
		this.provinceId = provinceId;
	}
	@JSONField(name="city_id")
	public Long getCityId() {
		return cityId;
	}
	@JSONField(name="city_id")
	public void setCityId(Long cityId) {
		this.cityId = cityId;
	}
	@JSONField(name="area_id")
	public Long getAreaId() {
		return areaId;
	}
	@JSONField(name="area_id")
	public void setAreaId(Long areaId) {
		this.areaId = areaId;
	}
	@JSONField(name="address_")
	public String getAddress() {
		return address;
	}
	@JSONField(name="address_")
	public void setAddress(String address) {
		this.address = address;
	}
	@JSONField(name="bussiness_scope")
	public String getBussinessScope() {
		return bussinessScope;
	}
	@JSONField(name="bussiness_scope")
	public void setBussinessScope(String bussinessScope) {
		this.bussinessScope = bussinessScope;
	}
	@JSONField(format = "yyyy-MM-dd",name="begin_date")
	public String getBeginDate() {
		return beginDate;
	}
	@JSONField(format = "yyyy-MM-dd",name="begin_date")
	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}
	@JSONField(format = "yyyy-MM-dd",name="end_date")
	public String getEndDate() {
		return endDate;
	}
	@JSONField(format = "yyyy-MM-dd",name="end_date")
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	@JSONField(name="legal_name")
	public String getLegalName() {
		return legalName;
	}
	@JSONField(name="legal_name")
	public void setLegalName(String legalName) {
		this.legalName = legalName;
	}
	@JSONField(name="legal_card_id")
	public String getLegalCardId() {
		return legalCardId;
	}
	@JSONField(name="legal_card_id")
	public void setLegalCardId(String legalCardId) {
		this.legalCardId = legalCardId;
	}
	@JSONField(name="legal_phone")
	public String getLegalPhone() {
		return legalPhone;
	}
	@JSONField(name="legal_phone")
	public void setLegalPhone(String legalPhone) {
		this.legalPhone = legalPhone;
	}
	@JSONField(name="open_bank")
	public String getOpenBank() {
		return openBank;
	}
	@JSONField(name="open_bank")
	public void setOpenBank(String openBank) {
		this.openBank = openBank;
	}
	@JSONField(name="account_province_id")
	public Long getAccountProvinceId() {
		return accountProvinceId;
	}
	@JSONField(name="account_province_id")
	public void setAccountProvinceId(Long accountProvinceId) {
		this.accountProvinceId = accountProvinceId;
	}
	@JSONField(name="account_city_id")
	public Long getAccountCityId() {
		return accountCityId;
	}
	@JSONField(name="account_city_id")
	public void setAccountCityId(Long accountCityId) {
		this.accountCityId = accountCityId;
	}
	@JSONField(name="account_area_id")
	public Long getAccountAreaId() {
		return accountAreaId;
	}
	@JSONField(name="account_area_id")
	public void setAccountAreaId(Long accountAreaId) {
		this.accountAreaId = accountAreaId;
	}
	@JSONField(name="account_no")
	public String getAccountNo() {
		return accountNo;
	}
	@JSONField(name="account_no")
	public void setAccountNo(String accountNo) {
		this.accountNo = accountNo;
	}
	@JSONField(name="branch_name")
	public String getBranchName() {
		return branchName;
	}
	@JSONField(name="branch_name")
	public void setBranchName(String branchName) {
		this.branchName = branchName;
	}
	@JSONField(name="remark_")
	public String getRemark() {
		return remark;
	}
	@JSONField(name="remark_")
	public void setRemark(String remark) {
		this.remark = remark;
	}
	@JSONField(name="company_profile")
	public String getCompanyProfile() {
		return companyProfile;
	}
	@JSONField(name="company_profile")
	public void setCompanyProfile(String companyProfile) {
		this.companyProfile = companyProfile;
	}
	@JSONField(name="status_")
	public String getStatus() {
		return status;
	}
	@JSONField(name="status_")
	public void setStatus(String status) {
		this.status = status;
	}	
	
}
