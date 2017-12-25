package com.bpm.framework.controller.v4.enterprise;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.utils.i18n.I18NUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v4.drools.V4BusinessAuthVO;
import cn.sunline.framework.controller.vo.v4.enterprise.IndexTodoVO;
import cn.sunline.framework.controller.vo.v4.factor.FactorCollectionManagementRepaymentPlanVo;
import cn.sunline.framework.controller.vo.v4.supplier.LoanApply;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 核心企业首页展示
 * 
 * @author pc
 *
 */
@Controller
@RequestMapping("/enterpriseIndexV4Controller")
public class EnterpriseIndexV4Controller extends AbstractController {

	@Autowired
	private static final long serialVersionUID = 1042344788738102506L;

	/**
	 * 核心企业首页
	 * 
	 * @return 核心企业首页
	 */
	@RequestMapping("/enterpriseIndex.htm")
	public String toEnterpriseIndex() {
		// (1) 用户登录判断
		UserVo user = ControllerUtils.getCurrentUser();
		if (user == null) {
			super.log.error("请先登录");
			return "ybl4.0/admin/doorl/login";
		}
		// 代办 与 预警提醒 （1：待办 （确权待办 及还款待办） 2：预警提醒（待还款小于等于3天，逾期的））
		V4BusinessAuthVO businessAuthVO = new V4BusinessAuthVO();
		businessAuthVO.setEnterpriseId(user.getEnterpriseId());
		if (user.getBusinessId() != null && user.getBusinessId() > 0) {
			businessAuthVO.setId(user.getBusinessId());
			PageVo<?> pageVo = new PageVo<>();
			pageVo.setPageSize(3);
			Map<String, Object> maps = new HashMap<String, Object>();
			maps.put("param", businessAuthVO);
			maps.put("page", pageVo);
			maps.put("sign", "queryIndexInfo");// 所调用的服务中的方法
			ResBody result = TradeInvokeUtils.invoke("EnterpriseIndexManagement", maps);
			if (result != null) {
				if (result.getSys() != null) {
					String status = result.getSys().getStatus();// 状态：'S'成功，'F'失败
					String erortx = result.getSys().getErortx();// 错误信息
					if ("S".equals(status)) {
						JSONObject output = (JSONObject) result.getOutput();
						// 记录数
						Map<String, Object> map = JsonUtils.toMap(output.getString("result"));
						// 待办
						String indexTodoJson = output.getString("indexTodo");
						List<IndexTodoVO> indexTodo = JsonUtils.toList(indexTodoJson, IndexTodoVO.class);
						ControllerUtils.getRequest().setAttribute("indexTodo", indexTodo);
						ControllerUtils.getRequest().setAttribute("toDoNum", map.get("todoNum"));
						// 预警还款
						String warningRepaymentJson = output.getString("warningRepayment");
						List<FactorCollectionManagementRepaymentPlanVo> warningRepayment = JsonUtils
								.toList(warningRepaymentJson, FactorCollectionManagementRepaymentPlanVo.class);
						ControllerUtils.getRequest().setAttribute("warningRepaymentSize", map.get("warningNum"));
						ControllerUtils.getRequest().setAttribute("warningRepayment", warningRepayment);
						super.log.error("根据条件查询业务基础信息，调用queryByCondition成功 ，信息" + erortx);
					} else {
						super.log.error("根据条件查询业务基础信息，调用queryByCondition失败 ，信息" + erortx);
					}
				}
			}
		} else {
			super.log.error("用户信息参数错误");
		}
		return "ybl4.0/admin/enterprise/enterpriseIndex/enterpriseIndex";
	}

	/**
	 * 更多待办
	 * 
	 * @param page
	 *            分页实体
	 * @return 更多待办页面
	 */
	@RequestMapping("/moreTodo.htm")
	public String moreTodo(PageVo<?> page) {
		// (1) 用户登录判断
		UserVo user = ControllerUtils.getCurrentUser();
		if (user == null) {
			super.log.error("请先登录");
			return "ybl4.0/admin/doorl/login";
		}
		// 2：待办
		V4BusinessAuthVO businessAuthVO = new V4BusinessAuthVO();
		businessAuthVO.setEnterpriseId(user.getEnterpriseId());
		if (user.getBusinessId() != null && user.getBusinessId() > 0) {
			businessAuthVO.setId(user.getBusinessId());
			Map<String, Object> maps = new HashMap<String, Object>();
			maps.put("param", businessAuthVO);
			maps.put("page", page);
			maps.put("sign", "queryMoreTodo");// 所调用的服务中的方法
			ResBody result = TradeInvokeUtils.invoke("EnterpriseIndexManagement", maps);
			if (result != null) {
				if (result.getSys() != null) {
					String status = result.getSys().getStatus();// 状态：'S'成功，'F'失败
					String erortx = result.getSys().getErortx();// 错误信息
					if ("S".equals(status)) {
						JSONObject output = (JSONObject) result.getOutput();
						// 预警还款
						String indexTodoJson = output.getString("indexTodo");
						List<IndexTodoVO> indexTodo = JsonUtils.toList(indexTodoJson, IndexTodoVO.class);
						ControllerUtils.getRequest().setAttribute("indexTodo", indexTodo);
						String jsonPage = output.getString("page");
						page = JSONObject.parseObject(jsonPage, PageVo.class);
						getRequest().setAttribute("page", page);
						super.log.error("根据条件查询业务基础信息，调用queryByCondition成功 ，信息" + erortx);
					} else {
						super.log.error("根据条件查询业务基础信息，调用queryByCondition失败 ，信息" + erortx);
					}
				}
			}
		} else {
			super.log.error("用户信息参数错误");
		}
		return "ybl4.0/admin/enterprise/enterpriseIndex/moreTodo";
	}

