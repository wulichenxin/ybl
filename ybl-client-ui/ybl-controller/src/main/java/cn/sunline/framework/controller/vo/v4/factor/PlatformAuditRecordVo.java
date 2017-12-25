package cn.sunline.framework.controller.vo.v4.factor;

import java.util.Date;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

import com.alibaba.fastjson.annotation.JSONField;

/**
 * 平台审核记录表
 */
public class PlatformAuditRecordVo extends AbstractEntity {
    
	/**
	 * 
	 */
	private static final long serialVersionUID = 3302226423890360560L;

	/**
	 * 融资申请id
	 */
	@JSONField(name="financing_apply_id")
	private Long financingApplyId;

    /**
     * 平台管理员id
     */
	@JSONField(name="user_id")
    private Long userId;

    /**
     * 审核类型：1-平台风控初审2-平台风控复审
     */
	@JSONField(name="audit_type")
    private String auditType;

    /**
     * 推荐资方（多个id，逗号间隔）
     */
	@JSONField(name="recommend_factor")
    private String recommendFactor;

    /**
     * 备注
     */
	@JSONField(name="remark")
    private String remark;

    /**
     * 审核结果：1-通过2-不通过3-驳回
     */
	@JSONField(name="audit_result")
    private String auditResult;
	
	/**
	 * 审核人
	 */
	@JSONField(name="user_name")
	private String userName;
	
	/**
	 * 审核时间
	 */
	@JSONField(name="created_time")
	private Date createdTime;
    
    public Date getCreatedTime() {
		return createdTime;
	}

	public void setCreatedTime(Date createdTime) {
		this.createdTime = createdTime;
	}

	public Long getFinancingApplyId() {
        return financingApplyId;
    }

    public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public void setFinancingApplyId(Long financingApplyId) {
        this.financingApplyId = financingApplyId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getAuditType() {
        return auditType;
    }

    public void setAuditType(String auditType) {
        this.auditType = auditType;
    }

    public String getRecommendFactor() {
        return recommendFactor;
    }

    public void setRecommendFactor(String recommendFactor) {
        this.recommendFactor = recommendFactor == null ? null : recommendFactor.trim();
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    public String getAuditResult() {
        return auditResult;
    }

    public void setAuditResult(String auditResult) {
        this.auditResult = auditResult;
    }

}