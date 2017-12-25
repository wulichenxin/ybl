package com.bpm.framework.controller.filedownload;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.regex.PatternSyntaxException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.net.ftp.FTPClient;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.console.Application;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.utils.FtpUtils;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.date.DateUtils;
import com.bpm.framework.utils.file.ResponseDownloadUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.AttachmentVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 
 *  文件下载
 * 
 * @author Gin
 * @createDate 2015-07-28 21:10:00
 */
@Controller
@RequestMapping({ "/fileDownloadController" })
public class FileDownloadController extends AbstractController {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5579378834935607952L;

	@RequestMapping(value="/download", method={ RequestMethod.POST })
	@ResponseBody
	public void download(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		try {
			String filePath=this.getParameterNotNull("filePath", String.class);
			String fileDownloadName=this.getParameterNotNull("fileDownloadName", String.class);
			File file = new File(filePath);
			//火狐浏览器会乱码
	    	String agent=getRequest().getHeader("User-Agent").toLowerCase();
			boolean isFirefox = (agent.indexOf("firefox") > -1);		
			ResponseDownloadUtils.download(response, file, fileDownloadName,isFirefox);
			//ResponseDownloadUtils.download(response, file ,fileDownloadName); 
		} catch (Exception ex) {
			log.error("下载文件异常：", ex);
			throw new RuntimeException("下载文件异常：", ex);
		}
	}
	/**
	 * 文件下载
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/downloadftp", method={ RequestMethod.GET })
	@ResponseBody
	public void downloadftp(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		try {
			Long id=this.getParameterNotNull("id", Long.class);
			if(id!=null){
				AttachmentVo paramter=new AttachmentVo();
				paramter.setId(id);
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("paramter", paramter);
				map.put("sign", "queryAttachmentById");
				ResBody result = TradeInvokeUtils.invoke("AttachmentManagement", map);
				AttachmentVo attachmentVo=null;
				if(result.getSys() != null){
					String status = result.getSys().getStatus();
					if("S".equals(status)){
						JSONObject output = (JSONObject) result.getOutput();
						String records = output.getString("result");
						attachmentVo = JsonUtils.toObject(records, AttachmentVo.class);
					}
				}
				if(attachmentVo!=null){
					String fileDownloadName=attachmentVo.getNewName();
					String oldName=attachmentVo.getOldName();
					String extName=attachmentVo.getExtName();
					oldName=oldName.substring(0,oldName.lastIndexOf("."));
					oldName=oldName.replaceAll(" ", "%");
					oldName=StringFilter(oldName);
					oldName=oldName+"."+extName;
					// 判断是否配置了ftp，如果配置了ftp，则使用ftp上传
					String ip = Application.getInstance().getByKey("ftp.ip");
					String user = Application.getInstance().getByKey("ftp.user");
					String pwd = Application.getInstance().getByKey("ftp.password");
					//先下载到本地的目录
					String tempDir = Application.getInstance().getByKey("app.attach.file_upload_temp.dir");
					//randomName="aa.jpg"
					File file = new File((tempDir +"/"+ fileDownloadName).replaceAll("\\\\", "/"));
					//如果文件不存在则先从FTP服务器上下载到本地
					if(!file.exists() && StringUtils.isNotEmpty(ip)) {
						StringBuffer  sb = new StringBuffer();
						sb.append("开始ftp下载，ip = ").append(ip)
						.append(";user = ").append(user)
						.append(";pwd = ").append(pwd)
						.append(";本地地址 = ").append(file.getParent())
						.append(";文件名称= ").append(file.getName());
						log.info(sb.toString());
						FTPClient client = FtpUtils.loginFtp(ip, user, pwd);
						client.changeWorkingDirectory("customer");
						boolean  ftpFlag = FtpUtils.downOneFile(client, file.getParent(), file.getName());
						log.info("开始ftp下载结果： " + ftpFlag);
					}
					String agent=getRequest().getHeader("User-Agent").toLowerCase();
					boolean isFirefox = (agent.indexOf("firefox") > -1);
					//下载
					ResponseDownloadUtils.download(response, file, oldName,isFirefox);
				}
			}
		} catch (Exception ex) {
			log.error("下载文件异常：", ex);
			throw new RuntimeException("下载文件异常：", ex);
		}
	}
	/**
	 * 文件下载
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/downloadftpByNewName", method={ RequestMethod.GET })
	@ResponseBody
	public void downloadftpByNewName(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		try {
			String newName=new String(this.getParameterNotNull("newName").getBytes("ISO-8859-1"),"utf-8");
			if(newName!=null&&!"".equals(newName)){
				AttachmentVo paramter=new AttachmentVo();
				paramter.setNewName(newName);
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("paramter", paramter);
				map.put("sign", "queryAttchmentByCondition");
				ResBody result = TradeInvokeUtils.invoke("AttachmentManagement", map);
				List<AttachmentVo> attachmentList=null;
				if (result.getSys() != null) {
					String retStatus = result.getSys().getStatus();
					if ("S".equals(retStatus)) {
						JSONObject output = (JSONObject) result.getOutput();
						String records = output.getString("result");
						attachmentList=JsonUtils.toList(records,AttachmentVo.class);
					}
				}
				if(attachmentList!=null&&attachmentList.size()>0){
					String fileDownloadName=attachmentList.get(0).getNewName();
					String oldName=attachmentList.get(0).getOldName();
					String extName=attachmentList.get(0).getExtName();
					oldName=oldName.substring(0,oldName.lastIndexOf("."));
					oldName=oldName.replaceAll(" ", "%");
					oldName=StringFilter(oldName);
					oldName=oldName+"."+extName;
					// 判断是否配置了ftp，如果配置了ftp，则使用ftp上传
					String ip = Application.getInstance().getByKey("ftp.ip");
					String user = Application.getInstance().getByKey("ftp.user");
					String pwd = Application.getInstance().getByKey("ftp.password");
					//先下载到本地的目录
					String tempDir = Application.getInstance().getByKey("app.attach.file_upload_temp.dir");
					//randomName="aa.jpg"
					File file = new File((tempDir +"/"+ fileDownloadName).replaceAll("\\\\", "/"));
					//如果文件不存在则先从FTP服务器上下载到本地
					if(!file.exists() && StringUtils.isNotEmpty(ip)) {
						StringBuffer  sb = new StringBuffer();
						sb.append("开始ftp下载，ip = ").append(ip)
						.append(";user = ").append(user)
						.append(";pwd = ").append(pwd)
						.append(";本地地址 = ").append(file.getParent())
						.append(";文件名称= ").append(file.getName());
						log.info(sb.toString());
						FTPClient client = FtpUtils.loginFtp(ip, user, pwd);
						client.changeWorkingDirectory("customer");
						boolean  ftpFlag = FtpUtils.downOneFile(client, file.getParent(), file.getName());
						log.info("开始ftp下载结果： " + ftpFlag);
					}
					String agent=getRequest().getHeader("User-Agent").toLowerCase();
					boolean isFirefox = (agent.indexOf("firefox") > -1);
					//下载
					ResponseDownloadUtils.download(response, file, oldName,isFirefox);
				}
			}
		} catch (Exception ex) {
			log.error("下载文件异常：", ex);
			throw new RuntimeException("下载文件异常：", ex);
		}
	}
	/**
     * 文件下载
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value="/downloadNow", method={ RequestMethod.GET })
    @ResponseBody
    public void downloadNow(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        try {
            String oldName = null;
            String fileDownloadName =new String(this.getParameterNotNull("newName").getBytes("ISO-8859-1"),"utf-8");
            try{
                oldName=new String(this.getParameterNotNull("oldName").getBytes("ISO-8859-1"),"utf-8");
            }catch(Exception e){//如果上传附件名字字符特殊，用当前时间表示附件名称
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHH");
                oldName = dateFormat.format(DateUtils.now());
                String extName = new String(this.getParameterNotNull("extName").getBytes("ISO-8859-1"),"utf-8");
                oldName = oldName+"."+extName;
            }
                if(fileDownloadName!=null && oldName != null){
                    // 判断是否配置了ftp，如果配置了ftp，则使用ftp上传
                    String ip = Application.getInstance().getByKey("ftp.ip");
                    String user = Application.getInstance().getByKey("ftp.user");
                    String pwd = Application.getInstance().getByKey("ftp.password");
                    //先下载到本地的目录
                    String tempDir = Application.getInstance().getByKey("app.attach.file_upload_temp.dir");
                    //randomName="aa.jpg"
                    File file = new File((tempDir +"/"+ fileDownloadName).replaceAll("\\\\", "/"));
                    //如果文件不存在则先从FTP服务器上下载到本地
                    if(!file.exists() && StringUtils.isNotEmpty(ip)) {
                        StringBuffer  sb = new StringBuffer();
                        sb.append("开始ftp下载，ip = ").append(ip)
                        .append(";user = ").append(user)
                        .append(";pwd = ").append(pwd)
                        .append(";本地地址 = ").append(file.getParent())
                        .append(";文件名称= ").append(file.getName());
                        log.info(sb.toString());
                        FTPClient client = FtpUtils.loginFtp(ip, user, pwd);
                        client.changeWorkingDirectory("customer");
                        boolean  ftpFlag = FtpUtils.downOneFile(client, file.getParent(), file.getName());
                        log.info("开始ftp下载结果： " + ftpFlag);
                    }
                    String agent=getRequest().getHeader("User-Agent").toLowerCase();
                    boolean isFirefox = (agent.indexOf("firefox") > -1);
                    //下载
                    ResponseDownloadUtils.download(response, file, oldName,isFirefox);
                }
            
        } catch (Exception ex) {
            log.error("下载文件异常：", ex);
            throw new RuntimeException("下载文件异常：", ex);
        }
    }
    public static String StringFilter(String str) throws PatternSyntaxException { // 过滤特殊字符 
    	// 只允许字母和数字 // String regEx ="[^a-zA-Z0-9]"; 
    	// 清除掉所有特殊字符 
    		String regEx="[`~!@#$%^&*()+=|{}':;',\\[\\].<>/?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？]"; 
    		Pattern p = Pattern.compile(regEx); 
    		Matcher m = p.matcher(str);
    		return m.replaceAll("").trim();
    	} 
}