	/**
	 * 更多预警提醒
	 * 
	 * @param page
	 *            分页实体
	 * @return 更多预警提醒页面
	 */
	@RequestMapping("/moreWarningreminder.htm")
	public String moreWarningreminder(PageVo<?> page) {
		// (1) 用户登录判断
		UserVo user = ControllerUtils.getCurrentUser();
		if (user == null) {
			super.log.error("请先登录");
			return "ybl4.0/admin/doorl/login";
		}
		// 2：预警提醒（待还款小于等于3天，逾期的））
		V4BusinessAuthVO businessAuthVO = new V4BusinessAuthVO();
		businessAuthVO.setEnterpriseId(user.getEnterpriseId());
		if (user.getBusinessId() != null && user.getBusinessId() > 0) {
			businessAuthVO.setId(user.getBusinessId());
			Map<String, Object> maps = new HashMap<String, Object>();
			maps.put("param", businessAuthVO);
			maps.put("page", page);
			maps.put("sign", "queryMoreWarningreminder");// 所调用的服务中的方法
			ResBody result = TradeInvokeUtils.invoke("EnterpriseIndexManagement", maps);
			if (result != null) {
				if (result.getSys() != null) {
					String status = result.getSys().getStatus();// 状态：'S'成功，'F'失败
					String erortx = result.getSys().getErortx();// 错误信息
					if ("S".equals(status)) {
						JSONObject output = (JSONObject) result.getOutput();
						// 预警还款
						String warningRepaymentJson = output.getString("warningRepayment");
						List<FactorCollectionManagementRepaymentPlanVo> warningRepayment = JsonUtils
								.toList(warningRepaymentJson, FactorCollectionManagementRepaymentPlanVo.class);
						ControllerUtils.getRequest().setAttribute("warningRepayment", warningRepayment);
						String jsonPage = output.getString("page");
						page = JSONObject.parseObject(jsonPage, PageVo.class);
						getRequest().setAttribute("page", page);
						super.log.error("根据条件查询业务基础信息，调用queryByCondition成功 ，信息" + erortx);
					} else {
						super.log.error("根据条件查询业务基础信息，调用queryByCondition失败 ，信息" + erortx);
					}
				}
			}
		} else {
			super.log.error("用户信息参数错误");
		}
		return "ybl4.0/admin/enterprise/enterpriseIndex/moreWarningreminder";
	}

	/**
	 * 还款处理
	 * 
	 * @param repaymentPlanId
	 *            还款集合表ID
	 * @param orderNo
	 *            返回字段标识
	 * @return 还款数据
	 */
	@RequestMapping({ "/queryRepaymentInfo" })
	@ResponseBody
	public ControllerResponse queryRepaymentInfo(Long repaymentPlanId, String orderNo) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("inputParam", orderNo);
		maps.put("sign", "queryRepaymentInfo");
		ResBody result = null;
		result = TradeInvokeUtils.invoke("EnterpriseIndexManagement", maps);
		if (isSuccess(result)) {
			response.setResponseType(ResponseType.SUCCESS);
			JSONObject output = (JSONObject) result.getOutput();
			String resultObj = output.getString("result");
			LoanApply loanApply = JsonUtils.toObject(resultObj, LoanApply.class);
			response.setObject(loanApply);
			response.setInfo(I18NUtils.getText("sys.client.operationSuccess"));// 操作成功
		} else {
			response.setResponseType(ResponseType.ERROR);
			super.log.error("修改收款状态服务调用信息：" + result.getSys().getErortx());
		}
		return response;
	}

	/**
	 * 账户中心页面跳转
	 * 
	 * @return
	 */
	@RequestMapping("/accountCenter.htm")
	public String accountCenter() {
		// (1) 用户登录判断
		UserVo user = ControllerUtils.getCurrentUser();
		if (user == null) {
			super.log.error("请先登录");
			return "ybl4.0/admin/doorl/login";
		}
		return "ybl4.0/admin/enterprise/memberCenter";
	}
}
