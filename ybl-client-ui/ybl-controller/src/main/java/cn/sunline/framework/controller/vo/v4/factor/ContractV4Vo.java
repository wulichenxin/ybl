package cn.sunline.framework.controller.vo.v4.factor;

import java.math.BigDecimal;

import javax.validation.constraints.Digits;
import javax.validation.constraints.NotNull;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;
/**
 * 合同复合类
 * @author WIN
 *
 */
public class ContractV4Vo extends AbstractEntity{

	/**
	 * 
	 */
	private static final long serialVersionUID = 2457884028317883088L;
	/**
	 * 主合同号
	 */
	@JSONField(name = "master_contract_no")
	private String masterContractNo;//master_contract_no;
	/**
	 * 融资方id
	 */
	private Long supplier;
	/**
	 * 资金方id
	 */
	private Long factor;
	/**
	 * 授信额度
	 */
	@JSONField(name = "credit_amount")
	private BigDecimal creditAmount;
	/**
	 * 合同状态1-资金方签署2-融资方签署3-都未签署(资金方上传,没签署)
	 */
	private Integer  status;
	/**
	 * 预警额度
	 */
	@NotNull(message="金额不能为空")
	@Digits(fraction = 4, integer = 28,message="金额数字不合法")
	@JSONField(name = "early_warning_amount")
	private BigDecimal earlyWarningAmount;
	/**
	 * 内容
	 */
	private String content;
	public String getMasterContractNo() {
		return masterContractNo;
	}
	public void setMasterContractNo(String masterContractNo) {
		this.masterContractNo = masterContractNo;
	}
	public Long getSupplier() {
		return supplier;
	}
	public void setSupplier(Long supplier) {
		this.supplier = supplier;
	}
	public Long getFactor() {
		return factor;
	}
	public void setFactor(Long factor) {
		this.factor = factor;
	}
	public BigDecimal getCreditAmount() {
		return creditAmount;
	}
	public void setCreditAmount(BigDecimal creditAmount) {
		this.creditAmount = creditAmount;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public BigDecimal getEarlyWarningAmount() {
		return earlyWarningAmount;
	}
	public void setEarlyWarningAmount(BigDecimal earlyWarningAmount) {
		this.earlyWarningAmount = earlyWarningAmount;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
}
