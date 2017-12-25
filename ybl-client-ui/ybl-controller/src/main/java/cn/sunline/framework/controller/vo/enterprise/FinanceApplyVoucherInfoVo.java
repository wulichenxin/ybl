package cn.sunline.framework.controller.vo.enterprise;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.alibaba.druid.util.StringUtils;
import com.alibaba.fastjson.annotation.JSONField;

public class FinanceApplyVoucherInfoVo {

	/**
	 * 融资申请id
	 */
	@JSONField(name = "finance_apply_id")
	private Long financeApplyId;
	/**
	 * 凭证id
	 */
	@JSONField(name = "voucher_id")
	private Long voucherId;
	/**
	 * 凭证状态
	 */
	@JSONField(name = "voucher_status")
	private String voucherStatus;
	/**
	 * 企业id
	 */
	@JSONField(name = "enterprise_id")
	private Long enterpriseId;
	/**
	 * 凭证编号
	 */
	@JSONField(name = "voucher_no")
	private String voucherNo;
	/**
	 * 所属核心企业
	 */
	@JSONField(name = "enterprise_memeber_id")
	private Long enterpriseMemeberId;
	/**
	 * 凭证金额
	 */
	@JSONField(name = "amount_")
	private BigDecimal amount;

	/**
	 * 凭证类型
	 */
	@JSONField(name = "type_")
	private String type;
	/**
	 * 凭证到期日
	 */
	@JSONField(name = "expire_date",format="yyyy-MM-dd")
	private String expireDate;
	/**
	 * 企业名称
	 */
	@JSONField(name = "enterprise_name")
	private String enterpriseName;

	public Long getFinanceApplyId() {
		return financeApplyId;
	}

	public void setFinanceApplyId(Long financeApplyId) {
		this.financeApplyId = financeApplyId;
	}

	public Long getVoucherId() {
		return voucherId;
	}

	public void setVoucherId(Long voucherId) {
		this.voucherId = voucherId;
	}

	public String getVoucherStatus() {
		return voucherStatus;
	}

	public void setVoucherStatus(String voucherStatus) {
		this.voucherStatus = voucherStatus;
	}

	public Long getEnterpriseId() {
		return enterpriseId;
	}

	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

	public String getVoucherNo() {
		return voucherNo;
	}

	public void setVoucherNo(String voucherNo) {
		this.voucherNo = voucherNo;
	}

	public Long getEnterpriseMemeberId() {
		return enterpriseMemeberId;
	}

	public void setEnterpriseMemeberId(Long enterpriseMemeberId) {
		this.enterpriseMemeberId = enterpriseMemeberId;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getExpireDate() {
		return expireDate;
	}

	public void setExpireDate(String expireDate) {
		if(!StringUtils.isEmpty(expireDate)){  
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
			expireDate = sdf.format(new Date(Long.valueOf(expireDate)));
        }
		this.expireDate = expireDate;
	}

	public String getEnterpriseName() {
		return enterpriseName;
	}

	public void setEnterpriseName(String enterpriseName) {
		this.enterpriseName = enterpriseName;
	}

}
