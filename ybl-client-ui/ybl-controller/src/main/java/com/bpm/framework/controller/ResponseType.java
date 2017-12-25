package com.bpm.framework.controller;

import com.bpm.framework.utils.i18n.I18NUtils;

public enum ResponseType {

	SUCCESS, INFO, INFOTEXT, FAILURE, WARNING, ERROR, CONFIRM, SUCCESS_DELETE, SUCCESS_UPDATE, SUCCESS_SAVE, NO_MSG;

	public String getCode() {
		switch (this) {
		case SUCCESS:
			return "success";
		case SUCCESS_DELETE:
			return "success";
		case SUCCESS_UPDATE:
			return "success";
		case SUCCESS_SAVE:
			return "success";
		case INFO:
			return "info";
		case INFOTEXT:
			return "infotext";
		case FAILURE:
			return "failure";
		case WARNING:
			return "warning";
		case CONFIRM:
			return "confirm";
		case NO_MSG:
			return "nomsg";
		case ERROR:
			return "error";
		}
		return null;
	}

	public String getInfo() {
		switch (this) {
		case SUCCESS:
			return I18NUtils.getText("fw.common.response.operationSuccess", "操作成功。");
		case SUCCESS_DELETE:
			return I18NUtils.getText("fw.common.response.deleteSuccess", "数据删除成功。");
		case SUCCESS_UPDATE:
			return I18NUtils.getText("fw.common.response.updateSuccess", "数据更新成功。");
		case SUCCESS_SAVE:
			return I18NUtils.getText("fw.common.response.saveSuccess", "数据保存成功。");
		case ERROR:
			return I18NUtils.getText("fw.common.response.operationFail", "操作失败。");
		case FAILURE:
			return I18NUtils.getText("fw.common.response.operationFail", "操作失败。");
		default:
			return I18NUtils.getText("fw.common.response.operationSuccess", "操作成功。");
		}
	}
}
