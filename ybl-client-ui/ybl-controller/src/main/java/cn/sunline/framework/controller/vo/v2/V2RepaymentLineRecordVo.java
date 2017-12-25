package cn.sunline.framework.controller.vo.v2;

import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.date.DateUtils;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

//还款记录行表V2
public class V2RepaymentLineRecordVo extends AbstractEntity {

	//还款主表id
	@JSONField(name = "repayment_id")
	private Long repaymentId;
	
	//交易流水号
	@JSONField(name = "trx_number")
	private String trxNumber;
	
	//本次还款款金额
	@JSONField(name = "amount_")
	private BigDecimal amount;
	
	//账款id
	@JSONField(name = "accounts_receivable_id")
	private Long accountsReceivableId;
	
	//还款时间
	@JSONField(name = "pay_time")
	private Date payTime;
	
	//接受前端的时间
	private String payTimeStr;
	
	//备注
	@JSONField(name = "comment_")
	private String comment;
	
	//企业id
	@JSONField(name = "enterprise_id")
	private Long enterpriseId;
	
	
	//操作人昵称
	@JSONField(name = "nick_name")
	private String nickName;
	
	//操作人真实名称
	@JSONField(name = "real_name")
	private String realName;
	
	//凭证编号
	@JSONField(name = "voucher_number")
	private String voucherNumber;
	
	
	//操作人用户名
	@JSONField(name = "user_name")
	private String userName;
		
	
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	
	public String getVoucherNumber() {
		return voucherNumber;
	}

	public void setVoucherNumber(String voucherNumber) {
		this.voucherNumber = voucherNumber;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public Long getRepaymentId() {
		return repaymentId;
	}

	public void setRepaymentId(Long repaymentId) {
		this.repaymentId = repaymentId;
	}

	public String getTrxNumber() {
		return trxNumber;
	}

	public void setTrxNumber(String trxNumber) {
		this.trxNumber = trxNumber;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public Long getAccountsReceivableId() {
		return accountsReceivableId;
	}

	public void setAccountsReceivableId(Long accountsReceivableId) {
		this.accountsReceivableId = accountsReceivableId;
	}

	public Date getPayTime() {
		return payTime;
	}

	public void setPayTime(Date payTime) {
		this.payTime = payTime;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public Long getEnterpriseId() {
		return enterpriseId;
	}

	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

	public String getPayTimeStr() {
		return payTimeStr;
	}

	public void setPayTimeStr(String payTimeStr) {
		if(StringUtils.isNullOrBlank(payTimeStr))
			return;
		this.payTime = DateUtils.toDate(payTimeStr);
		this.payTimeStr = payTimeStr;
	}
	
	
	
	
}
