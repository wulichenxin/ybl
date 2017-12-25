package cn.sunline.framework.mail;

import java.io.Serializable;
import java.util.List;

/**
 * 
 * 邮件发送消息实体接口
 * 
 * @author lixx
 * @since 1.0
 * @createDate 2015-07-28 09:58:00
 */
public interface MailMessage extends Serializable {

	public String getSubject();

	public String getContent();

	public String getFrom();

	public List<String> getTos();

	public List<String> getCcs();

	public List<String> getBccs();

	public List<String> getFilePaths();

}
