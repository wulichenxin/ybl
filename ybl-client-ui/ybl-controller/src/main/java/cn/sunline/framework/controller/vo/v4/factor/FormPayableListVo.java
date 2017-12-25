package cn.sunline.framework.controller.vo.v4.factor;

import java.util.List;

import cn.sunline.framework.controller.vo.v4.supplier.AccountsPayableVO;



/**
 * 类型描述
 * 表单列表对象 用于接收form表单提交的应付账款对象数组
 *
 */
public class FormPayableListVo {
	
	/*附件集合*/
	private List<AccountsPayableVO> assetslist;

	public List<AccountsPayableVO> getAssetslist() {
		return assetslist;
	}

	public void setAssetslist(List<AccountsPayableVO> assetslist) {
		this.assetslist = assetslist;
	}
	
	
	
}
