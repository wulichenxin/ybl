package com.bpm.framework.controller.login;

import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * 注册信息管理实体（游客表）
 * @author jzx
 *
 */
public class V2VisitorVo extends AbstractEntity {

	private static final long serialVersionUID = -4583688579650295017L;

	/*联系人*/
	private String name;
	/*企业名称*/
	private String enterpriseName;
	/*企业类型： 保理商：factor;供应商：supplier;核心企业：enterprise*/
	private String type;
	/*状态：待处理：pending已处理：processed*/
	private String status;
	/*性别*/
	private String sex;
	/*手机*/
	private String telephone;
	/*邮箱*/
	private String email;
	/*登记时间*/
	private Date registerTime;
	/*处理时间*/
	private Date operationTime;
	/*备注*/
	private String remark;
	
	/**
	 * 产品id
	 */
	private Long productId;
	
	@JSONField(name = "product_id")
	public Long productId() {
		return productId;
	}
	@JSONField(name = "product_id")
	public void setproductId(Long productId) {
		this.productId = productId;
	}
	@JSONField(name = "name_")
	public String name() {
		return name;
	}
	@JSONField(name = "name_")
	public void setName(String name) {
		this.name = name;
	}
	@JSONField(name = "enterprise_name")
	public String getEnterpriseName() {
		return enterpriseName;
	}
	@JSONField(name = "enterprise_name")
	public void setEnterpriseName(String enterpriseName) {
		this.enterpriseName = enterpriseName;
	}
	@JSONField(name = "type_")
	public String getType() {
		return type;
	}
	@JSONField(name = "type_")
	public void setType(String type) {
		this.type = type;
	}
	@JSONField(name = "status_")
	public String getStatus() {
		return status;
	}
	@JSONField(name = "status_")
	public void setStatus(String status) {
		this.status = status;
	}
	@JSONField(name = "sex_")
	public String getSex() {
		return sex;
	}
	@JSONField(name = "sex_")
	public void setSex(String sex) {
		this.sex = sex;
	}
	@JSONField(name = "telephone_")
	public String getTelephone() {
		return telephone;
	}
	@JSONField(name = "telephone_")
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	@JSONField(name = "email_")
	public String getEmail() {
		return email;
	}
	@JSONField(name = "email_")
	public void setEmail(String email) {
		this.email = email;
	}
	@JSONField(format = "yyyy-MM-dd",name = "register_time")
	public Date getRegisterTime() {
		return registerTime;
	}
	@JSONField(format = "yyyy-MM-dd",name = "register_time")
	public void setRegisterTime(Date registerTime) {
		this.registerTime = registerTime;
	}
	@JSONField(format = "yyyy-MM-dd",name = "operation_time")
	public Date getOperationTime() {
		return operationTime;
	}
	@JSONField(format = "yyyy-MM-dd",name = "operation_time")
	public void setOperationTime(Date operationTime) {
		this.operationTime = operationTime;
	}
	@JSONField(name = "remark_")
	public String getRemark() {
		return remark;
	}
	@JSONField(name = "remark_")
	public void setRemark(String remark) {
		this.remark = remark;
	}
	@Override
	public String toString() {
		return "V2VisitorVo [name=" + name + ", enterpriseName=" + enterpriseName + ", type=" + type + ", status="
				+ status + ", sex=" + sex + ", telephone=" + telephone + ", email=" + email + ", registerTime="
				+ registerTime + ", operationTime=" + operationTime + ", remark=" + remark + "]";
	}
	
}
