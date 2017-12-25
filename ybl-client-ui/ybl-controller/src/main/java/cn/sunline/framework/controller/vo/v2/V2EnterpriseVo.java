package cn.sunline.framework.controller.vo.v2;

import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * 企业表V2实体类
 * 
 * @author JZX
 *
 */
public class V2EnterpriseVo extends AbstractEntity {

	private static final long serialVersionUID = -5244103768722012078L;
	/* 企业表名称 */
	private String enterpriseFullName;
	/* 企业表简称 */
	private String enterpriseName;
	/* 管理员账号-手机号 */
	private String adminAccountNumber;
	/* 管理员账号-邮箱 */
	private String adminAccountMail;
	/* 注册日期 */
	private Date registerDate;
	/* 公司电话 */
	private String fixedPhone;
	/* 传真号 */
	private String faxNumber;
	/* 所属行业 */
	private String industry;
	/* 企业人数 */
	private String numberPeople;
	/* 营业执照注册号 */
	private String licenseNo;
	/* 营业执照到期时间 */
	private Date licenseDate;
	/* 机构代码证号 */
	private String orgCodeNo;
	/* 机构代码证号到期时间 */
	private Date orgCodeDate;
	/* 税务编号-国税 */
	private String taxNoCountry;
	/* 税务编号-地稅 */
	private String taxNoPlace;
	/* 机构信用证号 */
	private String creditNo;
	/* 类型*/
	private String type;
	/* 注册资金 */
	private BigDecimal registerAmount;
	/* 注册资金单位 */
	private String registerAmountType;
	/* 注册资本到位率 */
	private BigDecimal registerAmountRatio;
	/* 注册资金到位时间 */
	private Date registerAmountDate;
	/* 是否自有房产 */
	private String isHouse;
	/* 工商年检日期 */
	private Date icDate;
	/* 注册省份 */
	private String provinceId;
	/* 注册城市 */
	private String cityId;
	/* 注册区县 */
	private String areaId;
	/* 注册地址 */
	private String address;
	/* 邮编 */
	private String postcode;
	/* 法人姓名 */
	private String legalName;
	/* 法人身份证 */
	private String legalCardId;
	/* 联系人姓名 */
	private String contactsName;
	/* 联系人电话 */
	private String contactsTel;
	/* 联系人邮箱 */
	private String contactsMail;
	/* 上年底企业总资产 */
	private BigDecimal lastYearAssets;
	/* 上年底企业总负债 */
	private BigDecimal lastYearDebt;
	/* 上年年度销售收入 */
	private BigDecimal lastYearIncome;
	/* 前年年度销售收入 */
	private BigDecimal yearBeforeLastIncome;
	/* 预警额度 */
	private BigDecimal earlyWarningAmount;
	/* 备注 */
	private String remark;
	/* 上年度销售成本 */
	private BigDecimal lastYearCost;

	@JSONField(name = "enterprise_full_name")
	public String getEnterpriseFullName() {
		return enterpriseFullName;
	}

