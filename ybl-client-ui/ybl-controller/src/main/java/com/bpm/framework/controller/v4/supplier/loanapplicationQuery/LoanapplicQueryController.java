package com.bpm.framework.controller.v4.supplier.loanapplicationQuery;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.sunline.framework.controller.vo.AttachmentVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v4.drools.StockHolderVO;
import cn.sunline.framework.controller.vo.v4.drools.V4BusinessAuthVO;
import cn.sunline.framework.controller.vo.v4.factor.AccountsPayableElementsVo;
import cn.sunline.framework.controller.vo.v4.factor.AccountsReceivableElementsVo;
import cn.sunline.framework.controller.vo.v4.factor.BillElementsVo;
import cn.sunline.framework.controller.vo.v4.factor.ContractQuotaV4Vo;
import cn.sunline.framework.controller.vo.v4.factor.FactorCollectionManagementRepaymentPlanVo;
import cn.sunline.framework.controller.vo.v4.factor.FactorLoanManagementLoanBatchSettlementVo;
import cn.sunline.framework.controller.vo.v4.factor.FactorLoanManagementLoanPendingVo;
import cn.sunline.framework.controller.vo.v4.factor.FactorLoanManagementPaymentBatchVo;
import cn.sunline.framework.controller.vo.v4.factor.FactorRiskManagementFinalAuditVo;
import cn.sunline.framework.controller.vo.v4.factor.PlatformAuditRecordVo;
import cn.sunline.framework.controller.vo.v4.factor.PlatformConfigFreeVo;
import cn.sunline.framework.controller.vo.v4.factor.enums.E_V4_ATTACHMENT_CATEGORY;
import cn.sunline.framework.controller.vo.v4.factor.enums.E_V4_ATTACHMENT_TYPE;
import cn.sunline.framework.controller.vo.v4.supplier.AccountsPayableVO;
import cn.sunline.framework.controller.vo.v4.supplier.AccountsReceivableV4VO;
import cn.sunline.framework.controller.vo.v4.supplier.ApplicantFinancialSituationVO;
import cn.sunline.framework.controller.vo.v4.supplier.BillVO;
import cn.sunline.framework.controller.vo.v4.supplier.ExternalGuaranteeSituationVO;
import cn.sunline.framework.controller.vo.v4.supplier.FinancingApplyVO;
import cn.sunline.framework.controller.vo.v4.supplier.IntegerQueryVO;
import cn.sunline.framework.controller.vo.v4.supplier.LoanApply;
import cn.sunline.framework.controller.vo.v4.supplier.LoanDebtSituationVO;
import cn.sunline.framework.controller.vo.v4.supplier.LoanapplyChildrenQueryVO;
import cn.sunline.framework.controller.vo.v4.supplier.PlatformConfigFree;
import cn.sunline.framework.controller.vo.v4.supplier.RepaymentPlanVO;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.annotation.ValidateSession;
import com.bpm.framework.bootstrap.page.Page;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.controller.v4.common.LoanApplyCommonApi;
import com.bpm.framework.controller.v4.supplier.settlement.RePaymentVo;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.json.JsonUtils;

/**
 * 云保理4.0放款综合查询
 */
@Controller
@RequestMapping({ "/loanapplicationcontroller" })
@ValidateSession(validate = true)
public class LoanapplicQueryController extends AbstractController {

