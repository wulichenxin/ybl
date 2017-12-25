package com.bpm.framework.controller.v4.enterprise;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.sunline.framework.controller.vo.AttachmentVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v4.PlatformConfigFree;
import cn.sunline.framework.controller.vo.v4.drools.StockHolderVO;
import cn.sunline.framework.controller.vo.v4.drools.V4BusinessAuthVO;
import cn.sunline.framework.controller.vo.v4.factor.AccountsReceivableElementsVo;
import cn.sunline.framework.controller.vo.v4.factor.ContractQuotaV4Vo;
import cn.sunline.framework.controller.vo.v4.factor.FactorCollectionManagementRepaymentPlanVo;
import cn.sunline.framework.controller.vo.v4.factor.FactorLoanManagementLoanBatchSettlementVo;
import cn.sunline.framework.controller.vo.v4.factor.FactorLoanManagementLoanPendingVo;
import cn.sunline.framework.controller.vo.v4.factor.FactorLoanManagementPaymentBatchVo;
import cn.sunline.framework.controller.vo.v4.factor.FactorRiskManagementFinalAuditVo;
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
import com.bpm.framework.controller.v4.supplier.settlement.RePaymentVo;
import com.bpm.framework.utils.json.JsonUtils;

/**
 * 云保理4.0放款综合查询
 */
@Controller
@RequestMapping({ "/enterpriseLoanapplicationcontroller" })
@ValidateSession(validate = false)
public class EnterpriseLoanapplicQueryController extends AbstractController {

	private static final long serialVersionUID = -2809460978768158852L;

	@ValidateSession(validate = false)
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/list.htm")
	public String list(IntegerQueryVO financinapply,PageVo pageVo) {
		Map<String, Object> maps = new HashMap<String, Object>();
//		获取当前登录用户的企业id作为查询过滤条件
		UserVo userVo = ControllerUtils.getCurrentUser();
		Long enterpriseid;
        enterpriseid=userVo.getBusinessId();
        financinapply.setEnterprise_id(enterpriseid);
        financinapply.setIs_enterprise("1");
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
		return "ybl4.0/admin/enterprise/list";	
	}
	

}
