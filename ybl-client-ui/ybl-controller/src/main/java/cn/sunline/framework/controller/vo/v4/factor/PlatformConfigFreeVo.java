package cn.sunline.framework.controller.vo.v4.factor;

import java.math.BigDecimal;
import java.util.Date;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

import com.alibaba.fastjson.annotation.JSONField;

/**
 * 平台费用配置
 */
public class PlatformConfigFreeVo extends AbstractEntity {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 713598706677802287L;
	
	/*企业id*/
	@JSONField(name="enterprise_id")
	private Integer enterpriseId;
	/*认证类型id*/
	@JSONField(name="auth_type")
	private Integer authType;
	/*费率*/
	@JSONField(name="rate")
	private BigDecimal rate;
	/*生效日期*/
	@JSONField(name="start_date")
	private Date startDate;
	/*减免费率*/
	@JSONField(name="reduction_rate")
	private BigDecimal reductionRate;
	/*备注*/
	@JSONField(name="remark")
	private String remark;
	public Integer getEnterpriseId() {
		return enterpriseId;
	}
	public void setEnterpriseId(Integer enterpriseId) {
		this.enterpriseId = enterpriseId;
	}
	public Integer getAuthType() {
		return authType;
	}
	public void setAuthType(Integer authType) {
		this.authType = authType;
	}
	public BigDecimal getRate() {
		return rate;
	}
	public void setRate(BigDecimal rate) {
		this.rate = rate;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public BigDecimal getReductionRate() {
		return reductionRate;
	}
	public void setReductionRate(BigDecimal reductionRate) {
		this.reductionRate = reductionRate;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	
	
}
