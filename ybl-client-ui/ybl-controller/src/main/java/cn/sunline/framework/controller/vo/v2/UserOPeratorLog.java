package cn.sunline.framework.controller.vo.v2;

import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * 登录日志表实体类
 * 
 * @author jzx
 *
 */
public class UserOPeratorLog extends AbstractEntity {

	private static final long serialVersionUID = 273805953935568743L;

	/* 会员id */
	private Long userId;
	/* 登录时间 */
	private Date loginTime;
	/* 企业id */
	private Long enterpriseId;
	/* 登录ip */
	private String loginIp;
	/* 用户名称 */
	private String userName;
	/* 备注 */
	private String remark;
	/* 操作系统 */
	private String operatorSystem;
	/* 操作终端 */
	private String operatorTerminal;
	/* 渠道 */
	private String channel;
	/*操作内同容*/
	private String operator;
	/*原始请求参数*/
	private String requestParameter;
	/*响应参数*/
    private String responseParameter;
    /*内容*/
    private String context;
	@JSONField(name = "user_id")
	public Long getUserId() {
		return userId;
	}

	@JSONField(name = "user_id")
	public void setUserId(Long userId) {
		this.userId = userId;
	}

	@JSONField(name = "login_time")
	public Date getLoginTime() {
		return loginTime;
	}

	@JSONField(name = "login_time")
	public void setLoginTime(Date loginTime) {
		this.loginTime = loginTime;
	}

	@JSONField(name = "enterprise_id")
	public Long getEnterpriseId() {
		return enterpriseId;
	}

	@JSONField(name = "enterprise_id")
	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

	@JSONField(name = "login_ip")
	public String getLoginIp() {
		return loginIp;
	}

	@JSONField(name = "login_ip")
	public void setLoginIp(String loginIp) {
		this.loginIp = loginIp;
	}

	@JSONField(name = "user_name")
	public String getUserName() {
		return userName;
	}

	@JSONField(name = "user_name")
	public void setUserName(String userName) {
		this.userName = userName;
	}

	@JSONField(name = "remark_")
	public String getRemark() {
		return remark;
	}

	@JSONField(name = "remark_")
	public void setRemark(String remark) {
		this.remark = remark;
	}

	@JSONField(name = "operator_system")
	public String getOperatorSystem() {
		return operatorSystem;
	}

	@JSONField(name = "operator_system")
	public void setOperatorSystem(String operatorSystem) {
		this.operatorSystem = operatorSystem;
	}

	@JSONField(name = "operator_terminal")
	public String getOperatorTerminal() {
		return operatorTerminal;
	}

	@JSONField(name = "operator_terminal")
	public void setOperatorTerminal(String operatorTerminal) {
		this.operatorTerminal = operatorTerminal;
	}

	@JSONField(name = "channel_")
	public String getChannel() {
		return channel;
	}

	@JSONField(name = "channel_")
	public void setChannel(String channel) {
		this.channel = channel;
	}
	
	@JSONField(name = "operator_")
	public String getOperator() {
		return operator;
	}

	@JSONField(name = "operator_")
	public void setOperator(String operator) {
		this.operator = operator;
	}
	
	@JSONField(name = "request_parameter")
	public String getRequestParameter() {
		return requestParameter;
	}

	@JSONField(name = "request_parameter")
	public void setRequestParameter(String requestParameter) {
		this.requestParameter = requestParameter;
	}
	
	@JSONField(name = "response_parameter")
	public String getResponseParameter() {
		return responseParameter;
	}

	@JSONField(name = "response_parameter")
	public void setResponseParameter(String responseParameter) {
		this.responseParameter = responseParameter;
	}
	@JSONField(name = "context_")
	public String getContext() {
		return context;
	}

	@JSONField(name = "context_")
	public void setContext(String context) {
		this.context = context;
	}
}