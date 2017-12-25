package cn.sunline.framework.mail;

import java.io.File;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;

import com.bpm.framework.SystemConst;
import com.bpm.framework.utils.CollectionUtils;
import com.bpm.framework.utils.file.FileUtils;

/**
 * 
 * 邮件发送工具类
 * 
 * @author lixx
 * @since 1.0
 * @createDate 2015-07-28 09:58:00
 */
public class MailSender implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4631919451607606089L;

	final JavaMailSenderImpl senderImpl = new JavaMailSenderImpl();

	private static final Logger log = LoggerFactory.getLogger(MailSender.class);
	
	public MailSender(String host, String username, String password) {
		senderImpl.setHost(host);
		// SMTP验证时，需要用户名和密码
		senderImpl.setUsername(username);
		senderImpl.setPassword(password);
	}

	public MailSender(String host, String username, String password,
			Properties props) {
		senderImpl.setHost(host);
		// SMTP验证时，需要用户名和密码
		senderImpl.setUsername(username);
		senderImpl.setPassword(password);
		senderImpl.setJavaMailProperties(props);
	}

	public void setPort(int port) {
		senderImpl.setPort(port);
	}

	public void setDefaultEncoding(String defaultEncoding) {
		senderImpl.setDefaultEncoding(defaultEncoding);
	}

	public void setProtocol(String protocol) {
		senderImpl.setProtocol(protocol);
	}

	public void setJavaMailProperties(Properties props) {
		senderImpl.setJavaMailProperties(props);
	}

	public void send(MailMessage msg) {
		try {
			log.info("开始发送邮件...");
			MimeMessage mailMessage = senderImpl.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(mailMessage, true, SystemConst.ENCODING_UTF8);

			helper.setFrom(msg.getFrom());
			helper.setSubject(msg.getSubject());
			helper.setText(msg.getContent(), true);

			if (!CollectionUtils.isEmpty(msg.getTos())) {
				for (String to : msg.getTos()) {
					helper.addTo(to);
				}
			}

			if (!CollectionUtils.isEmpty(msg.getCcs())) {
				for (String cc : msg.getCcs()) {
					helper.addCc(cc);
				}
			}

			if (!CollectionUtils.isEmpty(msg.getBccs())) {
				for (String bcc : msg.getBccs()) {
					helper.addBcc(bcc);
				}
			}

			if (!CollectionUtils.isEmpty(msg.getFilePaths())) {
				for (String filepath : msg.getFilePaths()) {
					FileSystemResource file = new FileSystemResource(new File(
							filepath));
					helper.addAttachment(FileUtils.getFileName(filepath), file);
				}
			}
			senderImpl.send(mailMessage);
			log.info("发送邮件成功...");
		} catch (MessagingException e) {
			log.error("发送邮件异常：", e);
		}
	}
	
	/**
	 * 发送系统邮件
	 * @param title
	 * @param content
	 * @param targetAddr
	 */
	public static boolean sendSysMail(String title,String content,List<String> targetAddr){
		try{
			// pop.exmail.qq.com
			Properties props = new Properties();
			props.put("mail.smtp.auth", "true");// 默认就是true
			// smtp.exmail.qq.com  pop.exmail.qq.com 都可以
			MailSender s = new MailSender("smtp.qq.com", "system@dhhtong.com", "dhht2015", props);
			s.setPort(25);// 默认值就是25
			s.setProtocol("smtp");// 默认值就是smtp
			MailMessageImpl m = new MailMessageImpl();
			m.setTos(targetAddr);
			m.setSubject(title);
			m.setContent(content.toString());
			m.setFrom("system@dhhtong.com");
			s.send(m);
			log.info("sys发送邮件成功...");
			return true;
		}catch(Exception e){
			log.error("sys发送邮件异常：", e);
			return false;
		}
	}
	
	/**
	 * 发送info邮件
	 * @param title
	 * @param content
	 * @param targetAddr
	 */
	public static void sendInfoMail(String title,String content,List<String> targetAddr){
		try{
			 
			String emailServer = EmailPropCache.getInstance().getByKey("email.server");
			String emailUser = EmailPropCache.getInstance().getByKey("email.user");
			String emailPwd = EmailPropCache.getInstance().getByKey("email.pwd");
			String emailFrom = EmailPropCache.getInstance().getByKey("email.from");
			// pop.exmail.qq.com
			Properties props = new Properties();
			props.put("mail.smtp.auth", "true");// 默认就是true
			// smtp.exmail.qq.com  pop.exmail.qq.com 都可以
			MailSender s = new MailSender(emailServer, emailUser, emailPwd, props);
			s.setPort(25);// 默认值就是25
			s.setProtocol("smtp");// 默认值就是smtp
			MailMessageImpl m = new MailMessageImpl();
			m.setTos(targetAddr);
			m.setSubject(title);
			m.setContent(content.toString());
			m.setFrom(emailFrom);
			s.send(m);
			log.info("info发送邮件成功...");
		}catch(Exception e){
			log.error("info发送邮件异常：", e);
		}
	}
	
	public static void main(String... args) {
		/*// pop.exmail.qq.com
		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");// 默认就是true
		// smtp.exmail.qq.com  pop.exmail.qq.com 都可以
		MailSender s = new MailSender("smtp.exmail.qq.com", "sys@pictech.com.cn", "jbpm2015", props);
		s.setPort(25);// 默认值就是25
		s.setProtocol("smtp");// 默认值就是smtp
		MailMessageImpl m = new MailMessageImpl();
		StringBuffer content = new StringBuffer();
		content.append("<html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=gb2312\"></head><body style>");
		content.append("你好：<br>该邮件是普爱创科技自动发送邮件，提醒您，您有待办事项需要处理，点击下面的链接进入处理页面。<p>");
		content.append("<a href=\"http://120.24.239.89:8080\">");
		content.append("点击链接进入代办事宜处理页面</a></body></html>");
		content.append("以后发送邮件使用MailSender.java类，具体参数参考该类的mail方法！");
		m.setFrom("sys@pictech.com.cn");
		List<String> tos = new ArrayList<String>();
		tos.add("lijing@pictech.com.cn");
		m.setTos(tos);
		m.setSubject("测试邮件（该邮件为spring mail测试邮件）");
		m.setContent(content.toString());
		s.send(m);*/
		
		
		String mailTitle = "测试邮件";
		
		
		StringBuffer content = new StringBuffer();
		content.append("<html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=gb2312\"></head><body style>");
		content.append("你好");
		
		content.append("有新企业注册了");
		content.append("</body></html>");
		
		List<String> targets = new ArrayList<String>();
		targets.add("1056613390@qq.com");
		MailSender.sendSysMail(mailTitle, content.toString(), targets);
	}
}
