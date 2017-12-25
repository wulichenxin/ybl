package cn.sunline.framework.controller.vo.v2;

import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.date.DateUtils;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

//退款行表
public class V2ReimburseLineRecordVo extends AbstractEntity {

	//退款主表id
	@JSONField(name = "reimburse_id")
	private Long reimburseId;
	
	//本次退款金额
	@JSONField(name = "amount_")
	private BigDecimal amount;
	
	//退款时间
	@JSONField(name = "pay_time")
	private Date payTime;
	
	//交易流水号
	@JSONField(name = "trx_number")
	private String trxNumber;
	
	
	//备注
	@JSONField(name = "comment_")
	private String comment;
	
	//账款id
	@JSONField(name = "accounts_receivable_id")
	private Long accountsReceivableId;
	
	//企业id
	@JSONField(name = "enterprise_id")
	private Long enterpriseId;
	
	//操作人昵称
	@JSONField(name = "nick_name")
	private String nickName;
	
	//操作人真实名称
	@JSONField(name = "real_name")
	private String realName;
	
	//操作人用户名
	@JSONField(name = "user_name")
	private String userName;
		
	
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	//前端传过来的支付时间
	private String payTimeStr;

	public Long getReimburseId() {
		return reimburseId;
	}

	public void setReimburseId(Long reimburseId) {
		this.reimburseId = reimburseId;
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
	
	
	public String getTrxNumber() {
		return trxNumber;
	}

	public void setTrxNumber(String trxNumber) {
		this.trxNumber = trxNumber;
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
	
	
}
