package com.bpm.framework.controller.loanManage;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
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

import cn.sunline.framework.controller.vo.AttachmentVo;
import cn.sunline.framework.controller.vo.DisbursementRecordVo;
import cn.sunline.framework.controller.vo.DrawbackLineRecordVo;
import cn.sunline.framework.controller.vo.DrawbackRecordVo;
import cn.sunline.framework.controller.vo.EnterpriseVo;
import cn.sunline.framework.controller.vo.FinanceApplyVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.RepaymentLineRecordVo;
import cn.sunline.framework.controller.vo.RepaymentPlanVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.VoucherVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

@Controller
@RequestMapping({"/loanController"})
public class LoanController extends AbstractController {

    /**
     *保理端贷款管理controller
     */
    private static final long serialVersionUID = -2809460978768158852L;

  //查询还款管理
    @RequestMapping({"/queryAllLoan"})
    public String queryAll(String name,String number,String repayStatus , PageVo pageVo){
    	UserVo user = ControllerUtils.getCurrentUser();
		if(user == null){
			super.log.error("请先登录");
			return "/ybl/admin/index/login";
		}
		Map<String,String> map = new HashMap<String,String>();
		map.put("enterprise_name", name);
		map.put("number_", number);
		map.put("repayment_status", repayStatus);
		map.put("enterprise_id", user.getEnterpriseId().toString());
		Map<String,Object> maps = new HashMap<String,Object>();
		maps.put("paramter", map);
		maps.put("page", pageVo);
		maps.put("sign", "queryLoanList");//所调用的服务中的方法		
		ResBody result = TradeInvokeUtils.invoke("FacterLoanManagement", maps);					
		PageVo page=null;
		
		isSuccess(result);
 		if(result.getSys()!=null){
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();//错误信息	
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("result");
				page=(PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
				List<Map> list= new ArrayList<>();
				list = JsonUtils.toList(records, Map.class);
				getRequest().setAttribute("list", list);
				super.log.error("根据条件查询还款调用queryLoanList服务返回成功，信息："+list);
			}else{
				super.log.error("根据条件查询还款调用queryLoanList服务返回失败，信息："+erortx);
				return null;
			}			
		}
 		getRequest().setAttribute("name", name);
 		getRequest().setAttribute("number", number);
 		getRequest().setAttribute("repayStatus", repayStatus);
		getRequest().setAttribute("page", page);
		
        return "ybl/admin/factor/loan/repayManage";
    }
    
    
  //查询逾期管理
    @RequestMapping({"/queryAllOverdue"})
    public String queryAllOverdue(String name,String number,String isOverdue ,String minDays, String maxDays, PageVo pageVo){
    	UserVo user = ControllerUtils.getCurrentUser();
		if(user == null){
			super.log.error("请先登录");
			return "/ybl/admin/index/login";
		}
    	Map<String,String> map = new HashMap<String,String>();
		map.put("enterprise_name", name);
		map.put("number_", number);
		map.put("isOverdue", isOverdue);
		map.put("minDays", minDays);
		map.put("maxDays", maxDays);
		map.put("enterprise_id", user.getEnterpriseId().toString());
		Map<String,Object> maps = new HashMap<String,Object>();
		maps.put("paramter", map);
		maps.put("page", pageVo);
		maps.put("sign", "queryLoanList");//所调用的服务中的方法		
		ResBody result = TradeInvokeUtils.invoke("FacterLoanManagement", maps);					
		PageVo page=null;
		
		isSuccess(result);
 		if(result.getSys()!=null){
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();//错误信息	
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("result");
				page=(PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
				List<Map> list= new ArrayList<>();
				list = JsonUtils.toList(records, Map.class);
				getRequest().setAttribute("list", list);
				super.log.error("根据条件查询逾期调用queryLoanList服务返回成功，信息："+list);
			}else{
				super.log.error("根据条件查询逾期调用queryLoanList服务返回失败，信息："+erortx);
				return null;
			}			
		}
 		getRequest().setAttribute("name", name);
 		getRequest().setAttribute("number", number);
 		getRequest().setAttribute("isOverdue", isOverdue);
 		getRequest().setAttribute("minDays", minDays);
 		getRequest().setAttribute("maxDays", maxDays);
		getRequest().setAttribute("page", page);
		
        return "ybl/admin/factor/loan/overdueManage";
    }
    
