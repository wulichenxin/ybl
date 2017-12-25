package com.bpm.framework.controller.v2.systemSetting;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.i18n.I18NUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v2.UserLoginLogVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 登陆日志管理控制器
 * @author jzx
 *
 */
@Controller
@RequestMapping({ "/v2LogController" })
public class V2LogController extends AbstractController {

	private static final long serialVersionUID = 4459806969565723687L;

	/**
	 * 日志管理列表，并加载数据
	 * 
	 * @return
	 */
	@RequestMapping("/queryUserLoginLog.htm")
	public String queryUserLoginLog(PageVo<?> pageVo,String userName) {
		queryLogList(pageVo,userName);
		getRequest().setAttribute("userName", userName);
		return "ybl/v2/admin/systemSetting/logManage";
	}
	/**
	 * 日志管理列表，并加载数据
	 * 
	 * @return
	 */
	@RequestMapping("/queryUserLoginLogContext.htm")
	public String queryUserLoginLogContext(PageVo<?> pageVo,String context) {
		getRequest().setAttribute("context", context);
		return "ybl/v2/admin/systemSetting/context";
	}
	/**
	 * 根据条件查询登录日志信息
	 * 
	 * @param pageVo
	 *            分页参数
	 * @param map
	 *            查询参数
	 */
	private void queryLogList(PageVo<?> pageVo,String userName) {
		UserLoginLogVo logVo = new UserLoginLogVo();
		logVo.setUserName(userName);
		UserVo user=ControllerUtils.getCurrentUser();
		logVo.setEnterpriseId(user.getEnterpriseId());
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("paramter", logVo);
		maps.put("page", pageVo);
		maps.put("sign", "queryUserOperatorLog");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("V2UserOperatorLog", maps);
		isSuccess(result);
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage = output.getString("page");
				String records = output.getString("result");
				pageVo = (PageVo<?>) JSONObject.parseObject(jsonPage, PageVo.class);
				List<UserLoginLogVo> list = JsonUtils.toList(records, UserLoginLogVo.class);
				getRequest().setAttribute("list", list);
				getRequest().setAttribute("page", pageVo);
				super.log.error("根据条件查询登录日志调用queryUserLoginLogPage服务返回成功，信息：" + list);
			} else {
				super.log.error("根据条件查询登录日志调用queryUserLoginLogPage服务返回失败，信息：" + erortx);
			}
		}
	}
	
	/**
	 * 根据id删除日志
	 * @param ids
	 * @return
	 */
	@RequestMapping("/deleteUserLoginLog")
	@ResponseBody
	public ControllerResponse deleteUserLoginLog(String ids){
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		// (1)判断必要参数
		if (StringUtils.isEmpty(ids)) {
			super.log.error("id不能为空");
			response.setInfo(I18NUtils.getText("sys.v2.client.paramter.error"));//参数错误
			return response;
		}
		// (2) 调用服务，进行数据查询
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("parameter", ids);
		map.put("sign", "deleteUserLoginLogById");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("UserLoginLogsManagement", map);
		// (3)对调用服务后的返回数据进行解析
		if (result != null) {
			if (result.getSys() != null) {
				String status = result.getSys().getStatus();// 状态：'S'成功，'F'失败
				String erortx = result.getSys().getErortx();// 错误信息
				if ("S".equals(status)) {// 交易成功
					response.setInfo(I18NUtils.getText("sys.v2.client.delete.success"));//标的凭证删除成功！
					response.setResponseType(ResponseType.SUCCESS_DELETE);
					super.log.info("根据id删除登录日志，调用deleteUserLoginLogById服务成功，信息：" + erortx);
				} else {
					response.setInfo(I18NUtils.getText("sys.v2.client.delete.fail"));//标的凭证删除失败！
					super.log.error("根据id删除登录日志，调用deleteUserLoginLogById服务失败，信息：" + erortx);
				}
			}
		} else {
			response.setInfo(I18NUtils.getText("sys.v2.client.call.service.fail"));//调用服务失败
			super.log.error("调用服务失败！");
		}
		return response;
	}
}
