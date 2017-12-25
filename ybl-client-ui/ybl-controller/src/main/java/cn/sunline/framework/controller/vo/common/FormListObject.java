package cn.sunline.framework.controller.vo.common;

import java.util.List;

import com.bpm.framework.controller.fileupload.AttachmentVo;

import cn.sunline.framework.controller.vo.ProductConfigLoanMaterialVo;
import cn.sunline.framework.controller.vo.SubjectVo;
import cn.sunline.framework.controller.vo.SubjectVoucherVo;

/**
 * 类型描述
 * 表单列表对象 用于接收form表单提交的对象数组
 *
 */
public class FormListObject {
	/*标的对象集合*/
	private List<SubjectVo> subjectList;
	/*附件对象集合*/
	private List<AttachmentVo> attachmentlist;
	/*标的凭证对象集合*/
	private List<SubjectVoucherVo> subjectVoucherList;
	/*标的贷款材料对象集合*/
	private List<ProductConfigLoanMaterialVo> productConfigLoanMaterialVoList;
	public List<SubjectVo> getSubjectList() {
		return subjectList;
	}
	public void setSubjectList(List<SubjectVo> subjectList) {
		this.subjectList = subjectList;
	}
	public List<AttachmentVo> getAttachmentlist() {
		return attachmentlist;
	}
	public void setAttachmentlist(List<AttachmentVo> attachmentlist) {
		this.attachmentlist = attachmentlist;
	}
	public List<SubjectVoucherVo> getSubjectVoucherList() {
		return subjectVoucherList;
	}
	public void setSubjectVoucherList(List<SubjectVoucherVo> subjectVoucherList) {
		this.subjectVoucherList = subjectVoucherList;
	}
	public List<ProductConfigLoanMaterialVo> getProductConfigLoanMaterialVoList() {
		return productConfigLoanMaterialVoList;
	}
	public void setProductConfigLoanMaterialVoList(List<ProductConfigLoanMaterialVo> productConfigLoanMaterialVoList) {
		this.productConfigLoanMaterialVoList = productConfigLoanMaterialVoList;
	}
	
}
