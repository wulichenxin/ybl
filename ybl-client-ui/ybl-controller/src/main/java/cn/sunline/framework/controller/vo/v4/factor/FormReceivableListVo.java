package cn.sunline.framework.controller.vo.v4.factor;

import java.util.List;

import cn.sunline.framework.controller.vo.v4.supplier.AccountsReceivableV4VO;


/**
 * 类型描述
 * 表单列表对象 用于接收form表单提交的对象数组
 *
 */
public class FormReceivableListVo {
	
	/*附件集合*/
	private List<AccountsReceivableV4VO> assetslist;

	public List<AccountsReceivableV4VO> getAssetslist() {
		return assetslist;
	}

	public void setAssetslist(List<AccountsReceivableV4VO> assetslist) {
		this.assetslist = assetslist;
	}
	
	
	
}
