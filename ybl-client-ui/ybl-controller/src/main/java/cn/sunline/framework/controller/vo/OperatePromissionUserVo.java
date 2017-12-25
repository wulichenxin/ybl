package cn.sunline.framework.controller.vo;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * 用户授权（操作权限）
 * @author MaiBenBen
 *
 */
public class OperatePromissionUserVo extends AbstractEntity{
	
	private static final long serialVersionUID = -5123899126810334326L;
	
	private Long memberId;
	
	private List<String> operateId;
	
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
	public List<String> getOperateId() {
		return operateId;
	}
	@JSONField(name="operator_id")
	public void setOperateId(List<String> operateId) {
		this.operateId = operateId;
	}
	@JSONField(name="enterprise_id")
	public Long getEnterpriseId() {
		return enterpriseId;
	}
	@JSONField(name="enterprise_id")
	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}
	
	@Override
	public String toString() {
		return "OperatePromissionUserVo [memberId=" + memberId + ", operateId=" + operateId + ", enterpriseId="
				+ enterpriseId + ", id=" + id + ", createdTime=" + createdTime + ", createdBy=" + createdBy
				+ ", lastUpdateTime=" + lastUpdateTime + ", lastUpdateBy=" + lastUpdateBy + ", enable=" + enable
				+ ", sign=" + sign + ", attribute1=" + attribute1 + ", attribute2=" + attribute2 + ", attribute3="
				+ attribute3 + ", attribute4=" + attribute4 + ", attribute5=" + attribute5 + ", attribute6="
				+ attribute6 + ", attribute7=" + attribute7 + ", attribute8=" + attribute8 + ", attribute9="
				+ attribute9 + ", attribute10=" + attribute10 + ", rowNo=" + rowNo + "]";
	}
	
	
}
