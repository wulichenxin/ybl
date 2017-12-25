package cn.sunline.framework.controller.vo;

import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

public class MemberVo extends AbstractEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5104074038276496406L;
	
	//企业id
	private Long enterpriseId;
	//用户名
	private String userName;
	//真实姓名
	private String realName;
	//昵称
	private String nickName;
	//密码
	private String password;
	//盐
	private String salt;
	//手机
	private String telephone;
	//邮箱
	private String email;
	//注册时间
	private Date registerTime;
	//上次登录时间
	private Date preLoginTime;
	//上次登录地点
	private String preLoginAddress;
	//等级
	private String level;
	//认证角色
	private String certRole;
	//认证时间
	private Date certTime;
	//状态
	private String status;
	//部门id
	private Long deptId;
	//性别
	private String gender;
	
	@JSONField(name="enterprise_id")
	public Long getEnterpriseId() {
		return enterpriseId;
	}
	@JSONField(name="enterprise_id")
	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}
	@JSONField(name="user_name")
	public String getUserName() {
		return userName;
	}
	@JSONField(name="user_name")
	public void setUserName(String userName) {
		this.userName = userName;
	}
	@JSONField(name="real_name")
	public String getRealName() {
		return realName;
	}
	@JSONField(name="real_name")
	public void setRealName(String realName) {
		this.realName = realName;
	}
	@JSONField(name="nick_name")
	public String getNickName() {
		return nickName;
	}
	@JSONField(name="nick_name")
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	@JSONField(name="password_")
	public String getPassword() {
		return password;
	}
	@JSONField(name="password_")
	public void setPassword(String password) {
		this.password = password;
	}
	@JSONField(name="salt_")
	public String getSalt() {
		return salt;
	}
	@JSONField(name="salt_")
	public void setSalt(String salt) {
		this.salt = salt;
	}
	@JSONField(name="telephone_")
	public String getTelephone() {
		return telephone;
	}
	@JSONField(name="telephone_")
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	@JSONField(name="email_")
	public String getEmail() {
		return email;
	}
	@JSONField(name="email_")
	public void setEmail(String email) {
		this.email = email;
	}
	@JSONField(name="register_time")
	public Date getRegisterTime() {
		return registerTime;
	}
	@JSONField(name="register_time")
	public void setRegisterTime(Date registerTime) {
		this.registerTime = registerTime;
	}
	@JSONField(name="pre_login_time")
	public Date getPreLoginTime() {
		return preLoginTime;
	}
	@JSONField(name="pre_login_time")
	public void setPreLoginTime(Date preLoginTime) {
		this.preLoginTime = preLoginTime;
	}
	@JSONField(name="pre_login_address")
	public String getPreLoginAddress() {
		return preLoginAddress;
	}
	@JSONField(name="pre_login_address")
	public void setPreLoginAddress(String preLoginAddress) {
		this.preLoginAddress = preLoginAddress;
	}
	@JSONField(name="level_")
	public String getLevel() {
		return level;
	}
	@JSONField(name="level_")
	public void setLevel(String level) {
		this.level = level;
	}
	@JSONField(name="cert_role")
	public String getCertRole() {
		return certRole;
	}
	@JSONField(name="cert_time")
	public void setCertRole(String certRole) {
		this.certRole = certRole;
	}
	@JSONField(name="cert_time")
	public Date getCertTime() {
		return certTime;
	}
	@JSONField(name="cert_time")
	public void setCertTime(Date certTime) {
		this.certTime = certTime;
	}
	@JSONField(name="status_")
	public String getStatus() {
		return status;
	}
	@JSONField(name="status_")
	public void setStatus(String status) {
		this.status = status;
	}
	@JSONField(name="dept_id")
	public Long getDeptId() {
		return deptId;
	}
	@JSONField(name="dept_id")
	public void setDeptId(Long deptId) {
		this.deptId = deptId;
	}
	@JSONField(name="gender_")
	public String getGender() {
		return gender;
	}
	@JSONField(name="gender_")
	public void setGender(String gender) {
		this.gender = gender;
	}

}
