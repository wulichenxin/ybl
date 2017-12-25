package cn.sunline.ybl.sys.util.trade;

import java.io.Serializable;

/**
 * @author guotai guotai@sunline.cn
 * @date 2017年3月28日
 * @version 1.0.0
 * @Description 封装响应报文体
 */
public class ResBody implements Serializable {

	private static final long serialVersionUID = 1997429245608022314L;
	
	private Sys sys;
	
	private Object output;
	
	public Sys getSys() {
		return sys;
	}

	public void setSys(Sys sys) {
		this.sys = sys;
	}

	public Object getOutput() {
		return output;
	}

	public void setOutput(Object output) {
		this.output = output;
	}

	@Override
	public String toString() {
		return "ResBody [sys=" + sys + ", output=" + output + "]";
	}
	
	

}
