package cn.sunline.framework.controller.vo.common;

import java.io.Serializable;

public interface Entity extends Serializable {

	public Long getId();
	
	public void setId(Long id);
	
	public int getEnable();
	
	public void setEnable(int enable);
}
