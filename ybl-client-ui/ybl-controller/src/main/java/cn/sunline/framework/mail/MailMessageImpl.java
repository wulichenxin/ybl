package cn.sunline.framework.mail;

import java.util.List;

/**
 * 
 * 邮件发送消息实体
 * 
 * @author lixx
 * @since 1.0
 * @createDate 2015-07-28 09:58:00
 */
public class MailMessageImpl implements MailMessage {

	private static final long serialVersionUID = -5149047657811876603L;
	
	private String subject;// 消息主题
	private String content;// 消息内容
	private String from;// 消息发起人
	private List<String> tos;// 消息接收人)
	private List<String> ccs;// 消息抄送人
	private List<String> bccs;// 秘密抄送人
	private List<String> filePaths;// 附件路径

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getFrom() {
		return from;
	}

	public void setFrom(String from) {
		this.from = from;
	}

	public List<String> getTos() {
		return tos;
	}

	public void setTos(List<String> tos) {
		this.tos = tos;
	}

	public List<String> getCcs() {
		return ccs;
	}

	public void setCcs(List<String> ccs) {
		this.ccs = ccs;
	}

	public List<String> getBccs() {
		return bccs;
	}

	public void setBccs(List<String> bccs) {
		this.bccs = bccs;
	}

	public List<String> getFilePaths() {
		return filePaths;
	}

	public void setFilePaths(List<String> filePaths) {
		this.filePaths = filePaths;
	}

}
