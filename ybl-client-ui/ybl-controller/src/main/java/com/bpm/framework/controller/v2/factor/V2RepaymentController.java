package com.bpm.framework.controller.v2.factor;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.ss.usermodel.Sheet;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.annotation.Log;
import com.bpm.framework.annotation.OperationType;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.controller.common.ConfigCache;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.date.DateUtils;
import com.bpm.framework.utils.file.Excel2007Utils;
import com.bpm.framework.utils.file.ExcelUtils;
import com.bpm.framework.utils.file.ResponseDownloadUtils;
import com.bpm.framework.utils.i18n.I18NUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v2.TConfig;
import cn.sunline.framework.controller.vo.v2.V2RepaymentLineRecordVo;
import cn.sunline.framework.controller.vo.v2.V2RepaymentRecordVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 
 * 回款控制器
 *
 */
@Controller
@RequestMapping({"/v2repaymentController"})
public class V2RepaymentController extends AbstractController{

	private static final long serialVersionUID = -3638148272520531721L;
	
	/**
	 * 查询核心企业回款列表，并加载数据
	 * @return 
	 */
	@RequestMapping({"/queryEnterprisePaymentList.htm"})
	public String queryEnterprisePaymentList(V2RepaymentRecordVo repaymentRecordVo,PageVo<?> pageVo){
		
		UserVo curUser = ControllerUtils.getCurrentUser();
		
		Map<String, Object> input = new HashMap<String, Object>();
		
		repaymentRecordVo.setEnterpriseId(curUser.getEnterpriseId()); //设置企业id
		
		ControllerUtils.setWho(repaymentRecordVo);
		input.put("paramter", repaymentRecordVo);
		
		input.put("page", pageVo);
		input.put("sign", "queryRepaymentList");
		
		ResBody resBody = TradeInvokeUtils.invoke("V2RepaymentManagement", input);
		// 调用服务
		PageVo<?> page = null;
		List<V2RepaymentRecordVo> resultList = null;
		if (super.isSuccess(resBody)) {
			
			JSONObject output = (JSONObject) resBody.getOutput();
			
			page = JsonUtils.toObject(output.getString("page"), PageVo.class);
			String reult = output.getString("result");
			resultList = JsonUtils.toList(reult, V2RepaymentRecordVo.class);
		}

		getRequest().setAttribute("resultList", resultList);
		getRequest().setAttribute("page", page!=null?page:pageVo);
		getRequest().setAttribute("paramters", repaymentRecordVo); 
		return "ybl/v2/admin/factor/balance/enterprise_payment";
	}
	
	/**
	 * 跳转到单笔回款页面，并加载数据
	 * @param number 凭证编号
	 * @return
	 */
	@RequestMapping({"/singlePaymentEdit.htm-{number}"})
	public String singlePaymentEdit(@PathVariable("number") String number){
		
		V2RepaymentRecordVo repaymentRecord = new V2RepaymentRecordVo();
		repaymentRecord.setNumber(number);
		
		Map<String, Object> input = new HashMap<String, Object>();
		
		ControllerUtils.setWho(repaymentRecord);
		
		UserVo curUser = ControllerUtils.getCurrentUser();
		
		repaymentRecord.setEnterpriseId(curUser.getEnterpriseId());
		
		input.put("paramter", repaymentRecord);
		
		input.put("sign", "getRepaymentDetail");
		
		ResBody resBody = TradeInvokeUtils.invoke("V2RepaymentManagement", input);
		// 调用服务
		List<V2RepaymentLineRecordVo> resultList = null;
		
		if (super.isSuccess(resBody)) {
			
			JSONObject output = (JSONObject) resBody.getOutput();
			JSONObject result = output.getJSONObject("result");
			// 回款主表
			if (StringUtils.isNotEmpty(result.getString("repaymentRecord"))) {
				repaymentRecord = JsonUtils.toObject(result.getString("repaymentRecord"), V2RepaymentRecordVo.class);
			}
			
			//回款记录列表
			resultList = JsonUtils.toList(result.getString("repaymentLineRecord"), V2RepaymentLineRecordVo.class);
		}
		getRequest().setAttribute("resultList", resultList);             //回款记录列表
		getRequest().setAttribute("repaymentRecord",repaymentRecord);    //回款主表
		return "ybl/v2/admin/factor/balance/single_payment";
	}
	
