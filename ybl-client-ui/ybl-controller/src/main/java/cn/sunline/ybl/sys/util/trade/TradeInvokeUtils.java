package cn.sunline.ybl.sys.util.trade;

import java.io.Serializable;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.bpm.framework.console.Application;
import com.bpm.framework.utils.Assert;
import com.bpm.framework.utils.HttpRequest;
import com.bpm.framework.utils.json.JsonUtils;

/**
 * @author guotai guotai@sunline.cn
 * @date 2017年3月23日
 * @version 1.0.0
 */
public class TradeInvokeUtils implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6517469711908812271L;
	
	private static final Logger log = LoggerFactory.getLogger(TradeInvokeUtils.class);
	
	/**
	 * 
	 * 交易调用
	 * 
	 * prcscd 交易代码
	 * req  业务参数，必须是非基本类型对象
	 * 
	 * @param
	 * @return
	 * @throws
	 */
	public static ResBody invoke(String prcscd, Object req) {
		Assert.hasLength(prcscd, "prcscd must be not null.");
		final ReqBody body = new ReqBody();
		body.setSys(body.new Sys(prcscd));
		body.setInput(req);
		String serverUrl = Application.getInstance().getByKey("trade.server.url");
		String bodyJson = JsonUtils.fromObject(body);
		log.info("request body = " + bodyJson);
		ResBody result = null;
//		String result = null;
		if(serverUrl.toUpperCase().startsWith("HTTPS")) {
			result = JsonUtils.toObject(HttpRequest.sendHttpsPOST(serverUrl, bodyJson), ResBody.class);
		} else {
			result = JsonUtils.toObject(HttpRequest.sendPost(serverUrl, bodyJson),ResBody.class);
		}
		log.info("response body = " + JsonUtils.fromObject(result));
		return result;
	}
}
