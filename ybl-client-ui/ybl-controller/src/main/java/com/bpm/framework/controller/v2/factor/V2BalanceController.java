package com.bpm.framework.controller.v2.factor;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.annotation.Log;
import com.bpm.framework.annotation.OperationType;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.common.ConfigCache;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.date.DateUtils;
import com.bpm.framework.utils.file.ExcelUtils;
import com.bpm.framework.utils.file.ResponseDownloadUtils;
import com.bpm.framework.utils.i18n.I18NUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v2.TConfig;
import cn.sunline.framework.controller.vo.v2.V2BalanceVo;
import cn.sunline.framework.controller.vo.v2.V2BuybackLineRecordVo;
import cn.sunline.framework.controller.vo.v2.V2ReimburseLineRecordVo;
import cn.sunline.framework.controller.vo.v2.V2RepaymentLineRecordVo;
import cn.sunline.framework.controller.vo.v2.V2RepaymentRecordVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 
 * 平台对账-控制器
 *
 */
@Controller
@RequestMapping({"/v2BalanceController"})
public class V2BalanceController extends AbstractController{

	private static final long serialVersionUID = -3638148272520531721L;
	
	/**
	 * 跳转到结算详情页面
	 * 结算详情页面有：回款详情;回购详情;退款详情
	 * @param id 应收账款id
	 * @return
	 */
	@RequestMapping({"/buybackEdit.htm-{ID}","/reimbursementEdit.htm-{ID}","/singleRepaymentEdit.htm-{ID}"})
	public String getBalanceDetail(@PathVariable("ID") Long id){
		
		String uri = getRequest().getRequestURI();
		
		String retUri = "ybl/404";
		
		//回购详情
		if(uri.contains("buybackEdit.htm")){
			retUri = "ybl/v2/admin/factor/balance/buy_back";
		}
		//退款详情
		else if(uri.contains("reimbursementEdit.htm")){
			retUri = "ybl/v2/admin/factor/balance/refund";
		}
		//退款详情
		else if(uri.contains("singleRepaymentEdit.htm")){
			retUri = "ybl/v2/admin/factor/balance/single_payment";
		}
		else {
			return retUri;  //不支持的页面
		}
		
		V2BalanceVo balanceVo = new V2BalanceVo();
		
		balanceVo.setId(id);
		
		Map<String, Object> input = new HashMap<String, Object>();
		
		UserVo curUser = ControllerUtils.getCurrentUser( );
		balanceVo.setEnterpriseId(curUser.getEnterpriseId()); //设置企业id
		
		ControllerUtils.setWho(balanceVo);
		
		input.put("paramter", balanceVo);
		
		input.put("sign", "getBalanceDetail");
		
		ResBody resBody = TradeInvokeUtils.invoke("V2BalanceManagement", input);
		// 调用服务
		List<V2RepaymentLineRecordVo> resultList = null;
		V2RepaymentRecordVo repaymentRecord = null;
		V2BalanceVo balance = null;
		List<V2BuybackLineRecordVo> buybackList = null;
		List<V2ReimburseLineRecordVo> reimburseList = null;
		
		if (super.isSuccess(resBody)) {
			
			JSONObject output = (JSONObject) resBody.getOutput();
			JSONObject result = output.getJSONObject("result");
			// 回款主表
			if (StringUtils.isNotEmpty(result.getString("repaymentRecord"))) {
				repaymentRecord = JsonUtils.toObject(result.getString("repaymentRecord"), V2RepaymentRecordVo.class);
			}
			
			//回款记录列表
			if (StringUtils.isNotEmpty(result.getString("repaymentLineRecord"))) {
				resultList = JsonUtils.toList(result.getString("repaymentLineRecord"), V2RepaymentLineRecordVo.class);
			}
			
			//结算对象-综合查询
			if (StringUtils.isNotEmpty(result.getString("balance"))) {
				balance = JsonUtils.toObject(result.getString("balance"), V2BalanceVo.class);
			}
			
			//回购行表
			if (StringUtils.isNotEmpty(result.getString("buybackLineRecord"))) {
				buybackList = JsonUtils.toList(result.getString("buybackLineRecord"), V2BuybackLineRecordVo.class);
			}
			
			//退款行表
			if (StringUtils.isNotEmpty(result.getString("reimburseLineRecord"))) {
				reimburseList = JsonUtils.toList(result.getString("reimburseLineRecord"), V2ReimburseLineRecordVo.class);
			}
		}

		getRequest().setAttribute("resultList", resultList);             //回款记录列表
		getRequest().setAttribute("repaymentRecord",repaymentRecord);    //回款主表
		getRequest().setAttribute("buybackList", buybackList);           //回购行表记录列表
		getRequest().setAttribute("balance",balance);                    //回购主表
		getRequest().setAttribute("reimburseList", reimburseList);       //退款行表记录列表
		
		return retUri;
	}
	
	
	
