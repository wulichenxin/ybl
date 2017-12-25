package com.bpm.framework.controller.v2;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.constant.Constant;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.v2.enterprise.AccountsAffirmController;
import com.bpm.framework.controller.v2.factor.V2DisbursementController;
import com.bpm.framework.controller.v2.factor.V2ReimbursementController;
import com.bpm.framework.utils.i18n.I18NUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v2.AccountVo;
import cn.sunline.framework.controller.vo.v2.TodoListVo;
import cn.sunline.framework.controller.vo.v2.V2BalanceVo;
import cn.sunline.framework.controller.vo.v2.V2DisbursementBatchVo;
import cn.sunline.framework.controller.vo.v2.V2GenerateDisbursementBatchVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * @author JZX jinzhixian@sunline.cn
 * @version 2.0.0
 * @date 2017年6月14日
 */
@Controller
@RequestMapping("/indexV2Controller")
public class IndexV2Controller extends AbstractController {
	
	@Autowired
	
	private static int MAX_DISPLAY = 10; //最多显示的待处理条数

	private static final long serialVersionUID = 1L;

	// 供应商首页
	@RequestMapping("/supplierIndex.htm")
	public String toSupplierIndex() {
		UserVo user = ControllerUtils.getCurrentUser();
		if(user == null ){
			super.log.error("请先登录");
			return "/ybl/v2/admin/index/login";
		}
		PageVo<?> pageVo = new PageVo<>();
		pageVo.setPageSize(8);/* 分页，首页默认为 8条 */
		Map<String, String> map = new HashMap<String, String>();
		map.put("attribute1_", "8");/* 回款日期提前8天预警 */
		map.put("supplier_enterprise_id", user.getEnterpriseId().toString());
		queryList(pageVo, map);
		return "ybl/v2/admin/supplier/supplierIndex";
	}

	// 核心企业首页
	@RequestMapping("/enterpriseIndex.htm")
	public String toEnterpriseIndex() {
		UserVo user = ControllerUtils.getCurrentUser();
		if(user == null ){
			super.log.error("请先登录");
			return "/ybl/v2/admin/index/login";
		}
		PageVo<?> pageVo = new PageVo<>();
		pageVo.setPageSize(8);/* 分页，首页默认为 8条 */
		Map<String, String> map = new HashMap<String, String>();
		map.put("status_",
				Constant.ACCOUNT_RECEIVABLE_SUBMIT);/* 提交待确认(核心企业)：submit */
		map.put("enterprise_id", user.getEnterpriseId().toString());
		queryList(pageVo, map);
		return "ybl/v2/admin/enterprise/enterpriseIndex";
	}

	
	
	// 保理商首页
	@RequestMapping("/factorIndex.htm")
	public String toFactorIndex() {
		
		//构造待处理列表
		TodoListVo todoEntity = new TodoListVo();
		
		// 查询待审核列表
		List<Map> auditList = null;
		AccountVo account = new AccountVo();
		account.setAudit_status("first_trial");
		account.setOperation_("authstr");     //待审核
		auditList = AccountsAffirmController.queryFactorToAuditList(account, new PageVo<>(1,MAX_DISPLAY));
		todoEntity.setAuditTodoList(auditList,I18NUtils.getText("sys.v2.client.riskFirstAudit"),"/accountsAffirmController/queryAuditDetail.htm");
		
		account.setAudit_status("analyze");
		auditList = AccountsAffirmController.queryFactorToAuditList(account, new PageVo<>(1,MAX_DISPLAY));
		todoEntity.setAuditTodoList(auditList,I18NUtils.getText("sys.v2.client.analysis"),"/accountsAffirmController/queryauditAnalyzeDetail.htm");
		
		account.setAudit_status("recheck");
		auditList = AccountsAffirmController.queryFactorToAuditList(account, new PageVo<>(1,MAX_DISPLAY));
		todoEntity.setAuditTodoList(auditList,I18NUtils.getText("sys.v2.client.riskReAudit"),"/accountsAffirmController/queryRecheckDetail.htm");
		
		account.setAudit_status("business");
		auditList = AccountsAffirmController.queryFactorToAuditList(account, new PageVo<>(1,MAX_DISPLAY));
		todoEntity.setAuditTodoList(auditList,I18NUtils.getText("sys.v2.client.businessHandling"),"/accountsAffirmController/queryBusinessDetail.htm");
		
		//查询生成待付款批次
		List<V2GenerateDisbursementBatchVo> generateDisbursementBatchVos = V2DisbursementController.getAllGenerateBatchList();
		todoEntity.setGenerateDisburseTodoList(generateDisbursementBatchVos);
		
		//查询待结算列表
		List<V2DisbursementBatchVo> disbursementBatchVos = V2DisbursementController.getAllDisbursementBatchList("waiting");
		todoEntity.setDisburseTodoList(disbursementBatchVos);
		
		//查询待退款列表
		 List<V2BalanceVo> reimburses = V2ReimbursementController.getAllList("processing");
		 todoEntity.setReimburseTodoList(reimburses);
		 
		
		getRequest().setAttribute("todoList", todoEntity.getTodoList());
		getRequest().setAttribute("todoSize", todoEntity.getTodoList().size());
		return "ybl/v2/admin/factor/factorIndex";
	}
	
	
	
	
	
    
    
    

	// 重置密码页面
	@RequestMapping("/resetPassword.htm")
	public String toResetPassword() {
		return "ybl/admin/index/resetPassword";
	}

	/**
	 * 根据条件查询账款信息
	 * 
	 * @param pageVo
	 *            分页参数
	 * @param map
	 *            查询参数
	 */
	@SuppressWarnings("rawtypes")
	private void queryList(PageVo<?> pageVo, Map<String, String> map) {
		
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("paramter", map);
		maps.put("page", pageVo);
		maps.put("sign", "queryList");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("V2AccountsReceivableManage", maps);
		isSuccess(result);
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage = output.getString("page");
				String records = output.getString("result");
				pageVo = (PageVo<?>) JSONObject.parseObject(jsonPage, PageVo.class);
				List<Map> list = new ArrayList<>();
				list = JsonUtils.toList(records, Map.class);
				getRequest().setAttribute("list", list);
				getRequest().setAttribute("page", pageVo);
				super.log.error("根据条件查询账款调用queryList服务返回成功，信息：" + list);
			} else {
				super.log.error("根据条件查询账款调用queryList服务返回失败，信息：" + erortx);
			}
		}
	}
	
	
}
