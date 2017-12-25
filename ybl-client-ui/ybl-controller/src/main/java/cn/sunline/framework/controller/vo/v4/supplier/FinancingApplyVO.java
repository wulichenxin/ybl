package cn.sunline.framework.controller.vo.v4.supplier;

import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * 融资申请管理VO
 * @author jiangchangyuan
 *
 */
public class FinancingApplyVO extends AbstractEntity{
	private static final long serialVersionUID = 1L;
	
	//业务ID
	private Integer businessId;
	
	/*保理类型0-明保理1-暗保理*/
	private Integer factoringMode;
	
	/*申请单位*/
	private String enterpriseName;
	
	/*融资订单号*/
	private String financingOrderNumber;
	
	/*融资方式0-签约资方1-平台推荐2-竞标*/
	private Integer financingMode;
	
	/*资金方多个id逗号隔开*/
	private String investorName;
	
	/*竞标截止时间*/
	private Date bidExpireDate;
	/*临时字段--用来计算截止时间+1天*/
	private Date bigExpireDate;
	
	/*资产类型0-应收账款1-应付账款2-票据*/
	private Integer assetsType;
	
	/*融资状态0-待提交1-待平台初审2-待资方初审3-待选择资方4-待资方终审5-待确定资方6-待平台复核7-待签署合同8-融资完成9-融资失败*/
	private Integer financingStatus;
	
	/*未决诉讼或仲裁*/
	private String lawSituation;
	
	/*其他或有事项*/
	private String other;
	
	/*融资方*/
	private String financier;
	
	/*融资金额*/
	private String financingAmount;
	
	/*融资期限*/
	private Integer financingTerm;
	
	/*融资利率*/
	private String financingRate;
	
	/*增信措施*/
	private String trustMeasure;
	
	/*融资需求备注*/
	private String financingDemandRemark;
	
	/*备注*/
	private String remark;
	
	/*申请开始时间*/
	private String beginDate;
	
	/*申请结束时间*/
	private String endDate;
	/*竞标列表中用来接收该竞标有多少家意向资金方*/
	private Integer count;
	/*对应融资申请复合类型ID*/
	private Long apply_id;
	/*融资期限--记录间隔天数*/
	private Long gap;
	/*是否资金方有驳回记录*/
	private Boolean rujectStatus;
	
	
	/*
	 * 临时字段--标识查询竞标数据的排序方式  attribute1_
	 * 0-默认排序(能否参加<占用attribute2_来传参，但不影响数据库数据>,平台审核时间)
	 * 1-融资利率
	 * 2-融资期限(融资期限天数 = 融资期限日期 - 系统时间，精确到天<占用attribute3_来传参，但不影响数据库数据>)
	 * 3-融资金额
	 */

	@JSONField(name = "business_id")
	public Integer getBusinessId() {
		return businessId;
	}

	@JSONField(name = "business_id")
	public void setBusinessId(Integer businessId) {
		this.businessId = businessId;
	}

	@JSONField(name = "factoring_mode")
	public Integer getFactoringMode() {
		return factoringMode;
	}

	@JSONField(name = "factoring_mode")
	public void setFactoringMode(Integer factoringMode) {
		this.factoringMode = factoringMode;
	}
	
	@JSONField(name = "enterprise_name")
	public String getEnterpriseName() {
		return enterpriseName;
	}
	
	@JSONField(name = "enterprise_name")
	public void setEnterpriseName(String enterpriseName) {
		this.enterpriseName = enterpriseName;
	}

	@JSONField(name = "financing_order_number")
	public String getFinancingOrderNumber() {
		return financingOrderNumber;
	}

	@JSONField(name = "financing_order_number")
	public void setFinancingOrderNumber(String financingOrderNumber) {
		this.financingOrderNumber = financingOrderNumber;
	}

	@JSONField(name = "financing_mode")
	public Integer getFinancingMode() {
		return financingMode;
	}

	@JSONField(name = "financing_mode")
	public void setFinancingMode(Integer financingMode) {
		this.financingMode = financingMode;
	}

	@JSONField(name = "investor_name")
	public String getInvestorName() {
		return investorName;
	}

	@JSONField(name = "investor_name")
	public void setInvestorName(String investorName) {
		this.investorName = investorName;
	}

