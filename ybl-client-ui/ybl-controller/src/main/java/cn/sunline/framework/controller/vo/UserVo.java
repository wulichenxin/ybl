package cn.sunline.framework.controller.vo;

import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;
/**
 * 用户实体类
 * @author MaiBenBen
 */
public class UserVo extends AbstractEntity {

	private static final long serialVersionUID = 1L;
	/*企业表id*/
	private Long enterpriseId;
	/*登录名*/	
	private String userName;
	/*用户名*/
	private String realName;
	/*昵称*/
	private String nickName;
	/*注册时间*/
	private Date registerTime;
	/*上次登录时间*/
	private String preLoginTime;
	/*上次登录地址*/
	private String preLoginAddress;
	/*手机号码*/
	private String telephone;
	/*等级*/
	private String level;
	/*认证角色：保理商：factor 供应商：supplier 核心企业：enterprise 普通会员：member*/
	private String certRole;
	/*邮箱*/
	private String email; 
	/*初始密码*/
	private String password;
	/*加盐字段*/
	private String salt;
	/*状态:正常：normal 冻结：freeze 注销：logout*/
	private String status;
	/**
	 * 业务认证通过角色id(表ybl_v4_business_auth)
	 */
	private Long businessId;
	/**
	 * 部门id
	 */
	private Long deptId;
	/**
	 * 性别
	 */
	private String gender;
	
	/**
	 * 认证时间
	 */
	private Date certTime;
	
	/**
	 * 是否管理员1-超管2-普通
	 */
	private Long isAdmin;
	
	/**
	 * 类型-融资方：financing;资金方：fund;核心企业：enterprise;
	 */
	private String type;
	
	
	@JSONField(name="business_id")
	public Long getBusinessId() {
		return businessId;
	}
	@JSONField(name="business_id")
	public void setBusinessId(Long businessId) {
		this.businessId = businessId;
	}
	@JSONField(name="is_admin")
	public Long getIsAdmin() {
		return isAdmin;
	}
	@JSONField(name="is_admin")
	public void setIsAdmin(Long isAdmin) {
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
	
	@JSONField(name="user_name")
	public String getUserName() {
		return userName;
	}	
	@JSONField(name="user_name")
	public void setUserName(String userName) {
		this.userName = userName;
	}	
	@JSONField(name="email_")
	public String getEmail() {
		return email;
	}
	@JSONField(name="email_")
	public void setEmail(String email) {
		this.email = email;
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
	@JSONField(name="status_")
	public String getStatus() {
		return status;
	}
	@JSONField(name="status_")
	public void setStatus(String status) {
		this.status = status;
	}
	@JSONField(name="enterprise_id")
	public Long getEnterpriseId() {
		return enterpriseId;
	}
	@JSONField(name="enterprise_id")
	public void setEnterpriseId(Long enterpriseId) {
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
	@JSONField(name="register_time")
	public Date getRegisterTime() {
		return registerTime;
	}
	@JSONField(name="register_time")
	public void setRegisterTime(Date registerTime) {
		this.registerTime = registerTime;
	}
	@JSONField(name="pre_login_time")
	public String getPreLoginTime() {
		return preLoginTime;
	}
	@JSONField(name="pre_login_time")
	public void setPreLoginTime(String preLoginTime) {
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
	@JSONField(name="telephone_")
	public String getTelephone() {
		return telephone;
	}
	@JSONField(name="telephone_")
	public void setTelephone(String telephone) {
		this.telephone = telephone;
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
	@JSONField(name="cert_role")
	public void setCertRole(String certRole) {
		this.certRole = certRole;
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
	@JSONField(name="cert_time")
	public Date getCertTime() {
		return certTime;
	}
	@JSONField(name="cert_time")
	public void setCertTime(Date certTime) {
		this.certTime = certTime;
	}
	@Override
	public String toString() {
		return "UserVo [enterpriseId=" + enterpriseId + ", userName=" + userName + ", realName=" + realName
				+ ", nickName=" + nickName + ", registerTime=" + registerTime + ", preLoginTime=" + preLoginTime
				+ ", preLoginAddress=" + preLoginAddress + ", telephone=" + telephone + ", level=" + level
				+ ", certRole=" + certRole + ", email=" + email + ", password=" + password + ", salt=" + salt
				+ ", status=" + status + ", businessId=" + businessId + ", deptId=" + deptId + ", gender=" + gender
				+ ", certTime=" + certTime + ", isAdmin=" + isAdmin + ", type=" + type + ", id=" + id + ", createdTime="
				+ createdTime + ", createdBy=" + createdBy + ", lastUpdateTime=" + lastUpdateTime + ", lastUpdateBy="
				+ lastUpdateBy + ", enable=" + enable + ", sign=" + sign + ", attribute1=" + attribute1
				+ ", attribute2=" + attribute2 + ", attribute3=" + attribute3 + ", attribute4=" + attribute4
				+ ", attribute5=" + attribute5 + ", attribute6=" + attribute6 + ", attribute7=" + attribute7
				+ ", attribute8=" + attribute8 + ", attribute9=" + attribute9 + ", attribute10=" + attribute10
				+ ", rowNo=" + rowNo + "]";
	}
	
	
}
