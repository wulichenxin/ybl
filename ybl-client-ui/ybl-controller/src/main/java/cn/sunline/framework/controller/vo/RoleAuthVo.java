package cn.sunline.framework.controller.vo;

import java.util.List;
import com.bpm.framework.controller.fileupload.AttachmentVo;
/**
 * 角色认证所有参数对象
 * @author MaiBenBen
 *
 */
public class RoleAuthVo {
	private EnterpriseVo enterprise;
	private List<AttachmentVo> attachmentList;
	public EnterpriseVo getEnterprise() {
		return enterprise;
	}
	public void setEnterprise(EnterpriseVo enterprise) {
		this.enterprise = enterprise;
	}
	public List<AttachmentVo> getAttachmentList() {
		return attachmentList;
	}
	public void setAttachmentList(List<AttachmentVo> attachmentList) {
		this.attachmentList = attachmentList;
	}
}
