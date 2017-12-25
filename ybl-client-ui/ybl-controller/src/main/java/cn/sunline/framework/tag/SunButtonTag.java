package cn.sunline.framework.tag;

import java.util.List;

import javax.servlet.jsp.JspException;

import org.springframework.web.servlet.support.JspAwareRequestContext;
import org.springframework.web.servlet.support.RequestContext;

import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.common.PermisssionRedisCache;
import com.bpm.framework.utils.CollectionUtils;
import com.bpm.framework.utils.StringUtils;

import cn.sunline.framework.controller.vo.PermissionVo;
import cn.sunline.framework.controller.vo.UserVo;

/**
 * 
 * 自定义button标签
 * 用于做按钮权限
 * 用法：<sun:button id="xxxx" value="提交" clazz="c_button" />
 * 
 * @author andyLee
 * @createDate 2017-03-16 12:15:00
 */
public class SunButtonTag extends EasyTag {

	/**
	 * 
	 */
	private static final long serialVersionUID = -740008397208944909L;

	private String value;// 对应input的value
	
	private String clazz;// 对应input的class
	
	private String type = "button";// 只有tag为input的时候才有用，对应input的type
	
	private String style;// 对应input的style
	
	private String tag = "input";// 指定需要生成标签类型
	
	private String href;// 只有当tag为a标签的时候才有用
	
	private String i18nValue;// 该属性表示是使用国际化code
	
	public final static String TAG_A = "A";
	public final static String TAG_INPUT = "INPUT";
	
	@Override
	public int doEndTag() throws JspException {
		// TODO 根据id验证是否有权限
		boolean isAuth = true;
		//PermissionVo permission = queryGrantPromissionUserByButtonId(this.getId());	
		/*if(permission==null ||(permission!=null && !"1".equals(permission.getAttribute1()))){//1代表有权限
			isAuth = false;
		}*/
		if(!isAuth) {
			return EVAL_PAGE;
		}
		StringBuilder html = new StringBuilder();
		if(StringUtils.isEmpty(tag) || TAG_INPUT.equalsIgnoreCase(tag)) {// input
			String tempValue = "";
			if(StringUtils.isNotEmpty(this.value) || StringUtils.isNotEmpty(this.i18nValue)) {
				RequestContext rc = ((RequestContext)pageContext.getAttribute("org.springframework.web.servlet.tags.REQUEST_CONTEXT"));
				if(null == rc) {
					rc = new JspAwareRequestContext(pageContext);
				}
				tempValue = StringUtils.isEmpty(this.value) ? rc.getMessage(this.i18nValue) : this.value;
			}
			// 如果有权限
			html.append("<input type=\"").append(StringUtils.isNullOrBlank(type) ? "button" : this.getType())
				.append("\" id=\"").append(this.getId())
				.append("\" name=\"").append(this.getId())
				.append("\" value=\"").append(tempValue)
				.append("\" class=\"").append(this.getClazz())
				.append("\" style=\"").append(this.getStyle())
				.append("\" />");
		} else if(TAG_A.equalsIgnoreCase(tag)) {// a
			html.append("<a href=\"").append(StringUtils.isNullOrBlank(href) ? "javascript:void(0);" : this.href)
				.append("\" id=\"").append(this.getId())
				.append("\" class=\"").append(this.getClazz())
				.append("\" style=\"").append(this.getStyle())
				.append("\">");
			if(StringUtils.isNotEmpty(this.value) || StringUtils.isNotEmpty(this.i18nValue)) {
				RequestContext rc = ((RequestContext)pageContext.getAttribute("org.springframework.web.servlet.tags.REQUEST_CONTEXT"));
				if(null == rc) {
					rc = new JspAwareRequestContext(pageContext);
				}
				html.append(StringUtils.isEmpty(this.value) ? rc.getMessage(this.i18nValue) : this.value);
			}
			html.append("</a>");
		}
		super.write(html);
		return EVAL_PAGE;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getClazz() {
		return clazz;
	}

	public void setClazz(String clazz) {
		this.clazz = clazz;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getStyle() {
		return style;
	}

	public void setStyle(String style) {
		this.style = style;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	public String getHref() {
		return href;
	}

	public void setHref(String href) {
		this.href = href;
	}

	public String getI18nValue() {
		return i18nValue;
	}

	public void setI18nValue(String i18nValue) {
		this.i18nValue = i18nValue;
	}
	

	/**
	 * 根据按钮的id来查询当前登录用户的按钮权限
	 * @param buttonId 按钮的id
	 * @return
	 */
	public PermissionVo queryGrantPromissionUserByButtonId(String buttonId) {
		//(1)获取当前登录人信息
		UserVo user= ControllerUtils.getCurrentUser();
		if (user != null && user.getId()!=null && user.getId().longValue()>0) {
			List<PermissionVo> permissionList = PermisssionRedisCache.getPermissionList(user.getId(),user.getUserName());
			if (CollectionUtils.isEmpty(permissionList)) {
				return null;
			} else {
				for(PermissionVo permission:permissionList){
					if(buttonId.equals(permission.getButtonId())){
						return permission;
					}
				}
			}
		}
		return null;
	}
	
}
