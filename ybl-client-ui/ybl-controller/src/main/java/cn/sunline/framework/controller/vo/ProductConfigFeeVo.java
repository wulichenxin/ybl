package cn.sunline.framework.controller.vo;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

public class ProductConfigFeeVo extends AbstractEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1479831780038710293L;
	
	//主表id
	private Long productId;
	
	//名称
	private String type;
	//备注
	private String ratio;
	//企业id
	private Long enterpriseid;
	
	@JSONField(name="product_id")
	public Long getProductId() {
		return productId;
	}
	@JSONField(name="product_id")
	public void setProductId(Long productId) {
		this.productId = productId;
	}
	
	@JSONField(name="type_")
	public String getType() {
		return type;
	}
	@JSONField(name="type_")
	public void setType(String type) {
		this.type = type;
	}
	@JSONField(name="ratio_")
	public String getRatio() {
		return ratio;
	}
	@JSONField(name="ratio_")
	public void setRatio(String ratio) {
		this.ratio = ratio;
	}
	@JSONField(name="enterprise_id")
	public Long getEnterpriseid() {
		return enterpriseid;
	}
	@JSONField(name="enterprise_id")
	public void setEnterpriseid(Long enterpriseid) {
		this.enterpriseid = enterpriseid;
	}
	
	
	
	
}
