package cn.sunline.framework.controller.vo;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;
/*
 * 会员签约表
 */
public class MemberSign extends AbstractEntity{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
		/*签约会员*/	
		private long memberId;
		/*被签约会员*/
		private long member2Id;
		/*状态*/
		private String status;
		/*备注*/
		private String remark;
		/*企业id(供应商id)*/
		private long enterpriseId;
		/*企业id(保理商id)*/
		private long enterprise2Id;
		
		@JSONField(name="member_id")
		public long getMemberId() {
			return memberId;
		}
		@JSONField(name="member_id")
		public void setMemberId(long memberId) {
			this.memberId = memberId;
		}
		@JSONField(name="member2_id")
		public long getMember2Id() {
			return member2Id;
		}
		@JSONField(name="member2_id")
		public void setMember2Id(long member2Id) {
			this.member2Id = member2Id;
		}
		@JSONField(name="status_")
		public String getStatus() {
			return status;
		}
		@JSONField(name="status_")
		public void setStatus(String status) {
			this.status = status;
		}
		@JSONField(name="remark_")
		public String getRemark() {
			return remark;
		}
		@JSONField(name="remark_")
		public void setRemark(String remark) {
			this.remark = remark;
		}
		@JSONField(name="enterprise_id")
		public long getEnterpriseId() {
			return enterpriseId;
		}
		@JSONField(name="enterprise_id")
		public void setEnterpriseId(long enterpriseId) {
			this.enterpriseId = enterpriseId;
		}
		@JSONField(name="enterprise2_id")
		public long getEnterprise2Id() {
			return enterprise2Id;
		}
		@JSONField(name="enterprise2_id")
		public void setEnterprise2Id(long enterprise2Id) {
			this.enterprise2Id = enterprise2Id;
		}
		
		
	
	
}
