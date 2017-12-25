package cn.sunline.framework.controller.vo.v2;

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
public class FormBillVoucherObject {
	
	/*凭证商品集合*/
	private List<AccountsReceivableVoucherCommoditiesVo> voucherCommoditiesList;
	/*发票商品集合*/
	private List<AccountsReceivableBillCommoditiesVo> billCommoditiesList;
	public List<AccountsReceivableVoucherCommoditiesVo> getVoucherCommoditiesList() {
		return voucherCommoditiesList;
	}
	public void setVoucherCommoditiesList(List<AccountsReceivableVoucherCommoditiesVo> voucherCommoditiesList) {
		this.voucherCommoditiesList = voucherCommoditiesList;
	}
	public List<AccountsReceivableBillCommoditiesVo> getBillCommoditiesList() {
		return billCommoditiesList;
	}
	public void setBillCommoditiesList(List<AccountsReceivableBillCommoditiesVo> billCommoditiesList) {
		this.billCommoditiesList = billCommoditiesList;
	}
	
	
	
	
}
