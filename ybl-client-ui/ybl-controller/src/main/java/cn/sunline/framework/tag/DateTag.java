package cn.sunline.framework.tag;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

public class DateTag extends TagSupport {
    private static final long serialVersionUID = -2312310581852395045L;
    private String value;
    private String parttern;

    @Override
    public int doStartTag() throws JspException {
        String vv = "" + value;
        try {
        if(value ==null || "".equals(vv)){
        	pageContext.getOut().write("");
        	return super.doStartTag();
        }
        long time = Long.valueOf(vv);
        Calendar c = Calendar.getInstance();
        c.setTimeInMillis(time);
        SimpleDateFormat dateformat = new SimpleDateFormat(parttern);
        String s = dateformat.format(c.getTime());
        
            pageContext.getOut().write(s);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return super.doStartTag();
    }

    public void setValue(String value) {
        this.value = value;
    }
    
    public void setParttern(String parttern ) {
         this.parttern =  parttern ;
    }
}