package cn.sunline.framework.controller.vo.v4.drools;

import java.util.List;

import cn.sunline.framework.controller.vo.AttachmentVo;

/**
 * 业务认证所有参数对象
 * @author pc
 *
 */
public class V4AutoAddVo {
	//主要公共信息
	private V4BusinessAuthVO businessAuth;
	//股东列表集合
	private List<StockHolderVO> stockHolderList;
	//附件列表集合
	private List<AttachmentVo> attachmentList;
	public V4BusinessAuthVO getBusinessAuth() {
		return businessAuth;
	}
	public void setBusinessAuth(V4BusinessAuthVO businessAuth) {
		this.businessAuth = businessAuth;
	}
	public List<StockHolderVO> getStockHolderList() {
		return stockHolderList;
	}
	public void setStockHolderList(List<StockHolderVO> stockHolderList) {
		this.stockHolderList = stockHolderList;
	}
	public List<AttachmentVo> getAttachmentList() {
		return attachmentList;
	}
	public void setAttachmentList(List<AttachmentVo> attachmentList) {
		this.attachmentList = attachmentList;
	}
	
}
