package cn.sunline.framework.tag;

import java.io.IOException;

import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.tagext.TagSupport;

/**
 * 
 * 自定义标签
 * 
 * @author andyLee
 * @createDate 2017-03-16 12:15:00
 */
public class EasyTag extends TagSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = -740008397208944909L;
	
	private String id;

	@Override
	public int doStartTag() throws JspTagException {
		return EVAL_BODY_INCLUDE;
	}
	
	protected void write(StringBuilder html) {
		write(html.toString());
	}

	protected void write(String html) {
		try {
			pageContext.getOut().write(html);
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
}