    //项目管理
    @RequestMapping({"/queryAllProject"})
    public String queryAllProject(String name,String number,String repayStatus , PageVo pageVo){
    	UserVo user = ControllerUtils.getCurrentUser();
		if(user == null){
			super.log.error("请先登录");
			return "/ybl/admin/index/login";
		}
    	Map<String,String> map = new HashMap<String,String>();
		map.put("enterprise_name", name);
		map.put("number_", number);
		map.put("status_", repayStatus);
		map.put("enterprise_id", user.getEnterpriseId().toString());
		Map<String,Object> maps = new HashMap<String,Object>();
		maps.put("paramter", map);
		maps.put("page", pageVo);
		maps.put("sign", "queryLoanList");//所调用的服务中的方法		
		ResBody result = TradeInvokeUtils.invoke("FacterLoanManagement", maps);					
		PageVo page=null;
		
		isSuccess(result);
 		if(result.getSys()!=null){
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();//错误信息	
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("result");
				page=(PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
				List<Map> list= new ArrayList<>();
				list = JsonUtils.toList(records, Map.class);
				getRequest().setAttribute("list", list);
				super.log.error("根据条件查询项目管理调用queryLoanList服务返回成功，信息："+list);
			}else{
				super.log.error("根据条件查询项目管理调用queryLoanList服务返回失败，信息："+erortx);
				return null;
			}			
		}
 		getRequest().setAttribute("name", name);
 		getRequest().setAttribute("number", number);
 		getRequest().setAttribute("repayStatus", repayStatus);
		getRequest().setAttribute("page", page);
		
        return "ybl/admin/factor/loan/projectManage";
    }
    
