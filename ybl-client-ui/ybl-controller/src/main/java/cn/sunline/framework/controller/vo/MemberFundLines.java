package cn.sunline.framework.controller.vo;

import java.math.BigDecimal;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;
/**
 * 会员资金行信息实体类
 * @author MaiBenBen
 *
 */
public class MemberFundLines extends AbstractEntity {

	private static final long serialVersionUID = -5424461754482901082L;

	/* 企业表id */
	private Long enterpriseId=-1L;
	/* 主表id */
	private Long memberFundId=-1L;
	/*资金类型:充值：01,提现：02*/
	private String type;
	/*收入*/
	private BigDecimal income;
	/*支出*/
	private BigDecimal expenditure;
	/*可用金额*/
	private BigDecimal useableAmount;

	@JSONField(name = "enterprise_id")
	public Long getEnterpriseId() {
		return enterpriseId;
	}

	@JSONField(name = "enterprise_id")
	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

	@JSONField(name = "member_fund_id")
	public Long getMemberFundId() {
		return memberFundId;
	}

	@JSONField(name = "member_fund_id")
	public void setMemberFundId(Long memberFundId) {
		this.memberFundId = memberFundId;
	}

	@JSONField(name = "type_")
	public String getType() {
		return type;
	}

	@JSONField(name = "type_")
	public void setType(String type) {
		this.type = type;
	}

	@JSONField(name = "income_")
	public BigDecimal getIncome() {
		return income;
	}

	@JSONField(name = "income_")
	public void setIncome(BigDecimal income) {
		this.income = income;
	}

	@JSONField(name = "expenditure_")
	public BigDecimal getExpenditure() {
		return expenditure;
	}

	@JSONField(name = "expenditure_")
	public void setExpenditure(BigDecimal expenditure) {
		this.expenditure = expenditure;
	}

	@JSONField(name = "useable_amount")
	public BigDecimal getUseableAmount() {
		return useableAmount;
	}

	@JSONField(name = "useable_amount")
	public void setUseableAmount(BigDecimal useableAmount) {
		this.useableAmount = useableAmount;
	}
}
