package cn.sunline.framework.controller.vo;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

public class ProductConfigArchiveMaterialVo extends AbstractEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1479831780038710293L;
	
	//主表id
	private Long productId;
	//名称
	private String name;
	//备注
	private String remark;
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
	
	@JSONField(name="name_")
	public String getName() {
		return name;
	}
	@JSONField(name="name_")
	public void setName(String name) {
		this.name = name;
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
	public Long getEnterpriseid() {
		return enterpriseid;
	}
	@JSONField(name="enterprise_id")
	public void setEnterpriseid(Long enterpriseid) {
		this.enterpriseid = enterpriseid;
	}
	
	
	
	
}
