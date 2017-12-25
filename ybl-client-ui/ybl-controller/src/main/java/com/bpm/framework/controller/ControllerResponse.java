package com.bpm.framework.controller;

import java.io.Serializable;

import com.bpm.framework.utils.StringUtils;

public class ControllerResponse implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6912967753279809522L;
	
	private String info;
	private Object object;

	private ResponseType responseType;
	private String responseTypeCode = ResponseType.SUCCESS.getCode();

	public ControllerResponse(ResponseType responseType) {
		this(responseType, responseType.getInfo());
	}

	public ControllerResponse(ResponseType responseType, String info) {
		this.responseType = responseType;
		this.responseTypeCode = responseType.getCode();
		this.info = info;
	}

	public void setResponseType(ResponseType responseType) {
		this.responseType = responseType;
		this.responseTypeCode = responseType.getCode();
		//信息可以根据不同场景进行提醒,如果没有设置，则使用默认信息
		if(StringUtils.isNullOrBlank(this.info)){
			this.info = responseType.getInfo();
		}
		
	}
	
	public void setResponseType(ResponseType responseType, String info) {
		this.responseType = responseType;
		this.responseTypeCode = responseType.getCode();
		this.info = info;
	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}

	public Object getObject() {
		return object;
	}

	public void setObject(Object object) {
		this.object = object;
	}

	public String getResponseTypeCode() {
		return responseTypeCode;
	}

	public ResponseType getResponseType() {
		return responseType;
	}

	public boolean isSuccess() {
		if ((ResponseType.SUCCESS.getCode()).equals(this.getResponseType().getCode())) {
			return true;
		} else {
			return false;
		}
	}
}
