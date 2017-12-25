package cn.sunline.framework.controller.vo;

import java.util.List;
import com.bpm.framework.controller.fileupload.AttachmentVo;
/**
 * 标的申请所有参数对象
 * @author MaiBenBen
 *
 */
public class SubjectBatchVo {
	private SubjectVo Subject;
	private List<AttachmentVo> attachmentList;
	private List<SubjectVoucherVo> subjectVoucherList;
	private List<ProductConfigLoanMaterialVo> productConfigLoanMaterialVoList;
	
	public SubjectVo getSubject() {
		return Subject;
	}
	public void setSubject(SubjectVo subject) {
		Subject = subject;
	}
	public List<AttachmentVo> getAttachmentList() {
		return attachmentList;
	}
	public void setAttachmentList(List<AttachmentVo> attachmentList) {
		this.attachmentList = attachmentList;
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
