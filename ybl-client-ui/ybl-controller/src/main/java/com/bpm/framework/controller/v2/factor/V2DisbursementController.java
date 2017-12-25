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
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.annotation.Log;
import com.bpm.framework.annotation.OperationType;
import com.bpm.framework.annotation.ValidateSession;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.date.DateUtils;
import com.bpm.framework.utils.file.ExcelUtils;
import com.bpm.framework.utils.file.ResponseDownloadUtils;
import com.bpm.framework.utils.i18n.I18NUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v2.V2DisbursementBatchVo;
import cn.sunline.framework.controller.vo.v2.V2DisbursementRecordVo;
import cn.sunline.framework.controller.vo.v2.V2GenerateDisbursementBatchVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 
 * 放款管理控制器
 *
 */
@Controller
@ValidateSession(validate = true)
@RequestMapping({"/v2disbursementController"})
public class V2DisbursementController extends AbstractController{ 

	private static final long serialVersionUID = 1L;

	/**
	 * 需要生成带付款批次的列表
	 * 参数：
	 * @param enterpriseName 供应商 
	 * @param attribute1 审核日期（格式 yyyy-MM-dd)
	 * @return
	 */
	@RequestMapping({"/queryGenerateBatchList.htm"})
	public String queryGenerateBatchList(V2GenerateDisbursementBatchVo generateDisbursementBatchVo ,PageVo<?> pageVo){
		
		UserVo curUser = ControllerUtils.getCurrentUser();
		
		Map<String, Object> input = new HashMap<String, Object>();
		
		generateDisbursementBatchVo.setEnterpriseId(curUser.getEnterpriseId()); //设置企业id
		
		ControllerUtils.setWho(generateDisbursementBatchVo);
		
		generateDisbursementBatchVo.setEnterpriseId(curUser.getEnterpriseId());
		input.put("paramter", generateDisbursementBatchVo);
		
		input.put("page", pageVo);
		input.put("sign", "queryGenerateBatchList");
		
		ResBody resBody = TradeInvokeUtils.invoke("V2DisbursementManagement", input);
		// 调用服务
		PageVo<?> page = null;
		List<V2GenerateDisbursementBatchVo> resultList = null;
		if (super.isSuccess(resBody)) {
			JSONObject output = (JSONObject) resBody.getOutput();
			page = JsonUtils.toObject(output.getString("page"), PageVo.class);
			resultList = JsonUtils.toList(output.getString("result"), V2GenerateDisbursementBatchVo.class);
		}

		getRequest().setAttribute("resultList", resultList);
		getRequest().setAttribute("page", page!=null?page:pageVo);
		getRequest().setAttribute("paramters", generateDisbursementBatchVo); 
		return "ybl/v2/admin/factor/balance/generate_batch";
	}
	
	
	