	private static final long serialVersionUID = -2809460978768158852L;
	@Autowired
	private LoanApplyCommonApi  loanapplycommonapi;
	@ValidateSession(validate = true)
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/list.htm")
	public String list(IntegerQueryVO financinapply,PageVo pageVo) {
		UserVo userVo = ControllerUtils.getCurrentUser();
		Long  enterpriseid=userVo.getBusinessId();	
		financinapply.setEnterprise_id(enterpriseid);
		financinapply.setAuth_type(1);
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("loanappliction", financinapply);
		maps.put("page", pageVo);
		maps.put("sign", "loanapplicationQuery");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("LoanApplicationQuery",
				maps);
		PageVo page = null;
		List<IntegerQueryVO> list = null;
       if(result!=null  &&!"".equals(result)){
    	   if (result.getSys() != null) {
   			String status = result.getSys().getStatus();
   			String erortx = result.getSys().getErortx();// 错误信息
   			if ("S".equals(status)) {// 交易成功
   				JSONObject output = (JSONObject) result.getOutput();
   				String jsonPage = output.getString("page");
   				String records = output.getString("loanapplic");
   				page = (PageVo<?>) JSONObject.parseObject(jsonPage,
   						PageVo.class);
				list=JsonUtils.toList(records,IntegerQueryVO.class);
				page.setRecords(list);
   				getRequest().setAttribute("page", page);
   				getRequest().setAttribute("financinapply", financinapply);
   			}
   		}
		}
		return "ybl4.0/admin/supplier/loanapplicationQuery/list";	
	}
	
	
	//放款综合查询查询子订单，即每一笔子融资订单对应的所有的放款计划
	@ValidateSession(validate = true)
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/getlist")
	@ResponseBody
	public ControllerResponse getChildrenList(Long id,String type) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id_", id);
		//进行筛选，如果是核心企业，则进行right_business_id 进行过滤，得到线上确权的放款定单
		if(type!=null&&type.equals("1")){
			UserVo userVo = ControllerUtils.getCurrentUser();
			Long  bussinessid=userVo.getBusinessId();	
			map.put("right_business_id", bussinessid);			
		}
		map.put("sign", "loanapplicationQueryChildren");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("LoanApplicationQuery",
				map);
		List<LoanapplyChildrenQueryVO> list = new ArrayList<LoanapplyChildrenQueryVO>();
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String lists = output.getString("loanlist");
				list = JsonUtils.toList(lists, LoanapplyChildrenQueryVO.class);
			}
		}
		response.setObject(list);
		response.setResponseType(ResponseType.SUCCESS);
		return response;

	}
	
	
	
	/**
	 * 放款综合查询根据ID查询出竞标信息及详情页签信息 1、资料详情2、申请人信息
	 * 
	 * @return
	 */
	/**
	 * 
	 * @param id
	 * @param orderno
	 * @param batchid
	 * @param subid
	 * @param financingAmount
	 * @param financingstatus
	 * @param type
	 * @param attribute1
	 * @param attribute2
	 * @return
	 */
	@ValidateSession(validate = true)
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/view.htm")
	public String details(@Param("id") Long id,@Param("orderno") String orderno,@Param("batchid") Long batchid,@Param("subid") Long subid,@Param("financingAmount")String financingAmount,@Param("financingstatus") String financingstatus,@Param("type") String type,@Param("attribute1") String attribute1,@Param("attribute2") String attribute2,@Param("isenterprise") String isenterprise) {

		getRequest().setAttribute("id", id);
		getRequest().setAttribute("orderno", orderno);
		getRequest().setAttribute("batchid", batchid);
		getRequest().setAttribute("subid", subid);
		getRequest().setAttribute("financingAmount", financingAmount);
		getRequest().setAttribute("type", type);
		
		if(financingstatus==null||financingstatus==""){
			getRequest().setAttribute("financingstatus", 0);
		}else{
			getRequest().setAttribute("financingstatus", Integer.valueOf(financingstatus));
		}
		
		if(attribute1==null||attribute1==""){
			getRequest().setAttribute("attribute1", 0);
		}else{
			getRequest().setAttribute("attribute1", Integer.valueOf(attribute1));
		}
		if(attribute2==null||attribute2==""){
			getRequest().setAttribute("attribute2", 0);
		}else{
			getRequest().setAttribute("attribute2", Integer.valueOf(attribute2));
		}
		if(isenterprise.equals("enterprise")){
			getRequest().setAttribute("url", "/enterpriseLoanapplicationcontroller/list.htm");

		}else{
			getRequest().setAttribute("url", "/loanapplicationcontroller/list.htm");			
		}
		
		return "ybl4.0/admin/supplier/loanapplicationQuery/view";
	}
	

	
	

	
	

	
	
	

	
	

}