	@JSONField(name = "bid_expire_date",format="yyyy-MM-dd")
	public Date getBidExpireDate() {
		return bidExpireDate;
	}

	@JSONField(name = "bid_expire_date",format="yyyy-MM-dd")
	public void setBidExpireDate(Date bidExpireDate) {
		this.bidExpireDate = bidExpireDate;
	}

	@JSONField(name = "assets_type")
	public Integer getAssetsType() {
		return assetsType;
	}

	@JSONField(name = "assets_type")
	public void setAssetsType(Integer assetsType) {
		this.assetsType = assetsType;
	}

	@JSONField(name = "financing_status")
	public Integer getFinancingStatus() {
		return financingStatus;
	}

	@JSONField(name = "financing_status")
	public void setFinancingStatus(Integer financingStatus) {
		this.financingStatus = financingStatus;
	}

	@JSONField(name = "law_situation")
	public String getLawSituation() {
		return lawSituation;
	}

	@JSONField(name = "law_situation")
	public void setLawSituation(String lawSituation) {
		this.lawSituation = lawSituation;
	}

	@JSONField(name = "other")
	public String getOther() {
		return other;
	}

	@JSONField(name = "other")
	public void setOther(String other) {
		this.other = other;
	}

	@JSONField(name = "financier")
	public String getFinancier() {
		return financier;
	}

	@JSONField(name = "financier")
	public void setFinancier(String financier) {
		this.financier = financier;
	}

	@JSONField(name = "financing_amount")
	public String getFinancingAmount() {
		return financingAmount;
	}

	@JSONField(name = "financing_amount")
	public void setFinancingAmount(String financingAmount) {
		this.financingAmount = financingAmount;
	}

	@JSONField(name = "financing_term", format="yyyy-MM-dd")
	public Integer getFinancingTerm() {
		return financingTerm;
	}

	@JSONField(name = "financing_term", format="yyyy-MM-dd")
	public void setFinancingTerm(Integer financingTerm) {
		this.financingTerm = financingTerm;
	}

	@JSONField(name = "financing_rate")
	public String getFinancingRate() {
		return financingRate;
	}

	@JSONField(name = "financing_rate")
	public void setFinancingRate(String financingRate) {
		this.financingRate = financingRate;
	}

	@JSONField(name = "trust_measure")
	public String getTrustMeasure() {
		return trustMeasure;
	}

	@JSONField(name = "trust_measure")
	public void setTrustMeasure(String trustMeasure) {
		this.trustMeasure = trustMeasure;
	}

	@JSONField(name = "financing_demand_remark")
	public String getFinancingDemandRemark() {
		return financingDemandRemark;
	}

	@JSONField(name = "financing_demand_remark")
	public void setFinancingDemandRemark(String financingDemandRemark) {
		this.financingDemandRemark = financingDemandRemark;
	}

	@JSONField(name = "remark")
	public String getRemark() {
		return remark;
	}

	@JSONField(name = "remark")
	public void setRemark(String remark) {
		this.remark = remark;
	}

	@JSONField(name = "begin_date")
	public String getBeginDate() {
		return beginDate;
	}

	@JSONField(name = "begin_date")
	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}

	@JSONField(name = "end_date")
	public String getEndDate() {
		return endDate;
	}

	@JSONField(name = "end_date")
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	@JSONField(name = "apply_id")
	public Long getApply_id() {
		return apply_id;
	}
	@JSONField(name = "apply_id")
	public void setApply_id(Long apply_id) {
		this.apply_id = apply_id;
	}
	
	@JSONField(name = "count")
	public Integer getCount() {
		return count;
	}
	
	@JSONField(name = "count")
	public void setCount(Integer count) {
		this.count = count;
	}

	public Long getGap() {
		return gap;
	}

	public void setGap(Long gap) {
		this.gap = gap;
	}
	
	@JSONField(name = "ruject_status")
	public Boolean getRujectStatus() {
		return rujectStatus;
	}
	
	@JSONField(name = "ruject_status")
	public void setRujectStatus(Boolean rujectStatus) {
		this.rujectStatus = rujectStatus;
	}

	public Date getBigExpireDate() {
		return bigExpireDate;
	}

	public void setBigExpireDate(Date bigExpireDate) {
		this.bigExpireDate = bigExpireDate;
	}

}
