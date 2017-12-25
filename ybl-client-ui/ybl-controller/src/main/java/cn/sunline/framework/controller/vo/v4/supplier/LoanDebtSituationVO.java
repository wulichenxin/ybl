package cn.sunline.framework.controller.vo.v4.supplier;

import java.math.BigDecimal;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;


/**
 * 企业借款个人负债信息管理VO
 * @author jiangchangyuan
 *
 */
public class LoanDebtSituationVO extends AbstractEntity{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	/*融资申请id*/
	private Integer financingApplyId;
	
	/*借款金额*/
	private BigDecimal loanAmount;
	
	/*期限*/
	private String term;
	
	/*债权人*/
	private String creditor;
	
	/*借款日期*/
	private Date loanDate;
	
	/*到期日期*/
	private Date expireDate;
	
	/*余额*/
	private BigDecimal balance;
	
	/*备注*/
	private String remark;
	
	/*类型0-企业借款1-个人负债*/
	private int type;

	@JSONField(name = "financing_apply_id")
	public Integer getFinancingApplyId() {
		return financingApplyId;
	}

	@JSONField(name = "financing_apply_id")
	public void setFinancingApplyId(Integer financingApplyId) {
		this.financingApplyId = financingApplyId;
	}

	@JSONField(name = "loan_amount")
	public BigDecimal getLoanAmount() {
		return loanAmount;
	}

	@JSONField(name = "loan_amount")
	public void setLoanAmount(BigDecimal loanAmount) {
		this.loanAmount = loanAmount;
	}

	@JSONField(name = "term")
	public String getTerm() {
		return term;
	}

	@JSONField(name = "term")
	public void setTerm(String term) {
		this.term = term;
	}

	@JSONField(name = "creditor")
	public String getCreditor() {
		return creditor;
	}

	@JSONField(name = "creditor")
	public void setCreditor(String creditor) {
		this.creditor = creditor;
	}
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JSONField(name = "loan_date",format="yyyy-MM-dd")
	public Date getLoanDate() {
		return loanDate;
	}
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JSONField(name = "loan_date",format="yyyy-MM-dd")
	public void setLoanDate(Date loanDate) {
		this.loanDate = loanDate;
	}

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JSONField(name = "expire_date",format="yyyy-MM-dd")
	public Date getExpireDate() {
		return expireDate;
	}

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JSONField(name = "expire_date",format="yyyy-MM-dd")
	public void setExpireDate(Date expireDate) {
		this.expireDate = expireDate;
	}

	@JSONField(name = "balance")
	public BigDecimal getBalance() {
		return balance;
	}

	@JSONField(name = "balance")
	public void setBalance(BigDecimal balance) {
		this.balance = balance;
	}

	@JSONField(name = "remark")
	public String getRemark() {
		return remark;
	}

	@JSONField(name = "remark")
	public void setRemark(String remark) {
		this.remark = remark;
	}

	@JSONField(name = "type")
	public int getType() {
		return type;
	}

	@JSONField(name = "type")
	public void setType(int type) {
		this.type = type;
	}

	
}
