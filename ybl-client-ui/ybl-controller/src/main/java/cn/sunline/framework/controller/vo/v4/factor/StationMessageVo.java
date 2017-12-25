package cn.sunline.framework.controller.vo.v4.factor;

import com.alibaba.fastjson.annotation.JSONField;

import cn.sunline.framework.controller.vo.common.AbstractEntity;
/**
 * 站内信实体
 *
 */
public class StationMessageVo extends AbstractEntity{

	
	private static final long serialVersionUID = -2826139352347368843L;
	/*消息标题*/
	private String title;
	/*消息内容*/
	private String content;
	/*会员id*/
	private Long memberId;
	/*是否已读 1 未读 2 已读*/
	private int status;
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	@JSONField(name = "member_id")
	public Long getMemberId() {
		return memberId;
	}
	@JSONField(name = "member_id")
	public void setMemberId(Long memberId) {
		this.memberId = memberId;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	
}
