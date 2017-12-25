package cn.sunline.framework.controller.vo;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;
/**
 * 站内信实体类
 * @author MaiBenBen
 *
 */
public class InboxVo extends AbstractEntity {

	private static final long serialVersionUID = 7399651742616413876L;
	
	/* 企业表id */
	private Long enterpriseId=-1L;
	/* 发件人id*/
	private Long senderId;
	/*收件人id */
	private Long receiverId;
	/*标题 */
	private String title;
	/*内容 */
	private String content;
	/*是否已读:已读：Y 未读：N */
	private String isRead;
	

	@JSONField(name = "enterprise_id")
	public Long getEnterpriseId() {
		return enterpriseId;
	}

	@JSONField(name = "enterprise_id")
	public void setEnterpriseId(Long enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

	@JSONField(name = "sender_id")
	public Long getSenderId() {
		return senderId;
	}

	@JSONField(name = "sender_id")
	public void setSenderId(Long senderId) {
		this.senderId = senderId;
	}

	@JSONField(name = "receiver_id")
	public Long getReceiverId() {
		return receiverId;
	}

	@JSONField(name = "receiver_id")
	public void setReceiverId(Long receiverId) {
		this.receiverId = receiverId;
	}

	@JSONField(name = "title_")
	public String getTitle() {
		return title;
	}

	@JSONField(name = "title_")
	public void setTitle(String title) {
		this.title = title;
	}

	@JSONField(name = "content_")
	public String getContent() {
		return content;
	}

	@JSONField(name = "content_")
	public void setContent(String content) {
		this.content = content;
	}

	@JSONField(name = "is_read")
	public String getIsRead() {
		return isRead;
	}

	@JSONField(name = "is_read")
	public void setIsRead(String isRead) {
		this.isRead = isRead;
	}
	
}
