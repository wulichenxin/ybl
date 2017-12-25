package cn.sunline.ybl.sys.util.trade;

import java.io.Serializable;

/**
 * @author guotai guotai@sunline.cn
 * @date 2017年3月23日
 * @version 1.0.0
 * @Description 封装请求报文体
 */
public class ReqBody implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6776088324105953534L;

	private Sys sys;
	
	private Object input;

	public Sys getSys() {
		return sys;
	}

	public void setSys(Sys sys) {
		this.sys = sys;
	}

	public Object getInput() {
		return input;
	}

	public void setInput(Object input) {
		this.input = input;
	}
	
class Sys {
	
	private String prcscd;
	
	public Sys() {}
	
	public Sys(String prcscd) {
		this.prcscd = prcscd;
	}

	public String getPrcscd() {
		return prcscd;
	}

	public void setPrcscd(String prcscd) {
		this.prcscd = prcscd;
	}
}
}
