package cn.sunline.framework.controller.vo.common;

import java.util.List;

import com.bpm.framework.controller.fileupload.AttachmentVo;

import cn.sunline.framework.controller.vo.ProductConfigArchiveMaterialVo;
import cn.sunline.framework.controller.vo.ProductConfigFeeVo;
import cn.sunline.framework.controller.vo.ProductConfigLoanMaterialVo;
import cn.sunline.framework.controller.vo.SubjectVo;
import cn.sunline.framework.controller.vo.SubjectVoucherVo;

/**
 * 类型描述
 * 表单列表对象 用于接收form表单提交的对象数组
 *
 */
public class FormProductConfigObject {
	
	/*产品归档材料对象集合*/
	private List<ProductConfigArchiveMaterialVo> archiveMaterialList;
	/*产品费用对象集合*/
	private List<ProductConfigFeeVo> feeList;
	/*产品材料对象集合*/
	private List<ProductConfigLoanMaterialVo> materialList;
	
	public List<ProductConfigArchiveMaterialVo> getArchiveMaterialList() {
		return archiveMaterialList;
	}
	public void setArchiveMaterialList(List<ProductConfigArchiveMaterialVo> archiveMaterialList) {
		this.archiveMaterialList = archiveMaterialList;
	}
	public List<ProductConfigFeeVo> getFeeList() {
		return feeList;
	}
	public void setFeeList(List<ProductConfigFeeVo> feeList) {
		this.feeList = feeList;
	}
	public List<ProductConfigLoanMaterialVo> getMaterialList() {
		return materialList;
	}
	public void setMaterialList(List<ProductConfigLoanMaterialVo> materialList) {
		this.materialList = materialList;
	}
	
}
