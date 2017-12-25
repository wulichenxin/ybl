package cn.sunline.framework.controller.vo;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

/**
 * @author guotai guotai@sunline.cn
 * @date 2017年4月24日
 * @version 1.0.0
 * @Description 友情链接实体类
 */
public class FriendlyLinkVo extends AbstractEntity {

	private static final long serialVersionUID = 6129496030815767327L;

	/**
	 * 名称
	 */
	private String name;
	/**
	 * 图片地址
	 */
	private String url;
	/**
	 * 图片点击跳转地址
	 */
	private String href;
	/**
	 * 所属终端:
	 * PC端：pc
     * 移动端：mobile
	 */
	private String remark;
	/**
	 * 打开方式:新窗口：_blank
     * 当前窗口：_self
	 */
	private String openType;
	/**
	 * 是否显示:显示：1
     * 不显示：0
	 */
	private int isShow;
	/**
	 * 企业id
	 */
	private long enterpriseId;
	
	
	/**
	 * @return the name
	 */
	@JSONField(name="name_")
	public String getName() {
		return name;
	}
	/**
	 * @param name the name to set
	 */
	@JSONField(name="name_")
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * @return the url
	 */
	@JSONField(name="url_")
	public String getUrl() {
		return url;
	}
	/**
	 * @param url the url to set
	 */
	@JSONField(name="url_")
	public void setUrl(String url) {
		this.url = url;
	}
	/**
	 * @return the href
	 */
	@JSONField(name="href_")
	public String getHref() {
		return href;
	}
	/**
	 * @param href the href to set
	 */
	@JSONField(name="href_")
	public void setHref(String href) {
		this.href = href;
	}
	/**
	 * @return the remark
	 */
	@JSONField(name="remark_")
	public String getRemark() {
		return remark;
	}
	/**
	 * @param remark the remark to set
	 */
	@JSONField(name="remark_")
	public void setRemark(String remark) {
		this.remark = remark;
	}
	/**
	 * @return the openType
	 */
	@JSONField(name="open_type")
	public String getOpenType() {
		return openType;
	}
	/**
	 * @param openType the openType to set
	 */
	@JSONField(name="open_type")
	public void setOpenType(String openType) {
		this.openType = openType;
	}
	/**
	 * @return the isShow
	 */
	@JSONField(name="is_show")
	public int getIsShow() {
		return isShow;
	}
	/**
	 * @param isShow the isShow to set
	 */
	@JSONField(name="is_show")
	public void setIsShow(int isShow) {
		this.isShow = isShow;
	}
	/**
	 * @return the enterpriseId
	 */
	@JSONField(name="enterprise_id")
	public long getEnterpriseId() {
		return enterpriseId;
	}
	/**
	 * @param enterpriseId the enterpriseId to set
	 */
	@JSONField(name="enterprise_id")
	public void setEnterpriseId(long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}
	
	@Override
	public String toString() {
		return "FriendlyLinkVo [name=" + name + ", url=" + url + ", href=" + href + ", remark=" + remark + ", openType="
				+ openType + ", isShow=" + isShow + ", enterpriseId=" + enterpriseId + ", id=" + id + ", createdTime="
				+ createdTime + ", createdBy=" + createdBy + ", lastUpdateTime=" + lastUpdateTime + ", lastUpdateBy="
				+ lastUpdateBy + ", enable=" + enable + ", sign=" + sign + ", attribute1=" + attribute1
				+ ", attribute2=" + attribute2 + ", attribute3=" + attribute3 + ", attribute4=" + attribute4
				+ ", attribute5=" + attribute5 + ", attribute6=" + attribute6 + ", attribute7=" + attribute7
				+ ", attribute8=" + attribute8 + ", attribute9=" + attribute9 + ", attribute10=" + attribute10
				+ ", rowNo=" + rowNo + "]";
	}
	
	

}
