package cn.sunline.framework.controller.vo.v4.drools;

import java.util.List;

import cn.sunline.framework.controller.vo.AttachmentVo;

/**
 * 身份认证所有参数对象
 * @author pc
 *
 */
public class V4CardAutoVO {
	//主要公共信息
	private V4EnterpriseVO Enterprise;
	//附件列表集合
	private List<AttachmentVo> attachmentList;
	//会员id
	private Long memberId;
	
	public Long getMemberId() {
		return memberId;
	}
	public void setMemberId(Long memberId) {
		this.memberId = memberId;
	}
	public V4EnterpriseVO getEnterprise() {
		return Enterprise;
	}
	public void setEnterprise(V4EnterpriseVO enterprise) {
		Enterprise = enterprise;
	}
	public List<AttachmentVo> getAttachmentList() {
		return attachmentList;
	}
	public void setAttachmentList(List<AttachmentVo> attachmentList) {
		this.attachmentList = attachmentList;
	}
	
}
