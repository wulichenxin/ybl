package cn.sunline.framework.controller.vo.v2;

import java.util.List;

import cn.sunline.framework.controller.vo.AttachmentVo;


/**
 * 类型描述
 * 表单列表对象 用于接收form表单提交的对象数组
 *
 */
public class FormAttachmentListVo {
	
	/*附件集合*/
	private List<AttachmentVo> attachmentList;

	public List<AttachmentVo> getAttachmentList() {
		return attachmentList;
	}

	public void setAttachmentList(List<AttachmentVo> attachmentList) {
		this.attachmentList = attachmentList;
	}

	
	
	
}
