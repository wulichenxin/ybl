package cn.sunline.framework.controller.vo.v4.enterprise;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;
/**
 * 核心企业首页待办复合实体
 * @author pc
 *
 */
public class IndexTodoVO extends AbstractEntity{

	/**
	 * 
	 */
	private static final long serialVersionUID = 5770243294123550511L;
	
	@JSONField(name = "right_business_id")
	private Integer rightBusinessId; //业务id线下确权为资金方线上确权为核心企业，与子融资订单的business_id不是同一个
	
	@JSONField(name = "enterprise_name")
	private String enterpriseName; //申请单位
	
	@JSONField(name = "sub_financing_apply_id")
	private String subFinancingApplyId; //融资申请子订单id
	
	@JSONField(name = "type")
	private String type;//类型
	@JSONField(name = "order_no")//订单号
	private String orderNo;

	public Integer getRightBusinessId() {
		return rightBusinessId;
	}

	public void setRightBusinessId(Integer rightBusinessId) {
		this.rightBusinessId = rightBusinessId;
	}

	public String getEnterpriseName() {
		return enterpriseName;
	}

	public void setEnterpriseName(String enterpriseName) {
		this.enterpriseName = enterpriseName;
	}

	public String getSubFinancingApplyId() {
		return subFinancingApplyId;
	}

	public void setSubFinancingApplyId(String subFinancingApplyId) {
		this.subFinancingApplyId = subFinancingApplyId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

    public String getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }
	
}
