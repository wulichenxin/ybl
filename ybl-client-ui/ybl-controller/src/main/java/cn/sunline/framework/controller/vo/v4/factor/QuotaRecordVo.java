package cn.sunline.framework.controller.vo.v4.factor;

import java.math.BigDecimal;
import java.util.Date;

import javax.validation.constraints.Digits;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;
/**
 * 
 *额度调整记录
 */
public class QuotaRecordVo extends AbstractEntity{

	/**
	 * 
	 */
	private static final long serialVersionUID = 5781202752703486772L;
	/**
	 * 资金方id
	 */
	@JSONField(name = "enterprise_id")
	private Long enterpriseId;//enterprise_id;
	/**
	 * 合同id
	 */
	@JSONField(name = "contract_id")
	private Long contractId;//contract_id;
	/**
	 * 额度值
	 */
	@NotNull(message="金额不能为空")
	@Digits(fraction = 4, integer = 28,message="金额不合法")
	@JSONField(name = "quota_")
	private BigDecimal quota;//quota_;
	/**
	 * 生效日期
	 */
	@JSONField(name = "effective_time",format="yyyy-MM-dd HH:mm:ss")
	private Date effectiveTime;//effective_time;
	/**
	 * 备注
	 */
	@JSONField(name = "remark_")
	@Size(max=127,message="备注信息过长,请设置在127以内")
	private String remark;//remark_;
	/**
	 * 修改人真实姓名
	 */
	@JSONField(name = "real_name")
	private String realName;//real_name;

	public Long getEnterpriseId() {
		return enterpriseId;
	}

	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

	public Long getContractId() {
		return contractId;
	}
	
	public void setContractId(Long contractId) {
		this.contractId = contractId;
	}
	
	public BigDecimal getQuota() {
		return quota;
	}
	
	public void setQuota(BigDecimal quota) {
		this.quota = quota;
	}
	
	public Date getEffectiveTime() {
		return effectiveTime;
	}

	public void setEffectiveTime(Date effectiveTime) {
		this.effectiveTime = effectiveTime;
	}
	
	public String getRemark() {
		return remark;
	}
	
	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getRealName() {
		return realName;
	}
	
	public void setRealName(String realName) {
		this.realName = realName;
	}
	
}
