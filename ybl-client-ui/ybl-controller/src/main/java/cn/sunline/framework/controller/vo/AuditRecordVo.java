package cn.sunline.framework.controller.vo;

import java.math.BigDecimal;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;
/**
 * 审核记录表实体类
 * @author MaiBenBen
 *
 */
public class AuditRecordVo extends AbstractEntity {

	private static final long serialVersionUID = 70581823017359150L;
	
	private long businessId;
	
	private String type;
	
	private String operation;
	
	private String comment;
	
	private Long enterpriseId;
	
	private String status;

	@JSONField(name="business_id")
	public long getBusinessId() {
		return businessId;
	}

	@JSONField(name="business_id")
	public void setBusinessId(long businessId) {
		this.businessId = businessId;
	}

	@JSONField(name="type_")
	public String getType() {
		return type;
	}

	@JSONField(name="type_")
	public void setType(String type) {
		this.type = type;
	}

	@JSONField(name="operation_")
	public String getOperation() {
		return operation;
	}

	@JSONField(name="operation_")
	public void setOperation(String operation) {
		this.operation = operation;
	}

	@JSONField(name="comment_")
	public String getComment() {
		return comment;
	}

	@JSONField(name="comment_")
	public void setComment(String comment) {
		this.comment = comment;
	}

	@JSONField(name="enterprise_id")
	public Long getEnterpriseId() {
		return enterpriseId;
	}

	@JSONField(name="enterprise_id")
	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

	@JSONField(name="status_")
	public String getStatus() {
		return status;
	}

	@JSONField(name="status_")
	public void setStatus(String status) {
		this.status = status;
	}
	
	
	
}
