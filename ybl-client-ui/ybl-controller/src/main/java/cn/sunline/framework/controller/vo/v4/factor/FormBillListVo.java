package cn.sunline.framework.controller.vo.v4.factor;

import java.util.List;

import cn.sunline.framework.controller.vo.v4.supplier.BillVO;



/**
 * 类型描述
 * 表单列表对象 用于接收form表单提交的票据对象数组
 *
 */
public class FormBillListVo {
	
	/*附件集合*/
	private List<BillVO> assetslist;

	public List<BillVO> getAssetslist() {
		return assetslist;
	}

	public void setAssetslist(List<BillVO> assetslist) {
		this.assetslist = assetslist;
	}

	
	
	
}