	/**
	 * 查询待付款批次
	 * 参数：
	 * @param batchNumber 付款批次
	 * @param supplierEnterpriseName  供应商      
	 * @param 审核日期  attribute1
	 * @return
	 */
	@RequestMapping({"/queryDisbursementList.htm"})
	public String queryDisbursementList(V2DisbursementBatchVo disbursementBatchVo ,PageVo<?> pageVo){
		
		UserVo curUser = ControllerUtils.getCurrentUser();
		
		Map<String, Object> input = new HashMap<String, Object>();
		
		disbursementBatchVo.setStatus("waiting");
		
		disbursementBatchVo.setEnterpriseId(curUser.getEnterpriseId()); //设置企业id
		
		ControllerUtils.setWho(disbursementBatchVo);
		input.put("paramter", disbursementBatchVo);
		
		input.put("page", pageVo);
		input.put("sign", "queryDisbursementBatchList");
		
		ResBody resBody = TradeInvokeUtils.invoke("V2DisbursementManagement", input);
		// 调用服务
		PageVo<?> page = null;
		List<V2DisbursementBatchVo> resultList = null;
		
		if (resBody.getSys() != null) {
			String status = resBody.getSys().getStatus();
			if ("S".equals(status)) {// 交易成功
				
				JSONObject output = (JSONObject) resBody.getOutput();
				page = JsonUtils.toObject(output.getString("page"), PageVo.class);
				String reult = output.getString("result");
				resultList = JsonUtils.toList(reult, V2DisbursementBatchVo.class);
			}
		}
		
		getRequest().setAttribute("resultList", resultList);
		getRequest().setAttribute("page", page!=null?page:pageVo);
		getRequest().setAttribute("paramters", disbursementBatchVo); 
		return "ybl/v2/admin/factor/balance/disbursement_batch";
	}
	
	
	/**
	 * 结算详情页面
	 * 参数：
	 * @param batchNumber 批次编号
	 */
	@RequestMapping({"/getBalanceDetail.htm-{batchNumber}"})
	public String getBalanceDetail(@PathVariable("batchNumber")String batchNumber){
		
		Map<String, Object> input = new HashMap<String, Object>();
		
		UserVo curUser = ControllerUtils.getCurrentUser();
		
		V2DisbursementBatchVo disbursementBatchVo = new V2DisbursementBatchVo();
		
		disbursementBatchVo.setBatchNumber(batchNumber);
		
		disbursementBatchVo.setEnterpriseId(curUser.getEnterpriseId());
		
		input.put("paramter", disbursementBatchVo);
		
		input.put("sign", "getBalanceDetail");
		
		ResBody resBody = TradeInvokeUtils.invoke("V2DisbursementManagement", input);
		// 调用服务
		List<V2DisbursementRecordVo> resultList = null;
		V2DisbursementBatchVo disbursementBatch = null;  //付款批次
		
		if (super.isSuccess(resBody)) {
			
			JSONObject output = (JSONObject) resBody.getOutput();
			JSONObject result = output.getJSONObject("result");
			// 放款批次
			if (StringUtils.isNotEmpty(result.getString("disbursementBatch"))) {
				disbursementBatch = JsonUtils.toObject(result.getString("disbursementBatch"), V2DisbursementBatchVo.class);
			}
			
			//放款记录列表
			resultList = JsonUtils.toList(result.getString("disbursementRecord"), V2DisbursementRecordVo.class);
		}

		getRequest().setAttribute("resultList", resultList);             //放款记录列表
		getRequest().setAttribute("disbursementBatch",disbursementBatch); //付款批次
		return "ybl/v2/admin/factor/balance/balance_detail";
	}
	
	/**
	 * 查询批次凭证列表
	 * 参数：
	 * @param disbursementBatchId 付款批次id
	 * @return
	 */
	@RequestMapping({"/getVoucherDetail.htm-{ID}"})
	public String queryDisbursementRecordList(@PathVariable("ID")Long disbursementBatchId){
		
		UserVo curUser = ControllerUtils.getCurrentUser();
		
		V2DisbursementRecordVo disbursementRecordVo = new V2DisbursementRecordVo();
		
		disbursementRecordVo.setDisbursementBatchId(disbursementBatchId);
		
		disbursementRecordVo.setEnterpriseId(curUser.getEnterpriseId());
		
		Map<String, Object> input = new HashMap<String, Object>();
		
		input.put("paramter", disbursementRecordVo);
		
		input.put("sign", "queryDisbursementRecordList");
		
		ResBody resBody = TradeInvokeUtils.invoke("V2DisbursementManagement", input);
		// 调用服务
		List<V2DisbursementRecordVo> resultList = null;
		if (super.isSuccess(resBody)) {
			
			JSONObject output = (JSONObject) resBody.getOutput();
			resultList = JsonUtils.toList(output.getString("result"), V2DisbursementRecordVo.class);
		}

		getRequest().setAttribute("resultList", resultList);
		getRequest().setAttribute("paramters", disbursementRecordVo); 
		return "ybl/v2/admin/factor/balance/voucher_details";
	}