  //查询退款管理
    @RequestMapping({"/queryAllDrawback"})
    public String queryAllDrawback(String name,String number,String drawback_status , PageVo pageVo){
    	UserVo user = ControllerUtils.getCurrentUser();
		if(user == null){
			super.log.error("请先登录");
			return "/ybl/admin/index/login";
		}
    	Map<String,String> map = new HashMap<String,String>();
		map.put("enterprise_name", name);
		map.put("number_", number);
		map.put("drawback_status", drawback_status);
		map.put("enterprise_id", user.getEnterpriseId().toString());
		Map<String,Object> maps = new HashMap<String,Object>();
		maps.put("paramter", map);
		maps.put("page", pageVo);
		maps.put("sign", "queryLoanList");//所调用的服务中的方法		
		ResBody result = TradeInvokeUtils.invoke("FacterLoanManagement", maps);					
		PageVo page=null;
		
		isSuccess(result);
 		if(result.getSys()!=null){
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();//错误信息	
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("result");
				page=(PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
				List<Map> list= new ArrayList<>();
				list = JsonUtils.toList(records, Map.class);
				getRequest().setAttribute("list", list);
				super.log.error("根据条件查询还款调用queryLoanList服务返回成功，信息："+list);
			}else{
				super.log.error("根据条件查询还款调用queryLoanList服务返回失败，信息："+erortx);
				return null;
			}			
		}
 		getRequest().setAttribute("name", name);
 		getRequest().setAttribute("number", number);
 		getRequest().setAttribute("drawback_status", drawback_status);
		getRequest().setAttribute("page", page);
		
        return "ybl/admin/factor/loan/drawbackManage";
    }
    
    
    /**
     * 还款功能的实现
     */
    
    
    /**
	 * 查询还款页面详情 、 查询退款页面详情
	 * 
	 * @param request
	 * @param id 融资申请id
	 * @return
	 */
	@RequestMapping(value={"/getRepaymentDetail","getDrawbackDetail"})
	public String getPayDetail(HttpServletRequest request, String id) {
		
		String uri = request.getRequestURI();
		String retUrl = "ybl/admin/factor/loan/repaymentDetail";//还款详情
		
		if(uri.contains("getDrawbackDetail")){
			retUrl = "ybl/admin/factor/loan/drawbackDetail";//退款详情
		}

		Map<String, Object> input = new HashMap<String, Object>();
		Map<String, Object> paramter = new HashMap<String, Object>();
		if (StringUtils.isNullOrBlank(id)) {
			return retUrl; 
		}
		paramter.put("id_", id);
		input.put("paramter", paramter);
		input.put("sign", "getRepaymentDetail");

		// 调用服务
		ResBody resBody = TradeInvokeUtils.invoke("FacterLoanManagement", input);

		EnterpriseVo enterprise = null;    //供应商企业
		EnterpriseVo coreEnterprise = null; //核心企业
		FinanceApplyVo financeApply = null; //融资申请
		List<VoucherVo> voucherList = null; //融资凭证列表
		DisbursementRecordVo disbursementRecord = null; //放款主表
		RepaymentPlanVo repayLoanPlan = null; //还款主表
		DrawbackRecordVo drawbackRecord = null; //退款主表
		

		if (super.isSuccess(resBody)) {
			JSONObject output = (JSONObject) resBody.getOutput();
			JSONObject result = output.getJSONObject("result");
			//  供应商
			if (StringUtils.isNotEmpty(result.getString("enterprise"))) {
				enterprise = JsonUtils.toObject(result.getString("enterprise"), EnterpriseVo.class);
			}
			
			// 核心企业
			if (StringUtils.isNotEmpty(result.getString("coreEnterprise"))) {
				coreEnterprise = JsonUtils.toObject(result.getString("coreEnterprise"), EnterpriseVo.class);
			}

			//  融资申请
			if (StringUtils.isNotEmpty(result.getString("financeApply"))) {
				financeApply = JsonUtils.toObject(result.getString("financeApply"), FinanceApplyVo.class);
			}
			
			//  融资凭证材料
			if (StringUtils.isNotEmpty(result.getString("voucherList"))) {
				voucherList = JsonUtils.toList(result.getString("voucherList"), VoucherVo.class);
			}
			
			//  放款主表
			if (StringUtils.isNotEmpty(result.getString("disbursementRecord"))) {
				disbursementRecord = JsonUtils.toObject(result.getString("disbursementRecord"), DisbursementRecordVo.class);
			}
			
			//  还款主表
			if (StringUtils.isNotEmpty(result.getString("repayLoanPlan"))) {
				repayLoanPlan = JsonUtils.toObject(result.getString("repayLoanPlan"), RepaymentPlanVo.class);
			}
			
		    //  退款主表
			if (StringUtils.isNotEmpty(result.getString("drawbackRecord"))) {
				drawbackRecord = JsonUtils.toObject(result.getString("drawbackRecord"), DrawbackRecordVo.class);
			}
			
		}

		
		BigDecimal sum=new BigDecimal(0.0);
		if(CollectionUtils.isNotEmpty(voucherList)){
			for (int i=0;i<voucherList.size();i++){
				sum = sum.add(voucherList.get(i).getAmount());
			}
		}
		request.setAttribute("sum",sum);
		request.setAttribute("enterprise", enterprise);
		request.setAttribute("coreEnterprise", coreEnterprise);
		request.setAttribute("financeApply", financeApply);
		request.setAttribute("voucherList", voucherList);
		request.setAttribute("disbursementRecord", disbursementRecord);
		request.setAttribute("repayLoanPlan", repayLoanPlan);
		request.setAttribute("drawbackRecord", drawbackRecord);
		return retUrl;

	}
	
	
	
