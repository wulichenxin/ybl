package com.bpm.framework.controller.fileupload;

import java.io.Serializable;
import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

public class FileUploadVO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5710872940038400201L;
	
	private Long id;

	private String path;// 文件存在服务器中的目录
	
	private String oldName;// 文件原始名称
	
	private String newName;// 文件存在服务器上的名称
	
	private String extName;// 文件扩展名
	
	private long size;// 文件大小 KB
	
	private String uploadUserName;
	
	@JSONField(format="yyyy-MM-dd HH:mm:ss")
	private Date uploadTime;
	
	public FileUploadVO() {}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getOldName() {
		return oldName;
	}

	public void setOldName(String oldName) {
		this.oldName = oldName;
	}

	public String getNewName() {
		return newName;
	}

	public void setNewName(String newName) {
		this.newName = newName;
	}

	public String getExtName() {
		return extName;
	}

	public void setExtName(String extName) {
		this.extName = extName;
	}

	public long getSize() {
		return size;
	}

	public void setSize(long size) {
		this.size = size;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getUploadUserName() {
		return uploadUserName;
	}

	public void setUploadUserName(String uploadUserName) {
		this.uploadUserName = uploadUserName;
	}

	@JSONField(format = "yyyy-MM-dd HH:mm:ss")
	public Date getUploadTime() {
		return uploadTime;
	}

	public void setUploadTime(Date uploadTime) {
		this.uploadTime = uploadTime;
	}


	
}