	/**
	 * 查询凭证详情
	 * 参数：
	 * @param number 凭证编号
	 * @return
	 */
	@RequestMapping({"/getVoucherByNumber.htm-{NUMBER}"})
	public String queryVoucherByNumber(@PathVariable("NUMBER")String number){
		
		UserVo curUser = ControllerUtils.getCurrentUser();
		
		V2DisbursementRecordVo disbursementRecordVo = new V2DisbursementRecordVo();
		
		disbursementRecordVo.setNumber(number);
		
		disbursementRecordVo.setEnterpriseId(curUser.getEnterpriseId());
		
		Map<String, Object> input = new HashMap<String, Object>();
		
		input.put("paramter", disbursementRecordVo);
		
		input.put("sign", "queryDisbursementRecordList");
		
		ResBody resBody = TradeInvokeUtils.invoke("V2DisbursementManagement", input);
		// 调用服务
		List<V2DisbursementRecordVo> resultList = null;
		if (super.isSuccess(resBody)) {
			
			JSONObject output = (JSONObject) resBody.getOutput();
			resultList = JsonUtils.toList(output.getString("result"), V2DisbursementRecordVo.class);
		}

		getRequest().setAttribute("resultList", resultList);
		getRequest().setAttribute("paramters", disbursementRecordVo); 
		return "ybl/v2/admin/factor/balance/voucher_details";
	}
	
	/**
	 * 批量生成付款批次
	 * 参数：
	 * @param ids 需要打包的应收账款的id集合
	 * 返回：去到待付款批次页面
	 */
	@RequestMapping({"/generateDisburseBatch"})
	@ResponseBody
	@Log(operation=OperationType.Exe,info="批量生成付款批次文件")
	public ControllerResponse generateDisburseBatch(V2GenerateDisbursementBatchVo generateDisbursementBatchVo){
		
		UserVo curUser = ControllerUtils.getCurrentUser();
		
		ControllerResponse response = new ControllerResponse(ResponseType.FAILURE);
		
		Map<String, Object> input = new HashMap<String, Object>();
		
		ControllerUtils.setWho(generateDisbursementBatchVo);
		
		generateDisbursementBatchVo.setEnterpriseId(curUser.getEnterpriseId());
		
		input.put("paramter", generateDisbursementBatchVo);
		
		input.put("sign", "generateDisburseBatch");
		
		ResBody resBody = TradeInvokeUtils.invoke("V2DisbursementManagement", input);
		// 调用服务
		if (super.isSuccess(resBody)) {
			
			JSONObject output = (JSONObject) resBody.getOutput();
			String records = output.getString("result");
			if (Boolean.parseBoolean(records)) {
				response.setInfo(I18NUtils.getText("sys.v2.client.operationSuccess"));
				response.setResponseType(ResponseType.SUCCESS);
			}
		}

		return response;
	}
	
	/**
	 * 按照批次进行结算
	 * 参数：
	 * @param trxNumberPlat 平台交易流水号
	 * @param trxNumberSupplier 供应商交易流水号
	 * @param id_   付款批次id
	 * 结算完成后，回到待付款批次界面
	 * 
	 */
	@RequestMapping({"/balanceAccounts"})
	@ResponseBody
	@Log(operation=OperationType.Exe,info="按照批次进行结算")
	public ControllerResponse balanceAccounts(V2DisbursementBatchVo disbursementBatchVo){
		
		ControllerResponse response = new ControllerResponse(ResponseType.FAILURE);
		
		Map<String, Object> input = new HashMap<String, Object>();
		
		UserVo curUser = ControllerUtils.getCurrentUser();
		
		ControllerUtils.setWho(disbursementBatchVo);
		
		disbursementBatchVo.setEnterpriseId(curUser.getEnterpriseId());
		
		input.put("paramter", disbursementBatchVo);
		
		input.put("sign", "balanceAccounts");
		
		ResBody resBody = TradeInvokeUtils.invoke("V2DisbursementManagement", input);
		// 调用服务
		if (super.isSuccess(resBody)) {
			
			JSONObject output = (JSONObject) resBody.getOutput();
			String records = output.getString("result");
			if (Boolean.parseBoolean(records)) {
				response.setInfo(I18NUtils.getText("sys.v2.client.operationSuccess"));
				response.setResponseType(ResponseType.SUCCESS);
			}
		}
		return response;
	}
	
