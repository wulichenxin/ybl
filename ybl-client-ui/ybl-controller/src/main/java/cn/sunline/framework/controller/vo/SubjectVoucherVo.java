package cn.sunline.framework.controller.vo;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * 标的凭证表实体类
 * 
 * @author MaiBenBen
 *
 */
public class SubjectVoucherVo extends AbstractEntity {

	private static final long serialVersionUID = -5939446865827397820L;

	/* 企业表id */
	private Long enterpriseId;
	/* 凭证id */
	private Long voucherId;
	/* 凭证状态:已认证：certified 未认证：not_certified 认证失败：certify_fail */
	private String voucherStatus;
	/* 标的id */
	private Long loanSignId;

	@JSONField(name = "enterprise_id")
	public Long getEnterpriseId() {
		return enterpriseId;
	}

	@JSONField(name = "enterprise_id")
	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

	@JSONField(name = "voucher_id")
	public Long getVoucherId() {
		return voucherId;
	}

	@JSONField(name = "voucher_id")
	public void setVoucherId(Long voucherId) {
		this.voucherId = voucherId;
	}

	@JSONField(name = "voucher_status")
	public String getVoucherStatus() {
		return voucherStatus;
	}

	@JSONField(name = "voucher_status")
	public void setVoucherStatus(String voucherStatus) {
		this.voucherStatus = voucherStatus;
	}

	@JSONField(name = "loan_sign_id")
	public Long getLoanSignId() {
		return loanSignId;
	}

	@JSONField(name = "loan_sign_id")
	public void setLoanSignId(Long loanSignId) {
		this.loanSignId = loanSignId;
	}

}
