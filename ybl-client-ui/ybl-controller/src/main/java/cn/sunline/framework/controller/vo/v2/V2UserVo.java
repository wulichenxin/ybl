package cn.sunline.framework.controller.vo.v2;

import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

public class V2UserVo extends AbstractEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = -364376208443669581L;
	/*企业表id*/
	private Integer enterpriseId;
	/*登录名*/	
	private String userName;
	/*用户名*/
	private String realName;
	/*昵称*/
	private String nickName;
	/*初始密码*/
	private String password;
	/*性别*/
	private String sex;
	/*加盐字段*/
	private String salt;
	/*手机号码*/
	private String telePhone;
	/*座机号码*/
	private String fixedPhone;
	/*邮箱*/
	private String email; 
	/*部门id*/
	private String department_;
	/*注册时间*/
	private Date registerTime;
	/*上次登录时间*/
	private Date preLoginTime;
	/*上次登录地址*/
	private String preLoginAddress;
	/*等级*/
	private String level;
	/*状态:正常：normal 冻结：freeze 注销：logout*/
	private String status;
	/*是否管理员*/
	private Integer isAdmin;
	/*角色id*/
	private Integer roleId;
	/*区分账户类型-融资方：financing;资金方：fund;核心企业：enterprise;*/
	private String type;
	
	@JSONField(name="role_id")
	public Integer getRoleId() {
		return roleId;
	}
	@JSONField(name="role_id")
	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}
	@JSONField(name="user_name")
	public String getUserName() {
		return userName;
	}	
	@JSONField(name="user_name")
	public void setUserName(String userName) {
		this.userName = userName;
	}
	@JSONField(name="enterprise_id")
	public Integer getEnterpriseId() {
		return enterpriseId;
	}
	@JSONField(name="enterprise_id")
	public void setEnterpriseId(Integer enterpriseId) {
		this.enterpriseId = enterpriseId;
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
	@JSONField(name="sex_")
	public String getSex() {
		return sex;
	}
	@JSONField(name="sex_")
	public void setSex(String sex) {
		this.sex = sex;
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
	public String getTelePhone() {
		return telePhone;
	}
	@JSONField(name="telephone_")
	public void setTelePhone(String telePhone) {
		this.telePhone = telePhone;
	}
	@JSONField(name="fixed_phone")
	public String getFixedPhone() {
		return fixedPhone;
	}
	@JSONField(name="fixed_phone")
	public void setFixedPhone(String fixedPhone) {
		this.fixedPhone = fixedPhone;
	}
	@JSONField(name="email_")
	public String getEmail() {
		return email;
	}
	@JSONField(name="email_")
	public void setEmail(String email) {
		this.email = email;
	}
	@JSONField(name="department_")
	public String getDepartment_() {
		return department_;
	}
	@JSONField(name="department_")
	public void setDepartment_(String department_) {
		this.department_ = department_;
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
	@JSONField(name="status_")
	public String getStatus() {
		return status;
	}
	@JSONField(name="status_")
	public void setStatus(String status) {
		this.status = status;
	}
	@JSONField(name="is_admin")
	public Integer getIsAdmin() {
		return isAdmin;
	}
	@JSONField(name="is_admin")
	public void setIsAdmin(Integer isAdmin) {
		this.isAdmin = isAdmin;
	}
	@JSONField(name="type_")
	public String getType() {
		return type;
	}
	@JSONField(name="type_")
	public void setType(String type) {
		this.type = type;
	}

}
