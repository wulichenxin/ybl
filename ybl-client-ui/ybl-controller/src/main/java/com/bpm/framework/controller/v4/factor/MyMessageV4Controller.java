package com.bpm.framework.controller.v4.factor;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.utils.CollectionUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v4.factor.StationMessageVo;
import cn.sunline.framework.controller.vo.v4.factor.enums.E_V4_STATION_MESSAGE_STATUS;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 我的消息控制器
 * @author WIN
 *
 */
@Controller
@RequestMapping({ "/myMessageV4Controller" })
public class MyMessageV4Controller extends AbstractController{

	/**
	 * 
	 */
	private static final long serialVersionUID = 9002131471473550004L;
	/**
	 * 查询我的消息
	 * @param page
	 * @param stationMessage
	 * @return
	 */
	@RequestMapping({ "/messageList.htm" })
	public String queryMessageList(PageVo<?> page,StationMessageVo stationMessage) {
		// (1)获取当前登录人的信息
		UserVo userVo = ControllerUtils.getCurrentUser();
		if (userVo != null && userVo.getId().longValue()>0){
			stationMessage.setMemberId(userVo.getId());
			JSONObject output = queryMessageByCondition(stationMessage, page);
			if (output != null) {
				String pageJson = output.getString("page");
				String resultJson = output.getString("stationMessage");
				page = (PageVo<?>) JSONObject.parseObject(pageJson, PageVo.class);
				List<StationMessageVo> stationMessageList = JsonUtils.toList(resultJson, StationMessageVo.class);
				getRequest().setAttribute("stationMessageList", stationMessageList);
				getRequest().setAttribute("page", page);
			}
		}
		return "ybl4.0/admin/factor/accountCenter/myMessage";
	}
	/**
	 * 查看消息内容并标记为已读
	 * @param id
	 * @return
	 */
	@RequestMapping({ "/messageDetails.htm" })
	public String queryMessageList(Long id) {
		StationMessageVo stationMessage = new StationMessageVo();
		stationMessage.setId(id);
		JSONObject output = queryMessageByCondition(stationMessage, new PageVo<>());
		if (output != null) {
			String resultJson = output.getString("stationMessage");
			List<StationMessageVo> stationMessageVoList = JsonUtils.toList(resultJson, StationMessageVo.class);
			if(CollectionUtils.isNotEmpty(stationMessageVoList)){
				stationMessage = stationMessageVoList.get(0);
				getRequest().setAttribute("stationMessage", stationMessage);
				if(stationMessage !=null && E_V4_STATION_MESSAGE_STATUS.UNREAD.getStatus() == stationMessage.getStatus()){
					stationMessage.setStatus(1);//标记为已读
					ControllerUtils.setWho(stationMessage);//设置更新时间,人
					Map<String, Object> map = new HashMap<String, Object>();
					map.put("stationMessage", stationMessage);
					ResBody result = TradeInvokeUtils.invoke("V4UpdateStationMessageManagement", map);
					if (result != null) {
						if (result.getSys() != null) {
							String estatus = result.getSys().getStatus();// 状态：'S'成功，'F'失败
							String erortx = result.getSys().getErortx();// 错误信息
							if ("S".equals(estatus)) {// 交易成功
								super.log.info("站内信更新,调用updateInboxByBatch服务，信息：" + erortx);
							} else {
								super.log.error("站内信更新,调用updateInboxByBatch服务，信息：" + erortx);
							}
						}
					} else {
						super.log.error("调用服务失败！");
					}
				}
			}
		}
		return "ybl4.0/admin/factor/accountCenter/messageDetail";
	}
	
	/**
	 * 根据条件查询我的消息
	 * @param parameters
	 * @param page
	 * @return
	 */
	private JSONObject queryMessageByCondition(StationMessageVo parameters, PageVo<?> page) {
		// 调用服务，进行数据查询
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("stationMessage", parameters);
		map.put("page", page);
		ResBody result = TradeInvokeUtils.invoke("V4QueryStationMessageManagement", map);
		JSONObject output = (JSONObject) result.getOutput();
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				super.log.info("根据条件查询站内信调用V4QueryStationMessageManagement交易返回成功，信息：" + erortx);
			} else {
				super.log.error("根据条件查询站内信调用V4QueryStationMessageManagement交易返回失败，信息：" + erortx);
				return null;
			}
		}
		return output;
	}
	/**
	 * 发送站内信
	 * @param parameters
	 * @return
	 */
	public static Boolean insertStationMessage(StationMessageVo parameters) {
		Boolean insert = false;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("stationMessage", parameters);
		ResBody result = TradeInvokeUtils.invoke("V4StationMessageInsertManagement", map);
		if (result != null) {
			if (result.getSys() != null) {
				String estatus = result.getSys().getStatus();// 状态：'S'成功，'F'失败
				if ("S".equals(estatus)) {// 交易成功
					insert =true;
				} 
			}
		} 
		return insert;
	}
}
