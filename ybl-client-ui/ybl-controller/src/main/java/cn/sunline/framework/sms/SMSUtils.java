package cn.sunline.framework.sms;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.io.Serializable;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLDecoder;
import java.net.URLEncoder;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public final class SMSUtils implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4784997818299854978L;
	
	private static final Logger log = LoggerFactory.getLogger(SMSUtils.class);
	
	public static final boolean sendSms(String mobiles, String content) {
		try{
			String smsSvcUrl = SmsPropCache.getInstance().getByKey("sms.url");
			String cust_code = SmsPropCache.getInstance().getByKey("sms.cust_code");
			String password = SmsPropCache.getInstance().getByKey("sms.password");
			String sp_code = SmsPropCache.getInstance().getByKey("sms.sp_code");
			String urlencContent = URLEncoder.encode(content,"utf-8");
	        String sign=MD5.sign(urlencContent, password, "utf-8");
			String postData = "content=" + urlencContent + "&destMobiles="+ mobiles + "&sign=" + sign + "&cust_code=" + cust_code+ "&sp_code=" + sp_code + "&task_id=" + System.currentTimeMillis();
			log.info("短信请求参数：" + postData);
			URL myurl = new URL(smsSvcUrl);
			URLConnection urlc = myurl.openConnection();
			urlc.setReadTimeout(1000 * 30);
			urlc.setDoOutput(true);
			urlc.setDoInput(true);
			urlc.setAllowUserInteraction(false);

			DataOutputStream server = new DataOutputStream(urlc.getOutputStream());

			server.write(postData.getBytes("utf-8"));
			server.close();

			BufferedReader in = new BufferedReader(new InputStreamReader(urlc.getInputStream(), "utf-8"));
			String resXml = "", s = "";
			while ((s = in.readLine()) != null){
				resXml = resXml + s + "\r\n";
			}
			in.close();
			String restext = URLDecoder.decode(resXml,"utf-8");
			log.info("响应参数：" + restext);
			return (null != restext && restext.contains("SUCCESS"));
		}catch(Exception ex){
			log.error("短信发送异常(sendSms0)：", ex);
			return false;
		}
	}
	
	public static void main(String[] args) {
		boolean bool = SMSUtils.sendSms("17727838020", "测试短信");
		System.out.println(bool);
	}
}
