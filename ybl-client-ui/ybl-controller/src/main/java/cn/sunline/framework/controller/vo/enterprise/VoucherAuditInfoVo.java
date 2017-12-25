package cn.sunline.framework.controller.vo.enterprise;

import java.math.BigDecimal;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;

public class VoucherAuditInfoVo {
	/** 主键 */
	@JSONField(name = "id_")
	private long id;
	/** 编号 */
	@JSONField(name = "number_")
	private String number;
	/** 申请金额 */
	@JSONField(name = "apply_amount")
	private BigDecimal applyAmount;
	/** 状态 */
	@JSONField(name = "status_")
	private String status;
	/** 企业名称 */
	@JSONField(name = "enterprise_name")
	private String enterpriseName;
	/** 营业执照注册号 */
	@JSONField(name = "license_no")
	private String licenseNo;
	/** 法人姓名 */
	@JSONField(name = "legal_name")
	private String legalName;
	/** 法人联系电话 */
	@JSONField(name = "legal_phone")
	private String legalPhone;
	/** 保理类型 */
	@JSONField(name = "type_")
	private String type;
	/** 贷款年利率 */
	@JSONField(name = "rate_")
	private String rate;
	/** 保理商企业名称 */
	@JSONField(name = "f_enterprise_name")
	private String fEnterpriseName;
	/** 贷款期限 */
	@JSONField(name = "loan_period")
	private int loanPeriod;
	
	/** 贷款期限 类型*/
	@JSONField(name = "period_type")
	private String periodType;
	
	/** loansign:标的，financeapply:融资申请 */
	@JSONField(name = "is_loan")
	private String isLoan;
	
	@JSONField(name = "finance_body")
	private String financeBody;
	
	/**
	 * 凭证列表
	 */
	private List<FinanceApplyVoucherInfoVo> faVouchers;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public BigDecimal getApplyAmount() {
		return applyAmount;
	}

	public void setApplyAmount(BigDecimal applyAmount) {
		this.applyAmount = applyAmount;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getEnterpriseName() {
		return enterpriseName;
	}

	public void setEnterpriseName(String enterpriseName) {
		this.enterpriseName = enterpriseName;
	}

	public String getLicenseNo() {
		return licenseNo;
	}

	public void setLicenseNo(String licenseNo) {
		this.licenseNo = licenseNo;
	}

	public String getLegalName() {
		return legalName;
	}

	public void setLegalName(String legalName) {
		this.legalName = legalName;
	}

	public String getLegalPhone() {
		return legalPhone;
	}

	public void setLegalPhone(String legalPhone) {
		this.legalPhone = legalPhone;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getRate() {
		return rate;
	}

	public void setRate(String rate) {
		this.rate = rate;
	}

	public String getfEnterpriseName() {
		return fEnterpriseName;
	}

	public void setfEnterpriseName(String fEnterpriseName) {
		this.fEnterpriseName = fEnterpriseName;
	}

	public int getLoanPeriod() {
		return loanPeriod;
	}

	public void setLoanPeriod(int loanPeriod) {
		this.loanPeriod = loanPeriod;
	}

	public List<FinanceApplyVoucherInfoVo> getFaVouchers() {
		return faVouchers;
	}

	public void setFaVouchers(List<FinanceApplyVoucherInfoVo> faVouchers) {
		this.faVouchers = faVouchers;
	}

	public String getIsLoan() {
		return isLoan;
	}

	public void setIsLoan(String isLoan) {
		this.isLoan = isLoan;
	}

	public String getPeriodType() {
		return periodType;
	}

	public void setPeriodType(String periodType) {
		this.periodType = periodType;
	}

	public String getFinanceBody() {
		return financeBody;
	}

	public void setFinanceBody(String financeBody) {
		this.financeBody = financeBody;
	}

}
