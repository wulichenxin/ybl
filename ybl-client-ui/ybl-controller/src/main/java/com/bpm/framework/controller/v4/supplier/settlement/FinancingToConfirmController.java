package com.bpm.framework.controller.v4.supplier.settlement;

import java.math.BigDecimal;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.annotation.ValidateSession;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.utils.i18n.I18NUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.AttachmentVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v4.PlatformCapitalFlow;
import cn.sunline.framework.controller.vo.v4.PlatformConfigFree;
import cn.sunline.framework.controller.vo.v4.factor.AccountsPayableElementsVo;
import cn.sunline.framework.controller.vo.v4.factor.AccountsReceivableElementsVo;
import cn.sunline.framework.controller.vo.v4.factor.BillElementsVo;
import cn.sunline.framework.controller.vo.v4.factor.ContractQuotaV4Vo;
import cn.sunline.framework.controller.vo.v4.factor.FactorLoanManagementLoanBatchSettlementVo;
import cn.sunline.framework.controller.vo.v4.factor.enums.E_V4_ATTACHMENT_CATEGORY;
import cn.sunline.framework.controller.vo.v4.factor.enums.E_V4_ATTACHMENT_TYPE;
import cn.sunline.framework.controller.vo.v4.supplier.AccountsPayableVO;
import cn.sunline.framework.controller.vo.v4.supplier.AccountsReceivableV4VO;
import cn.sunline.framework.controller.vo.v4.supplier.BillVO;
import cn.sunline.framework.controller.vo.v4.supplier.LoanApply;
import cn.sunline.framework.controller.vo.v4.supplier.LoanApplyInfo;
import cn.sunline.framework.controller.vo.v4.supplier.LoanapplyChildrenQueryVO;
import cn.sunline.framework.controller.vo.v4.supplier.enums.E_V4_LOAN_STATE;
import cn.sunline.framework.controller.vo.v4.supplier.enums.E_V4_PLATFORM_FREE_STATE;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 收款确认
 * 
 * @author win 10
 *
 */
@Controller
@RequestMapping({ "/financingToConfirm" })
public class FinancingToConfirmController extends AbstractController {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6607259745857188386L;