	/**
	 * 核心企业单笔还款
	 * 结算完成后，回到待付款批次界面
	 */
	@RequestMapping({"/saveRepayment"})
	@ResponseBody
	@Log(operation=OperationType.Exe,info="核心企业单笔还款")
	public ControllerResponse saveRepayment(V2RepaymentLineRecordVo repaymentLineRecordVo){
		
		ControllerResponse response = new ControllerResponse(ResponseType.FAILURE);
		
		Map<String, Object> input = new HashMap<String, Object>();
		
		ControllerUtils.setWho(repaymentLineRecordVo);
		
		UserVo curUser = ControllerUtils.getCurrentUser();
		
		repaymentLineRecordVo.setEnterpriseId(curUser.getEnterpriseId());

		input.put("paramter", repaymentLineRecordVo);
		
		input.put("sign", "saveRepayment");
		
		ResBody resBody = TradeInvokeUtils.invoke("V2RepaymentManagement", input);
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
	 * 跳转到批量回款页面，并加载数据
	 * @return
	 */
	@RequestMapping({"/toBatchPaymentPage.htm"})
	public String toBatchPaymentPage(){
		return "ybl/v2/admin/factor/balance/recevied_payment_batch";
	}
	
	/**
	 * 下载批量导入模板
	 */
	@RequestMapping({"/downloadRepaymentTemplate.htm"})
	@Log(operation=OperationType.Exe,info="下载批量导入模板")
	public void download(HttpServletRequest request, HttpServletResponse response) {
		String path = request.getSession().getServletContext().getRealPath("/");
		
		String filePath = path + "WEB-INF/classes/ftl/repayment_template.xlsx";
		
		File f = new File(filePath);
		
		ExcelUtils.download(response,f );
		
	}
	
	/**
	 * 上传excel-批量导入文件
	 * 解析内容，将内容转换成repaymentLineRecordVo列表
	 */
	@RequestMapping({"/saveRepayments"})
	@ResponseBody
	@Log(operation=OperationType.Exe,info="批量导入核心企业回款文件")
	public void saveRepayments(HttpServletRequest request, HttpServletResponse httpServletResponse) throws IOException{
		
		Map<String, Object> input = new HashMap<String, Object>();
		
		List<V2RepaymentLineRecordVo>  recordList = getRepaymentLineRecordList( request,  httpServletResponse);

		input.put("paramter", recordList);
		
		input.put("sign", "saveRepayments");
		
		ResBody resBody = TradeInvokeUtils.invoke("V2RepaymentManagement", input);
		
		String handleMsg  = resBody.getSys().getErorMsg(); 
		
		// 调用服务
		if (super.isSuccess(resBody)) {
			
			JSONObject output = (JSONObject) resBody.getOutput();
			String records = output.getString("result");
			if (Boolean.parseBoolean(records)) {

				handleMsg = I18NUtils.getText("sys.v2.client.operationSuccess");
			}

		}
		
		handleMsg = handleMsg.replaceAll("'", "");  //handleMsg字符串中，有可能会有'这个英文符号，使得调用js函数 _callback的参数不是一个字符串而报错。
		
		String callBack = "<script>parent._callback" + "('" + handleMsg + "');</script>";

		httpServletResponse.getWriter().write(callBack);
		
	}
	
	/**
	 * 解析excel里面的数据
	 * @param request
	 * @param response
	 * @return
	 */
	private List<V2RepaymentLineRecordVo> getRepaymentLineRecordList(HttpServletRequest request, HttpServletResponse response) {
		
		List<V2RepaymentLineRecordVo>  recordList = new ArrayList<V2RepaymentLineRecordVo>();
		
		UserVo curUser = ControllerUtils.getCurrentUser();
		
		
		try {
			boolean isMultipart = ServletFileUpload.isMultipartContent(request);
			if (!isMultipart) return recordList;
			FileItemFactory uploadFactory = new DiskFileItemFactory();
			ServletFileUpload fileUpload = new ServletFileUpload(uploadFactory);
			List<FileItem> items = fileUpload.parseRequest(request);
			
			for(FileItem item : items) {
				Sheet sheet = Excel2007Utils.getSheet(item.getInputStream(), 0);//第一个工作簿
				
				for(int row = 1; row <= sheet.getLastRowNum(); row ++){
						V2RepaymentLineRecordVo repaymentLineRecordVo = new V2RepaymentLineRecordVo();
						repaymentLineRecordVo.setEnterpriseId(curUser.getEnterpriseId());
						ControllerUtils.setWho(repaymentLineRecordVo);  
						
						
						//账款凭证
						String value = Excel2007Utils.getCellValue(sheet, row, 0);
						repaymentLineRecordVo.setVoucherNumber(value);
						
						//交易流水号
						value = Excel2007Utils.getCellValue(sheet, row, 1);
						repaymentLineRecordVo.setTrxNumber(value);
						
						//回款金额
						value = Excel2007Utils.getCellValue(sheet, row, 2);
						repaymentLineRecordVo.setAmount(BigDecimal.valueOf(Double.valueOf(value)));
						
						//回款日期
						value = Excel2007Utils.getCellValue(sheet, row, 3);
						repaymentLineRecordVo.setPayTime(DateUtils.toDate(value));
						
						//备注
						value = Excel2007Utils.getCellValue(sheet, row, 4);
						repaymentLineRecordVo.setComment(value);
						
						recordList.add(repaymentLineRecordVo);
					}
				
			}
		} catch(Exception e) {
			log.error("异常：", e);
		}
		return recordList;
	}
	
	/**
	 * 批量导出文件
	 * @param request
	 * @param response
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping({"/exportAll"})
	@Log(operation=OperationType.Exe,info="批量导出核心企业回款文件")
	public void exportAll(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		
		String title = I18NUtils.getText("sys.v2.client.enterprise.repayment");
		
		String []columnTitles = {
				I18NUtils.getText("sys.v2.client.no"),//序号
				I18NUtils.getText("sys.v2.client.supplier"),//供应商
				I18NUtils.getText("sys.v2.client.core.enterprise"),//企业
				I18NUtils.getText("sys.v2.client.account.voucher"),//账款凭证
				I18NUtils.getText("sys.v2.client.plan.return.date"),//计划回款日
				I18NUtils.getText("sys.v2.client.actual.return.date"),//实际回款日
				I18NUtils.getText("sys.v2.client.amount.receivable"),//应收金额
				I18NUtils.getText("sys.v2.client.amountOfMoneyBack"),//回款金额
				I18NUtils.getText("sys.v2.client.repayment.status"),//回款状态
		};
		
		//构造数据
		List<V2RepaymentRecordVo> resultList = getAllList();
		
		List<String[]> dataList = new ArrayList<String[]>();
		int row = 1;
		for(V2RepaymentRecordVo record:resultList){
			int col = 0;
			String[] rowData = new String[columnTitles.length];
			rowData[col ++] = String.valueOf(row ++);
			rowData[col ++] = record.getSupplierEnterpriseName();
			rowData[col ++] = record.getCoreEnterpriseName();
			rowData[col ++] = record.getNumber();
			if(record!=null && record.getRepaymentDate()!=null){
				rowData[col ++] = DateUtils.toString(record.getRepaymentDate());
			}else{
				rowData[col ++] = "";
			}
			if(record!=null && record.getPayTime()!=null){
				rowData[col ++] = DateUtils.toString(record.getPayTime());
			}else{
				rowData[col ++] = "";
			}
			rowData[col ++] = record.getAmount().setScale(2, BigDecimal.ROUND_HALF_UP).toString();
			rowData[col ++] = record.getActualAmount().setScale(2, BigDecimal.ROUND_HALF_UP).toString();
			TConfig config = ConfigCache.getByTypeCode("REPAYMENT_STATUS", record.getStatus());
			rowData[col ++] = config.getValue();//回款状态
			dataList.add(rowData);
		}
		
		File file = ExcelUtils.simpleCreate(title, columnTitles, dataList);
		
		//火狐浏览器有点特殊
		String agent=request.getHeader("User-Agent").toLowerCase();
		boolean isFirefox = (agent.indexOf("firefox") > -1);		
		ResponseDownloadUtils.download(response, file, isFirefox);
	}
	
	/**
	 * 
	 * @return
	 */
	private List<V2RepaymentRecordVo> getAllList(){
		
		UserVo curUser = ControllerUtils.getCurrentUser();
		
		Map<String, Object> input = new HashMap<String, Object>();
		
		V2RepaymentRecordVo repaymentRecordVo = new V2RepaymentRecordVo();
		
		repaymentRecordVo.setEnterpriseId(curUser.getEnterpriseId()); //设置企业id
		
		input.put("paramter", repaymentRecordVo);
		
		input.put("sign", "queryRepaymentList");
		
		ResBody resBody = TradeInvokeUtils.invoke("V2RepaymentManagement", input);
		// 调用服务
		List<V2RepaymentRecordVo> resultList = null;
		if (super.isSuccess(resBody)) {
			
			JSONObject output = (JSONObject) resBody.getOutput();
			String reult = output.getString("result");
			resultList = JsonUtils.toList(reult, V2RepaymentRecordVo.class);
		}
		return resultList!=null?resultList:new ArrayList<V2RepaymentRecordVo>();
	}
}