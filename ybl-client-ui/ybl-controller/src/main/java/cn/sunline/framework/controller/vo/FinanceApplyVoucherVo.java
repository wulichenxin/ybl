package cn.sunline.framework.controller.vo;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

public class FinanceApplyVoucherVo extends AbstractEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6791629919868042417L;

	// 融资申请id
	private Long financeApplyId;
	
	// 凭证id
	private Long voucherId;
	// 凭证状态
	private String voucherStatus;
	// 企业id
	private Long enterpriseId;

	@JSONField(name="finance_apply_id")
	public Long getFinanceApplyId() {
		return financeApplyId;
	}
	@JSONField(name="finance_apply_id")
	public void setFinanceApplyId(Long financeApplyId) {
		this.financeApplyId = financeApplyId;
	}
	@JSONField(name="voucher_id")
	public Long getVoucherId() {
		return voucherId;
	}
	@JSONField(name="voucher_id")
	public void setVoucherId(Long voucherId) {
		this.voucherId = voucherId;
	}
	@JSONField(name="voucher_status")
	public String getVoucherStatus() {
		return voucherStatus;
	}
	@JSONField(name="voucher_status")
	public void setVoucherStatus(String voucherStatus) {
		this.voucherStatus = voucherStatus;
	}
	@JSONField(name="enterprise_id")
	public Long getEnterpriseId() {
		return enterpriseId;
	}
	@JSONField(name="enterprise_id")
	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}
}
