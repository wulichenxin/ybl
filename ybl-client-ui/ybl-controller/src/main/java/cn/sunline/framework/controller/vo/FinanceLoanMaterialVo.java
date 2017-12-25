package cn.sunline.framework.controller.vo;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

public class FinanceLoanMaterialVo extends AbstractEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3835386781864841983L;

	/* 融资申请id */
	@JSONField(name = "finance_apply_id")
	private Long finance_apply_id;
	
	/* 代码 */
	@JSONField(name = "code_")
	private String code_;
	
	
	/* 材料名称 */
	@JSONField(name = "name_")
	private String name_;
	
	
	/* 材料备注 */
	@JSONField(name = "remark_")
	private String remark_;
	
	
	/* 企业id */
	@JSONField(name = "enterprise_id")
	private Long enterprise_id;
	
	
	/* url  */
	@JSONField(name = "url_")
	private String url_;
	
	


	public String getUrl_() {
		return url_;
	}

	public void setUrl_(String url_) {
		this.url_ = url_;
	}

	public Long getFinance_apply_id() {
		return finance_apply_id;
	}

	public void setFinance_apply_id(Long finance_apply_id) {
		this.finance_apply_id = finance_apply_id;
	}

	public String getCode_() {
		return code_;
	}

	public void setCode_(String code_) {
		this.code_ = code_;
	}

	public String getName_() {
		return name_;
	}

	public void setName_(String name_) {
		this.name_ = name_;
	}

	public String getRemark_() {
		return remark_;
	}

	public void setRemark_(String remark_) {
		this.remark_ = remark_;
	}

	public Long getEnterprise_id() {
		return enterprise_id;
	}

	public void setEnterprise_id(Long enterprise_id) {
		this.enterprise_id = enterprise_id;
	}


	
	
}
