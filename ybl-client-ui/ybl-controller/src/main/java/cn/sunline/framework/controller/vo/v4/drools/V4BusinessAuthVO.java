package cn.sunline.framework.controller.vo.v4.drools;

import java.math.BigDecimal;
import java.util.Date;

import javax.validation.constraints.Digits;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.springframework.format.annotation.DateTimeFormat;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;
/**
 * 业务认证VO
 * @author pc
 *
 */
public class V4BusinessAuthVO extends AbstractEntity{

	/**
	 * 
	 */
	private static final long serialVersionUID = -4556477614419933643L;
	

	@JSONField(name = "enterprise_id")
	private Long enterpriseId;//企业id

	@JSONField(name = "auth_type")
	private Integer authType;//业务认证类型
	
	@JSONField(name = "enterprise_name")
	private String enterpriseName;//企业名称
	
	@JSONField(name = "industry")
	private String industry;//所属行业
	
	@JSONField(name = "register_address")
	private String registerAddress;//注册地址
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JSONField(name = "register_date" , format = "yyyy-MM-dd")
	private Date registerDate;//注册日期
	
	@Digits(fraction = 4, integer = 28,message="注册资本格式错误")
	@JSONField(name = "register_capital")
	private BigDecimal registerCapital;//注册资本
	
	@Digits(fraction = 4, integer = 28,message="实缴资本格式错误")
	@JSONField(name = "paid_capital")
	private BigDecimal paidCapital;//实缴资本
	
	@JSONField(name = "office_address")
	private String officeAddress;//办公地址
	
	@JSONField(name = "social_credit_code")
	private String socialCreditCode;//社会信用代码

	@JSONField(name = "annual_survey_situation")
	private String annualSurveySituation;//年检情况
	
	@JSONField(name = "contacts")
	private String contacts;//联系人
	
	@JSONField(name = "contacts_phone")
	private String contactsPhone;//联系人电话
	
	@JSONField(name = "contacts_email")
	private String contactsEmail;//联系人邮箱
	
	@JSONField(name = "enterprise_phone")
	private String enterprisePhone;//公司电话
	
	@NotBlank(message="实际控制人姓名不能为空")
    @Length(min=1,max=25)
	@JSONField(name = "controller_name")
	private String controllerName;//实际控制人
	
	@JSONField(name = "controller_gender")
	private Integer controllerGender;//实际控制人性别1-男2-女
	
	@Digits(fraction = 4, integer = 28) 
	@JSONField(name = "controller_age")
	private Integer controllerAge;//实际控制人年龄
	
	@JSONField(name = "controller_card_id")
	private String controllerCardId;//实际控制人身份证
	
	@JSONField(name = "controller_nationality")
	private String controllerNationality;//实际控制人国籍
	
	@Digits(fraction = 4, integer = 28) 
	@JSONField(name = "controller_work_year")
	private Integer controllerWorkYear;//实际控制人工作年限
	
	@JSONField(name = "controller_office_phone")
	private String controllerOfficePhone;//实际控制人办公电话
	
	@JSONField(name = "controller_marital_status")
	private String controllerMaritalStatus;//实际控制人婚姻状况
	
	@JSONField(name = "controller_home_address")
	private String controllerHomeAddress;//实际控制人家庭住址
	
	@NotBlank(message="法人姓名不能为空")
    @Length(min=1,max=25)
	@JSONField(name = "legal_name")
	private String legalName ;//法人姓名
	
	@JSONField(name = "legal_card_id")
	private String legalCardId;//法人身份证

	@JSONField(name = "legal_nationality")
	private String legalNationality;//法人国籍
	
	@Digits(fraction = 4, integer = 28) 
	@JSONField(name = "legal_work_year")
	private Integer legalWorkYear;//法人工作年限
	
	@JSONField(name = "legal_office_phone")
	private String legalOfficePhone;//法人办公电话
	
	@JSONField(name = "legal_marital_status")
	private String legalMaritalStatus;//法人婚姻状况
	
	@JSONField(name = "legal_home_address")
	private String legalHomeAddress;//法人家庭住址
	
	@JSONField(name = "legal_gender")
	private Integer legalGender;//法人性别1-男2-女
	
	@Digits(fraction = 4, integer = 28) 
	@JSONField(name = "legal_age")
	private Integer legalAge;//法人年龄
	
	@JSONField(name = "business_scope")
	private String businessScope;//经营范围
	
	@JSONField(name = "history")
	private String history;//历史沿革
	
	@JSONField(name = "auth_status")
	private Integer authStatus;//认证状态
	
	@JSONField(name = "ids")
	private String ids;//查询用,融资申请资方查找
	
	@JSONField(name = "is_check")
	private Boolean isCheck;//查询用,融资申请资方查找

	public Long getEnterpriseId() {
		return enterpriseId;
	}

	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

	public Integer getAuthType() {
		return authType;
	}

	public void setAuthType(Integer authType) {
		this.authType = authType;
	}

	public String getEnterpriseName() {
		return enterpriseName;
	}

	public void setEnterpriseName(String enterpriseName) {
		this.enterpriseName = enterpriseName;
	}

	public String getIndustry() {
		return industry;
	}

	public void setIndustry(String industry) {
		this.industry = industry;
	}

	public String getRegisterAddress() {
		return registerAddress;
	}

	public void setRegisterAddress(String registerAddress) {
		this.registerAddress = registerAddress;
	}

