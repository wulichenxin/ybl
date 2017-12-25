package com.bpm.framework.controller.accountCenter;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.sunline.framework.controller.vo.BankAccountVo;
import cn.sunline.framework.controller.vo.BankVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.constant.Constant;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.controller.login.ValidCodeUtil;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.json.JsonUtils;

@Controller
@RequestMapping({"/bankAccount"})
public class BankAccountController extends AbstractController{

	private static final long serialVersionUID = 1L;
	
	/**
	 * 添加银行卡信息页面
	 * @return
	 */
	@RequestMapping(value = "/bindBankCard")
	public String bindBankCard(HttpServletRequest request){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", "");
		map.put("page", new PageVo());
		map.put("sign", "selectAllBank");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("BankAccountsManagement", map);
		JSONObject output = (JSONObject) result.getOutput();
		List<BankVo> bankList = null;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				String resultJson = output.getString("result");
				bankList = JsonUtils.toList(resultJson, BankVo.class);
				request.setAttribute("bankList", bankList);
				super.log.info("根据条件查询用户调用queryMemberByCondition服务返回成功，信息：" + erortx);
			} else {
				super.log.error("根据条件查询用户调用queryMemberByCondition服务返回失败，信息：" + erortx);
			}
		}
		return "ybl/admin/bank/bindBankCard";
	}
	
	/**
	 * 新增银行卡信息
	 * @param bankAccount 银行卡信息
	 * @return
	 */
	@RequestMapping(value = "/bindBankCardSave")
	@ResponseBody
	public String bindBankCardSave(BankAccountVo bankAccount, String smsCode,String bankPhone){
		String retStr = "F";
		if(StringUtils.isEmpty(bankPhone) ){
			super.log.info("手机号不能为空");
		}
		if(StringUtils.isEmpty(smsCode) ){
			super.log.info("验证码不能为空");
		}
		String ret = ValidCodeUtil.checkedValidCode(bankPhone, smsCode);
		//校验用户名，短信是否发送频繁，成功发送短信，保存验证码信息
 		if("S".equals(ret)) {
 			super.log.info("验证成功");
 		} else {
 			super.log.info("验证失败");
 			return "短信验证码不正确";
 		}
		
		ControllerUtils.setWho(bankAccount);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", bankAccount);
		map.put("page", new PageVo());
		map.put("sign", "insertBankAccountInfo");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("BankAccountsManagement", map);
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				retStr = "S";
				super.log.info("根据条件查询用户调用queryMemberByCondition服务返回成功，信息：" + erortx);
			} else {
				super.log.error("根据条件查询用户调用queryMemberByCondition服务返回失败，信息：" + erortx);
			}
		}
		return retStr;
	}
	
	/**
	 * 解绑银行卡信息
	 * @return
	 */
	@RequestMapping(value = "/unbindBankCard")
	@ResponseBody
	public String unbindBankCard(Long bankId){
		String retStr = "F";
		Map<String, Object> paramter = new HashMap<String, Object>();
		paramter.put("id_", bankId);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", paramter);
		map.put("page", new PageVo());
		map.put("sign", "deleteBankAccountInfoById");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("BankAccountsManagement", map);
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				retStr = "S";
				super.log.info("根据条件查询用户调用queryMemberByCondition服务返回成功，信息：" + erortx);
			} else {
				super.log.error("根据条件查询用户调用queryMemberByCondition服务返回失败，信息：" + erortx);
			}
		}
		return retStr;
	}
}