	/**
	 * 批量导出文件-待生成付款批次列表
	 * @param request
	 * @param response
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping({"/exportGenerateBatch"})
	@Log(operation=OperationType.Exe,info="批量导出待生成付款批次列表文件")
	public void exportGenerateBatch(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		
		String title = I18NUtils.getText("sys.v2.client.generate.payment.lot");
		
		String []columnTitles = {
				I18NUtils.getText("sys.v2.client.no"),                    //序号
				I18NUtils.getText("sys.v2.client.supplier"),              //供应商 
				I18NUtils.getText("sys.v2.client.amount.receivable"),     //应收金额
				I18NUtils.getText("sys.v2.client.audit.date"),            //审核日期
				I18NUtils.getText("sys.v2.client.status"),                //回款状态
		};
		
		//构造数据
		List<V2GenerateDisbursementBatchVo> resultList = getAllGenerateBatchList();
		
		List<String[]> dataList = new ArrayList<String[]>();
		int row = 1;
		for(V2GenerateDisbursementBatchVo record:resultList){
			int col = 0;
			String[] rowData = new String[columnTitles.length];
			rowData[col ++] = String.valueOf(row ++);
			rowData[col ++] = record.getEnterpriseName();
			rowData[col ++] = record.getAmount().setScale(2, BigDecimal.ROUND_HALF_UP).toString();
			rowData[col ++] = DateUtils.toString(record.getDate());
			rowData[col ++] = I18NUtils.getText("sys.v2.client.pending.settlement");
			dataList.add(rowData);
		}
		
		File file = ExcelUtils.simpleCreate(title, columnTitles, dataList);
		
		//火狐浏览器有点特殊
		String agent=request.getHeader("User-Agent").toLowerCase();
		boolean isFirefox = (agent.indexOf("firefox") > -1);		
		ResponseDownloadUtils.download(response, file, isFirefox);
		
	}
	
	/**
	 * 返回所有待生成的付款批次列表
	 * @return
	 */
	public static List<V2GenerateDisbursementBatchVo> getAllGenerateBatchList(){
		
		UserVo curUser = ControllerUtils.getCurrentUser();
		
		Map<String, Object> input = new HashMap<String, Object>();
		
		V2GenerateDisbursementBatchVo generateDisbursementBatchVo = new V2GenerateDisbursementBatchVo();
		
		generateDisbursementBatchVo.setEnterpriseId(curUser.getEnterpriseId()); //设置企业id
		
		ControllerUtils.setWho(generateDisbursementBatchVo);
		
		generateDisbursementBatchVo.setEnterpriseId(curUser.getEnterpriseId());
		
		input.put("paramter", generateDisbursementBatchVo);
		
		input.put("sign", "queryGenerateBatchList");
		
		ResBody resBody = TradeInvokeUtils.invoke("V2DisbursementManagement", input);
		// 调用服务
		List<V2GenerateDisbursementBatchVo> resultList = null;
		if (resBody.getSys() != null) {
			String status = resBody.getSys().getStatus();
			if ("S".equals(status)) {// 交易成功
				JSONObject output = (JSONObject) resBody.getOutput();
				resultList = JsonUtils.toList(output.getString("result"), V2GenerateDisbursementBatchVo.class);
			}
		}
		return resultList!=null?resultList:new ArrayList<V2GenerateDisbursementBatchVo>();
		
	}
	
	
	/**
	 * 批量导出文件-付款批次列表
	 * @param request
	 * @param response
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping({"/exportDisbursementBatch"})
	@Log(operation=OperationType.Exe,info="批量导出付款批次列表文件")
	public void exportDisbursementBatch(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		
		String title = I18NUtils.getText("sys.v2.client.batch.tobepaid");
		
		String []columnTitles = {
				I18NUtils.getText("sys.v2.client.no"),//序号
				I18NUtils.getText("sys.v2.client.batch.topay"),
				I18NUtils.getText("sys.v2.client.supplier"),//供应商
				I18NUtils.getText("sys.v2.client.audit.date"),//审核日期
				I18NUtils.getText("sys.v2.client.batch.amount"),//批次金额(元)
				I18NUtils.getText("sys.v2.client.settlementAmount"),//结算金额
				I18NUtils.getText("sys.v2.client.facte.fee"),//保理费(元
				I18NUtils.getText("sys.v2.client.loan.raite"),//贷款利息(元)
				I18NUtils.getText("sys.v2.client.platform.user.fee"),//平台使用费
				I18NUtils.getText("sys.v2.client.loan.amount"),//放款金额(元)
		};
		
		//构造数据
		List<V2DisbursementBatchVo> resultList = getAllDisbursementBatchList("waiting");
		
		List<String[]> dataList = new ArrayList<String[]>();
		int row = 1;
		for(V2DisbursementBatchVo record:resultList){
			int col = 0;
			String[] rowData = new String[columnTitles.length];
			rowData[col ++] = String.valueOf(row ++);//序号
			rowData[col ++] = record.getBatchNumber();//批次编号
			rowData[col ++] = record.getSupplierEnterpriseName();//供应商
			rowData[col ++] = DateUtils.toString(record.getLastUpdateTime());//审核日期
			rowData[col ++] = record.getBatchAmount().setScale(2,BigDecimal.ROUND_HALF_UP).toString();//批次金额
			rowData[col ++] = record.getBalanceAmount().setScale(2, BigDecimal.ROUND_HALF_UP).toString();
			rowData[col ++] = record.getLoanFee().setScale(2, BigDecimal.ROUND_HALF_UP).toString();//保理费
			rowData[col ++] = record.getLoanInterest().setScale(2, BigDecimal.ROUND_HALF_UP).toString(); //贷款利息
			rowData[col ++] = record.getManageFee().setScale(2, BigDecimal.ROUND_HALF_UP).toString(); //管理费用
			rowData[col ++] = record.getDisbursementAmount().setScale(2, BigDecimal.ROUND_HALF_UP).toString();//放款金额
			dataList.add(rowData);
		}
		
		File file = ExcelUtils.simpleCreate(title, columnTitles, dataList);
		
		//火狐浏览器有点特殊
		String agent=request.getHeader("User-Agent").toLowerCase();
		boolean isFirefox = (agent.indexOf("firefox") > -1);		
		ResponseDownloadUtils.download(response, file, isFirefox);
	}
	
	/**
	 * 返回所有待付款批次列表
	 * @param balanceStatus :waiting 待处理 ，done 已放款;如果为""，则查询所有
	 * @return
	 */
	public static List<V2DisbursementBatchVo> getAllDisbursementBatchList(String balanceStatus){
		
		UserVo curUser = ControllerUtils.getCurrentUser();
		
		Map<String, Object> input = new HashMap<String, Object>();
		
		V2DisbursementBatchVo disbursementBatchVo = new V2DisbursementBatchVo();
		
		disbursementBatchVo.setEnterpriseId(curUser.getEnterpriseId()); //设置企业id
		
		ControllerUtils.setWho(disbursementBatchVo);
		
		disbursementBatchVo.setEnterpriseId(curUser.getEnterpriseId());
		
		disbursementBatchVo.setStatus(balanceStatus);
		
		input.put("paramter", disbursementBatchVo);
		
		input.put("sign", "queryDisbursementBatchList");
		
		ResBody resBody = TradeInvokeUtils.invoke("V2DisbursementManagement", input);
		// 调用服务
		List<V2DisbursementBatchVo> resultList = null;
		
		if (resBody.getSys() != null) {
			String status = resBody.getSys().getStatus();
			if ("S".equals(status)) {// 交易成功
				JSONObject output = (JSONObject) resBody.getOutput();
				String reult = output.getString("result");
				resultList = JsonUtils.toList(reult, V2DisbursementBatchVo.class);
			}
		}
		return resultList!=null?resultList:new ArrayList<V2DisbursementBatchVo>();
	}
}
