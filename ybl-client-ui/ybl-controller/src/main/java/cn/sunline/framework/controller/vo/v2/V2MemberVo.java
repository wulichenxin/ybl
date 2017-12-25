package cn.sunline.framework.controller.vo.v2;

import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * 用户表V2实体类
 * 
 * @author JZX
 *
 */
public class V2MemberVo extends AbstractEntity {

	private static final long serialVersionUID = 8741638688750065907L;
	/* 企业id */
	private long enterpriseId;
	/* 用户名 */
	private String username;
	/* 真实姓名 */
	private String realname;
	/* 昵称 */
	private String nickname;
	/* 密码 */
	private String password;
	/* 性别 */
	private String sex;
	/* 盐 */
	private String salt;
	/* 手机 */
	private String telephone;
	/* 座机 */
	private String fixedPhone;
	/* 邮箱 */
	private String email;
	/* 注册时间 */
	private Date registerTime;
	/* 上次登录时间 */
	private Date preLoginTime;
	/* 上次登录地点 */
	private String preLoginAddress;
	/* 等级 */
	private String level;
	/* 是否管理员 */
	private Long isAdmin;
	/* 状态 */
	private String status;
	/* 部门 */
	private String department;
	/*角色id*/
	private Integer roleId;
	
	/**
	 * 类型-融资方：financing;资金方：fund;核心企业：enterprise;
	 */
	private String type;
	
	@JSONField(name="type_")
	public String getType() {
		return type;
	}
	@JSONField(name="type_")
	public void setType(String type) {
		this.type = type;
	}
	
	@JSONField(name = "role_id")
	public Integer getRoleId() {
		return roleId;
	}
	@JSONField(name = "role_id")
	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}
	@JSONField(name = "enterprise_id")
	public long getEnterpriseId() {
		return enterpriseId;
	}

	@JSONField(name = "enterprise_id")
	public void setEnterpriseId(long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

	@JSONField(name = "user_name")
	public String getUsername() {
		return username;
	}

	@JSONField(name = "user_name")
	public void setUsername(String username) {
		this.username = username;
	}

	@JSONField(name = "real_name")
	public String getRealname() {
		return realname;
	}

	@JSONField(name = "real_name")
	public void setRealname(String realname) {
		this.realname = realname;
	}

	@JSONField(name = "nick_name")
	public String getNickname() {
		return nickname;
	}

	@JSONField(name = "nick_name")
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	@JSONField(name = "password_")
	public String getPassword() {
		return password;
	}

	@JSONField(name = "password_")
	public void setPassword(String password) {
		this.password = password;
	}

	@JSONField(name = "salt_")
	public String getSalt() {
		return salt;
	}

	@JSONField(name = "salt_")
	public void setSalt(String salt) {
		this.salt = salt;
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

	@JSONField(name = "register_time")
	public Date getRegisterTime() {
		return registerTime;
	}

	@JSONField(name = "register_time")
	public void setRegisterTime(Date registerTime) {
		this.registerTime = registerTime;
	}

	@JSONField(name = "pre_login_time")
	public Date getPreLoginTime() {
		return preLoginTime;
	}

	@JSONField(name = "pre_login_time")
	public void setPreLoginTime(Date preLoginTime) {
		this.preLoginTime = preLoginTime;
	}

	@JSONField(name = "pre_login_address")
	public String getPreLoginAddress() {
		return preLoginAddress;
	}

	@JSONField(name = "pre_login_address")
	public void setPreLoginAddress(String preLoginAddress) {
		this.preLoginAddress = preLoginAddress;
	}

	@JSONField(name = "level_")
	public String getLevel() {
		return level;
	}

	@JSONField(name = "level_")
	public void setLevel(String level) {
		this.level = level;
	}

	@JSONField(name = "status_")
	public String getStatus() {
		return status;
	}

	@JSONField(name = "status_")
	public void setStatus(String status) {
		this.status = status;
	}

	@JSONField(name = "department_")
	public String getDepartment() {
		return department;
	}

	@JSONField(name = "department_")
	public void setDepartment(String department) {
		this.department = department;
	}

	@JSONField(name = "sex_")
	public String getSex() {
		return sex;
	}

	@JSONField(name = "sex_")
	public void setSex(String sex) {
		this.sex = sex;
	}

	@JSONField(name = "fixed_phone")
	public String getFixedPhone() {
		return fixedPhone;
	}

	@JSONField(name = "fixed_phone")
	public void setFixedPhone(String fixedPhone) {
		this.fixedPhone = fixedPhone;
	}

	@JSONField(name = "is_admin")
	public Long getIsAdmin() {
		return isAdmin;
	}

	@JSONField(name = "is_admin")
	public void setIsAdmin(Long isAdmin) {
		this.isAdmin = isAdmin;
	}

	@Override
	public String toString() {
		return "V2MemberVo [enterpriseId=" + enterpriseId + ", username=" + username + ", realname=" + realname
				+ ", nickname=" + nickname + ", password=" + password + ", sex=" + sex + ", salt=" + salt
				+ ", telephone=" + telephone + ", fixedPhone=" + fixedPhone + ", email=" + email + ", registerTime="
				+ registerTime + ", preLoginTime=" + preLoginTime + ", preLoginAddress=" + preLoginAddress + ", level="
				+ level + ", isAdmin=" + isAdmin + ", status=" + status + ", department=" + department + "]";
	}
}
