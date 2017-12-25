package cn.sunline.framework.controller.vo;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

public class TeamIntroductionVo extends  AbstractEntity{

	/**
	 * 
	 */
	private static final long serialVersionUID = -5168041902262380396L;
	//成员名称
	private String name;
	//职位头衔
	private String position;
	//排序
	private Long sort;
	//成员头像地址
	private String url;
	//个人简介
	private String desc;
	//工作成果
	private String achieve;
	@JSONField(name="name_")
	public String getName() {
		return name;
	}
	@JSONField(name="name_")
	public void setName(String name) {
		this.name = name;
	}
	@JSONField(name="position_description")
	public String getPosition() {
		return position;
	}
	@JSONField(name="position_description")
	public void setPosition(String position) {
		this.position = position;
	}
	@JSONField(name="sort_")
	public Long getSort() {
		return sort;
	}
	@JSONField(name="sort_")
	public void setSort(Long sort) {
		this.sort = sort;
	}
	@JSONField(name="url_")
	public String getUrl() {
		return url;
	}
	@JSONField(name="url_")
	public void setUrl(String url) {
		this.url = url;
	}
	@JSONField(name="desc_")
	public String getDesc() {
		return desc;
	}
	@JSONField(name="desc_")
	public void setDesc(String desc) {
		this.desc = desc;
	}
	@JSONField(name="work_achieve")
	public String getAchieve() {
		return achieve;
	}
	@JSONField(name="work_achieve")
	public void setAchieve(String achieve) {
		this.achieve = achieve;
	}
	
}
