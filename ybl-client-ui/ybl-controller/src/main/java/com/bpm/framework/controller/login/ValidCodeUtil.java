package com.bpm.framework.controller.login;

import java.util.HashMap;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.constant.Constant;
import com.bpm.framework.controller.ControllerUtils;

import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * @author guotai guotai@sunline.cn
 * @date 2017年5月16日
 * @version 1.0.0
 * @Description
 */
public class ValidCodeUtil {

	/**
	 * 短信邮箱验证码校验
	 * target ： 手机号或邮箱
	 * code : 验证码
	 * @return "S"：校验成功，其他字符串为失败
	 * @throws
	 */
	public static String checkedValidCode(String target, String code){
		Map<String,Object> paramter = new HashMap<String,Object>();
		paramter.put("target_", target);
		paramter.put("code_", code);
		UserVo user = ControllerUtils.getCurrentUser();
		if(null != user) {
			paramter.put("member_id", user.getId());
		}
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", paramter);
		map.put("page", new PageVo<>());
		map.put("sign", "checkValidCode");	
		ResBody result = TradeInvokeUtils.invoke("ValidCodeManagement", map);
		String ret = "";
 		if(result.getSys()!=null){
			String status = result.getSys().getStatus();
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) result.getOutput();
				ret = output.getString("result");
			} else {
				ret = result.getSys().getErortx();
			}
		}
 		return ret;
	}
}
