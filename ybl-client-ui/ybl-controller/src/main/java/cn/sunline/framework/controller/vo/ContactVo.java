package cn.sunline.framework.controller.vo;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

public class ContactVo extends AbstractEntity{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1386323796942640281L;
	private String title;
	private String address;
	private String phone;
	private String fax;
	private String email;
	private String ranking;
	@JSONField(name="title_")
	public String getTitle() {
		return title;
	}
	@JSONField(name="title_")
	public void setTitle(String title) {
		this.title = title;
	}
	@JSONField(name="address_")
	public String getAddress() {
		return address;
	}
	@JSONField(name="address_")
	public void setAddress(String address) {
		this.address = address;
	}
	@JSONField(name="phone_")
	public String getPhone() {
		return phone;
	}
	@JSONField(name="phone_")
	public void setPhone(String phone) {
		this.phone = phone;
	}
	@JSONField(name="fax_")
	public String getFax() {
		return fax;
	}
	@JSONField(name="fax_")
	public void setFax(String fax) {
		this.fax = fax;
	}
	@JSONField(name="email_")
	public String getEmail() {
		return email;
	}
	@JSONField(name="email_")
	public void setEmail(String email) {
		this.email = email;
	}
	@JSONField(name="ranking_")
	public String getRanking() {
		return ranking;
	}
	@JSONField(name="ranking_")
	public void setRanking(String ranking) {
		this.ranking = ranking;
	}
	
}
