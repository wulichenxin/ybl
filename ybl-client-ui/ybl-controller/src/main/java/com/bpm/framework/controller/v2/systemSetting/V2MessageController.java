package com.bpm.framework.controller.v2.systemSetting;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.utils.CollectionUtils;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.i18n.I18NUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.InboxVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 消息中心2.0controller
 * 
 * @author JZX
 *
 */
@Controller
@RequestMapping({ "/v2messageController" })
public class V2MessageController extends AbstractController {

	private static final long serialVersionUID = -8810128436392827766L;

	/**
	 * 消息中心列表页面跳转，并加载数据
	 * 
	 * @param inbox
	 *            消息查询对象
	 * @return
	 */
	@RequestMapping({ "/messageList.htm" })
	public String queryMessageList(PageVo<?> page, InboxVo inbox) {
		// (1)获取当前登录人的信息
		UserVo userVo = ControllerUtils.getCurrentUser();
		if (userVo != null && userVo.getEnterpriseId().longValue() > 0) {
			inbox.setReceiverId(userVo.getId());
			inbox.setEnable(1);// 有效
			JSONObject output = queryInboxByCondition(inbox, page);
			if (output != null) {
				String pageJson = output.getString("page");
				String resultJson = output.getString("result");
				page = (PageVo<?>) JSONObject.parseObject(pageJson, PageVo.class);
				List<InboxVo> inboxList = JsonUtils.toList(resultJson, InboxVo.class);
				getRequest().setAttribute("inboxList", inboxList);
				getRequest().setAttribute("page", page);
			}
		}
		return "ybl/v2/admin/systemSetting/messageCenter";
	}

	/**
	 * 消息中心列表页面跳转，并加载数据
	 * 
	 * @param inbox
	 *            消息查询对象
	 * @return
	 */
	@RequestMapping({ "/messageDetails.htm-{id}" })
	public String queryMessageList(@PathVariable("id") Long id) {
		InboxVo inbox = new InboxVo();
		inbox.setId(id);
		inbox.setEnable(1);// 有效
		JSONObject output = queryInboxByCondition(inbox, new PageVo<>());
		if (output != null) {
			String resultJson = output.getString("result");
			List<InboxVo> inboxList = JsonUtils.toList(resultJson, InboxVo.class);
			if(CollectionUtils.isNotEmpty(inboxList)){
				getRequest().setAttribute("inbox", inboxList.get(0));
				if(inboxList.get(0) !=null && "N".equals(inboxList.get(0).getIsRead())){
					inbox.setIsRead("Y");
					updateMessage(getRequest(),inbox,id.toString());
				}
			}
		}
		getRequest().setAttribute("id", id);
		return "ybl/v2/admin/systemSetting/messageDetail";
	}

