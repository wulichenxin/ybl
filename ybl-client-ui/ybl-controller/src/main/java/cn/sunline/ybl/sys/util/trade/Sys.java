package cn.sunline.ybl.sys.util.trade;

import com.bpm.framework.utils.StringUtils;

/**
 * @author guotai guotai@sunline.cn
 * @date 2017年3月28日
 * @version 1.0.0
 * @Description
 */
public class Sys {
	
	/**
	 * 调用服务返回的流水号
	 */
	private String pckgsq;
	
	/**
	 * 服务调用描述信息
	 */
	private String erortx;
	
	/**
	 * 服务调用返回码
	 */
	private String erorcd;
	
	/**
	 * 服务调用返回状态 S-成功，F-失败
	 */
	private String status;
	/**
	 * @return the pckgsq
	 */
	public String getPckgsq() {
		return pckgsq;
	}
	/**
	 * @param pckgsq the pckgsq to set
	 */
	public void setPckgsq(String pckgsq) {
		this.pckgsq = pckgsq;
	}
	/**
	 * @return the erortx
	 */
	public String getErortx() {
		return erortx;
	}
	
	//  客户不需要展示[ApErr.E00010]
	public String getErorMsg() {
		if(StringUtils.isNotEmpty(erortx)){
			int start = erortx.indexOf("]");
			return erortx.substring(start+1, erortx.length());
		}
		return erortx;
	}
	
	/**
	 * @param erortx the erortx to set
	 */
	public void setErortx(String erortx) {
		this.erortx = erortx;
	}
	/**
	 * @return the erorcd
	 */
	public String getErorcd() {
		return erorcd;
	}
	/**
	 * @param erorcd the erorcd to set
	 */
	public void setErorcd(String erorcd) {
		this.erorcd = erorcd;
	}
	/**
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}
	/**
	 * @param status the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
	}
	@Override
	public String toString() {
		return "Sys [pckgsq=" + pckgsq + ", erortx=" + erortx + ", erorcd=" + erorcd + ", status=" + status + "]";
	}
	
}
