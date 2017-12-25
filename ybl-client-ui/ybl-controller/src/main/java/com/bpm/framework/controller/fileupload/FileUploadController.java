package com.bpm.framework.controller.fileupload;

import java.io.File;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.net.ftp.FTPClient;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.annotation.ValidateSession;
import com.bpm.framework.annotation.Web;
import com.bpm.framework.annotation.WebValue;
import com.bpm.framework.console.Application;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.exception.FrameworkRuntimeException;
import com.bpm.framework.utils.FtpUtils;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.file.FileUtils;
import com.bpm.framework.utils.file.ResponseDownloadUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 
 * 文件上传控制器
 * 
 * @author lixx
 * @createDate 2015-07-27 23:00:00
 */
@Web(WebValue.ALL)
@Controller
@RequestMapping({ "/fileUploadController" })
public class FileUploadController extends AbstractController {

	private static final long serialVersionUID = 5579378834935607952L;
	/*不允许上传的文件*/
	private static String[] ILLAEAL_SUFFIX = new String[]{".jsp",".html",".jspx",".jsf",".htm",".shtml",".asp",".aspx",".php"};

	@ValidateSession(validate = false)
	@RequestMapping(value = "/upload", method = { RequestMethod.POST })
	@ResponseBody
	public Object upload(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
			FileUploadVO vo = new FileUploadVO();
			boolean isMultipart = ServletFileUpload.isMultipartContent(request);
			if (!isMultipart) {
				throw new FrameworkRuntimeException("file upload must be form submit.");
			} else {
				/**
				 * 
				 * 1、如果没有配置ftp，则以application.properties配置的uploadFiles目录为准，上传到此目录
				 * 2、如果配置了ftp，则把文件先上传到application.
				 * properties配置的tempFileDirectory目录，然后再从这个目录上传到ftp的目录（ftp.dir)
				 * 
				 */
				String fileUploadDir = Application.getInstance().getUploadFileDirectory();

				// 判断是否配置了ftp，如果配置了ftp，则使用ftp上传
				String ip = Application.getInstance().getByKey("ftp.ip");
				String user = Application.getInstance().getByKey("ftp.user");
				String pwd = Application.getInstance().getByKey("ftp.password");

				// // 默认在根目录下加一个企业id文件夹
				// fileUploadDir += "/" + super.getCurrentEnterpriseId();
				// // 如果指定上传子目录则把文件存放到子目录当中
				// if(!StringUtils.isNullOrBlank(type)) {
				// fileUploadDir += "/" + type;
				// }

				DiskFileItemFactory factory = new DiskFileItemFactory();
				FileUtils.createDir(fileUploadDir);
				factory.setRepository(new File(fileUploadDir));
				ServletFileUpload upload = new ServletFileUpload(factory);

				List<FileItem> items = upload.parseRequest(request);
				Iterator<FileItem> iter = items.iterator();
				while (iter.hasNext()) {
					FileItem item = iter.next();
					if (item.isFormField()) {
						// processFormField
					} else {
						// 避免文件较多，随机名字重复，停留一毫秒
						// / Thread.sleep(1L);
						String fileName = item.getName();

						int i2 = fileName.lastIndexOf("\\");
						if (i2 > -1) {
							fileName = fileName.substring(i2 + 1);
						}
						String oldName = fileName;
						// 把文件名重命名，避免文件多了导致重复文件
						String[] fileNames = fileName.split("\\.");
						String extName = null;
						if (fileNames.length > 1) {
							// 得到扩展名
							extName = fileNames[fileNames.length - 1];
							fileName = UUID.randomUUID().toString() + "." + extName; // System.currentTimeMillis()
						} else {
							fileName = UUID.randomUUID().toString() + "";
						}
						//判断是否为非法文件
						if(isIllegalFile(extName)){
							throw new RuntimeException("Illegal file upload!");
						}
						File dirs = new File(fileUploadDir);
						FileUtils.createDir(fileUploadDir);

						File uploadedFile = new File(dirs, fileName);
						item.write(uploadedFile);
						// 如果配置了ftp，则把文件从tempUploadedFile本地上传到ftp
						if (StringUtils.isNotEmpty(ip)) {
							log.info("开始ftp上传，ip = " + ip + ";user = " + user + ";pwd = " + pwd);
							FTPClient client = FtpUtils.loginFtp(ip, user, pwd);
							boolean result = FtpUtils.upLoadFile(client, uploadedFile, null);
							log.info("ftp上传结果：" + result);
						}

						// 返回对象
						vo = new FileUploadVO();
						vo.setPath(fileUploadDir);
						vo.setOldName(oldName);
						vo.setNewName(fileName);
						vo.setExtName(extName);
						vo.setSize(item.getSize());

						// 上传人，上传时间
						vo.setUploadTime(new Date());
						vo.setUploadUserName("admin");

						// add to list
						return vo;
					}
				}
			}
			return vo;
		} catch (Exception ex) {
			log.error("上传文件异常：", ex);
			throw new RuntimeException("上传文件异常：", ex);
		}
	}

	/**
	 * 上传文件到ftp
	 * 
	 * @param request
	 * @param response
	 * @param uploadUrl
	 *            文件目录（必填）
	 * @param _callback
	 *            回调函数
	 * @throws Exception
	 */
	@ValidateSession(validate = false)
	@RequestMapping(value = "/uploadFtp", method = { RequestMethod.POST })
	public void uploadFtp(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(value = "uploadUrl", required = false) String uploadUrl,
			@RequestParam(value = "_callback", required = false) String _callback) throws Exception {
		try {
			boolean isMultipart = ServletFileUpload.isMultipartContent(request);
			if (!isMultipart) {
				throw new FrameworkRuntimeException("file upload must be form submit.");
			} else {
				/**
				 * 
				 * 1、如果没有配置ftp，则以application.properties配置的uploadFiles目录为准，上传到此目录
				 * 2、如果配置了ftp，则把文件先上传到application.
				 * properties配置的tempFileDirectory目录，然后再从这个目录上传到ftp的目录（ftp.dir)
				 * 
				 */
				String tempFileUploadDir = Application.getInstance().getTempFileDirectory();

				// 判断是否配置了ftp，如果配置了ftp，则使用ftp上传
				String ip = Application.getInstance().getByKey("ftp.ip");
				String user = Application.getInstance().getByKey("ftp.user");
				String pwd = Application.getInstance().getByKey("ftp.password");

				DiskFileItemFactory factory = new DiskFileItemFactory();
				FileUtils.createDir(tempFileUploadDir);
				factory.setRepository(new File(tempFileUploadDir));
				ServletFileUpload upload = new ServletFileUpload(factory);

				List<FileItem> items = upload.parseRequest(request);
				Iterator<FileItem> iter = items.iterator();
				while (iter.hasNext()) {
					FileItem item = iter.next();
					if (item.isFormField()) {
						// processFormField
					} else {
						String fileName = item.getName();

						int i2 = fileName.lastIndexOf("\\");
						if (i2 > -1) {
							fileName = fileName.substring(i2 + 1);
						}
						// 把文件名重命名，避免文件多了导致重复文件
						String[] fileNames = fileName.split("\\.");
						String extName = null;
						if (fileNames.length > 1) {
							// 得到扩展名
							extName = fileNames[fileNames.length - 1];
							fileName = UUID.randomUUID().toString() + "." + extName;
						} else {
							fileName = UUID.randomUUID().toString() + "";
						}
						
						//判断是否为非法文件
						if(isIllegalFile(extName)){
							throw new RuntimeException("Illegal file upload!");
						}
						File dirs = new File(tempFileUploadDir);
						FileUtils.createDir(tempFileUploadDir);

						File uploadedFile = new File(dirs, fileName);
						item.write(uploadedFile);
						// 如果配置了ftp，则把文件从tempUploadedFile本地上传到ftp
						if (StringUtils.isNotEmpty(ip)) {
							log.info("开始ftp上传，ip = " + ip + ";user = " + user + ";pwd = " + pwd);
							FTPClient client = FtpUtils.loginFtp(ip, user, pwd);
							// 与服务器的pasv_promiscuous=YES参数有关，设置为YES，此处需要设置为false才能访问
							client.setRemoteVerificationEnabled(false);
							boolean result = FtpUtils.upLoadFile(client, uploadedFile, uploadUrl);
							log.info("ftp上传结果：" + result);
						}
						String ftpUrl = Application.getInstance().getByKey("ftp.url");
						if (ftpUrl.endsWith("/")) {
							ftpUrl = ftpUrl + (uploadUrl.startsWith("/") ? uploadUrl.substring(1, uploadUrl.length())
									: uploadUrl);
						} else {
							ftpUrl = ftpUrl + (uploadUrl.startsWith("/") ? uploadUrl : ("/" + uploadUrl));
						}
						if (ftpUrl.endsWith("/")) {
							ftpUrl = ftpUrl + uploadedFile.getName();
						} else {
							ftpUrl = ftpUrl + "/" + uploadedFile.getName();
						}
						log.info("图片上传的ftpurl=" + ftpUrl);
						AttachmentVo attachment = new AttachmentVo();
						attachment.setOldName(item.getName());
						attachment.setNewName(fileName);
						attachment.setExtName(extName);
						attachment.setUrl(ftpUrl);
						attachment.setFileSize(item.getSize());
						response.getWriter().write("<script>parent." + _callback + "('" + JsonUtils.fromObject(attachment) + "');</script>");
					}
				}
			}
		} catch (Exception ex) {
			log.error("上传文件异常：", ex);
			throw new RuntimeException("上传文件异常：", ex);
		}
	}

	/**
	 * 
	 * 移除文件
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/remove", method = { RequestMethod.POST })
	@ResponseBody
	public Object remove(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
			String filePath = super.getParameterNotNull("filePath");// 文件绝对路径，带文件名
			File file = new File(filePath);
			file.deleteOnExit();
			return true;
		} catch (Exception ex) {
			log.error("移除文件异常：", ex);
			throw new RuntimeException("移除文件异常：", ex);
		}
	}

	/**
	 * 新增附件信息
	 * 
	 * @param request
	 * @param attachment
	 *            提交的附件数据
	 * @return
	 */
	@RequestMapping(value = "/addAttachment")
	@ResponseBody
	public ControllerResponse addAttachment(AttachmentVo parameters) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		// (1)判断是否有数据
		if (parameters == null) {
			response.setInfo("参数错误");
			super.log.error("新增附件对象不能为空！");
			return response;
		}
		// (2)新增
		ControllerUtils.setWho(parameters);// 设置时间、操作人
		parameters.setEnable(1);// 设置有效字段（0：否，1：是）
		Object result = null;
		Map<String, Object> map = new HashMap<String, Object>();
		// (3)调用服务，进行数据保存
		map.put("paramter", parameters);
		map.put("sign", "insertAttachmentInfo");// 所调用的服务中的方法
		result = TradeInvokeUtils.invoke("AttachmentManagement", map);
		response.setResponseType(ResponseType.SUCCESS_SAVE);
		// (4)对调用服务后的返回数据进行解析
		if (result != null) {
			Map<String, Object> jsonMap = JsonUtils.toMap(result);
			JSONObject sys = (JSONObject) jsonMap.get("sys");
			if (sys != null) {
				String status = sys.getString("status");// 状态：'S'成功，'F'失败
				String erortx = sys.getString("erortx");// 错误信息
				if ("S".equals(status)) {// 交易成功
					response.setObject(result);// 设置返回结果
					response.setInfo(erortx);// 设置返回的信息
					super.log.info("新增insertAttachmentInfo服务调用信息：" + erortx);
				} else {
					response.setResponseType(ResponseType.ERROR);
					response.setInfo(erortx);
					super.log.error("新增insertAttachmentInfo服务调用信息：" + erortx);
				}
			}
		} else {
			response.setResponseType(ResponseType.ERROR);
			response.setInfo("调用服务失败！");
			super.log.error("调用服务失败！");
		}
		return response;
	}
	
	/**
	 * 根据条件查询附件信息
	 * @param request
	 * @param parameters 附件查询条件
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/queryAttchmentByCondition")
	@ResponseBody
	public List<AttachmentVo> queryAttchmentByCondition(AttachmentVo parameters){
		parameters.setEnable(1);//（0：否，1：是）
		//调用服务，进行数据查询	
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", parameters);
		map.put("page", new PageVo());
		map.put("sign", "queryAttchmentByCondition");//所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("AttachmentManagement", map);				
		JSONObject output = (JSONObject) result.getOutput();	
		List<AttachmentVo> attachmentList = null;
		if(result.getSys()!=null){
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();//错误信息
			if("S".equals(status)){//交易成功	
				String resultJson = output.getString("result");
				attachmentList=JsonUtils.toList(resultJson,AttachmentVo.class);
				super.log.info("根据条件查询企业调用queryAttchmentByCondition服务返回成功，信息："+erortx);
			}else{
				super.log.error("根据条件查询企业调用queryAttchmentByCondition服务返回失败，信息："+erortx);
				return null;
			}
		}
		return attachmentList;
	}
	
	/**
	 * 批量更新附件信息
	 * 
	 * @param request
	 * @param parameters
	 *            附件对象
	 * @return
	 */
	@RequestMapping(value = "/updateAttachmentByCondition")
	@ResponseBody
	public ControllerResponse updateAttachmentByCondition(AttachmentVo parameters) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		// (1)判断必要参数
		if (!(parameters != null)) {
			super.log.error("附件对象不能为空！");
			response.setInfo("参数错误");
			return response;
		}
		// (2)调用服务，进行数据更新
		Map<String, Object> map = new HashMap<String, Object>();
		parameters.setEnable(1);
		ControllerUtils.setWho(parameters);// 设置时间、操作人
		map.put("paramter", parameters);
		map.put("sign", "updateAttachmentByCondition");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("AttachmentManagement", map);
		// (3)对调用服务后的返回数据进行解析
		if (result != null) {
			if (result.getSys() != null) {
				String estatus = result.getSys().getStatus();// 状态：'S'成功，'F'失败
				String erortx = result.getSys().getErortx();// 错误信息
				if ("S".equals(estatus)) {// 交易成功
					response.setInfo("附件信息更新成功！");
					response.setResponseType(ResponseType.SUCCESS_UPDATE);
					super.log.info("附件信息更新,调用updateAttachmentByCondition服务，信息：" + erortx);
				} else {
					response.setInfo("附件信息更新失败！");
					super.log.error("附件信息更新,调用updateAttachmentByCondition服务，信息：" + erortx);
				}
			}
		} else {
			response.setInfo("调用服务失败！");
			super.log.error("调用服务失败！");
		}
		return response;
	}
	
	
	/**
     * 文件下载
     * 
     * @param workingDir   ftp根目录
     * @param newName	     附件表new_name字段
     * @param oldName      附件表old_name字段
     * @param response
     */
    @RequestMapping({"/fileDownload"})
	public void fileDownload(String workingDir, String newName, String oldName, HttpServletResponse response) {
    	try {
	    	Application app = Application.getInstance();
	    	//获取ftp ip/账号/密码
	    	String ftpUrl = app.getByKey("ftp.ip");
	    	String ftpUserName = app.getByKey("ftp.user");
	    	String ftpPwd = app.getByKey("ftp.password");
	    	//登录ftp
	    	FTPClient client = FtpUtils.loginFtp(ftpUrl, ftpUserName, ftpPwd);
	    	//ftp目录
	    	client.changeWorkingDirectory(workingDir);
	    	client.setRemoteVerificationEnabled(false);
	    	boolean bool = FtpUtils.downOneFile(client, app.getTempFileDirectory(), newName);
	    	log.info("ftp下载文件结果：" + bool);
	    	//火狐浏览器会乱码
	    	String agent=getRequest().getHeader("User-Agent").toLowerCase();
			boolean isFirefox = (agent.indexOf("firefox") > -1);		
			ResponseDownloadUtils.download(response, new File(app.getTempFileDirectory(), newName), new String(oldName.getBytes("iso-8859-1"),"utf-8"),isFirefox);
    	} catch(Exception e) {
    		log.error("下载异常：", e);
    	}
	}
    
    /**
     * 是否非法文件
     * @param extName 上传文件的扩展名
     * @return true 是；false 否
     */
    private boolean isIllegalFile(String extName){
    	boolean isIllegal = false;
    	if(extName!=null){
    		extName = extName.toLowerCase();
    		isIllegal =Arrays.asList(ILLAEAL_SUFFIX).contains(extName);
    	}
    	return isIllegal;
    }
}