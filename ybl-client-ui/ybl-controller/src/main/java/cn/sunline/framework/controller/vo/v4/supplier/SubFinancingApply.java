package cn.sunline.framework.controller.vo.v4.supplier;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

import com.alibaba.fastjson.annotation.JSONField;

/**
 * 融资子订单
 * @author jiangchangyuan
 *
 */
public class SubFinancingApply extends AbstractEntity {
    
	private static final long serialVersionUID = 7275037453634864019L;

	/**
	 * 融资申请id
	 */
	private Long financingApplyId;
	
	/**
	 * 业务id（保存的是资金方id）
	 */
	private Long businessId;

	/**
	 * 子订单号
	 */
    private String orderNo;

    /**
     * 融资状态1-待提交2-待平台初审3-待资方初审4-待选择资方5-待资方终审6-待确定资方7-待平台复核8-待签署合同9-融资完成99-融资失败
     */
    private String financingStatus;
    
    private String funderName;
    
    @JSONField(name="business_id")
    public Long getBusinessId() {
        return businessId;
    }
	
	@JSONField(name="business_id")
    public void setBusinessId(Long businessId) {
        this.businessId = businessId;
    }
	
	@JSONField(name="financing_status")
    public String getFinancingStatus() {
        return financingStatus;
    }

	@JSONField(name="financing_status")
    public void setFinancingStatus(String financingStatus) {
        this.financingStatus = financingStatus;
    }
    
    @JSONField(name="financing_apply_id")
	public Long getFinancingApplyId() {
		return financingApplyId;
	}
    
    @JSONField(name="financing_apply_id")
	public void setFinancingApplyId(Long financingApplyId) {
		this.financingApplyId = financingApplyId;
	}
    
    @JSONField(name="order_no")
	public String getOrderNo() {
		return orderNo;
	}
    
    @JSONField(name="order_no")
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
    @JSONField(name="funder_name")
	public String getFunderName() {
		return funderName;
	}
	@JSONField(name="funder_name")
	public void setFunderName(String funderName) {
		this.funderName = funderName;
	}
}