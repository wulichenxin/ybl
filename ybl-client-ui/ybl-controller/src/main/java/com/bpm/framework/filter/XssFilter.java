package com.bpm.framework.filter;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import com.alibaba.fastjson.JSONObject;

/**
 * 非法字符拦截
 * 20170717
 * @author 张昌斌，孔德聚
 *
 */
public class XssFilter implements Filter {
	Logger logger = Logger.getLogger(XssFilter.class);

    FilterConfig filterConfig = null;
    private String encoding;
    
    private String[] illegalChars;
    
    private String[] unCatch;


    public void init(FilterConfig filterConfig) throws ServletException {
    	 this.encoding = filterConfig.getInitParameter("encoding");
         this.illegalChars = filterConfig.getInitParameter("illegalChars").split(",");
         this.unCatch = filterConfig.getInitParameter("unCatch").split(",");
    }
    public void destroy() {

        this.filterConfig = null;

    }

    public void doFilter(ServletRequest req, ServletResponse res,FilterChain chain) throws IOException, ServletException {
    	  HttpServletRequest request = (HttpServletRequest)req;
          req.setCharacterEncoding(this.encoding);
          res.setContentType("text/html;charset=" + this.encoding);
          //是否为Ajax标志
          String xrq = request.getHeader("X-Requested-With");
          boolean result = false;
          boolean flag = true;
          for (int i = 0; i < this.unCatch.length; ++i)
          {
              if (!(request.getRequestURI().contains(this.unCatch[i])))
                  continue;
              flag = false;
              break;
          }
          
          Map<String, String[]> submitParams = req.getParameterMap();
          
          if (flag)
          {
              
              if (StringUtils.isNotBlank(req.getContentType())
                  && req.getContentType().split(";")[0].equals("multipart/form-data"))
              {
                  try
                  {
                	  HttpServletRequestWrapper wrapperRequest =
                          new HttpServletRequestWrapper((HttpServletRequest)req);
                      DiskFileItemFactory factory = new DiskFileItemFactory();
                      ServletFileUpload upload = new ServletFileUpload(factory);
                      upload.setHeaderEncoding("UTF-8");
                      List<FileItem> items = upload.parseRequest(wrapperRequest);
                      for (FileItem fileItem : items)
                      {
                          if (fileItem.isFormField())
                          {
                              for (int j = 0; j < this.illegalChars.length; ++j)
                              {
                                  String illegalChar = this.illegalChars[j].replaceAll("&lt;", "<");
                                  if (fileItem.getString("utf-8").indexOf(illegalChar) == -1)
                                  {
                                      continue;
                                  }
                                  writerMessage((HttpServletRequest)req, res);
                                  return;
                              }
                          }
                      }
                      chain.doFilter(wrapperRequest, res);
                      return;
                  }
                  catch (FileUploadException e)
                  {
                      e.printStackTrace();
                  }
                  
              }
              
              if (null != submitParams)
              {
                  Set<String> submitNames = submitParams.keySet();
                  for (String submitName : submitNames)
                  {
                      for (int j = 0; j < this.illegalChars.length; ++j)
                      {
                          String illegalChar = this.illegalChars[j].replaceAll("&lt;", "<");
                          
                          if (request.getParameter(submitName).indexOf(illegalChar) == -1)
                              continue;
                          result = true;
                          break;
                      }
                      
                  }
                  
              }
              else
              {
                  result = false;
              }
              
          }
          
          if (result)
          {
              //是否是ajax请求
              if (StringUtils.isEmpty(xrq))
              {
                  HttpServletResponse response = (HttpServletResponse)res;
                  String webPath = request.getContextPath();
                  response.sendRedirect(webPath + "/home/errorcharactor.do");
                  
              }
              else
              {
                  writerMessage((HttpServletRequest)req, res);
              }
              return;
          }
          chain.doFilter(req, res);
    }
    public void writerMessage(HttpServletRequest req, ServletResponse res)
    {
        try
        {
            res.setContentType("application/json;charset=UTF-8");
            OutputStream out = res.getOutputStream();
            Map<String, String> map = new HashMap<String, String>();
            map.put("description", "当前链接中存在非法字符");
            out.write(("'','xss':" + JSONObject.toJSONString(map) + "}").getBytes("UTF-8"));
        }
        catch (IOException e)
        {
            e.printStackTrace();
        }
    }
}
