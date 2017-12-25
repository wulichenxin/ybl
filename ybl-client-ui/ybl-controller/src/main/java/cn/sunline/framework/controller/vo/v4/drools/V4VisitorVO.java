package cn.sunline.framework.controller.vo.v4.drools;

import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;
/**
 * 保理咨询访客对象V4
 * @author win7
 *
 */
public class V4VisitorVO extends AbstractEntity{
	/**
	 * 
	 */
	private static final long serialVersionUID = 4275462727635962387L;
	/**
	 * 联系人
	 */
	@JSONField(name = "name_")
	private String name;
	/**
	 * 企业名称
	 */
	@JSONField(name = "enterprise_name")
	private String enterpriseName;
	/**
	 * 企业类型： 保理商：factor;    供应商：supplier;  核心企业：enterprise
	 */
	@JSONField(name = "type_")
	private String type;
	/**
	 * 待处理：pending 已处理：processed
	 */
	@JSONField(name = "status_")
	private String status;
	/**
	 * 性别
	 */
	@JSONField(name = "sex_")
	private String sex;
	/**
	 * 手机
	 */
	@JSONField(name = "telephone_")
	private String telephone;
	/**
	 * 邮箱
	 */
	@JSONField(name = "email_")
	private String email;
	/**
	 * 登记时间
	 */
	@JSONField(name = "register_time")
	private Date registerTime;
	/** 
	 * 处理时间
	 */
	@JSONField(name = "operation_time")
	private Date operationTime;
	/**
	 * 备注
	 */
	@JSONField(name = "remark_")
	private String remark;
	/**
	 * 项目id
	 */
	@JSONField(name = "product_id")
	private Long productId;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEnterpriseName() {
		return enterpriseName;
	}
	public void setEnterpriseName(String enterpriseName) {
		this.enterpriseName = enterpriseName;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Date getRegisterTime() {
		return registerTime;
	}
	public void setRegisterTime(Date registerTime) {
		this.registerTime = registerTime;
	}
	public Date getOperationTime() {
		return operationTime;
	}
	public void setOperationTime(Date operationTime) {
		this.operationTime = operationTime;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Long getProductId() {
		return productId;
	}
	public void setProductId(Long productId) {
		this.productId = productId;
	}
	
}