	public Date getRegisterDate() {
		return registerDate;
	}

	public void setRegisterDate(Date registerDate) {
		this.registerDate = registerDate;
	}

	public BigDecimal getRegisterCapital() {
		return registerCapital;
	}

	public void setRegisterCapital(BigDecimal registerCapital) {
		this.registerCapital = registerCapital;
	}

	public BigDecimal getPaidCapital() {
		return paidCapital;
	}

	public void setPaidCapital(BigDecimal paidCapital) {
		this.paidCapital = paidCapital;
	}

	public String getOfficeAddress() {
		return officeAddress;
	}

	public void setOfficeAddress(String officeAddress) {
		this.officeAddress = officeAddress;
	}

	public String getSocialCreditCode() {
		return socialCreditCode;
	}

	public void setSocialCreditCode(String socialCreditCode) {
		this.socialCreditCode = socialCreditCode;
	}

	public String getAnnualSurveySituation() {
		return annualSurveySituation;
	}

	public void setAnnualSurveySituation(String annualSurveySituation) {
		this.annualSurveySituation = annualSurveySituation;
	}

	public String getContacts() {
		return contacts;
	}

	public void setContacts(String contacts) {
		this.contacts = contacts;
	}

	public String getContactsPhone() {
		return contactsPhone;
	}

	public void setContactsPhone(String contactsPhone) {
		this.contactsPhone = contactsPhone;
	}

	public String getContactsEmail() {
		return contactsEmail;
	}

	public void setContactsEmail(String contactsEmail) {
		this.contactsEmail = contactsEmail;
	}

	public String getEnterprisePhone() {
		return enterprisePhone;
	}

	public void setEnterprisePhone(String enterprisePhone) {
		this.enterprisePhone = enterprisePhone;
	}

	public String getControllerName() {
		return controllerName;
	}

	public void setControllerName(String controllerName) {
		this.controllerName = controllerName;
	}

	public Integer getControllerGender() {
		return controllerGender;
	}

	public void setControllerGender(Integer controllerGender) {
		this.controllerGender = controllerGender;
	}

	public Integer getControllerAge() {
		return controllerAge;
	}

	public void setControllerAge(Integer controllerAge) {
		this.controllerAge = controllerAge;
	}

	public String getControllerCardId() {
		return controllerCardId;
	}

	public void setControllerCardId(String controllerCardId) {
		this.controllerCardId = controllerCardId;
	}

	public String getControllerNationality() {
		return controllerNationality;
	}

	public void setControllerNationality(String controllerNationality) {
		this.controllerNationality = controllerNationality;
	}

	public Integer getControllerWorkYear() {
		return controllerWorkYear;
	}

	public void setControllerWorkYear(Integer controllerWorkYear) {
		this.controllerWorkYear = controllerWorkYear;
	}

	public String getControllerOfficePhone() {
		return controllerOfficePhone;
	}

	public void setControllerOfficePhone(String controllerOfficePhone) {
		this.controllerOfficePhone = controllerOfficePhone;
	}

	public String getControllerMaritalStatus() {
		return controllerMaritalStatus;
	}

	public void setControllerMaritalStatus(String controllerMaritalStatus) {
		this.controllerMaritalStatus = controllerMaritalStatus;
	}

	public String getControllerHomeAddress() {
		return controllerHomeAddress;
	}

	public void setControllerHomeAddress(String controllerHomeAddress) {
		this.controllerHomeAddress = controllerHomeAddress;
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

	public String getLegalNationality() {
		return legalNationality;
	}

	public void setLegalNationality(String legalNationality) {
		this.legalNationality = legalNationality;
	}

	public Integer getLegalWorkYear() {
		return legalWorkYear;
	}

	public void setLegalWorkYear(Integer legalWorkYear) {
		this.legalWorkYear = legalWorkYear;
	}

	public String getLegalOfficePhone() {
		return legalOfficePhone;
	}

	public void setLegalOfficePhone(String legalOfficePhone) {
		this.legalOfficePhone = legalOfficePhone;
	}

	public String getLegalMaritalStatus() {
		return legalMaritalStatus;
	}

	public void setLegalMaritalStatus(String legalMaritalStatus) {
		this.legalMaritalStatus = legalMaritalStatus;
	}

	public String getLegalHomeAddress() {
		return legalHomeAddress;
	}

	public void setLegalHomeAddress(String legalHomeAddress) {
		this.legalHomeAddress = legalHomeAddress;
	}

	public Integer getLegalGender() {
		return legalGender;
	}

	public void setLegalGender(Integer legalGender) {
		this.legalGender = legalGender;
	}

	public Integer getLegalAge() {
		return legalAge;
	}

	public void setLegalAge(int legalAge) {
		this.legalAge = legalAge;
	}

	public String getBusinessScope() {
		return businessScope;
	}

	public void setBusinessScope(String businessScope) {
		this.businessScope = businessScope;
	}

	public String getHistory() {
		return history;
	}

	public void setHistory(String history) {
		this.history = history;
	}

	public Integer getAuthStatus() {
		return authStatus;
	}

	public void setAuthStatus(Integer authStatus) {
		this.authStatus = authStatus;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public Boolean getIsCheck() {
		return isCheck;
	}

	public void setIsCheck(Boolean isCheck) {
		this.isCheck = isCheck;
	}

	
}
