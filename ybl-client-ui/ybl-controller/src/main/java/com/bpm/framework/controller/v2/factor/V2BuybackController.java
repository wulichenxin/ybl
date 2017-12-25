package com.bpm.framework.controller.v2.factor;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.annotation.Log;
import com.bpm.framework.annotation.OperationType;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.utils.i18n.I18NUtils;

import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v2.V2BuybackLineRecordVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 
 * 回购控制器
 *
 */
@Controller
@RequestMapping({"/v2buybackController"})
public class V2BuybackController extends AbstractController{

	private static final long serialVersionUID = -3638148272520531721L;
	
	/**
	 * 核心企业单笔还款
	 * 结算完成后，回到待付款批次界面
	 * 
	 */
	@RequestMapping({"/saveBuyback"})
	@ResponseBody
	@Log(operation=OperationType.Exe,info="核心企业单笔还款")
	public ControllerResponse saveBuyback(V2BuybackLineRecordVo buybackLineRecordVo){
		ControllerResponse response = new ControllerResponse(ResponseType.FAILURE);
		
		Map<String, Object> input = new HashMap<String, Object>();
		
		UserVo curUser = ControllerUtils.getCurrentUser( );
		buybackLineRecordVo.setEnterpriseId(curUser.getEnterpriseId()); //设置企业id
		
		ControllerUtils.setWho(buybackLineRecordVo);

		input.put("paramter", buybackLineRecordVo);
		
		input.put("sign", "saveBuyback");
		
		ResBody resBody = TradeInvokeUtils.invoke("V2BuybackManagement", input);
		// 调用服务
		if (super.isSuccess(resBody)) {
			JSONObject output = (JSONObject) resBody.getOutput();
			String records = output.getString("result");
			if (Boolean.parseBoolean(records)) {
				response.setInfo(I18NUtils.getText("sys.v2.client.operationSuccess"));
				response.setResponseType(ResponseType.SUCCESS);
			}
		}
		return response;
	}
}