	@JSONField(name = "enterprise_full_name")
	public void setEnterpriseFullName(String enterpriseFullName) {
		this.enterpriseFullName = enterpriseFullName;
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

	@JSONField(name = "org_code_no")
	public String getOrgCodeNo() {
		return orgCodeNo;
	}

	@JSONField(name = "org_code_no")
	public void setOrgCodeNo(String orgCodeNo) {
		this.orgCodeNo = orgCodeNo;
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
	public String getProvinceId() {
		return provinceId;
	}

	@JSONField(name = "province_id")
	public void setProvinceId(String provinceId) {
		this.provinceId = provinceId;
	}

	@JSONField(name = "city_id")
	public String getCityId() {
		return cityId;
	}

	@JSONField(name = "city_id")
	public void setCityId(String cityId) {
		this.cityId = cityId;
	}

	@JSONField(name = "area_id")
	public String getAreaId() {
		return areaId;
	}

	@JSONField(name = "area_id")
	public void setAreaId(String areaId) {
		this.areaId = areaId;
	}

	@JSONField(name = "address_")
	public String getAddress() {
		return address;
	}

	@JSONField(name = "address_")
	public void setAddress(String address) {
		this.address = address;
	}

	@JSONField(name = "legal_name")
	public String getLegalName() {
		return legalName;
	}

	@JSONField(name = "legal_name")
	public void setLegalName(String legalName) {
		this.legalName = legalName;
	}

	@JSONField(name = "legal_card_id")
	public String getLegalCardId() {
		return legalCardId;
	}

	@JSONField(name = "legal_card_id")
	public void setLegalCardId(String legalCardId) {
		this.legalCardId = legalCardId;
	}

	@JSONField(name = "remark_")
	public String getRemark() {
		return remark;
	}

	@JSONField(name = "remark_")
	public void setRemark(String remark) {
		this.remark = remark;
	}

	@JSONField(name = "admin_account_number")
	public String getAdminAccountNumber() {
		return adminAccountNumber;
	}

	@JSONField(name = "admin_account_number")
	public void setAdminAccountNumber(String adminAccountNumber) {
		this.adminAccountNumber = adminAccountNumber;
	}

	@JSONField(name = "admin_account_mail")
	public String getAdminAccountMail() {
		return adminAccountMail;
	}

	@JSONField(name = "admin_account_mail")
	public void setAdminAccountMail(String adminAccountMail) {
		this.adminAccountMail = adminAccountMail;
	}

	@JSONField(format = "yyyy-MM-dd", name = "register_date")
	public Date getRegisterDate() {
		return registerDate;
	}

	@JSONField(format = "yyyy-MM-dd", name = "register_date")
	public void setRegisterDate(Date registerDate) {
		this.registerDate = registerDate;
	}

	@JSONField(name = "fax_number")
	public String getFaxNumber() {
		return faxNumber;
	}

	@JSONField(name = "fax_number")
	public void setFaxNumber(String faxNumber) {
		this.faxNumber = faxNumber;
	}

	@JSONField(name = "industry_")
	public String getIndustry() {
		return industry;
	}

	@JSONField(name = "industry_")
	public void setIndustry(String industry) {
		this.industry = industry;
	}

	@JSONField(name = "number_people")
	public String getNumberPeople() {
		return numberPeople;
	}

	@JSONField(name = "number_people")
	public void setNumberPeople(String numberPeople) {
		this.numberPeople = numberPeople;
	}

	@JSONField(format = "yyyy-MM-dd", name = "license_date")
	public Date getLicenseDate() {
		return licenseDate;
	}

	@JSONField(format = "yyyy-MM-dd", name = "license_date")
	public void setLicenseDate(Date licenseDate) {
		this.licenseDate = licenseDate;
	}

	@JSONField(name = "org_code_date")
	public Date getOrgCodeDate() {
		return orgCodeDate;
	}

	@JSONField(name = "org_code_date")
	public void setOrgCodeDate(Date orgCodeDate) {
		this.orgCodeDate = orgCodeDate;
	}

	@JSONField(name = "tax_no_country")
	public String getTaxNoCountry() {
		return taxNoCountry;
	}

	@JSONField(name = "tax_no_country")
	public void setTaxNoCountry(String taxNoCountry) {
		this.taxNoCountry = taxNoCountry;
	}

	@JSONField(name = "tax_no_place")
	public String getTaxNoPlace() {
		return taxNoPlace;
	}

	@JSONField(name = "tax_no_place")
	public void setTaxNoPlace(String taxNoPlace) {
		this.taxNoPlace = taxNoPlace;
	}

	@JSONField(name = "credit_no")
	public String getCreditNo() {
		return creditNo;
	}

	@JSONField(name = "credit_no")
	public void setCreditNo(String creditNo) {
		this.creditNo = creditNo;
	}

	@JSONField(name = "register_amount_type")
	public String getRegisterAmountType() {
		return registerAmountType;
	}

	@JSONField(name = "register_amount_type")
	public void setRegisterAmountType(String registerAmountType) {
		this.registerAmountType = registerAmountType;
	}

	@JSONField(name = "register_amount_ratio")
	public BigDecimal getRegisterAmountRatio() {
		return registerAmountRatio;
	}

	@JSONField(name = "register_amount_ratio")
	public void setRegisterAmountRatio(BigDecimal registerAmountRatio) {
		this.registerAmountRatio = registerAmountRatio;
	}

	@JSONField(format = "yyyy-MM-dd", name = "register_amount_date")
	public Date getRegisterAmountDate() {
		return registerAmountDate;
	}

	@JSONField(format = "yyyy-MM-dd", name = "register_amount_date")
	public void setRegisterAmountDate(Date registerAmountDate) {
		this.registerAmountDate = registerAmountDate;
	}

	@JSONField(name = "is_house")
	public String getIsHouse() {
		return isHouse;
	}

	@JSONField(name = "is_house")
	public void setIsHouse(String isHouse) {
		this.isHouse = isHouse;
	}

	@JSONField(format = "yyyy-MM-dd", name = "ic_date")
	public Date getIcDate() {
		return icDate;
	}

	@JSONField(format = "yyyy-MM-dd", name = "ic_date")
	public void setIcDate(Date icDate) {
		this.icDate = icDate;
	}

	@JSONField(name = "postcode_")
	public String getPostcode() {
		return postcode;
	}

	@JSONField(name = "postcode_")
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	@JSONField(name = "contacts_name")
	public String getContactsName() {
		return contactsName;
	}

	@JSONField(name = "contacts_name")
	public void setContactsName(String contactsName) {
		this.contactsName = contactsName;
	}

	@JSONField(name = "contacts_tel")
	public String getContactsTel() {
		return contactsTel;
	}

	@JSONField(name = "contacts_tel")
	public void setContactsTel(String contactsTel) {
		this.contactsTel = contactsTel;
	}

	@JSONField(name = "contacts_mail")
	public String getContactsMail() {
		return contactsMail;
	}

	@JSONField(name = "contacts_mail")
	public void setContactsMail(String contactsMail) {
		this.contactsMail = contactsMail;
	}

	@JSONField(name = "last_year_assets")
	public BigDecimal getLastYearAssets() {
		return lastYearAssets;
	}

	@JSONField(name = "last_year_assets")
	public void setLastYearAssets(BigDecimal lastYearAssets) {
		this.lastYearAssets = lastYearAssets;
	}

	@JSONField(name = "last_year_debt")
	public BigDecimal getLastYearDebt() {
		return lastYearDebt;
	}

	@JSONField(name = "last_year_debt")
	public void setLastYearDebt(BigDecimal lastYearDebt) {
		this.lastYearDebt = lastYearDebt;
	}

	@JSONField(name = "last_year_income")
	public BigDecimal getLastYearIncome() {
		return lastYearIncome;
	}

	@JSONField(name = "last_year_income")
	public void setLastYearIncome(BigDecimal lastYearIncome) {
		this.lastYearIncome = lastYearIncome;
	}

	@JSONField(name = "year_before_last_income")
	public BigDecimal getYearBeforeLastIncome() {
		return yearBeforeLastIncome;
	}

	@JSONField(name = "year_before_last_income")
	public void setYearBeforeLastIncome(BigDecimal yearBeforeLastIncome) {
		this.yearBeforeLastIncome = yearBeforeLastIncome;
	}

	@JSONField(name = "early_warning_amount")
	public BigDecimal getEarlyWarningAmount() {
		return earlyWarningAmount;
	}

	@JSONField(name = "early_warning_amount")
	public void setEarlyWarningAmount(BigDecimal earlyWarningAmount) {
		this.earlyWarningAmount = earlyWarningAmount;
	}

	@JSONField(name = "last_year_cost")
	public BigDecimal getLastYearCost() {
		return lastYearCost;
	}

	@JSONField(name = "last_year_cost")
	public void setLastYearCost(BigDecimal lastYearCost) {
		this.lastYearCost = lastYearCost;
	}

	@Override
	public String toString() {
		return "V2EnterpriseVo [enterpriseFullName=" + enterpriseFullName + ", enterpriseName=" + enterpriseName
				+ ", adminAccountNumber=" + adminAccountNumber + ", adminAccountMail=" + adminAccountMail
				+ ", registerDate=" + registerDate + ", fixedPhone=" + fixedPhone + ", faxNumber=" + faxNumber
				+ ", industry=" + industry + ", numberPeople=" + numberPeople + ", licenseNo=" + licenseNo
				+ ", licenseDate=" + licenseDate + ", orgCodeNo=" + orgCodeNo + ", orgCodeDate=" + orgCodeDate
				+ ", taxNoCountry=" + taxNoCountry + ", taxNoPlace=" + taxNoPlace + ", creditNo=" + creditNo + ", type="
				+ type + ", registerAmount=" + registerAmount + ", registerAmountType=" + registerAmountType
				+ ", registerAmountRatio=" + registerAmountRatio + ", registerAmountDate=" + registerAmountDate
				+ ", isHouse=" + isHouse + ", icDate=" + icDate + ", provinceId=" + provinceId + ", cityId=" + cityId
				+ ", areaId=" + areaId + ", address=" + address + ", postcode=" + postcode + ", legalName=" + legalName
				+ ", legalCardId=" + legalCardId + ", contactsName=" + contactsName + ", contactsTel=" + contactsTel
				+ ", contactsMail=" + contactsMail + ", lastYearAssets=" + lastYearAssets + ", lastYearDebt="
				+ lastYearDebt + ", lastYearIncome=" + lastYearIncome + ", yearBeforeLastIncome=" + yearBeforeLastIncome
				+ ", earlyWarningAmount=" + earlyWarningAmount + ", remark=" + remark + ", lastYearCost=" + lastYearCost
				+ "]";
	}

}