	/**
	 * 结算综合查询
	 * 参数：balanceVo
	 * @param supplierEnterpriseName 供应商企业
	 * @param coreEnterpriseName 核心企业
	 * @param voucherNumber 凭证编号
	 * @param repaymentStatus 还款状态
	 * @param buybackStatus 回购状态
	 * @param reimbursedStatus 退款状态
	 * @param attribute1_ 计划回款日-开始
	 * @param attribute2_ 计划回款日-结束
	 * @param attribute3_ 回购日期-开始
	 * @param attribute4_ 回购日期-结束
	 * @param attribute5_ 还款日-开始
	 * @param attribute6_ 还款日-结束
	 * @param attribute7_ 查询类型:1)buyback;2)reimburse
	 * @param attribute8_ 结算日-开始
	 * @param attribute9_ 结算日-结束
	 * @return
	 */
	@RequestMapping({"/queryBuyBackList.htm ","/queryRefundProcessList.htm","/queryPlatformReconList.htm"})
	public String queryBuyBackList(V2BalanceVo balanceVo,PageVo<?> pageVo){
		
		String uri = getRequest().getRequestURI();
		String retUri = "ybl/404";
		//查询回购列表
		if(uri.contains("queryBuyBackList.htm")){
			balanceVo.setAttribute7("buyback");   //查询回购列表
			retUri = "ybl/v2/admin/factor/balance/supplier_buyback";
		}
		//查询退款列表
		else if(uri.contains("queryRefundProcessList.htm")){
			balanceVo.setAttribute7("reimburse");   //查询退款列表
			retUri = "ybl/v2/admin/factor/balance/refund_process";
		}
		//查询平台对账
		else if(uri.contains("/queryPlatformReconList.htm")){
			balanceVo.setAttribute7("buyback");   //结算完成后的列表（结算完成后就会创建回购表）
			retUri = "ybl/v2/admin/factor/balance/platform_reconciliation";
		}
		else{
			return retUri;
		}
		
		Map<String, Object> input = new HashMap<String, Object>();
		UserVo curUser = ControllerUtils.getCurrentUser( );
		balanceVo.setEnterpriseId(curUser.getEnterpriseId()); //设置企业id
		ControllerUtils.setWho(balanceVo);
		input.put("paramter", balanceVo);
		input.put("page", pageVo);
		input.put("sign", "queryBalanceList");
		
		ResBody resBody = TradeInvokeUtils.invoke("V2BalanceManagement", input);
		// 调用服务
		PageVo<?> page = null;
		List<V2BalanceVo> resultList = null;
		if (super.isSuccess(resBody)) {
			
			JSONObject output = (JSONObject) resBody.getOutput();
			page = JsonUtils.toObject(output.getString("page"), PageVo.class);
			String reult = output.getString("result");
			resultList = JsonUtils.toList(reult, V2BalanceVo.class);
		}

		getRequest().setAttribute("resultList", resultList);
		getRequest().setAttribute("page", page!=null?page:pageVo);
		getRequest().setAttribute("paramters", balanceVo); 
		
		return retUri;
	}
	
	/**
	 * 批量导出文件-平台对账
	 * @param request
	 * @param response
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping({" /exportAll "})
	@Log(operation=OperationType.Exe,info="批量导出平台对账文件")
	public void exportAll(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		//平台对账
		String title = I18NUtils.getText("sys.v2.client.platform.recon");
		String []columnTitles = {
				I18NUtils.getText("sys.v2.client.no"),                   //序号
				I18NUtils.getText("sys.v2.client.supplier"),             //供应商
				I18NUtils.getText("sys.v2.client.core.enterprise"),      //企业
				I18NUtils.getText("sys.v2.client.account.voucher"),      //账款凭证
				I18NUtils.getText("sys.v2.client.amount.receivable"),    //应收金额
				I18NUtils.getText("sys.v2.client.settlementAmount"),     //结算金额
				I18NUtils.getText("sys.v2.client.settlement.date"),      //结算日期
				I18NUtils.getText("sys.v2.client.platform.user.fee")    //平台使用费
		};
		
		//构造数据
		List<V2BalanceVo> resultList = getAllList();
		List<String[]> dataList = new ArrayList<String[]>();
		int row = 1;
		for(V2BalanceVo record:resultList){
			int col = 0;
			String[] rowData = new String[columnTitles.length];
			rowData[col ++] = String.valueOf(row ++);
			rowData[col ++] = record.getSupplierEnterpriseName();
			rowData[col ++] = record.getCoreEnterpriseName();
			rowData[col ++] = record.getVoucherNumber();
			rowData[col ++] = record.getVoucherAmount().setScale(2, BigDecimal.ROUND_HALF_UP).toString();//应收金额
			rowData[col ++] = new BigDecimal((record.getVoucherAmount().doubleValue() * record.getSettlementRatio().doubleValue())/100).setScale(2, BigDecimal.ROUND_HALF_UP).toString();//结算金额  
			rowData[col ++] = DateUtils.toString(record.getDisbursementDate());
			rowData[col ++] = record.getManageFee().setScale(2, BigDecimal.ROUND_HALF_UP).toString();  
			dataList.add(rowData);
		}
		File file = ExcelUtils.simpleCreate(title, columnTitles, dataList);
		//火狐浏览器有点特殊
		String agent=request.getHeader("User-Agent").toLowerCase();
		boolean isFirefox = (agent.indexOf("firefox") > -1);		
		ResponseDownloadUtils.download(response, file, isFirefox);
		
	}
	
	/**
	 * 平台对账列表
	 * @return
	 */
	private List<V2BalanceVo> getAllList(){
		
		UserVo curUser = ControllerUtils.getCurrentUser();
		
		Map<String, Object> input = new HashMap<String, Object>();
		
		V2BalanceVo balanceVo = new V2BalanceVo();
		
		balanceVo.setEnterpriseId(curUser.getEnterpriseId()); //设置企业id
		
		balanceVo.setAttribute7("buyback");   //查询平台对账列表
		
		input.put("paramter", balanceVo);
		
		input.put("sign", "queryBalanceList");
		
		ResBody resBody = TradeInvokeUtils.invoke("V2BalanceManagement", input);
		// 调用服务
		List<V2BalanceVo> resultList = null;
		if (super.isSuccess(resBody)) {
			
			JSONObject output = (JSONObject) resBody.getOutput();
			String reult = output.getString("result");
			resultList = JsonUtils.toList(reult, V2BalanceVo.class);
		}
		
		return resultList!=null?resultList:new ArrayList<V2BalanceVo>();
		
	}
	
