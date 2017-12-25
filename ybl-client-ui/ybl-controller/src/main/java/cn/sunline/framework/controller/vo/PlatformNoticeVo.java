package cn.sunline.framework.controller.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;

public class PlatformNoticeVo extends AbstractEntity{

	/**
	 * 
	 */
	private static final long serialVersionUID = -8411682380667025658L;
	//公告图片
	private String url;
	//公告标题
	private String title;
	//公告状态
	private String status;
	//公告内容
	private String content;
	//发布时间
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date releaseDate;
	//发布开始时间,条件查询用
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date releaseBeginDate;
	//发布结束时间
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date releaseEendDate;
	
	//发布端口0-保理商门户端1-资产交易端
	private String publishPort;
	//浏览次数
	@JSONField(name="viewed_")
	private int viewed;
	
	public int getViewed() {
		return viewed;
	}
	public void setViewed(int viewed) {
		this.viewed = viewed;
	}
	@JSONField(name="publish_port")
	public String getPublishPort() {
		return publishPort;
	}
	@JSONField(name="publish_port")
	public void setPublishPort(String publishPort) {
		this.publishPort = publishPort;
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
	@JSONField(format = "yyyy-MM-dd",name="release_begin_date")
	public Date getReleaseBeginDate() {
		return releaseBeginDate;
	}
	@JSONField(format = "yyyy-MM-dd",name="release_begin_date")
	public void setReleaseBeginDate(Date releaseBeginDate) {
		this.releaseBeginDate = releaseBeginDate;
	}
	@JSONField(format = "yyyy-MM-dd",name="release_end_date")
	public Date getReleaseEendDate() {
		return releaseEendDate;
	}
	@JSONField(format = "yyyy-MM-dd",name="release_end_date")
	public void setReleaseEendDate(Date releaseEendDate) {
		this.releaseEendDate = releaseEendDate;
	}
	
	
}
