package com.bpm.framework.controller.v4.supplier;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v4.supplier.IndexEarlyWarningVO;
import cn.sunline.framework.controller.vo.v4.supplier.IndexTodoVO;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.Sys;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.utils.json.JsonUtils;

/**
 * 云保理4.0融资方首页
 */
@SuppressWarnings({ "rawtypes", "unchecked" })
@Controller
@RequestMapping({ "/supplierIndexController" })
public class SupplierIndexController extends AbstractController {

	private static final long serialVersionUID = -2809460978768158852L;
	
	/**
	 * 资金方首页
	 * @return
	 */
	@RequestMapping(value = "/homepage.htm")
	public String homepage() {
		UserVo user = ControllerUtils.getCurrentUser();
		Map<String,Object> map = new HashMap<String,Object>();
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("businessId", user.getBusinessId());
		log.info("请求参数：" + JsonUtils.fromObject(param));
		map.put("paramter",JsonUtils.fromObject(param));
		map.put("sign", "selectHomepage");
		ResBody result = TradeInvokeUtils.invoke("SupplierIndexManagementTran", map);
		List<IndexTodoVO> todoList = null;
		List<IndexEarlyWarningVO> earlyWarningList = null;
		long todoTotalCount = 0;
		long earlyWarningTotalCount = 0;
		Sys sys = result.getSys();
		if (null != sys) {
			String retStatus = sys.getStatus();
			String erortx = sys.getErortx();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String resultStr = output.getString("result");
				Map<String,Object> resultMap = JSONObject.parseObject(resultStr, Map.class);
				todoList = JsonUtils.toList(resultMap.get("todoList").toString(),IndexTodoVO.class);
				earlyWarningList = JsonUtils.toList(resultMap.get("earlyWarningList").toString(),IndexEarlyWarningVO.class);
				todoTotalCount = Long.valueOf(resultMap.get("todoTotalCount").toString());
				earlyWarningTotalCount = Long.valueOf(resultMap.get("earlyWarningTotalCount").toString());
				getRequest().setAttribute("todoList", todoList);
				getRequest().setAttribute("earlyWarningList", earlyWarningList);
				getRequest().setAttribute("todoTotalCount", todoTotalCount);
				getRequest().setAttribute("earlyWarningTotalCount", earlyWarningTotalCount);
			} else{
				log.error("资金方首页调用selectHomepage服务返回失败，信息：" + erortx);
				return "500";
			}
		}
		return "ybl4.0/admin/supplier/index";
	}
	
	@RequestMapping(value = "/todo/{category}/more.htm")
	public String todoMore(@PathVariable("category") Integer category,PageVo pageVo) {
		UserVo user = ControllerUtils.getCurrentUser();
		Map<String,Object> map = new HashMap<String,Object>();
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("businessId", user.getBusinessId());
		if(category < 1 && category > 6) {
			log.error("参数非法");
			return "500";
		}
		getRequest().setAttribute("category", category);
		param.put("category", category);
		log.info("请求参数：" + JsonUtils.fromObject(param));
		map.put("paramter",JsonUtils.fromObject(param));
		map.put("sign", "selectHomepageTodoMore");
		map.put("page", pageVo);
		ResBody result = TradeInvokeUtils.invoke("SupplierIndexManagementTran", map);
		PageVo page=null;
		List<IndexTodoVO> list=null;
		Sys sys = result.getSys();
		if (null != sys) {
			String retStatus = sys.getStatus();
			String erortx = sys.getErortx();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("result");
				page=(PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
				list=JsonUtils.toList(records,IndexTodoVO.class);
				page.setRecords(list);
				getRequest().setAttribute("page", page);
			} else{
				log.error("资金方首页调用selectHomepageTodoMore服务返回失败，信息：" + erortx);
				return "500";
			}
		}
		return "ybl4.0/admin/supplier/index_todo_more";
	}
	
	@RequestMapping(value = "/earlywarning/{category}/more.htm")
	public String earlywarningMore(@PathVariable("category") Integer category,PageVo pageVo) {
		UserVo user = ControllerUtils.getCurrentUser();
		Map<String,Object> map = new HashMap<String,Object>();
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("businessId", user.getBusinessId());
		if(category < 1 && category > 3) {
			log.error("参数非法");
			return "500";
		}
		getRequest().setAttribute("category", category);
		param.put("category", category);
		log.info("请求参数：" + JsonUtils.fromObject(param));
		map.put("paramter",JsonUtils.fromObject(param));
		map.put("sign", "selectHomepageEarlyWarningMore");
		map.put("page", pageVo);
		ResBody result = TradeInvokeUtils.invoke("SupplierIndexManagementTran", map);
		PageVo page=null;
		List<IndexEarlyWarningVO> list=null;
		Sys sys = result.getSys();
		if (null != sys) {
			String retStatus = sys.getStatus();
			String erortx = sys.getErortx();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("result");
				page=(PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
				list=JsonUtils.toList(records,IndexEarlyWarningVO.class);
				page.setRecords(list);
				getRequest().setAttribute("page", page);
			} else{
				log.error("资金方首页调用selectHomepageEarlyWarningMore服务返回失败，信息：" + erortx);
				return "500";
			}
		}
		return "ybl4.0/admin/supplier/index_earlywarning_more";
	}
}
