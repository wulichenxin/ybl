package cn.sunline.framework.controller.vo;

import java.math.BigDecimal;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;
/**
 * 提现记录实现类
 * @author MaiBenBen
 *
 */
public class WidthdralRecordVo extends AbstractEntity {
	
	private static final long serialVersionUID = -8644490575337483738L;
	
	/* 企业表id */
	private Long enterpriseId=-1L;
	/* 所属会员id */
	private Long memberId=-1L;
	/*编号number_*/
	private String number;
	/*提现金额*/
	private BigDecimal amount;
	/*手续费*/
	private BigDecimal fee;
	/*提现银行*/
	private String bankName;
	/*提现账号*/
	private String accountNo;
	/*状态：成功：success 失败：fail 处理中：processing*/
	private String status;
	
	@JSONField(name = "enterprise_id")
	public Long getEnterpriseId() {
		return enterpriseId;
	}

	@JSONField(name = "enterprise_id")
	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

	@JSONField(name = "member_id")
	public Long getMemberId() {
		return memberId;
	}

	@JSONField(name = "member_id")
	public void setMemberId(Long memberId) {
		this.memberId = memberId;
	}
	@JSONField(name = "number_")
	public String getNumber() {
		return number;
	}
	@JSONField(name = "number_")
	public void setNumber(String number) {
		this.number = number;
	}
	@JSONField(name = "amount_")
	public BigDecimal getAmount() {
		return amount;
	}
	@JSONField(name = "amount_")
	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}
	@JSONField(name = "fee_")
	public BigDecimal getFee() {
		return fee;
	}
	@JSONField(name = "fee_")
	public void setFee(BigDecimal fee) {
		this.fee = fee;
	}
	@JSONField(name = "bank_name")
	public String getBankName() {
		return bankName;
	}
	@JSONField(name = "bank_name")
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	@JSONField(name = "account_no")
	public String getAccountNo() {
		return accountNo;
	}
	@JSONField(name = "account_no")
	public void setAccountNo(String accountNo) {
		this.accountNo = accountNo;
	}
	@JSONField(name = "status_")
	public String getStatus() {
		return status;
	}
	@JSONField(name = "status_")
	public void setStatus(String status) {
		this.status = status;
	}
}
