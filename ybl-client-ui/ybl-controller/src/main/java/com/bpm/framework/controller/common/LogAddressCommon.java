package com.bpm.framework.controller.common;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.InetAddress;
import java.net.MalformedURLException;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.constant.UserAgent;

/**
 * 公共的静态方法
 * @author jzx
 *
 */
public class LogAddressCommon {
	/**
	 * 获取登录ip
	 * @return
	 */
	public static final String getAddress() {
		String address = "未知";
		try {
			final String key = "58653768a80b7ed13e8086a4f32fa46d";
			final String ip = InetAddress.getLocalHost().getHostAddress();
	        URL url = null;
	        try {
	            url = new URL("http://api.map.baidu.com/location/ip?ak=" + key
	                    + "&ip=" + ip);
	        } catch (MalformedURLException e) {
	            return address;
	        }
	
	        InputStreamReader isr = null;
	        try {
	            isr = new InputStreamReader(url.openStream());
	        } catch (IOException e) {
	            return address;
	        }
	
	        StringBuffer sb = new StringBuffer();
	
	        BufferedReader br = new BufferedReader(isr);
	        String str;
	        try {
	            while ((str = br.readLine()) != null) {
	                sb.append(str.trim());
	            }
	        } catch (IOException e) {
	            return address;
	        } finally {
	            try {
	                br.close();
	                isr.close();
	            } catch (IOException e) {
	            }
	        }
	
	        if (sb != null && sb.length() > 10) {
	            JSONObject json = JSONObject.parseObject(sb.toString());
	            if ("0".equals(json.get("status").toString())) {
	                json = json.getJSONObject("content");
	                json = json.getJSONObject("address_detail");
	                address = json.getString("city");
	                if (address != null && !"".equals(address)
	                        && address.length() > 1) {
	                    address = address.substring(0, address.length() - 1);
	                }
	            }
	        }
	
	        return address;
		} catch(Exception e) {}
		return address;
	}
	
	/**
     * 真.判断移动端访问
     * @param request
     * @return
     */
    public static boolean isRealMobile(HttpServletRequest request) {
		UserAgent userAgent = UserAgent.parseUserAgentString(request.getHeader("User-Agent"));
		if(userAgent.getOperatingSystem().isMobileDevice()) {
			return true;
		}
		return false;
	}
	
	
}