	/**
	 * 根据条件查询站内信信息
	 * 
	 * @param request
	 * @param parameters
	 *            站内信查询条件
	 * @param page
	 *            分页对象
	 * @return
	 */
	@RequestMapping(value = "/queryInboxByCondition")
	@ResponseBody
	public JSONObject queryInboxByCondition(InboxVo parameters, PageVo<?> page) {
		parameters.setEnable(1);// （0：否，1：是）
		// 调用服务，进行数据查询
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", parameters);
		map.put("page", page);
		map.put("sign", "queryInboxByCondition");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("InboxManagement", map);
		JSONObject output = (JSONObject) result.getOutput();
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				super.log.info("根据条件查询站内信调用queryInboxByCondition服务返回成功，信息：" + erortx);
				return output;
			} else {
				super.log.error("根据条件查询站内信调用queryInboxByCondition服务返回失败，信息：" + erortx);
				return null;
			}
		}
		return null;
	}

	/**
	 * 查询所有站内信信息
	 * 
	 * @param page
	 *            分页对象
	 * @return inboxList 站内信信息集合
	 */
	@RequestMapping(value = "/queryAllInbox")
	@ResponseBody
	public List<InboxVo> queryAllInbox(PageVo<?> page) {
		// 调用服务，进行数据查询
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", "");
		map.put("page", page);
		map.put("sign", "queryInboxByCondition");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("InboxManagement", map);
		JSONObject output = (JSONObject) result.getOutput();
		List<InboxVo> inboxList = null;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				String resultJson = output.getString("result");
				inboxList = JsonUtils.toList(resultJson, InboxVo.class);
				super.log.info("查询全部站内信调用queryAllInbox服务返回成功，信息：" + erortx);
			} else {
				super.log.error("查询全部站内信调用queryAllInbox服务返回失败，信息：" + erortx);
				return null;
			}
		}
		return inboxList;
	}

	/**
	 * 根据id修改站内信
	 * 
	 * @param request
	 * @param parameters
	 *            站内信对象
	 * @param ids
	 *            要更新数据的id字符串
	 * @return
	 */
	@RequestMapping(value = "/updateMessage")
	@ResponseBody
	public ControllerResponse updateMessage(HttpServletRequest request, InboxVo parameters, String ids) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		// (1)判断必要参数
		if (!(parameters != null && parameters.getEnterpriseId() != null && StringUtils.isNotEmpty(ids))) {
			super.log.error("修改站内信时，站内信对象及id不能为空！");
			response.setInfo(I18NUtils.getText("sys.client.paramter.error"));// 参数错误
			return response;
		}
		// (2)调用服务，进行数据更新
		Map<String, Object> map = new HashMap<String, Object>();
		List<InboxVo> paramList = new ArrayList<InboxVo>();
		InboxVo inbox = null;
		String[] idArr = ids.split(",");
		for (int i = 0; i < idArr.length; i++) {
			if (StringUtils.isNotEmpty(idArr[i])) {
				inbox = new InboxVo();
				inbox.setEnable(1);
				inbox.setId(Long.valueOf(idArr[i]));
				inbox.setIsRead(parameters.getIsRead());
				ControllerUtils.setWho(inbox);// 设置时间、操作人
				paramList.add(inbox);
			}
		}
		map.put("paramter", paramList);
		map.put("sign", "updateInboxByBatch");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("InboxManagement", map);
		// (3)对调用服务后的返回数据进行解析
		if (result != null) {
			if (result.getSys() != null) {
				String estatus = result.getSys().getStatus();// 状态：'S'成功，'F'失败
				String erortx = result.getSys().getErortx();// 错误信息
				if ("S".equals(estatus)) {// 交易成功
					response.setInfo(I18NUtils.getText("sys.client.update.success"));// 站内信更新成功！
					response.setResponseType(ResponseType.SUCCESS_UPDATE);
					super.log.info("站内信更新,调用updateInboxByBatch服务，信息：" + erortx);
				} else {
					response.setInfo(I18NUtils.getText("sys.client.update.fail"));// 站内信更新失败！
					super.log.error("站内信更新,调用updateInboxByBatch服务，信息：" + erortx);
				}
			}
		} else {
			response.setInfo(I18NUtils.getText("sys.client.call.service.fail"));// 调用服务失败！
			super.log.error("调用服务失败！");
		}
		return response;
	}

	/**
	 * 删除站内信信息（by id）
	 * 
	 * @param request
	 * @param ids
	 *            删除的站内信主键id
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteMessage")
	@ResponseBody
	public ControllerResponse deleteMessage(HttpServletRequest request, String ids) throws Exception {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		// (1)判断必要参数
		if (StringUtils.isEmpty(ids)) {
			super.log.error("id不能为空");
			response.setInfo(I18NUtils.getText("sys.client.paramter.error"));// 参数错误
			return response;
		}
		// (2) 调用服务，进行数据查询
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", ids);
		map.put("sign", "deleteInboxById");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("InboxManagement", map);
		// (3)对调用服务后的返回数据进行解析
		if (result != null) {
			if (result.getSys() != null) {
				String status = result.getSys().getStatus();// 状态：'S'成功，'F'失败
				String erortx = result.getSys().getErortx();// 错误信息
				response.setInfo(erortx);
				if ("S".equals(status)) {// 交易成功
					response.setResponseType(ResponseType.SUCCESS_DELETE);
					super.log.info("根据id删除站内信，调用deleteInboxById服务成功，信息：" + erortx);
				} else {
					super.log.error("根据id删除站内信，调用deleteInboxById服务失败，信息：" + erortx);
				}
			}
		}
		return response;
	}

	/**
	 * 根据条件查询站内信信息
	 * 
	 * @param request
	 * @param parameters
	 *            站内信查询条件
	 * @param page
	 *            分页对象
	 * @return
	 */
	@RequestMapping(value = "/getInboxCount")
	@ResponseBody
	public Long getInboxCount(InboxVo parameters, PageVo<?> page) {
		Long inter = 0L;
		// (1)获取当前登录人的信息
		UserVo userVo = ControllerUtils.getCurrentUser();
		if (userVo != null && userVo.getId() > 0) {
			parameters.setReceiverId(userVo.getId());
		}
		JSONObject jsonStr = queryInboxByCondition(parameters, page);
		if (jsonStr != null) {
			String pageJson = jsonStr.getString("page");
			page = (PageVo<?>) JSONObject.parseObject(pageJson, PageVo.class);
			if (page != null && page.getRecordCount() > 0) {
				inter = page.getRecordCount();
			}
		}
		return inter;
	}
}