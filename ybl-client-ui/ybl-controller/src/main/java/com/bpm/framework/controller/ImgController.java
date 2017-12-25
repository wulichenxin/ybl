package com.bpm.framework.controller;


import java.io.File;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.net.ftp.FTPClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bpm.framework.annotation.ValidateSession;
import com.bpm.framework.console.Application;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.utils.FtpUtils;
import com.bpm.framework.utils.file.ResponseDownloadUtils;

/**
 * @author paigu
 * 从ftp读取
 */
@Controller
@RequestMapping(value = "/imgController")
public class ImgController extends AbstractController {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 2042899479230692931L;
	
	private static final Logger log = LoggerFactory.getLogger(ImgController.class);
	/**
	 * @return
	 */
	@ValidateSession(validate=false)
	@RequestMapping(value = "/loadFtpImg", method = { RequestMethod.GET, RequestMethod.POST })
	public  void loadFtpImg(HttpServletResponse response,String imgName) {
		try {
			String fileName=imgName.substring(imgName.lastIndexOf("/")+1);
			//从本地读取文件
			String locaPath=Application.getInstance().getUploadFileDirectory();
			if(!locaPath.endsWith("/")){
				locaPath+="/";
			}
			File file = new File(locaPath+fileName);
			
			//不存在则从ftp取
			if(!file.exists()){
				//设置ftp目录
				String workingDirectory=imgName.substring(0,imgName.lastIndexOf("/")+1);
				if(workingDirectory.startsWith("/")){
					workingDirectory=workingDirectory.substring(1, workingDirectory.length());
				}
				log.info("开始ftp下载  ftp目录:" +workingDirectory+"文件名:"+ imgName);
				String ftpIp=Application.getInstance().getByKey("ftp.ip");
				String ftpUser=Application.getInstance().getByKey("ftp.user");
				String ftpPwd=Application.getInstance().getByKey("ftp.password");
				
				FTPClient client = FtpUtils.loginFtp(ftpIp,ftpUser, ftpPwd);
				client.setFileType(FTPClient.BINARY_FILE_TYPE);
				client.changeWorkingDirectory(workingDirectory);
				
				String locaTempPath=Application.getInstance().getUploadFileDirectory();
				if(locaTempPath.endsWith("/")){
					locaTempPath+="/";
				}
				
				boolean result = FtpUtils.downOneFile(client, locaTempPath, fileName);
				log.info("下载结果 " + result);
				
				file = new File(locaTempPath+fileName);
			}
			
  			ResponseDownloadUtils.showImg(response, file);
		} catch (Exception e) {
			e.printStackTrace();
		}  
	} 
}





