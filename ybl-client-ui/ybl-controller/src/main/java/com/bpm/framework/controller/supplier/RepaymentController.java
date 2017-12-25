package com.bpm.framework.controller.supplier;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.EnterpriseSignVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.RepaymentFinanceVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

@Controller
@RequestMapping({"/repaymentController"})
public class RepaymentController extends AbstractController {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7882704651125578624L;
	
	@RequestMapping({"/repayment"})
	public String repayment(RepaymentFinanceVo vo,PageVo<?> pagevo){
		
		UserVo user = ControllerUtils.getCurrentUser();
		if(null==user){
			return "ybl/admin/index/login";
		}
		vo.setEnterpriseId(user.getEnterpriseId());
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", vo);
		map.put("page", pagevo);
		map.put("sign", "queryRepanmentPlanByCondition");
		ResBody result = TradeInvokeUtils.invoke("RepaymentManagement", map);
		List<RepaymentFinanceVo> repaymentList = null;
		PageVo<?> page = null;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage = output.getString("page");
				String records = output.getString("result");
				page = JSONObject.parseObject(jsonPage, PageVo.class);
				repaymentList = JsonUtils.toList(records, RepaymentFinanceVo.class);
			}
		}
		
		getRequest().setAttribute("repaymentList", repaymentList);
		getRequest().setAttribute("page", page);
		getRequest().setAttribute("vo", vo);
		
		return "ybl/admin/supplier/finance/repayment";
	}
	
	@RequestMapping({"/advanceRepay"})
	public String advanceRepay(String applyId){
		
		if(StringUtils.isEmpty(applyId)){
			super.log.error("请选择一条数据");
			return "";
		}
		RepaymentFinanceVo vo = new RepaymentFinanceVo();
		vo.setFinanceApplyId(Long.parseLong(applyId));
		//获取当前用户id
		UserVo user = ControllerUtils.getCurrentUser();
		if(null==user){
			return "ybl/admin/index/login";
		}
		vo.setMemberId(user.getEnterpriseId());
		PageVo<?> page = new PageVo<>();
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("paramter", vo);
		map.put("sign", "queryRepanmentPlanByCondition");
		map.put("page", page);
		ResBody result = TradeInvokeUtils.invoke("RepaymentManagement", map);
		List<RepaymentFinanceVo> repaymentList = null;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage = output.getString("page");
				String records = output.getString("result");
				page = JSONObject.parseObject(jsonPage, PageVo.class);
				repaymentList = JsonUtils.toList(records, RepaymentFinanceVo.class);
			}
		}
		
		if(repaymentList==null || repaymentList.size()<1 ){
			super.log.error("查询数据出错");
			return "ybl/admin/supplier/finance/advanceRepay";
		}
		
		getRequest().setAttribute("repay", repaymentList.get(0));
		
		return "ybl/admin/supplier/finance/advanceRepay";
	}
	
	

}
