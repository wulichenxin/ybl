package cn.sunline.framework.controller.vo;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * 竞标方符合实体
 * @author MaiBenBen
 *
 */
public class SubjectBidVo extends AbstractEntity{
	
	private static final long serialVersionUID = -5341631997332280910L;
	
	/*投标会员*/
	private Long memberId;
	/*投标企业id*/
	private Long enterpriseId;
	/*贷款年利率*/
	private String rate;
	/*标的id*/
	private Long loanSignId;
	/*融资比率*/
	private String ratio;
	/*最大可贷金额*/
	private String maxAmount;
	/*状态*/
	private String status;
	/*预期违约金比率*/
	private String overdueRate;
	/*企业名称*/
	private String enterpriseName;
	/*综合评分*/
	private String compositeScore;
	/*机构代码证号*/
	private String orgCodeNo;
	/* 管理费年利率*/
	private Double managerRate;
	/*备注*/
	private String remark;
	/* 提前还款违约金比率 */
	private Double advenceRate;
	
	@JSONField(name="member_id")
	public Long getMemberId() {
		return memberId;
	}
	@JSONField(name="member_id")
	public void setMemberId(Long memberId) {
		this.memberId = memberId;
	}
	@JSONField(name="enterprise_id")
	public Long getEnterpriseId() {
		return enterpriseId;
	}
	@JSONField(name="enterprise_id")
	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}
	@JSONField(name="rate_")
	public String getRate() {
		return rate;
	}
	@JSONField(name="rate_")
	public void setRate(String rate) {
		this.rate = rate;
	}
	@JSONField(name="loan_sign_id")
	public Long getLoanSignId() {
		return loanSignId;
	}
	@JSONField(name="loan_sign_id")
	public void setLoanSignId(Long loanSignId) {
		this.loanSignId = loanSignId;
	}
	@JSONField(name="ratio_")
	public String getRatio() {
		return ratio;
	}
	@JSONField(name="ratio_")
	public void setRatio(String ratio) {
		this.ratio = ratio;
	}
	@JSONField(name="max_amount")
	public String getMaxAmount() {
		return maxAmount;
	}
	@JSONField(name="max_amount")
	public void setMaxAmount(String maxAmount) {
		this.maxAmount = maxAmount;
	}
	@JSONField(name="status_")
	public String getStatus() {
		return status;
	}
	@JSONField(name="status_")
	public void setStatus(String status) {
		this.status = status;
	}
	@JSONField(name="overdue_rate")
	public String getOverdueRate() {
		return overdueRate;
	}
	@JSONField(name="overdue_rate")
	public void setOverdueRate(String overdueRate) {
		this.overdueRate = overdueRate;
	}
	@JSONField(name="enterprise_name")
	public String getEnterpriseName() {
		return enterpriseName;
	}
	@JSONField(name="enterprise_name")
	public void setEnterpriseName(String enterpriseName) {
		this.enterpriseName = enterpriseName;
	}
	@JSONField(name="composite_score")
	public String getCompositeScore() {
		return compositeScore;
	}
	@JSONField(name="composite_score")
	public void setCompositeScore(String compositeScore) {
		this.compositeScore = compositeScore;
	}
	@JSONField(name="org_code_no")
	public String getOrgCodeNo() {
		return orgCodeNo;
	}
	@JSONField(name="org_code_no")
	public void setOrgCodeNo(String orgCodeNo) {
		this.orgCodeNo = orgCodeNo;
	}
	@JSONField(name = "manager_rate")
	public Double getManagerRate() {
		return managerRate;
	}
	@JSONField(name = "manager_rate")
	public void setManagerRate(Double managerRate) {
		this.managerRate = managerRate;
	}
	@JSONField(name = "remark_")
	public String getRemark() {
		return remark;
	}
	@JSONField(name = "remark_")
	public void setRemark(String remark) {
		this.remark = remark;
	}
	@JSONField(name = "advence_rate")
	public Double getAdvenceRate() {
		return advenceRate;
	}
	@JSONField(name = "advence_rate")
	public void setAdvenceRate(Double advenceRate) {
		this.advenceRate = advenceRate;
	}
	
}
