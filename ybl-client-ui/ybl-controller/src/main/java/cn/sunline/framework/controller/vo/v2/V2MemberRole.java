package cn.sunline.framework.controller.vo.v2;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

public class V2MemberRole  extends AbstractEntity{

	/**
	 * 
	 */
	private static final long serialVersionUID = -7601496300693920772L;
		//用户id	
		private Long userId;
		//角色id	
		private Long roleId;
		/**
		 *企业id
		 */
		private Long enterpriseId;
		
		@JSONField(name="member_id")
		public Long getUserId() {
			return userId;
		}
		@JSONField(name="member_id")
		public void setUserId(Long userId) {
			this.userId = userId;
		}
		@JSONField(name="role_id")
		public Long getRoleId() {
			return roleId;
		}
		@JSONField(name="role_id")
		public void setRoleId(Long roleId) {
			this.roleId = roleId;
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
			return "UserRoleVo [userId=" + userId + ", roleId=" + roleId + ", enterpriseId=" + enterpriseId + ", id=" + id
					+ ", createdTime=" + createdTime + ", createdBy=" + createdBy + ", lastUpdateTime=" + lastUpdateTime
					+ ", lastUpdateBy=" + lastUpdateBy + ", enable=" + enable + ", sign=" + sign + ", attribute1="
					+ attribute1 + ", attribute2=" + attribute2 + ", attribute3=" + attribute3 + ", attribute4="
					+ attribute4 + ", attribute5=" + attribute5 + ", attribute6=" + attribute6 + ", attribute7="
					+ attribute7 + ", attribute8=" + attribute8 + ", attribute9=" + attribute9 + ", attribute10="
					+ attribute10 + ", rowNo=" + rowNo + "]";
		}
	

}
