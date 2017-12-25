package cn.sunline.framework.controller.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

public class NewsVo extends AbstractEntity{

	/**
	 * 新闻实体类
	 */
	private static final long serialVersionUID = -75376377293165881L;
	//新闻图片地址
	private String url;
	//新闻标题
	private String title;
	//新闻类型
	private String type;
	//新闻状态
	private String status;
	//新闻内容
	private String content;
	//新闻发布时间
	@DateTimeFormat(pattern = "yyyy-MM-dd") 
	private Date releaseDate;
	//发布端口1-保理商门户端2-资产交易端
	@JSONField(name="publish_port")
	private Integer publishPort;
	//推荐状态1-推荐2-不推荐
	@JSONField(name="recommend_")
	private Integer recommend;
	//浏览次数
	@JSONField(name="viewed_")
	private int viewed;
	
	//简介
	@JSONField(name="introduction_")
	private String introduction;
		
		
	public String getIntroduction() {
		return introduction;
	}
	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}
	public Integer getPublishPort() {
		return publishPort;
	}
	public void setPublishPort(Integer publishPort) {
		this.publishPort = publishPort;
	}
	public Integer getRecommend() {
		return recommend;
	}
	public void setRecommend(Integer recommend) {
		this.recommend = recommend;
	}
	public int getViewed() {
		return viewed;
	}
	public void setViewed(int viewed) {
		this.viewed = viewed;
	}
	@JSONField(name="url_")
	public String getUrl() {
		return url;
	}
	@JSONField(name="url_")
	public void setUrl(String url) {
		this.url = url;
	}
	@JSONField(name="title_")
	public String getTitle() {
		return title;
	}
	@JSONField(name="title_")
	public void setTitle(String title) {
		this.title = title;
	}
	@JSONField(name="type_")
	public String getType() {
		return type;
	}
	@JSONField(name="type_")
	public void setType(String type) {
		this.type = type;
	}
	@JSONField(name="status_")
	public String getStatus() {
		return status;
	}
	@JSONField(name="status_")
	public void setStatus(String status) {
		this.status = status;
	}
	@JSONField(name="content_")
	public String getContent() {
		return content;
	}
	@JSONField(name="content_")
	public void setContent(String content) {
		this.content = content;
	}
	@JSONField(format = "yyyy-MM-dd",name="release_date")
	public Date getReleaseDate() {
		return releaseDate;
	}
	@JSONField(format = "yyyy-MM-dd",name="release_date")
	public void setReleaseDate(Date releaseDate) {
		this.releaseDate = releaseDate;
	}
	
}
