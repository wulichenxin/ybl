package cn.sunline.framework.controller.vo.v4.factor;

import java.math.BigDecimal;
import java.util.Date;



import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * 资金方融资申请综合查询vo
 * @author pc
 *
 */
public class FactorFinancingQueryVo extends AbstractEntity {

	private static final long serialVersionUID = 1687508927979625542L;

	//融资申请id
	@JSONField(name="financing_apply_id")
	private Integer financingApplyId;
	//融资订单号
	@JSONField(name="order_no")
	private String orderNo;
	//融资方
	@JSONField(name="financier")
	private String financier;
	//保理类型
	@JSONField(name="factoring_mode")
	private Integer factoringMode;
	//资产类型
	@JSONField(name="assets_type")
	private Integer assetsType;
	//融资方式
	@JSONField(name="financing_mode")
	private String financingMode;
	//融资申请金额
	@JSONField(name="financing_amount")
	private BigDecimal financingAmount;
	//融资期限
	@JSONField(name="financing_term")
	private Integer financingTerm;
	//融资利率
	@JSONField(name="financing_rate")
	private BigDecimal financingRate;
	//申请日期
	@JSONField(name="created_time")
	private Date createdTime;
	//关联融资主合同号
	@JSONField(name="financing_order_number")
	private String financingOrderNumber;
	//融资状态
	@JSONField(name="financing_status")
	private Integer financingStatus;
	//融资申请时间-开始时间
	@JSONField(name="start_apply_date")
	private String startApplyDate;
	//融资申请时间-截止时间
	@JSONField(name="end_apply_date")
	private String endApplyDate;
	//业务id对应资金方
	@JSONField(name="business_id")
	private Long businessId;
	/**
	 * 合同额度
	 */
	@JSONField(name="give_quota")
	private BigDecimal giveQuota;
	/**
	 * 服务费
	 */
	@JSONField(name="service_fee")
	private BigDecimal serviceFee;
	/**
	 * 合同状态
	 */
	private Integer status;
	/**
	 * 融资方业务id
	 */
	@JSONField(name="en_business_id")
	private Long enbusinessId;
	public void setFactoringMode(Integer factoringMode) {
		this.factoringMode = factoringMode;
	}
	public void setAssetsType(Integer assetsType) {
		this.assetsType = assetsType;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public Integer getFinancingApplyId() {
		return financingApplyId;
	}
	public void setFinancingApplyId(Integer financingApplyId) {
		this.financingApplyId = financingApplyId;
	}
	public String getFinancier() {
		return financier;
	}
	public void setFinancier(String financier) {
		this.financier = financier;
	}
	public String getFinancingMode() {
		return financingMode;
	}
	public void setFinancingMode(String financingMode) {
		this.financingMode = financingMode;
	}
	public BigDecimal getFinancingAmount() {
		return financingAmount;
	}
	public void setFinancingAmount(BigDecimal financingAmount) {
		this.financingAmount = financingAmount;
	}
	public Integer getFinancingTerm() {
		return financingTerm;
	}
	public void setFinancingTerm(Integer financingTerm) {
		this.financingTerm = financingTerm;
	}
	public BigDecimal getFinancingRate() {
		return financingRate;
	}
	public void setFinancingRate(BigDecimal financingRate) {
		this.financingRate = financingRate;
	}
	public Date getCreatedTime() {
		return createdTime;
	}
	public void setCreatedTime(Date createdTime) {
		this.createdTime = createdTime;
	}
	public String getFinancingOrderNumber() {
		return financingOrderNumber;
	}
	public void setFinancingOrderNumber(String financingOrderNumber) {
		this.financingOrderNumber = financingOrderNumber;
	}
	public Integer getFinancingStatus() {
		return financingStatus;
	}
	public void setFinancingStatus(Integer financingStatus) {
		this.financingStatus = financingStatus;
	}
	public String getStartApplyDate() {
		return startApplyDate;
	}
	public void setStartApplyDate(String startApplyDate) {
		this.startApplyDate = startApplyDate;
	}
	public String getEndApplyDate() {
		return endApplyDate;
	}
	public void setEndApplyDate(String endApplyDate) {
		this.endApplyDate = endApplyDate;
	}
	public Long getBusinessId() {
		return businessId;
	}
	public void setBusinessId(Long businessId) {
		this.businessId = businessId;
	}
	public Integer getFactoringMode() {
		return factoringMode;
	}
	public Integer getAssetsType() {
		return assetsType;
	}
	public BigDecimal getGiveQuota() {
		return giveQuota;
	}
	public void setGiveQuota(BigDecimal giveQuota) {
		this.giveQuota = giveQuota;
	}
	public BigDecimal getServiceFee() {
		return serviceFee;
	}
	public void setServiceFee(BigDecimal serviceFee) {
		this.serviceFee = serviceFee;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Long getEnbusinessId() {
		return enbusinessId;
	}
	public void setEnbusinessId(Long enbusinessId) {
		this.enbusinessId = enbusinessId;
	}
	
}