	/**
	 *  融资确认列表
	 * @param parm 筛选条件
	 * @param page 分页参数
	 * @return
	 */
	@RequestMapping(value = "list")
	public String financingToConfirm(LoanApplyParm parm, PageVo page) {
		if (page == null) {
			page = new PageVo<>(1, 10);
		}

		if (parm == null) {
			parm = new LoanApplyParm();
		}

		if (parm.getStatus() == null) {
			parm.setStatus(8);
		}
		UserVo user = ControllerUtils.getCurrentUser();
		parm.setBusiness_id(user.getBusinessId());
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("parm", parm);
		maps.put("page", page);
		maps.put("sign", "selectLoanApplyForPage");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("SettlementManagement", maps);

		isSuccess(result);
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String stringPage = output.getString("page");
				page = JSONObject.parseObject(stringPage, PageVo.class);
				super.log.error("根据条件查询账款调用queryList服务返回成功，信息：" + page);
			} else {
				super.log.error("根据条件查询账款调用queryList服务返回失败，信息：" + erortx);
				return null;
			}
		}
		getRequest().setAttribute("page", page);
		getRequest().setAttribute("parm", parm);

		return "ybl4.0/admin/supplier/settlementManagement/financingToConfirmList";
	}
	
	/**
	 * 详情展示view
	 * @param id_ 付款批次id
	 * @param financingAmount 融资金额
	 * @return
	 */
	@RequestMapping(value = "view")
	public String view(Integer id_,@RequestParam("financingAmount") String financingAmount) {
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("id_", id_);
		maps.put("sign", "selectPaymentBatchById");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("SettlementManagement", maps);
		isSuccess(result);
		FactorLoanManagementLoanBatchSettlementVo resultInfo = null;
		LoanApply loanApply = null;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String stringInfo = output.getString("paymentBatch");
				String loanInfo = output.getString("loanApply");
				loanApply = JSONObject.parseObject(loanInfo, LoanApply.class);
				resultInfo = JSONObject.parseObject(stringInfo, FactorLoanManagementLoanBatchSettlementVo.class);
				super.log.error("根据条件查询账款调用queryList服务返回成功，信息：" + stringInfo);
			} else {
				super.log.error("根据条件查询账款调用queryList服务返回失败，信息：" + erortx);
				return null;
			}
		}
		getRequest().setAttribute("entity", resultInfo);
		getRequest().setAttribute("loanApply", loanApply);
		getRequest().setAttribute("financingAmount", financingAmount);
		return "ybl4.0/admin/supplier/settlementManagement/view";
		
	}
	

	/**
	 * @param id_ 付款批次id
	 * @param financingAmount 融资金额
	 */
	@RequestMapping(value = "info")
	public String paymentBatchInfo(Integer id_ , String financingAmount) {
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("id_", id_);
		maps.put("sign", "selectPaymentBatchById");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("SettlementManagement", maps);
		isSuccess(result);
		FactorLoanManagementLoanBatchSettlementVo resultInfo = null;
		LoanApply loanApply = null;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String stringInfo = output.getString("paymentBatch");
				String loanInfo = output.getString("loanApply");
				loanApply = JSONObject.parseObject(loanInfo, LoanApply.class);
				resultInfo = JSONObject.parseObject(stringInfo, FactorLoanManagementLoanBatchSettlementVo.class);
				super.log.error("根据条件查询账款调用queryList服务返回成功，信息：" + stringInfo);
			} else {
				super.log.error("根据条件查询账款调用queryList服务返回失败，信息：" + erortx);
				return null;
			}
		}

		// 查询平台费用
		Map<String, Object> configFree = new HashMap<String, Object>();
		PlatformConfigFree configFreeEntity = new PlatformConfigFree();
		UserVo user = ControllerUtils.getCurrentUser();
		configFreeEntity.setEnterpriseId(user.getEnterpriseId());
		configFree.put("parameter", configFreeEntity);
		configFree.put("sign", "queryPlatformConfigFreeByCondition");
		ResBody configFreeResult = TradeInvokeUtils.invoke("V4PlatformConfigFreeManagement", configFree);
		PlatformConfigFree configFreeReturnPage = null;
		isSuccess(configFreeResult);
		List<PlatformConfigFree> platformConfigFreeList = null;
		if (isSuccess(result)) {
			JSONObject configFreeoutput = (JSONObject) configFreeResult.getOutput();
			String configFreerecords = configFreeoutput.getString("result");
			platformConfigFreeList = JsonUtils.toList(configFreerecords, PlatformConfigFree.class);
			if (platformConfigFreeList.size() > 0) {
				configFreeReturnPage = platformConfigFreeList.get(0);
				getRequest().setAttribute("platformConfigFree", configFreeReturnPage);
				BigDecimal actual_rate = configFreeReturnPage.getRate()
						.subtract(configFreeReturnPage.getReductionRate()); // 实际费率
				BigDecimal plat_free = resultInfo.getActualLoanAmount().multiply(actual_rate)
						.divide(new BigDecimal(100), 4, BigDecimal.ROUND_HALF_UP); // 平台实际费用
				getRequest().setAttribute("plat_free", plat_free);// 平台费用
			}
		} else {
			super.log.error("根据企业ID查询平台费用交易返回错误信息: " + configFreeResult.getSys().getErortx());
			return null;
		} // 查询平台费用结束

		/**
		 * 放款附件信息
		 */
		AttachmentVo attachment = new AttachmentVo();
		attachment.setType("50");
		attachment.setCategory(7L);
		attachment.setResourceId(id_);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", attachment);
		map.put("sign", "queryAttchmentByCondition");// 所调用的服务中的方法
		ResBody resultAttachment = TradeInvokeUtils.invoke("AttachmentManagement", map);
		isSuccess(resultAttachment);
		JSONObject output = (JSONObject) resultAttachment.getOutput();
		String resultJson = output.getString("result");
		List<AttachmentVo> attachmentList = null;
		attachmentList = JsonUtils.toList(resultJson, AttachmentVo.class);
		if (attachmentList != null && attachmentList.size() > 0) {
			attachment = attachmentList.get(0);
			getRequest().setAttribute("attachment", attachment);
		}

		getRequest().setAttribute("entity", resultInfo);
		getRequest().setAttribute("loanApply", loanApply);
		if(financingAmount != null && financingAmount != ""){
			getRequest().setAttribute("financingAmount", financingAmount);
		}
		return "ybl4.0/admin/supplier/settlementManagement/paymentInfo";

	}

	/**
	 * 更新确认收款状态 
	 * @param id 放款申请id
	 * @param attachment 附件信息
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "uploadConfirm")
	public ControllerResponse uploadConfirm(Integer id, AttachmentVo attachment ,HttpServletRequest req) {
		ControllerResponse ResponseResult = new ControllerResponse(ResponseType.FAILURE);
		UserVo user = ControllerUtils.getCurrentUser();
		Map<String, Object> obj = new HashMap<String, Object>();
		LoanApply loanApply = new LoanApply();
    	loanApply.setId(Long.valueOf(req.getParameter("id")));
    	loanApply.setStatus(E_V4_LOAN_STATE.FINANCER_CONFIRM.getStatus());//已确认收款状态
    	obj.put("loanApply", loanApply);
		
		//start attachment 设置附件信息
		attachment.setType("58");
		attachment.setCategory(14L);
		attachment.setEnterpriseId(user.getEnterpriseId());
		attachment.setResourceId(id);
		attachment.setCreatedTime(new Date());
		attachment.setLastUpdateTime(new Date());
		attachment.setEnable(1);
		attachment.setCreatedBy(user.getId());
		attachment.setLastUpdateBy(user.getId());
		attachment.setId(null);
		obj.put("attach", attachment);
		obj.put("platformCapitalFlow", getPlatformCapitalFlowFromHttpRequest(req));
		Map<String,Object> maps = new HashMap<String,Object>();
    	maps.put("parameter", obj);
		maps.put("sign", "updateLoanStatusAndInsertFlow");
		ResBody result = null;
		result = TradeInvokeUtils.invoke("LoanProjectManagement", maps);
		if (isSuccess(result)) {
			ResponseResult.setResponseType(ResponseType.SUCCESS, "确认收款成功");
		}
		
		return ResponseResult;

	}

	/**
	 * 查询放款申请项目详情
	 * @param loanApplyId 放款申请id
	 * @return
	 */
	@ValidateSession(validate = false)
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/loanappictionitem")
	public String loanappictionitem(@RequestParam("loanApplyId") String loanApplyId) {
		// 查询放款申请信息
		if (loanApplyId != null && loanApplyId != "") {
			LoanApplyInfo parameter = new LoanApplyInfo();
			parameter.setId(Long.valueOf(loanApplyId));
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("parameter", parameter);
			map.put("sign", "selectLoanApplyInfoBySubId");// 所调用的服务中的方法
			ResBody result = TradeInvokeUtils.invoke("PlatformFinancingApplyManagement", map);
			List<LoanApplyInfo> list = new ArrayList<LoanApplyInfo>();
			if (result.getSys() != null) {
				String status = result.getSys().getStatus();
				String erortx = result.getSys().getErortx();// 错误信息
				if ("S".equals(status)) {// 交易成功
					JSONObject output = (JSONObject) result.getOutput();
					String records = output.getString("result");
					list = JsonUtils.toList(records, LoanApplyInfo.class);
					if (list.size() > 0) {
						LoanApplyInfo loanApplyInfo = list.get(0);
						getRequest().setAttribute("loanApplyInfo", loanApplyInfo);
						// 查询到放款信息后 通过合同号查询 合同金额 和可用余额
						if (loanApplyInfo != null) {
							// 查询到放款信息后 通过合同号查询 合同金额 和可用余额
							ContractQuotaV4Vo contractQuotaV4Vo = new ContractQuotaV4Vo();
							contractQuotaV4Vo.setMasterContractNo(loanApplyInfo.getMasterContractNo());
							Map<String, Object> map2 = new HashMap<String, Object>();
							map.put("v4ContractQuotaInfo", contractQuotaV4Vo);
							ResBody result2 = TradeInvokeUtils.invoke("V4QueryContractQuotaManagement", map2);
							List<ContractQuotaV4Vo> list2 = null;
							if (result2.getSys() != null) {
								String status2 = result2.getSys().getStatus();
								String erortx2 = result2.getSys().getErortx();// 错误信息
								if ("S".equals(status2)) {// 交易成功
									JSONObject output2 = (JSONObject) result2.getOutput();
									String pageJson = output2.getString("v4ContractQuotaInfo");
									list2 = JsonUtils.toList(pageJson, ContractQuotaV4Vo.class);
									if (list2.size() > 0) {
										ContractQuotaV4Vo contractInfo = (ContractQuotaV4Vo) list2.get(0);
										getRequest().setAttribute("contractInfo", contractInfo);
									}
									super.log.info("根据条件查询合同额度信息调用V4QueryContractQuotaManagement交易返回成功，信息：" + erortx);
								} else {
									super.log.error("根据条件查询合同额度信息调用V4QueryContractQuotaManagement交易返回失败，信息：" + erortx);
								}
							}

							// 查询附件列表
							AttachmentVo attachmentVo = new AttachmentVo();
							attachmentVo.setResourceId(Integer.valueOf(loanApplyInfo.getId().toString()));
							attachmentVo.setCategory(6L);
							List<AttachmentVo> attachmentList = getFwAttachmentList(attachmentVo);
							getRequest().setAttribute("attachmentList", attachmentList);

							// 根据资产类型查询不同的底层资产
							if (loanApplyInfo.getAssetsType().equals("1")) {
								// 查询应收账款信息
								AccountsReceivableV4VO accountsReceivableV4VO = new AccountsReceivableV4VO();
								accountsReceivableV4VO
										.setLoanApplyId(Integer.parseInt(loanApplyInfo.getId().toString()));
								Map<String, Object> mapAccountsReceivable = new HashMap<String, Object>();
								map.put("parameter", mapAccountsReceivable);
								map.put("sign", "selectAccountsReceivableByCondition");// 所调用的服务中的方法
								ResBody resultAccountsReceivable = TradeInvokeUtils
										.invoke("PlatformFinancingApplyManagement", map);
								List<AccountsReceivableV4VO> accountsReceivableList = new ArrayList<AccountsReceivableV4VO>();
								if (resultAccountsReceivable.getSys() != null) {
									String statusAccountsReceivable = resultAccountsReceivable.getSys().getStatus();
									if ("S".equals(statusAccountsReceivable)) {// 交易成功
										JSONObject outputAccountsReceivable = (JSONObject) resultAccountsReceivable
												.getOutput();
										String recordsAccountsReceivable = outputAccountsReceivable.getString("result");
										if (recordsAccountsReceivable != null) {
											accountsReceivableList = JsonUtils.toList(recordsAccountsReceivable,
													AccountsReceivableV4VO.class);
											getRequest().setAttribute("accountsReceivableList", accountsReceivableList);
										}
									}
								}

							} else if (loanApplyInfo.getAssetsType().equals("2")) {
								// 查询应付账款信息
								AccountsPayableVO accountsPayableVO = new AccountsPayableVO();
								accountsPayableVO.setLoanApplyId(Integer.parseInt(loanApplyInfo.getId().toString()));
								Map<String, Object> mapAccountsPayablee = new HashMap<String, Object>();
								map.put("parameter", mapAccountsPayablee);
								map.put("sign", "selectAccountsPayableByCondition");// 所调用的服务中的方法
								ResBody resultAccountsPayable = TradeInvokeUtils
										.invoke("PlatformFinancingApplyManagement", map);
								List<AccountsPayableVO> accountsPayableList = new ArrayList<AccountsPayableVO>();
								if (resultAccountsPayable.getSys() != null) {
									String statusAccountsPayable = resultAccountsPayable.getSys().getStatus();
									if ("S".equals(statusAccountsPayable)) {// 交易成功
										JSONObject outputAccountsPayable = (JSONObject) resultAccountsPayable
												.getOutput();
										String recordsAccountsPayable = outputAccountsPayable.getString("result");
										accountsPayableList = JsonUtils.toList(recordsAccountsPayable,
												AccountsPayableVO.class);
										getRequest().setAttribute("accountsPayableList", accountsPayableList);
									}
								}
							} else if (loanApplyInfo.getAssetsType().equals("3")) {
								// 查询应付账款信息
								BillVO billVO = new BillVO();
								billVO.setLoanApplyId(Integer.parseInt(loanApplyInfo.getId().toString()));
								Map<String, Object> mapBill = new HashMap<String, Object>();
								map.put("parameter", mapBill);
								map.put("sign", "selectBillByCondition");// 所调用的服务中的方法
								ResBody resultBill = TradeInvokeUtils.invoke("PlatformFinancingApplyManagement", map);
								List<BillVO> billList = new ArrayList<BillVO>();
								if (resultBill.getSys() != null) {
									String statusBill = resultBill.getSys().getStatus();
									if ("S".equals(statusBill)) {// 交易成功
										JSONObject outputBill = (JSONObject) resultBill.getOutput();
										String recordsBill = outputBill.getString("result");
										billList = JsonUtils.toList(recordsBill, BillVO.class);
										getRequest().setAttribute("billList", billList);
									}
								}
							}
						}
					}
					log.info("查询子融资申请订单调用selectChildFinancingApplyByCondition服务返回成功，信息：" + erortx);
				} else {
					log.info("查询子融资申请订单调用selectChildFinancingApplyByCondition服务返回成功，信息：" + erortx);
				}
			}
		}

		return "ybl4.0/admin/supplier/settlementManagement/tab/loanappictionitem";
	}

	/**
	 * 条件查询附件列表
	 */
	public List<AttachmentVo> getFwAttachmentList(AttachmentVo attachmentVo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", attachmentVo);
		map.put("sign", "queryAttchmentByCondition");
		ResBody result = TradeInvokeUtils.invoke("AttachmentManagement", map);
		List<AttachmentVo> attachmentList = null;
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				attachmentList = JsonUtils.toList(records, AttachmentVo.class);
			}
		}
		return attachmentList;
	}

	/**
	 * 查询保理要素信息 type(资产类型); 1= 应收 2=应付 3=票据 loanApplyId 放款申请id
	 */
	@RequestMapping("/selectTotalElemets")
	public String toFactoringElements(@RequestParam("type") String type,
			@RequestParam("loanApplyId") String loanApplyId) {
		Map<String, Object> param = new HashMap<String, Object>();
		String elementType = type;
		param.put("elementType", elementType);
		param.put("loan_apply_id", loanApplyId);
		Map<String, Object> tradeParam = new HashMap<String, Object>();
		tradeParam.put("parameter", param);
		tradeParam.put("sign", "queryElementsByLoanOrderId");
		ResBody tradeResult = TradeInvokeUtils.invoke("LoanProjectManagement", tradeParam);
		if (isSuccess(tradeResult)) {
			JSONObject result = (JSONObject) tradeResult.getOutput();
			String obj = result.getString("result");
			if (elementType.equalsIgnoreCase("1") && null != obj) {
				AccountsReceivableElementsVo receivableElementsResult = JsonUtils.toObject(obj,
						AccountsReceivableElementsVo.class);
				getRequest().setAttribute("vo", receivableElementsResult);
			} else if (elementType.equalsIgnoreCase("2") && null != obj) {
				AccountsPayableElementsVo payableElementsResult = JsonUtils.toObject(obj,
						AccountsPayableElementsVo.class);
				getRequest().setAttribute("vo", payableElementsResult);
			} else if (elementType.equalsIgnoreCase("3") && null != obj) {
				BillElementsVo billElementsResult = JsonUtils.toObject(obj, BillElementsVo.class);
				getRequest().setAttribute("vo", billElementsResult);
			}
		} else {
			super.log.error("根据资产类型与放款申请id查询保理要素信息: " + tradeResult.getSys().getErortx());
			return null;
		}

		Map<String, Object> mapInfo = new HashMap<String, Object>();
		if (type.equalsIgnoreCase("1")) {// 跳转至应收账款保理要素页面
			mapInfo.put("id", Integer.parseInt(loanApplyId));// 放款申请id
			mapInfo.put("type", E_V4_ATTACHMENT_TYPE.RECEIVABLE_ELEMENTS.getStatus());
			mapInfo.put("category", E_V4_ATTACHMENT_CATEGORY.RISK_FINAL_AUDIT.getStatus());
			// 查询风控措施
			queryAttachmentList(mapInfo);
			// 查询底层资产
			getAssetsById(Integer.valueOf(loanApplyId), Integer.parseInt(type));
			return "ybl4.0/admin/supplier/settlementManagement/tab/receivableElements";
		} else if (type.equalsIgnoreCase("2")) {// 跳转至应付账款保理要素页面
			mapInfo.put("id", Integer.parseInt(loanApplyId));// 放款申请id
			mapInfo.put("type", E_V4_ATTACHMENT_TYPE.PAYABLE_ELEMENTS.getStatus());
			mapInfo.put("category", E_V4_ATTACHMENT_CATEGORY.RISK_FINAL_AUDIT.getStatus());
			// 查询风控措施
			queryAttachmentList(mapInfo);
			// 查询底层资产
			getAssetsById(Integer.valueOf(loanApplyId), Integer.parseInt(type));
			return "ybl4.0/admin/supplier/settlementManagement/tab/payableElements";
		} else if (type.equalsIgnoreCase("3")) {
			mapInfo.put("id", Integer.parseInt(loanApplyId));// 放款申请id
			mapInfo.put("type", E_V4_ATTACHMENT_TYPE.BILL_ELEMENTS.getStatus());
			mapInfo.put("category", E_V4_ATTACHMENT_CATEGORY.RISK_FINAL_AUDIT.getStatus());
			// 查询风控措施
			queryAttachmentList(mapInfo);
			// 查询底层资产
			getAssetsById(Integer.valueOf(loanApplyId), Integer.parseInt(type));
			return "ybl4.0/admin/supplier/settlementManagement/tab/billElements";
		} else {
			return null;
		}

	}

	/**
	 * 条件查询保理要素页面相关附件列表
	 */
	public void queryAttachmentList(Map<String, Object> mapInfo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", mapInfo);
		map.put("sign", "queryRiskAttachmentInfo");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("FactorLoanAudit", map);

		List<AttachmentVo> Attachmentlist = null;
		if (null != result.getSys()) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				if (null != records) {
					Attachmentlist = JsonUtils.toList(records, AttachmentVo.class);
				}
				getRequest().setAttribute("Attachmentlist", Attachmentlist);
				super.log.error("查询风控措施附件服务返回成功，信息：" + Attachmentlist);
			} else {
				super.log.error("查询风控措施附件服务返回失败，信息：" + erortx);
			}
		}
	}

	/**
	 * 根据放款申请id查询底层资产信息
	 */
	public void getAssetsById(int id, Integer assetsType) {
		Map<String, Object> map = new HashMap<String, Object>();
		if (1 == assetsType) {// 应收账款
			Map<String, Object> mapInfo = new HashMap<String, Object>();
			mapInfo.put("id", id);// 放款申请id

			map.put("paramter", mapInfo);
			map.put("sign", "queryReceivableById");// 所调用的服务中的方法
			ResBody result = TradeInvokeUtils.invoke("FactoringElements", map);

			List<AccountsReceivableV4VO> assetslist = null;
			if (null != result.getSys()) {
				String status = result.getSys().getStatus();
				String erortx = result.getSys().getErortx();// 错误信息
				if ("S".equals(status)) {
					JSONObject output = (JSONObject) result.getOutput();
					String records = output.getString("result");
					if (null != records) {
						assetslist = JsonUtils.toList(records, AccountsReceivableV4VO.class);
					}
					getRequest().setAttribute("assetslist", assetslist);
					super.log.error("根据放款申请id查询应收账款服务返回成功，信息：" + assetslist);
				} else {
					super.log.error("根据放款申请id查询应收账款服务返回失败，信息：" + erortx);
				}
			}
		} else if (2 == assetsType) {// 应付账款
			Map<String, Object> mapInfo = new HashMap<String, Object>();
			mapInfo.put("id", id);// 放款申请id

			map.put("paramter", mapInfo);
			map.put("sign", "queryPayableById");// 所调用的服务中的方法
			ResBody result = TradeInvokeUtils.invoke("FactoringElements", map);

			List<AccountsPayableVO> assetslist = null;
			if (null != result.getSys()) {
				String status = result.getSys().getStatus();
				String erortx = result.getSys().getErortx();// 错误信息
				if ("S".equals(status)) {
					JSONObject output = (JSONObject) result.getOutput();
					String records = output.getString("result");
					assetslist = JsonUtils.toList(records, AccountsPayableVO.class);

					getRequest().setAttribute("assetslist", assetslist);
					super.log.error("根据放款申请id查询应付账款服务返回成功，信息：" + assetslist);
				} else {
					super.log.error("根据放款申请id查询应付账款服务返回失败，信息：" + erortx);
				}
			}
		} else if (3 == assetsType) {// 票据
			Map<String, Object> mapInfo = new HashMap<String, Object>();
			mapInfo.put("id", id);// 放款申请id

			map.put("paramter", mapInfo);
			map.put("sign", "queryPayableById");// 所调用的服务中的方法
			ResBody result = TradeInvokeUtils.invoke("FactoringElements", map);

			List<BillVO> assetslist = null;
			if (null != result.getSys()) {
				String status = result.getSys().getStatus();
				String erortx = result.getSys().getErortx();// 错误信息
				if ("S".equals(status)) {
					JSONObject output = (JSONObject) result.getOutput();
					String records = output.getString("result");
					assetslist = JsonUtils.toList(records, BillVO.class);

					getRequest().setAttribute("assetslist", assetslist);
					super.log.error("根据放款申请id查询票据服务返回成功，信息：" + assetslist);
				} else {
					super.log.error("根据放款申请id查询票据服务返回失败，信息：" + erortx);
				}
			}
		}
	}

	/**
     * 根据放款订单号查询资产转让函附件
     * @param orderNo 放款申请订单号
     * @return
     */
    @RequestMapping("/selectAssetAttach")
    public String selectTotalElemets(@RequestParam("loanApplyId") int loanOrderId) {
    	UserVo user = ControllerUtils.getCurrentUser();
 		AttachmentVo attachmentVo = new AttachmentVo();
		attachmentVo.setCategory(7L);
		//attachmentVo.setEnterpriseId(user.getEnterpriseId());
		attachmentVo.setResourceId(loanOrderId);
		attachmentVo.setType("48");
 		List<AttachmentVo> attachmentList = getFwAttachmentList(attachmentVo);
 		getRequest().setAttribute("attch", attachmentList.size() > 0 ? attachmentList.get(0) : null);
    	return "ybl4.0/admin/supplier/settlementManagement/tab/assettransfer";
    }
    
    /**
     * 根据放款订单id查询平台审核结果
     * @param loanApplyId
     * @return
     */
    @RequestMapping("/selectPlatAudiByLoanOrderId")
    public String selectPlatAudiByLoanOrderId(@RequestParam("loanApplyId") String loanApplyId) {
    	Map<String, Object> param = new HashMap<String, Object>();
    	param.put("loan_apply_id",loanApplyId);
    	Map<String,Object> tradeParam = new HashMap<String,Object>();
    	tradeParam.put("parameter", param);
    	tradeParam.put("sign", "selectFlatformAudiByLoan");
		ResBody tradeResult = TradeInvokeUtils.invoke("LoanProjectManagement", tradeParam);
		LoanApply result = null;
 		if(isSuccess(tradeResult)){
			JSONObject totalAmoutoutput = (JSONObject) tradeResult.getOutput(); 
			String totalAmoutrecords = totalAmoutoutput.getString("result");
			result = JsonUtils.toObject(totalAmoutrecords,LoanApply.class);
			getRequest().setAttribute("record", result); 
		}else{
			super.log.error("根据放款订单号查询平台审核结果交易返回错误信息: " + tradeResult.getSys().getErortx());
			return null;
		}
 		
    	return "ybl4.0/admin/supplier/settlementManagement/tab/platAudit";
    }
    
    /**
     * 根据放款订单号查询结算放款信息
     */
    @RequestMapping("/selectSettleInfoByLoanOrderNo")
    public String selectSettleInfoByOrderNo(@RequestParam("orderNo") String orderNo, @RequestParam("financingAmount") String financingAmount) {
    	LoanApply param = new LoanApply();
    	param.setOrderNo(orderNo);
    	Map<String,Object> maps = new HashMap<String,Object>();
		maps.put("parameter", param);
		maps.put("sign", "queryloanReconfirmproject");	//根据放款订单号查询付款批次信息
		ResBody result = TradeInvokeUtils.invoke("LoanProjectManagement", maps);
		FactorLoanManagementLoanBatchSettlementVo factorLoanVo=null;
 		if(isSuccess(result)){
			JSONObject output = (JSONObject) result.getOutput(); 
			String records = output.getString("result");
			factorLoanVo = JsonUtils.toObject(records,FactorLoanManagementLoanBatchSettlementVo.class);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd") ;
			String dateStr = sdf.format(Long.valueOf(factorLoanVo.getActualLoanDate()));
			factorLoanVo.setActualLoanDate(dateStr);
			getRequest().setAttribute("paymentBatch", factorLoanVo);
			getRequest().setAttribute("financingAmount", financingAmount);
		}else{
			super.log.error("根据放款订单号查询付款批次信息交易返回错误信息: " + result.getSys().getErortx());
			return null;
		}
 		if(factorLoanVo != null) {
 			AttachmentVo attachment = new AttachmentVo();
 	 		attachment.setType("50");
 			attachment.setCategory(7L);
 			attachment.setResourceId(Integer.parseInt(factorLoanVo.getId().toString()));
 			List<AttachmentVo> attachmentList = getFwAttachmentList(attachment);
 			if(null != attachmentList && attachmentList.size() > 0) {
 				getRequest().setAttribute("attachment", attachmentList.get(0));
 			}else {
 				getRequest().setAttribute("attachment", null);
 			}
 		}
 		//查询平台费用
 		Map<String,Object> configFree = new HashMap<String,Object>();
		PlatformConfigFree configFreeEntity = new PlatformConfigFree();
		UserVo user = ControllerUtils.getCurrentUser();
		configFreeEntity.setEnterpriseId(user.getEnterpriseId());
		configFree.put("parameter", configFreeEntity);
		configFree.put("sign", "queryPlatformConfigFreeByCondition");	
		ResBody configFreeResult = TradeInvokeUtils.invoke("V4PlatformConfigFreeManagement", configFree);
		PlatformConfigFree configFreeReturnPage=null;
		isSuccess(configFreeResult);
		List<PlatformConfigFree> platformConfigFreeList = null;
 		if(isSuccess(result)){
			JSONObject configFreeoutput = (JSONObject) configFreeResult.getOutput();
			String configFreerecords = configFreeoutput.getString("result");
			platformConfigFreeList = JsonUtils.toList(configFreerecords, PlatformConfigFree.class);
			if(platformConfigFreeList.size() > 0) {
				configFreeReturnPage = platformConfigFreeList.get(0);
				getRequest().setAttribute("platformConfigFree", configFreeReturnPage);
				BigDecimal actual_rate = configFreeReturnPage.getRate().subtract(configFreeReturnPage.getReductionRate()); //实际费率
				BigDecimal plat_free = factorLoanVo.getActualLoanAmount().multiply(actual_rate).divide(new BigDecimal(100),4,BigDecimal.ROUND_HALF_UP); //平台实际费用
				getRequest().setAttribute("plat_free", plat_free);//平台费用
			}
		}else{
			super.log.error("根据企业ID查询平台费用交易返回错误信息: " + configFreeResult.getSys().getErortx());
			return null;
		}
 		return "ybl4.0/admin/supplier/settlementManagement/tab/paymentInfo";
    }
    
    /**
     *  平台资金流水实体
     * @param req
     * @return
     */
    private PlatformCapitalFlow getPlatformCapitalFlowFromHttpRequest(HttpServletRequest req) {
    	PlatformCapitalFlow platformCapitalFlow = new PlatformCapitalFlow(); //资金流水实体类
    	platformCapitalFlow.setEnterpriseId(ControllerUtils.getCurrentUser().getEnterpriseId());
    	platformCapitalFlow.setPaymentBatchNo(req.getParameter("batch_no"));
    	platformCapitalFlow.setLoanOrderNo(req.getParameter("orderNo"));
    	platformCapitalFlow.setPlatformRate(new BigDecimal(req.getParameter("rate")));
    	platformCapitalFlow.setReductionRate(new BigDecimal(req.getParameter("reductionRate")));
    	platformCapitalFlow.setPaidPlatformFee(new BigDecimal(req.getParameter("paidPlatformFee")));
    	platformCapitalFlow.setStatus(E_V4_PLATFORM_FREE_STATE.PLATFORM_TO_BE_CONFIRM.getStatus());//1-平台费用未确认
    	return platformCapitalFlow;
    }
    
    
    
    /**
	 * 放款综合查询详情，根据放款id单得id查询
	 * 
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/selectChildrenDetail.htm")
	public String details(@Param("id") Long id,@Param("url") String url) {
		//通过放款定单的id查询详情页面所需得参数
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id_", id);
		map.put("sign", "selectloanApplyById");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("LoanApplicationQuery", map);
		LoanapplyChildrenQueryVO loan = new LoanapplyChildrenQueryVO();
		isSuccess(result);
		JSONObject output = (JSONObject) result.getOutput();
		String resultJson = output.getString("loan");
		if(resultJson != null){
			loan = JsonUtils.toObject(resultJson, LoanapplyChildrenQueryVO.class);
			getRequest().setAttribute("id", id);
			getRequest().setAttribute("orderno", loan.getOrder_no());
			getRequest().setAttribute("type", loan.getAssets_type());
			getRequest().setAttribute("financingAmount", loan.getFinancing_amount());
			getRequest().setAttribute("batch_id", loan.getPayment_batch_id());
			getRequest().setAttribute("url", url);
			String attribute1=loan.getAttribute1();
			String attribute2=loan.getAttribute2();
			int financingstatus=loan.getStatus();
			if(financingstatus==0){
				getRequest().setAttribute("financingstatus", 0);
			}else{
				getRequest().setAttribute("financingstatus", financingstatus);
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
			
		}
		
		return "ybl4.0/admin/supplier/settlementManagement/commonApiConFir";
		}
}
