package cn.sunline.framework.controller.vo;

import java.math.BigDecimal;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

public class FinanceApplySupplierVo extends AbstractEntity{

	/**
	 * 
	 */
	private static final long serialVersionUID = -1598757914845696509L;
	
	
	//融资产品id（标的/产品）
	private Long businessId;
	//融资主体
	private String financeBody;
	//供应商id
	private Long SupplierMemberId;
	//保理商id
	private Long factoringMemberId;
	//编号
	private String number;
	//申请金额
	private BigDecimal applyAmount;
	//还款日期
	private Date repaymentdate;
	//贷款期限
	private int loanPeriod;
	//期限类型
	private String periodType;
	//申请说明
	private String remark;
	//企业id
	private Long enterpriseId;
	//融资状态
	private String status;
	//项目名称
	private String name;
	//保理类型
	private String factorType;
	//出账时间
	private Date payTime;
	//贷款年利率
	private BigDecimal rate;
	//逾期日利率
	private BigDecimal overdueRate;
	//管理费年利率
	private BigDecimal manageRate;
	//融资比例
	private BigDecimal financeRatio;
	//违约利率
	private BigDecimal penaltyRate;
	//保理商名称
	private String enterpriseName;
	
	@JSONField(name="enterprise_name")
	public String getEnterpriseName() {
		return enterpriseName;
	}
	@JSONField(name="enterprise_name")
	public void setEnterpriseName(String enterpriseName) {
		this.enterpriseName = enterpriseName;
	}
	@JSONField(name="business_id")
	public Long getBusinessId() {
		return businessId;
	}
	@JSONField(name="business_id")
	public void setBusinessId(Long businessId) {
		this.businessId = businessId;
	}
	@JSONField(name="finance_body")
	public String getFinanceBody() {
		return financeBody;
	}
	@JSONField(name="finance_body")
	public void setFinanceBody(String financeBody) {
		this.financeBody = financeBody;
	}
	@JSONField(name="Supplier_member_id")
	public Long getSupplierMemberId() {
		return SupplierMemberId;
	}
	@JSONField(name="Supplier_member_id")
	public void setSupplierMemberId(Long supplierMemberId) {
		SupplierMemberId = supplierMemberId;
	}
	@JSONField(name="factoring_member_id")
	public Long getFactoringMemberId() {
		return factoringMemberId;
	}
	@JSONField(name="factoring_member_id")
	public void setFactoringMemberId(Long factoringMemberId) {
		this.factoringMemberId = factoringMemberId;
	}
	@JSONField(name="number_")
	public String getNumber() {
		return number;
	}
	@JSONField(name="number_")
	public void setNumber(String number) {
		this.number = number;
	}
	@JSONField(name="apply_amount")
	public BigDecimal getApplyAmount() {
		return applyAmount;
	}
	@JSONField(name="apply_amount")
	public void setApplyAmount(BigDecimal applyAmount) {
		this.applyAmount = applyAmount;
	}
	@JSONField(name="repayment_date")
	public Date getRepaymentdate() {
		return repaymentdate;
	}
	@JSONField(name="repayment_date")
	public void setRepaymentdate(Date repaymentdate) {
		this.repaymentdate = repaymentdate;
	}
	@JSONField(name="period_type")
	public String getPeriodType() {
		return periodType;
	}
	@JSONField(name="period_type")
	public void setPeriodType(String periodType) {
		this.periodType = periodType;
	}
	@JSONField(name="loan_period")
	public int getLoanPeriod() {
		return loanPeriod;
	}
	@JSONField(name="loan_period")
	public void setLoanPeriod(int loanPeriod) {
		this.loanPeriod = loanPeriod;
	}
	@JSONField(name="remark_")
	public String getRemark() {
		return remark;
	}
	@JSONField(name="remark_")
	public void setRemark(String remark) {
		this.remark = remark;
	}
	@JSONField(name="enterprise_id")
	public Long getEnterpriseId() {
		return enterpriseId;
	}
	@JSONField(name="enterprise_id")
	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}
	@JSONField(name="status_")
	public String getStatus() {
		return status;
	}
	@JSONField(name="status_")
	public void setStatus(String status) {
		this.status = status;
	}
	@JSONField(name="name_")
	public String getName() {
		return name;
	}
	@JSONField(name="name_")
	public void setName(String name) {
		this.name = name;
	}
	@JSONField(name="factor_type")
	public String getFactorType() {
		return factorType;
	}
	@JSONField(name="factor_type")
	public void setFactorType(String factorType) {
		this.factorType = factorType;
	}
	@JSONField(name="pay_time")
	public Date getPayTime() {
		return payTime;
	}
	@JSONField(name="pay_time")
	public void setPayTime(Date payTime) {
		this.payTime = payTime;
	}
	@JSONField(name="rate_")
	public BigDecimal getRate() {
		return rate;
	}
	@JSONField(name="rate_")
	public void setRate(BigDecimal rate) {
		this.rate = rate;
	}
	@JSONField(name="overdue_rate")
	public BigDecimal getOverdueRate() {
		return overdueRate;
	}
	@JSONField(name="overdue_rate")
	public void setOverdueRate(BigDecimal overdueRate) {
		this.overdueRate = overdueRate;
	}
	@JSONField(name="manage_rate")
	public BigDecimal getManageRate() {
		return manageRate;
	}
	@JSONField(name="manage_rate")
	public void setManageRate(BigDecimal manageRate) {
		this.manageRate = manageRate;
	}
	@JSONField(name="finance_ratio")
	public BigDecimal getFinanceRatio() {
		return financeRatio;
	}
	@JSONField(name="finance_ratio")
	public void setFinanceRatio(BigDecimal financeRatio) {
		this.financeRatio = financeRatio;
	}
	@JSONField(name="penalty_rate")
	public BigDecimal getPenaltyRate() {
		return penaltyRate;
	}
	@JSONField(name="penalty_rate")
	public void setPenaltyRate(BigDecimal penaltyRate) {
		this.penaltyRate = penaltyRate;
	}
	

}
