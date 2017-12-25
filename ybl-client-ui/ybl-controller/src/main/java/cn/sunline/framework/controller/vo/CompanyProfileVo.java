package cn.sunline.framework.controller.vo;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

public class CompanyProfileVo extends AbstractEntity{

	/**
	 * 公司简介实体类
	 */
	private static final long serialVersionUID = 5784066131697003047L;
	//标题
	private String title;
	//内容
	private String content;
	//背景介绍
	private String background;
	
	@JSONField(name="background_")
	public String getBackground() {
		return background;
	}
	@JSONField(name="background_")
	public void setBackground(String background) {
		this.background = background;
	}
	@JSONField(name="title_")
	public String getTitle() {
		return title;
	}
	@JSONField(name="title_")
	public void setTitle(String title) {
		this.title = title;
	}
	@JSONField(name="content_")
	public String getContent() {
		return content;
	}
	@JSONField(name="content_")
	public void setContent(String content) {
		this.content = content;
	}
	
}
