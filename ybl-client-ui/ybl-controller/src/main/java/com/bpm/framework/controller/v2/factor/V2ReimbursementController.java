package com.bpm.framework.controller.v2.factor;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
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
import com.bpm.framework.utils.date.DateUtils;
import com.bpm.framework.utils.file.ExcelUtils;
import com.bpm.framework.utils.file.ResponseDownloadUtils;
import com.bpm.framework.utils.i18n.I18NUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v2.TConfig;
import cn.sunline.framework.controller.vo.v2.V2BalanceVo;
import cn.sunline.framework.controller.vo.v2.V2ReimburseLineRecordVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 
 * 退款控制器
 *
 */
@Controller
@RequestMapping({"/v2reimbursementController"})
public class V2ReimbursementController extends AbstractController{

	private static final long serialVersionUID = -3638148272520531721L;

	/**
	 * 核心企业单笔还款
	 * 结算完成后，回到待付款批次界面
	 * 
	 */
	@RequestMapping({"/saveReimburse"})
	@ResponseBody
	@Log(operation=OperationType.Exe,info="核心企业单笔还款")
	public ControllerResponse saveReimburse(V2ReimburseLineRecordVo reimburseLineRecordVo){
		
		ControllerResponse response = new ControllerResponse(ResponseType.FAILURE);
		
		Map<String, Object> input = new HashMap<String, Object>();
		
		UserVo curUser = ControllerUtils.getCurrentUser( );
		reimburseLineRecordVo.setEnterpriseId(curUser.getEnterpriseId()); //设置企业id
		
		ControllerUtils.setWho(reimburseLineRecordVo);

		input.put("paramter", reimburseLineRecordVo);
		
		input.put("sign", "saveReimburse");
		
		ResBody resBody = TradeInvokeUtils.invoke("V2ReimburseManagement", input);
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
	 * 批量导出文件-退款处理
	 * @param request
	 * @param response
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping({"/exportAll"})
	@Log(operation=OperationType.Exe,info="批量导出退款处理列表文件")
	public void exportAll(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		
		String title = I18NUtils.getText("sys.v2.client.refund.process");//退款处理
		
		String []columnTitles = {
				I18NUtils.getText("sys.v2.client.no"),                   //序号
				I18NUtils.getText("sys.v2.client.supplier"),             //供应商
				I18NUtils.getText("sys.v2.client.core.enterprise"),      //企业
				I18NUtils.getText("sys.v2.client.account.voucher"),      //账款凭证
				I18NUtils.getText("sys.v2.client.repayment.status"),     //回款状态
				I18NUtils.getText("sys.v2.client.buyback.status"),       //回购状态
				I18NUtils.getText("sys.v2.client.actual.return.date"),   //实际回款日
				I18NUtils.getText("sys.v2.client.buyback.date"),         //回购日期
				I18NUtils.getText("sys.v2.client.amount.receivable"),    //应收金额
				I18NUtils.getText("sys.v2.client.settlement.ratio"),     //结算比例
				I18NUtils.getText("sys.v2.client.amountOfMoneyBack"),    //回款金额
				I18NUtils.getText("sys.v2.client.buyback.amount"),       //回购金额
				I18NUtils.getText("sys.v2.client.RefundAmount"),         //已退款金额
				I18NUtils.getText("sys.v2.client.amountToBeRefunded"),   //待退款金额
		};
		
		//构造数据
		List<V2BalanceVo> resultList = getAllList("");
		
		List<String[]> dataList = new ArrayList<String[]>();
		int row = 1;
		for(V2BalanceVo record:resultList){
			int col = 0;
			String[] rowData = new String[columnTitles.length];
			rowData[col ++] = String.valueOf(row ++);
			rowData[col ++] = record.getSupplierEnterpriseName();
			rowData[col ++] = record.getCoreEnterpriseName();
			rowData[col ++] = record.getVoucherNumber();
			TConfig config = ConfigCache.getByTypeCode("REPAYMENT_STATUS", record.getRepaymentStatus());
			rowData[col ++] = config.getValue();//回款状态
			
			config = ConfigCache.getByTypeCode("BUYBACK_STATUS", record.getBuybackStatus());
			rowData[col ++] = config.getValue();//回购状态

			if(record.getRealRepaymentDate()!=null){
				rowData[col ++] = DateUtils.toString(record.getRealRepaymentDate());
			}else{
				rowData[col ++] = "";
			}
			if(record.getRealBuybackDate()!=null){
				rowData[col ++] = DateUtils.toString(record.getRealBuybackDate());
			}else{
				rowData[col ++] = "";
			}
			rowData[col ++] = record.getVoucherAmount().setScale(2, BigDecimal.ROUND_HALF_UP).toString();
			rowData[col ++] = record.getSettlementRatio().setScale(2, BigDecimal.ROUND_HALF_UP).toString();
			
			rowData[col ++] = record.getActualRepaymentAmount().setScale(2, BigDecimal.ROUND_HALF_UP).toString();
			rowData[col ++] = record.getActualBuybackAmount().setScale(2, BigDecimal.ROUND_HALF_UP).toString();
			rowData[col ++] = record.getReimbursedAmount().setScale(2, BigDecimal.ROUND_HALF_UP).toString();
			rowData[col ++] = record.getReimbursementAmount().setScale(2, BigDecimal.ROUND_HALF_UP).toString();
			
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
	public static List<V2BalanceVo> getAllList(String reimbursedStatus){
		
		UserVo curUser = ControllerUtils.getCurrentUser();
		
		Map<String, Object> input = new HashMap<String, Object>();
		
		V2BalanceVo balanceVo = new V2BalanceVo();
		
		balanceVo.setReimbursedStatus(reimbursedStatus);
		
		balanceVo.setEnterpriseId(curUser.getEnterpriseId()); //设置企业id
		
		balanceVo.setAttribute7("reimburse");   //查询退款列表
		
		input.put("paramter", balanceVo);
		
		input.put("sign", "queryBalanceList");
		
		ResBody resBody = TradeInvokeUtils.invoke("V2BalanceManagement", input);
		// 调用服务
		List<V2BalanceVo> resultList = null;
		if (resBody.getSys() != null) {
			String status = resBody.getSys().getStatus();
			if ("S".equals(status)) {// 交易成功
				JSONObject output = (JSONObject) resBody.getOutput();
				String reult = output.getString("result");
				resultList = JsonUtils.toList(reult, V2BalanceVo.class);
			}
		}
		return resultList!=null?resultList:new ArrayList<V2BalanceVo>();
	}
}