	//保存还款记录
	@RequestMapping({ "/saveRepayment" })
	@ResponseBody
	public ControllerResponse saveDisbursement(RepaymentLineRecordVo repaymentLineRecordVo,String attachmentArray ) {
		ControllerResponse response = new ControllerResponse(ResponseType.FAILURE);
		
		Map<String, Object> condition = new HashMap<String, Object>();
		ControllerUtils.setWho(repaymentLineRecordVo);
		UserVo user = ControllerUtils.getCurrentUser();
		if(null==user){
			response.setResponseType(ResponseType.FAILURE, "请先登录！");
			return response;
		}
		repaymentLineRecordVo.setEnterpriseId(user.getEnterpriseId());
		
		
		//附件信息
		List<AttachmentVo> attachList = new ArrayList<AttachmentVo>();
		if(StringUtils.isNotEmpty(attachmentArray)){
			String[] str = attachmentArray.split("#");
			for (int i = 0; i < str.length; i++) {
				AttachmentVo attache = JsonUtils.toObject(str[i], AttachmentVo.class);
				ControllerUtils.setWho(attache);
				attache.setEnterpriseId(user.getEnterpriseId());
				attachList.add(attache);
			}
		}
		
		condition.put("repaymentLineRecord", repaymentLineRecordVo);//行表
		condition.put("attachList", attachList);  //附件
		
		Map<String, Object> req = new HashMap<String, Object>();
		req.put("paramter", condition);
		req.put("sign", "saveDisbursement");
		ResBody result = TradeInvokeUtils.invoke("FacterLoanManagement", req);
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			JSONObject output = (JSONObject) result.getOutput();
			String records = output.getString("result");
			if ("S".equals(status) && Boolean.parseBoolean(records)) {
				response.setInfo(I18NUtils.getText("sys.client.operationSuccess"));
				response.setResponseType(ResponseType.SUCCESS);
			}else{
				response.setResponseType(ResponseType.FAILURE);
			}
		}

		return response;
	}
	
	
	//保存退款记录
		@RequestMapping({ "/saveDrawback" })
		@ResponseBody
		public ControllerResponse saveDrawback(DrawbackRecordVo drawbackRecordVo,DrawbackLineRecordVo drawbackLineRecordVo,String attachmentArray ) {
			ControllerResponse response = new ControllerResponse(ResponseType.FAILURE);
			
			Map<String, Object> condition = new HashMap<String, Object>();
			 
			ControllerUtils.setWho(drawbackRecordVo);
			ControllerUtils.setWho(drawbackLineRecordVo);
			UserVo user = ControllerUtils.getCurrentUser();
			if(null==user){
				response.setResponseType(ResponseType.FAILURE, "请先登录！");
				return response;
			}
			
			drawbackRecordVo.setEnterpriseId(user.getEnterpriseId());
			drawbackLineRecordVo.setEnterpriseId(user.getEnterpriseId());
			//主表需要计算：
			//1）融资申请id
			
			//行表需要写入：
			//1）支付时间
			//2）备注
			//3）本次付款金额
			
			//附件信息
			List<AttachmentVo> attachList = new ArrayList<AttachmentVo>();
			if(StringUtils.isNotEmpty(attachmentArray)){
				String[] str = attachmentArray.split("#");
				for (int i = 0; i < str.length; i++) {
					AttachmentVo attache = JsonUtils.toObject(str[i], AttachmentVo.class);
					ControllerUtils.setWho(attache);
					attache.setEnterpriseId(user.getEnterpriseId());
					attachList.add(attache);
				}
			}
			
			condition.put("drawbackRecord", drawbackRecordVo);       //主表
			condition.put("drawbackLineRecordVo", drawbackLineRecordVo);//行表
			condition.put("attachList", attachList);  //附件
			
			Map<String, Object> req = new HashMap<String, Object>();
			req.put("paramter", condition);
			req.put("sign", "saveDrawback");
			ResBody result = TradeInvokeUtils.invoke("FacterLoanManagement", req);
			if (result.getSys() != null) {
				String status = result.getSys().getStatus();
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				if ("S".equals(status) && Boolean.parseBoolean(records)) {
					response.setInfo(I18NUtils.getText("sys.client.operationSuccess"));
					response.setResponseType(ResponseType.SUCCESS);
				}else{
					response.setResponseType(ResponseType.FAILURE);
				}
			}

			return response;
		}
	
	
	
	
    
}
