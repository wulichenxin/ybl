package cn.sunline.framework.controller.vo.v4.supplier;


import java.math.BigDecimal;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * 平台费用设置表
 * @author lyy
 *
 */
public class PlatformConfigFree extends AbstractEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2679063192545385837L;
	/**
	 * 企业id
	 */
	private Long enterpriseId;
	/**
	 * 业务id
	 */
	private Long businessId;
	/**
	 * 业务认证类型1-融资方2-资金方3-核心企业
	 */
	private int authType;
	/**
	 * 费率
	 */
	private BigDecimal rate;
	/**
	 * 生效日期
	 */
	@DateTimeFormat(pattern = "yyyy-MM-dd") 
	private Date startDate;
	/**
	 * 减免费率
	 */
	private BigDecimal reductionRate;
	/**
	 * 备注
	 */
	private String remark;
	/**
	 * 企业名称
	 */
	private String enterpriseName;
	/**
	 * 社会统一信用证号码
	 */
	private String socialCreditCode;
	@JSONField(name="business_id")
	public Long getBusinessId() {
		return businessId;
	}
	@JSONField(name="business_id")
	public void setBusinessId(Long businessId) {
		this.businessId = businessId;
	}
	@JSONField(name="social_credit_code")
	public String getSocialCreditCode() {
		return socialCreditCode;
	}
	@JSONField(name="social_credit_code")
	public void setSocialCreditCode(String socialCreditCode) {
		this.socialCreditCode = socialCreditCode;
	}
	@JSONField(name="enterprise_name")
	public String getEnterpriseName() {
		return enterpriseName;
	}
	@JSONField(name="enterprise_name")
	public void setEnterpriseName(String enterpriseName) {
		this.enterpriseName = enterpriseName;
	}
	@JSONField(name="enterprise_id")
	public Long getEnterpriseId() {
		return enterpriseId;
	}
	@JSONField(name="enterprise_id")
	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}
	@JSONField(name="auth_type")
	public int getAuthType() {
		return authType;
	}
	@JSONField(name="auth_type")
	public void setAuthType(int authType) {
		this.authType = authType;
	}
	@JSONField(name="rate")
	public BigDecimal getRate() {
		return rate;
	}
	@JSONField(name="rate")
	public void setRate(BigDecimal rate) {
		this.rate = rate;
	}
	@JSONField(name="start_date")
	public Date getStartDate() {
		return startDate;
	}
	@JSONField(name="start_date")
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	@JSONField(name="reduction_rate")
	public BigDecimal getReductionRate() {
		return reductionRate;
	}
	@JSONField(name="reduction_rate")
	public void setReductionRate(BigDecimal reductionRate) {
		this.reductionRate = reductionRate;
	}
	@JSONField(name="remark")
	public String getRemark() {
		return remark;
	}
	@JSONField(name="remark")
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
}