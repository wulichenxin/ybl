package cn.sunline.framework.controller.vo.v4.factor;

import java.math.BigDecimal;
import java.util.Date;


import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * 平台端融资子订单综合查询 融资申请实体类
 *
 */
public class FinancingApplyChildInfo extends AbstractEntity {
    
	private static final long serialVersionUID = -8080788587041498105L;
	/**
	 * 融资申请id
	 */
	@JSONField(name="financing_apply_id")
	private Long financingApplyId;
	/**
	 * 子融资申请订单号
	 */
	@JSONField(name="order_no")
	private String ordernNo;
	/**
	 * 
	 */
	@JSONField(name="financing_status")
	private Integer financingStatus;
	/**
	 * 业务id
	 */
	@JSONField(name="business_id")
	private Long businessId;
	/**
	 * 融资方
	 */
	@JSONField(name="enterprise_name")
	private String enterpriseName;
	/**
	 * 保利类型
	 */
	@JSONField(name="factoring_mode")
	private Integer factoringMode;
	/**
	 * 资产类型
	 */
	@JSONField(name="assets_type")
	private Integer assetsType;
	/**
	 * 融资方式
	 */
	@JSONField(name="financing_mode")
	private Integer financingMode;
	/**
	 * 融资金额
	 */
	@JSONField(name="financing_amount")
	private BigDecimal financingAmount;
	/**
	 * 融资期限
	 */
	@JSONField(name="financing_term")
	private Integer financingTerm;
	/**
	 * 融资利率
	 */
	@JSONField(name="financing_rate")
	private BigDecimal financingRate;
	/**
	 * 主合同号
	 */
	@JSONField(name="master_contract_no")
	private String masterContractNo;
	/**
	 * 保理商企业名称
	 */
	@JSONField(name="f_enterprise_name")
	private String fEnterpriseName;
	/**
	 * 开始时间
	 */
	@JSONField(name="start_time")
	private String startTime;
	/**
	 * 结束时间
	 */
	@JSONField(name="end_time")
	private String endTime;
	
	/**
	 * 子订单个数
	 */
	@JSONField(name="count_child")
	private Integer countChild;
	
	
	
	public Integer getCountChild() {
		return countChild;
	}
	public void setCountChild(Integer countChild) {
		this.countChild = countChild;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public Long getFinancingApplyId() {
		return financingApplyId;
	}
	public void setFinancingApplyId(Long financingApplyId) {
		this.financingApplyId = financingApplyId;
	}
	public String getOrdernNo() {
		return ordernNo;
	}
	public void setOrdernNo(String ordernNo) {
		this.ordernNo = ordernNo;
	}
	public Integer getFinancingStatus() {
		return financingStatus;
	}
	public void setFinancingStatus(Integer financingStatus) {
		this.financingStatus = financingStatus;
	}
	public Long getBusinessId() {
		return businessId;
	}
	public void setBusinessId(Long businessId) {
		this.businessId = businessId;
	}
	public String getEnterpriseName() {
		return enterpriseName;
	}
	public void setEnterpriseName(String enterpriseName) {
		this.enterpriseName = enterpriseName;
	}
	public Integer getFactoringMode() {
		return factoringMode;
	}
	public void setFactoringMode(Integer factoringMode) {
		this.factoringMode = factoringMode;
	}
	public Integer getAssetsType() {
		return assetsType;
	}
	public void setAssetsType(Integer assetsType) {
		this.assetsType = assetsType;
	}
	public Integer getFinancingMode() {
		return financingMode;
	}
	public void setFinancingMode(Integer financingMode) {
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
	public String getMasterContractNo() {
		return masterContractNo;
	}
	public void setMasterContractNo(String masterContractNo) {
		this.masterContractNo = masterContractNo;
	}
	public String getfEnterpriseName() {
		return fEnterpriseName;
	}
	public void setfEnterpriseName(String fEnterpriseName) {
		this.fEnterpriseName = fEnterpriseName;
	}
	

}