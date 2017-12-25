package cn.sunline.framework.controller.vo.v2;

import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.date.DateUtils;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

//回购行表
public class V2BuybackLineRecordVo extends AbstractEntity {

	//回购主表id
	@JSONField(name = "buyback_id")
	private Long buybackId;
	
	//交易流水号
	@JSONField(name = "trx_number")
	private String trxNumber;
	
	//本次回购金额
	@JSONField(name = "amount_")
	private BigDecimal amount;
	
	//回购时间
	@JSONField(name = "pay_time")
	private Date payTime;
	
	//接受前端的时间
	private String payTimeStr;
	
	//备注
	@JSONField(name = "comment_")
	private String comment;
	
	//账款id
	@JSONField(name = "accounts_receivable_id")
	private Long accountsReceivableId;
		
	//企业id
	@JSONField(name = "enterprise_id")
	private Long enterpriseId;
	
	
	//操作人用户名
	@JSONField(name = "user_name")
	private String userName;
		
	
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Long getBuybackId() {
		return buybackId;
	}

	public void setBuybackId(Long buybackId) {
		this.buybackId = buybackId;
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

	public Long getAccountsReceivableId() {
		return accountsReceivableId;
	}

	public void setAccountsReceivableId(Long accountsReceivableId) {
		this.accountsReceivableId = accountsReceivableId;
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
