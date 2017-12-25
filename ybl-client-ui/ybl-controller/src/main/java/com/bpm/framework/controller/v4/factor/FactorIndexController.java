package com.bpm.framework.controller.v4.factor;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v4.factor.FactorLoanAuditVo;
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
 * 资金方首页
 */
@Controller
@RequestMapping({ "/factorIndexController" })
@SuppressWarnings({ "rawtypes", "unchecked" })
public class FactorIndexController extends AbstractController {

	private static final long serialVersionUID = -6822807362750361909L;

	/**
	 * 资金方首页
	 * @return
	 */
	@RequestMapping(value = "/homepage.htm")
	public String homepage() {
		UserVo user = ControllerUtils.getCurrentUser();
		//登录验证
		if (null == user) {
			super.log.error("请先登录");
			return "ybl4.0/admin/doorl/login";
		}
		Map<String,Object> map = new HashMap<String,Object>();
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("businessId", user.getBusinessId());
		super.log.info("请求参数：" + JsonUtils.fromObject(param));
		map.put("paramter",JsonUtils.fromObject(param));
		map.put("sign", "selectHomepage");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("FactorIndexManagement", map);
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
				todoList = JsonUtils.toList(resultMap.get("todoList").toString(),IndexTodoVO.class);//待办事项List
				earlyWarningList = JsonUtils.toList(resultMap.get("earlyWarningList").toString(),IndexEarlyWarningVO.class);//预警事项List
				todoTotalCount = Long.valueOf(resultMap.get("todoTotalCount").toString());//待办事项总数
				earlyWarningTotalCount = Long.valueOf(resultMap.get("earlyWarningTotalCount").toString());//预警事项总数
				getRequest().setAttribute("todoList", todoList);
				getRequest().setAttribute("earlyWarningList", earlyWarningList);
				getRequest().setAttribute("todoTotalCount", todoTotalCount);
				getRequest().setAttribute("earlyWarningTotalCount", earlyWarningTotalCount);
				super.log.info("资金方首页调用selectHomepage服务返回成功");
			} else{
				super.log.error("资金方首页调用selectHomepage服务返回失败，信息：" + erortx);
				return "500";
			}
		}
		return "ybl4.0/admin/factor/index/list";
	}
	
	/**
	 * 更多待办信息
	 * @param category 首页待办事项业务类型标识 1.风控初审2.风控终审3.放款审核4.资产确权5.放款管理6.收款确认
	 * @param pageVo
	 * @return
	 */
	@RequestMapping(value = "/todo/{category}/more.htm")
	public String todoMore(@PathVariable("category") Integer category,PageVo pageVo) {
		UserVo user = ControllerUtils.getCurrentUser();
		//登录验证
		if (null == user) {
			super.log.error("请先登录");
			return "ybl4.0/admin/doorl/login";
		}
		Map<String,Object> map = new HashMap<String,Object>();
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("businessId", user.getBusinessId());
		//参数验证
		if(category < 1 || category > 6) {
			super.log.error("参数非法");
			return "500";
		}
		getRequest().setAttribute("category", category);
		param.put("category", category);
		super.log.info("请求参数：" + JsonUtils.fromObject(param));
		map.put("paramter",JsonUtils.fromObject(param));
		map.put("sign", "selectHomepageTodoMore");// 所调用的服务中的方法
		map.put("page", pageVo);
		ResBody result = TradeInvokeUtils.invoke("FactorIndexManagement", map);
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
				log.info("资金方首页调用selectHomepageTodoMore服务返回成功");
			} else{
				log.error("资金方首页调用selectHomepageTodoMore服务返回失败，信息：" + erortx);
				return "500";
			}
		}
		return "ybl4.0/admin/factor/index/toDoList";
	}
	
	/**
	 * 更多预警信息
	 * @param category 首页预警事项业务类型标识 1.收款确认预警
	 * @param pageVo
	 * @return
	 */
	@RequestMapping(value = "/earlywarning/{category}/more.htm")
	public String earlywarningMore(@PathVariable("category") Integer category,PageVo pageVo) {
		UserVo user = ControllerUtils.getCurrentUser();
		//登录验证
		if (null == user) {
			super.log.error("请先登录");
			return "ybl4.0/admin/doorl/login";
		}
		Map<String,Object> map = new HashMap<String,Object>();
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("businessId", user.getBusinessId());
		//参数验证
		if(category < 1 || category > 1) {
			super.log.error("参数非法");
			return "500";
		}
		getRequest().setAttribute("category", category);
		param.put("category", category);
		super.log.info("请求参数：" + JsonUtils.fromObject(param));
		map.put("paramter",JsonUtils.fromObject(param));
		map.put("sign", "selectHomepageEarlyWarningMore");// 所调用的服务中的方法
		map.put("page", pageVo);
		ResBody result = TradeInvokeUtils.invoke("FactorIndexManagement", map);
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
				super.log.info("资金方首页调用selectHomepageEarlyWarningMore服务返回成功");
			} else{
				super.log.error("资金方首页调用selectHomepageEarlyWarningMore服务返回失败，信息：" + erortx);
				return "500";
			}
		}
		return "ybl4.0/admin/factor/index/warningList";
	}
	
	/**
	 * 首页待办事项跳转处理
	 * @param resourceId
	 * @param type 首页业务类型标识 1.风控初审2.风控终审3.放款审核4.资产确权5.放款管理6.收款确认
	 * @return
	 */
	@RequestMapping(value = "/{resourceId}/{type}/toDeal")
	public String toDeal(@PathVariable("resourceId") Integer resourceId, @PathVariable("type") Integer type) {
		UserVo user = ControllerUtils.getCurrentUser();
		//登录验证
		if (null == user) {
			super.log.error("请先登录");
			return "ybl4.0/admin/doorl/login";
		}
		//参数验证
		if(null == resourceId || null == type || type < 1 || type > 6){
			super.log.error("参数非法");
			return "500";
		}
		if(1 == type) {//跳转到风控初审页面
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("paramter", resourceId);
			map.put("sign", "selectFaidBySfaid");// 所调用的服务中的方法
			ResBody result = TradeInvokeUtils.invoke("FactorIndexManagement", map);
			if (null != result.getSys()) {
				String status = result.getSys().getStatus();
				String erortx = result.getSys().getErortx();//错误信息
				if ("S".equals(status)) {
					JSONObject output = (JSONObject) result.getOutput();
					String records = output.getString("result");
					Integer financingApplyId = JsonUtils.toObject(records, Integer.class);//融资申请id
					super.log.info("根据子融资id查询融资订单id服务返回成功，信息："+ financingApplyId);
					return "redirect:/factorRiskManagementController/" + financingApplyId + "/"+ resourceId +"/1/financingApplyDetail.htm";
				}else{
					super.log.error("根据子融资id查询融资订单id服务返回失败，信息："+erortx);
				}
			}
		}else if(2 == type) {//跳转到风控终审页面
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("paramter", resourceId);
			map.put("sign", "selectFaidBySfaid");// 所调用的服务中的方法
			ResBody result = TradeInvokeUtils.invoke("FactorIndexManagement", map);
			if (null != result.getSys()) {
				String status = result.getSys().getStatus();
				String erortx = result.getSys().getErortx();//错误信息
				if ("S".equals(status)) {
					JSONObject output = (JSONObject) result.getOutput();
					String records = output.getString("result");
					Integer financingApplyId = JsonUtils.toObject(records, Integer.class);//融资申请id
					super.log.info("根据子融资id查询融资订单id服务返回成功，信息："+ financingApplyId);
					return "redirect:/factorRiskManagementController/" + financingApplyId + "/"+ resourceId +"/2/financingApplyDetail.htm";
				}else{
					super.log.error("根据子融资id查询融资订单id服务返回失败，信息："+erortx);
				}
			}
		}else if(3 == type || 4 == type) {//跳转到放款审核页面或者确权页面
			return "redirect:/factorLoanAuditController/" + resourceId + "/view.htm";
		}else if(5 == type) {//跳转到放款管理页面
			//根据放款申请id查询放款批次id
			Map<String, Object> map = new HashMap<String, Object>();
			Map<String, Object> mapinfo = new HashMap<String, Object>();
			mapinfo.put("id", resourceId);//放款申请id
			mapinfo.put("businessId", user.getBusinessId());
			
			map.put("paramter", mapinfo);
			map.put("sign", "selectAssetsTypeById");// 所调用的服务中的方法
			ResBody result = TradeInvokeUtils.invoke("FactorIndexManagement", map);
			Integer batchId = 0;
			if (null != result.getSys()) {
				String sta = result.getSys().getStatus();
				String erortx = result.getSys().getErortx();//错误信息
				if ("S".equals(sta)) {
					JSONObject output = (JSONObject) result.getOutput();
					String records = output.getString("result");
					FactorLoanAuditVo loanInfo = JsonUtils.toObject(records, FactorLoanAuditVo.class);
					batchId = loanInfo.getPaymentBatchId();
					super.log.info("根据放款id查询底层资产服务返回成功，信息："+ loanInfo);
				}else{
					super.log.error("根据放款id查询底层资产服务返回服务返回失败，信息："+erortx);
				}
			}
			if(null == batchId || 0 == batchId) {
				return "redirect:/factorLoanManagementController/loanPending/list.htm";//生成付款批次
			}else{
				return "redirect:/factorLoanManagementController/loanBatchPending/list.htm";//待付款批次
			}
		}else if(6 == type) {//跳转到收款确认页面
			return "redirect:/factorCollectionManagementController/unconfirmed/list.htm";
		}
		super.log.error("参数非法");
		return "500";
	}
}