	/**
	 * 批量导出文件-供应商回购
	 * @param request
	 * @param response
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping({" /exportBuybackAll "})
	@Log(operation=OperationType.Exe,info="批量导出供应商回购文件")
	public void exportBuybackAll(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		//供应商回购
		String title = I18NUtils.getText("sys.v2.client.supplier.buyback");
		
		String []columnTitles = {
				I18NUtils.getText("sys.v2.client.no"),                   //序号
				I18NUtils.getText("sys.v2.client.supplier"),             //供应商
				I18NUtils.getText("sys.v2.client.core.enterprise"),      //企业
				I18NUtils.getText("sys.v2.client.account.voucher"),      //账款凭证
				I18NUtils.getText("sys.v2.client.plan.return.date"),     //计划回款日
				I18NUtils.getText("sys.v2.client.actual.return.date"),   //实际回款日
				I18NUtils.getText("sys.v2.client.buyback.date"),         //回购日期
				I18NUtils.getText("sys.v2.client.settlementAmount"),     //账款凭证
				I18NUtils.getText("sys.v2.client.amountOfMoneyBack"),    //回款金额（元）
				I18NUtils.getText("sys.v2.client.buyback.amount")+"("+I18NUtils.getText("sys.v2.client.element")+")",      //回购金额（元）
				I18NUtils.getText("sys.v2.client.repayment.status"),    //回款状态 
				I18NUtils.getText("sys.v2.client.buyback.status")      //回购状态
		};
				
		//构造数据
		List<V2BalanceVo> resultList = getAllList();
		List<String[]> dataList = new ArrayList<String[]>();
		int row = 1;
		for(V2BalanceVo record:resultList){
			int col = 0;
			String[] rowData = new String[columnTitles.length];
			rowData[col ++] = String.valueOf(row ++);
			rowData[col ++] = record.getSupplierEnterpriseName();
			rowData[col ++] = record.getCoreEnterpriseName();
			rowData[col ++] = record.getVoucherNumber();
			if(record!=null && record.getReturnDate()!=null){
				rowData[col ++] = DateUtils.toString(record.getReturnDate());
			}else{
				rowData[col ++] = "";
			}
			if(record!=null && record.getRealRepaymentDate()!=null){
				rowData[col ++] = DateUtils.toString(record.getRealRepaymentDate());
			}else{
				rowData[col ++] = "";
			}
			if(record!=null && record.getRealBuybackDate()!=null){
				rowData[col ++] = DateUtils.toString(record.getRealBuybackDate());
			}else{
				rowData[col ++] = "";
			}
			rowData[col ++] = ((record.getVoucherAmount().doubleValue() * record.getSettlementRatio().doubleValue())/100)+"";
			rowData[col ++] = record.getActualRepaymentAmount().setScale(2, BigDecimal.ROUND_HALF_UP).toString();
			rowData[col ++] = record.getActualBuybackAmount().setScale(2, BigDecimal.ROUND_HALF_UP).toString();
			TConfig config = ConfigCache.getByTypeCode("REPAYMENT_STATUS", record.getRepaymentStatus());
			rowData[col ++] = config.getValue();//回款状态
			config = ConfigCache.getByTypeCode("BUYBACK_STATUS", record.getBuybackStatus());
			rowData[col ++] = config.getValue();//回购状态
			dataList.add(rowData);
		}
		File file = ExcelUtils.simpleCreate(title, columnTitles, dataList);
		String agent=request.getHeader("User-Agent").toLowerCase();
		boolean isFirefox = (agent.indexOf("firefox") > -1);		
		ResponseDownloadUtils.download(response, file, isFirefox);
	}
	
}
