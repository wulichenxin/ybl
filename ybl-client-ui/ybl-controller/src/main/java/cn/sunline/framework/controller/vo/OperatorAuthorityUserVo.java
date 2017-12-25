package cn.sunline.framework.controller.vo;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;
/**
 * 用户关联权限实体类
 * @author MaiBenBen
 *
 */
public class OperatorAuthorityUserVo extends AbstractEntity{
	private static final long serialVersionUID = -1157066099975429232L;
	//用户id	
	private Long memberId;
	//操作id	
	private Long operatorId;
	//企业id
	private Long enterpriseId;
	
	@JSONField(name="member_id")
	public Long getMemberId() {
		return memberId;
	}
	@JSONField(name="member_id")
	public void setMemberId(Long memberId) {
		this.memberId = memberId;
	}
	@JSONField(name="operator_id")
	public Long getOperatorId() {
		return operatorId;
	}
	@JSONField(name="operator_id")
	public void setOperatorId(Long operatorId) {
		this.operatorId = operatorId;
	}
	@JSONField(name="enterpriseId")
	public Long getEnterpriseId() {
		return enterpriseId;
	}
	@JSONField(name="enterpriseId")
	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}
	
	@Override
	public String toString() {
		return "OperatorAuthorityUserVo [memberId=" + memberId + ", operatorId=" + operatorId + ", enterpriseId="
				+ enterpriseId + ", id=" + id + ", createdTime=" + createdTime + ", createdBy=" + createdBy
				+ ", lastUpdateTime=" + lastUpdateTime + ", lastUpdateBy=" + lastUpdateBy + ", enable=" + enable
				+ ", sign=" + sign + ", attribute1=" + attribute1 + ", attribute2=" + attribute2 + ", attribute3="
				+ attribute3 + ", attribute4=" + attribute4 + ", attribute5=" + attribute5 + ", attribute6="
				+ attribute6 + ", attribute7=" + attribute7 + ", attribute8=" + attribute8 + ", attribute9="
				+ attribute9 + ", attribute10=" + attribute10 + ", rowNo=" + rowNo + "]";
	}
}
