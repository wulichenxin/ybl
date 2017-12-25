package com.bpm.framework.controller.v4.supplier.loanApply;

import java.beans.PropertyEditorSupport;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.annotation.Log;
import com.bpm.framework.annotation.OperationType;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.controller.v4.common.FinancingApplyCommonApi;
import com.bpm.framework.utils.i18n.I18NUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.AttachmentVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v4.drools.V4BusinessAuthVO;
import cn.sunline.framework.controller.vo.v4.drools.enums.E_V4_AUTH_STATUS;
import cn.sunline.framework.controller.vo.v4.drools.enums.E_V4_AUTH_TYPE;
import cn.sunline.framework.controller.vo.v4.factor.ContractQuotaV4Vo;
import cn.sunline.framework.controller.vo.v4.factor.enums.E_V4_ATTACHMENT_CATEGORY;
import cn.sunline.framework.controller.vo.v4.factor.enums.E_V4_ATTACHMENT_TYPE;
import cn.sunline.framework.controller.vo.v4.supplier.AccountsPayableVO;
import cn.sunline.framework.controller.vo.v4.supplier.AccountsReceivableV4VO;
import cn.sunline.framework.controller.vo.v4.supplier.BillVO;
import cn.sunline.framework.controller.vo.v4.supplier.FinancingApplyVO;
import cn.sunline.framework.controller.vo.v4.supplier.FormFinancingObject;
import cn.sunline.framework.controller.vo.v4.supplier.LoanApply;
import cn.sunline.framework.controller.vo.v4.supplier.SubFinancingApplyVO;
import cn.sunline.framework.controller.vo.v4.supplier.enums.E_V4_ASSETS_TYPE;
import cn.sunline.framework.controller.vo.v4.supplier.enums.E_V4_FINANCING_STATE;
import cn.sunline.framework.controller.vo.v4.supplier.enums.E_V4_IS_USE;
import cn.sunline.framework.controller.vo.v4.supplier.enums.E_V4_LOAN_STATE;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 云保理4.0融资方申请放款控制器
 */
@Controller
@RequestMapping({ "/loanApplyV4Controller" })
public class LoanApplyV4Controller extends AbstractController {

	private static final long serialVersionUID = 1L;
	
	/**
	 * 跳转到放款申请新增页面
	 * @return
	 */
	@RequestMapping(value = "/loanApply/add.htm")
	public String add(@RequestParam("financingApplyId")Integer financingApplyId, @RequestParam("subId")Integer subId) {
		UserVo user = ControllerUtils.getCurrentUser();
		if(user == null ){
			super.log.error("请先登录");
			return "ybl4.0/admin/doorl/login";
		}
		// 1.获取放款申请订单申请人信息
		V4BusinessAuthVO businessAuthVO = new V4BusinessAuthVO();
        businessAuthVO.setAuthStatus(E_V4_AUTH_STATUS.AUDITSUCCESS.getStatus());
		businessAuthVO.setEnterpriseId(user.getEnterpriseId());
		V4BusinessAuthVO businessAuth=queryNewestBusinessAuth(businessAuthVO);
		// 2.获取融资申请订单内容
		FinancingApplyVO financingApplyVO = new FinancingApplyVO();
		financingApplyVO.setApply_id(financingApplyId.longValue());
		financingApplyVO.setId(financingApplyId.longValue());
		FinancingApplyVO financingApply = FinancingApplyCommonApi.getFinancingApply(financingApplyVO.getId());
		// 3.获取融资申请子订单内容
		Map<String,Object> maps = new HashMap<String,Object>();
		SubFinancingApplyVO subFinancingApplyVO = new SubFinancingApplyVO();
		subFinancingApplyVO.setId(subId.longValue());
		maps.put("subFinancingApply", subFinancingApplyVO);
		maps.put("sign", "selectSubFinancingApply");//所调用的服务中的方法		
		ResBody result = TradeInvokeUtils.invoke("FinancingApplyManagement", maps);
		List<SubFinancingApplyVO> subFinancingApplyVOList =  null;
 		if(result.getSys()!=null){
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();//错误信息	
			if("S".equals(status)){//交易成功
				log.info("查询子融资查询交易成功====================");
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("financingSubApplyList");
				subFinancingApplyVOList=JsonUtils.toList(records,SubFinancingApplyVO.class);
				if (subFinancingApplyVOList.size() > 0) {
					getRequest().setAttribute("subFinancingApply", subFinancingApplyVOList.get(0));
				}
			}else{
				super.log.error("查询子融资返回失败，信息："+erortx);
				return null;
			}		
 		}
		getRequest().setAttribute("businessAuth", businessAuth);
		getRequest().setAttribute("financingApply", financingApply);
		getRequest().setAttribute("financingApplyId", financingApply.getId());
		getRequest().setAttribute("operType", "insert");
		return "ybl4.0/admin/supplier/loanApply/add";
	}
	
	/**
	 * 根据条件查合同额度信息
	 * @param parameters
	 * @param page
	 * @return
	 */
	@RequestMapping(value="/loanApply/getContractInfo")
	@ResponseBody
	private ControllerResponse querycontractQuotaByCondition(ContractQuotaV4Vo parameters, PageVo<?> page) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		// 调用服务，进行数据查询
		List<?> list =  queryContract(parameters,page);
		if (list.size() > 0) {
			response.setResponseType(ResponseType.SUCCESS);
			response.setObject(list.get(0));
		}
		return response;
	}
	
	/**
	 * 修改
	 * @return
	 */
	@RequestMapping(value = "/loanApply/update.htm")
	public String update(@RequestParam("id")Long id) {
		UserVo user = ControllerUtils.getCurrentUser();
		if(user == null ){
			super.log.error("请先登录");
			return "ybl4.0/admin/doorl/login";
		}
		// 获取放款申请主信息
		LoanApply loanApply = new LoanApply();
		loanApply.setId(id);
		loanApply.setFinancierBusinessId(user.getBusinessId().intValue());
		LoanApply loanApplyVO = new LoanApply();
		List<LoanApply> loanApplyList = selectLoanApplyList(loanApply);
		if (loanApplyList.size() > 0) {
			loanApplyVO = loanApplyList.get(0);
		}
		SubFinancingApplyVO subFinancingApplyVO = new SubFinancingApplyVO();
		subFinancingApplyVO.setId(loanApplyVO.getSubFinancingApplyId().longValue());
		List<SubFinancingApplyVO> subList = getSubList(subFinancingApplyVO);
		if (subList.size() > 0) {
			getRequest().setAttribute("financingApplyId", subList.get(0).getFinancing_apply_id());
		}
		// 获取资料列表
		AttachmentVo attachmentVo = new AttachmentVo();
		attachmentVo.setCategory(new Long((long)E_V4_ATTACHMENT_CATEGORY.LOAN_APPLY.getStatus()));
		attachmentVo.setEnterpriseId(user.getEnterpriseId());
		attachmentVo.setResourceId(loanApplyVO.getId().intValue());
		List<AttachmentVo> attachmentVoList = FinancingApplyCommonApi.getFwAttachmentList(attachmentVo);
		// 获取附件列表
		AttachmentVo attachment = new AttachmentVo();
		attachment.setCategory(new Long((long)E_V4_ATTACHMENT_CATEGORY.LOAN_APPLY.getStatus()));
		attachment.setType(String.valueOf(E_V4_ATTACHMENT_TYPE.LOAN_ASSETS.getStatus()));
		attachment.setEnterpriseId(user.getEnterpriseId());
		attachment.setResourceId(loanApplyVO.getId().intValue());
		List<AttachmentVo> assetList = FinancingApplyCommonApi.getFwAttachmentList(attachment);
		// 根据资产类型查找资产列表
		if (loanApplyVO.getAssetsType() == E_V4_ASSETS_TYPE.ACCOUNTS_RECEIVABLE.getStatus()) {
			// 应收账款
			AccountsReceivableV4VO accountsReceivableV4VO = new AccountsReceivableV4VO();
			accountsReceivableV4VO.setLoanApplyId(loanApplyVO.getId().intValue());
			List<AccountsReceivableV4VO> accountsReceivableList = selectAccountsReceivableList(accountsReceivableV4VO);
			getRequest().setAttribute("receivableList", accountsReceivableList);
		} else if (loanApplyVO.getAssetsType() == E_V4_ASSETS_TYPE.ACCOUNTS_PAYABLE.getStatus()) {
			// 应付账款
			AccountsPayableVO accountsPayableVO = new AccountsPayableVO();
			accountsPayableVO.setLoanApplyId(loanApplyVO.getId().intValue());
			List<AccountsPayableVO> accountsPayableList = selectAccountsPayableList(accountsPayableVO);
			getRequest().setAttribute("repayableList", accountsPayableList);
		} else if (loanApplyVO.getAssetsType() == E_V4_ASSETS_TYPE.BILL.getStatus()) {
			// 票据
			BillVO billVO = new BillVO();
			billVO.setLoanApplyId(loanApplyVO.getId().intValue());
			List<BillVO> billList = selectBillList(billVO);
			getRequest().setAttribute("billList", billList);
		}
		
		
		// 得到的列表按类型分别放到attribute里
		setAttachmentToAttr(attachmentVoList);
		getRequest().setAttribute("loanApplyVO", loanApplyVO);
		getRequest().setAttribute("assetList", assetList);
		getRequest().setAttribute("operType", "update");
		return "ybl4.0/admin/supplier/loanApply/add";
	}

	/**
	 * 新增融资申请
	 * @param financingApplyVO
	 * @param applicantFinancialSituationVO
	 * @param formFinancingObject
	 * @param deleteEnterpriseLoanIdArray
	 * @param deletePersonDebtIdArray
	 * @param deleteGuaranteeIdArray
	 * @param deleteReceivableIdArray
	 * @param deleteRepayableIdArray
	 * @param deleteBillIdArray
	 * @param financingApplyId
	 * @param status
	 * @return
	 */
	@RequestMapping(value = "/loanApply/saveAll")
	@ResponseBody
	@Log(operation=OperationType.Add, info="新增或修改放款申请")
	public ControllerResponse saveAll(FormFinancingObject formFinancingObject, LoanApply loanApplyVO, Long loanApplyId,
			String deleteReceivableIdArray,String deleteRepayableIdArray, String deleteBillIdArray, String deleteFileIdArray) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		UserVo user = ControllerUtils.getCurrentUser();
		if(user == null ){
			super.log.error("请先登录");
			return response;
		}
		// 应收账款
        List<AccountsReceivableV4VO> accountsReceivableList = formFinancingObject.getReceivableList();
        // 应付账款
        List<AccountsPayableVO> accountsPayableList = formFinancingObject.getRepayableList();
        // 票据
        List<BillVO> billList = formFinancingObject.getBillList();

        // 资料清单
        List<AttachmentVo> dataAttachmentList =  formFinancingObject.getDataAttachmentList();

        // 资产附件
        List<AttachmentVo> assetList =  formFinancingObject.getAssetList();
        
		// 1.校验
        if (E_V4_LOAN_STATE.TO_FUNDER_AUDI.getStatus() == loanApplyVO.getStatus()) {
            // 放款申请信息
            if (null == loanApplyVO.getFinancing_amount() || loanApplyVO.getFinancing_amount().compareTo(BigDecimal.ZERO) == -1) {
                response.setInfo("融资金额不能为空或者小于0");
                return response;
            }
            if (null == loanApplyVO.getFinancingTerm() || loanApplyVO.getFinancingTerm().intValue() < 0) {
                response.setInfo("融资期限不能为空或者小于0");
                return response;
            }
            if (null == loanApplyVO.getFinancingRate() || loanApplyVO.getFinancingRate().compareTo(BigDecimal.ZERO) == -1
                    || loanApplyVO.getFinancingRate().compareTo(new BigDecimal(100)) == 1) {
                response.setInfo("融资利率不能为空或者小于0大于100");
                return response;
            }
            // 资产
            StringBuffer strBuffer = new StringBuffer();
            if (loanApplyVO.getAssetsType() == E_V4_ASSETS_TYPE.ACCOUNTS_RECEIVABLE.getStatus()) {
                // 应收账款
                for (int i = 0; i < accountsReceivableList.size(); i++) {
                    AccountsReceivableV4VO checkVO = accountsReceivableList.get(i);
                    if (null == checkVO.getCustomerName() || "".equals(checkVO.getCustomerName())) {
                        strBuffer.append("应收账款").append("第").append(i+1).append("行").append("客户名称不能为空");
                        response.setInfo(strBuffer.toString());
                        return response;
                    }
                    if (null == checkVO.getOrderInfo() || "".equals(checkVO.getOrderInfo())) {
                        strBuffer.append("应收账款").append("第").append(i+1).append("行").append("订单信息不能为空");
                        response.setInfo(strBuffer.toString());
                        return response;
                    }
                    if (null == checkVO.getOrderAmount() || checkVO.getOrderAmount().compareTo(BigDecimal.ZERO) == -1) {
                        strBuffer.append("应收账款").append("第").append(i+1).append("行").append("订单金额不能为空并且不能小于0");
                        response.setInfo(strBuffer.toString());
                        return response;
                    }
                    if (null == checkVO.getAmountsReceivableMoney() || checkVO.getAmountsReceivableMoney().compareTo(BigDecimal.ZERO) == -1) {
                        strBuffer.append("应收账款").append("第").append(i+1).append("行").append("应收账款金额不能为空并且不能小于0");
                        response.setInfo(strBuffer.toString());
                        return response;
                    }
                    if (null == checkVO.getSignDate()) {
                        strBuffer.append("应收账款").append("第").append(i+1).append("行").append("签署日期不能为空");
                        response.setInfo(strBuffer.toString());
                        return response;
                    }
                    if (null == checkVO.getExpectedPaymentDate()) {
                        strBuffer.append("应收账款").append("第").append(i+1).append("行").append("预支付日期不能为空");
                        response.setInfo(strBuffer.toString());
                        return response;
                    }
                    if (null == checkVO.getInvoiceInfo() || "".equals(checkVO.getInvoiceInfo())) {
                        strBuffer.append("应收账款").append("第").append(i+1).append("行").append("发票信息不能为空");
                        response.setInfo(strBuffer.toString());
                        return response;
                    }
                }
            } else if (loanApplyVO.getAssetsType() == E_V4_ASSETS_TYPE.ACCOUNTS_PAYABLE.getStatus()) {
                // 应付账款
                for (int i = 0; i < accountsPayableList.size(); i++) {
                    AccountsPayableVO checkVO = accountsPayableList.get(i);
                    if (null == checkVO.getSupplierName() || "".equals(checkVO.getSupplierName())) {
                        strBuffer.append("应付账款").append("第").append(i+1).append("行").append("供应商名称不能为空");
                        response.setInfo(strBuffer.toString());
                        strBuffer.delete(0, strBuffer.length());
                        return response;
                    }
                    if (null == checkVO.getOrderInfo() || "".equals(checkVO.getOrderInfo())) {
                        strBuffer.append("应付账款").append("第").append(i+1).append("行").append("订单信息不能为空");
                        response.setInfo(strBuffer.toString());
                        strBuffer.delete(0, strBuffer.length());
                        return response;
                    }
                    if (null == checkVO.getOrderAmount() || checkVO.getOrderAmount().compareTo(BigDecimal.ZERO) == -1) {
                        strBuffer.append("应付账款").append("第").append(i+1).append("行").append("订单金额不能为空并且不能小于0");
                        response.setInfo(strBuffer.toString());
                        strBuffer.delete(0, strBuffer.length());
                        return response;
                    }
                    if (null == checkVO.getAmountsPayableMoney() || checkVO.getAmountsPayableMoney().compareTo(BigDecimal.ZERO) == -1) {
                        strBuffer.append("应付账款").append("第").append(i+1).append("行").append("应付账款金额不能为空并且不能小于0");
                        response.setInfo(strBuffer.toString());
                        strBuffer.delete(0, strBuffer.length());
                        return response;
                    }
                    if (null == checkVO.getSignDate()) {
                        strBuffer.append("应付账款").append("第").append(i+1).append("行").append("签署日期不能为空");
                        response.setInfo(strBuffer.toString());
                        strBuffer.delete(0, strBuffer.length());
                        return response;
                    }
                    if (null == checkVO.getExpectedPaymentDate()) {
                        strBuffer.append("应付账款").append("第").append(i+1).append("行").append("预支付日期不能为空");
                        response.setInfo(strBuffer.toString());
                        strBuffer.delete(0, strBuffer.length());
                        return response;
                    }
                    if (null == checkVO.getInvoiceInfo() || "".equals(checkVO.getInvoiceInfo())) {
                        strBuffer.append("应付账款").append("第").append(i+1).append("行").append("发票信息不能为空");
                        response.setInfo(strBuffer.toString());
                        strBuffer.delete(0, strBuffer.length());
                        return response;
                    }
                }
            } else if (loanApplyVO.getAssetsType() == E_V4_ASSETS_TYPE.BILL.getStatus()) {
                // 票据
                for (int i = 0; i < billList.size(); i++) {
                    BillVO checkVO = billList.get(i);
                    if (null == checkVO.getAcceptorName() || "".equals(checkVO.getAcceptorName())) {
                        strBuffer.append("票据").append("第").append(i+1).append("行").append("承兑人名称不能为空");
                        response.setInfo(strBuffer.toString());
                        strBuffer.delete(0, strBuffer.length());
                        return response;
                    }
                    if (null == checkVO.getBillNo() || "".equals(checkVO.getBillNo())) {
                        strBuffer.append("票据").append("第").append(i+1).append("行").append("票据号码不能为空");
                        response.setInfo(strBuffer.toString());
                        strBuffer.delete(0, strBuffer.length());
                        return response;
                    }
                    if (null == checkVO.getOrderAmount() || checkVO.getOrderAmount().compareTo(BigDecimal.ZERO) == -1) {
                        strBuffer.append("票据").append("第").append(i+1).append("行").append("订单金额不能为空并且不能小于0");
                        response.setInfo(strBuffer.toString());
                        strBuffer.delete(0, strBuffer.length());
                        return response;
                    }
                    if (null == checkVO.getBillAmount() || checkVO.getBillAmount().compareTo(BigDecimal.ZERO) == -1) {
                        strBuffer.append("票据").append("第").append(i+1).append("行").append("票据金额不能为空并且不能小于0");
                        response.setInfo(strBuffer.toString());
                        strBuffer.delete(0, strBuffer.length());
                        return response;
                    }
                    if (null == checkVO.getBillingDate()) {
                        strBuffer.append("票据").append("第").append(i+1).append("行").append("出票日期不能为空");
                        response.setInfo(strBuffer.toString());
                        strBuffer.delete(0, strBuffer.length());
                        return response;
                    }
                    if (null == checkVO.getExpireDate()) {
                        strBuffer.append("票据").append("第").append(i+1).append("行").append("到期日期不能为空");
                        response.setInfo(strBuffer.toString());
                        strBuffer.delete(0, strBuffer.length());
                        return response;
                    }
                    if (null == checkVO.getSignDate()) {
                        strBuffer.append("票据").append("第").append(i+1).append("行").append("签署日期不能为空");
                        response.setInfo(strBuffer.toString());
                        strBuffer.delete(0, strBuffer.length());
                        return response;
                    }
                }
            }
            
            // 判断资产是否被占用
            StringBuffer strUse = new StringBuffer();
            // 应收账款
            if (loanApplyVO.getAssetsType() == E_V4_ASSETS_TYPE.ACCOUNTS_RECEIVABLE.getStatus()) {
                for (AccountsReceivableV4VO vo : accountsReceivableList) {
                    if (null != vo.getPid() && vo.getPid().intValue() != 0) {
                        // pid不为空则说明引用融资申请资产
                        AccountsReceivableV4VO check = new AccountsReceivableV4VO();
                        check.setId(vo.getPid().longValue());
                        List<AccountsReceivableV4VO> list = selectAccountsReceivableList(check);
                        if (null != list && list.size() > 0) {
                            if (E_V4_IS_USE.NOTUSED.getStatus() != list.get(0).getIsUse()) {
                                strUse.append("底层资产被占用或被使用,编号为:").append(list.get(0).getAssetNumber());
                                response.setInfo(strUse.toString());
                                strUse.delete(0, strUse.length());
                                return response;
                            }
                        }
                    }
                }
            }
            // 应付账款
            if (loanApplyVO.getAssetsType() == E_V4_ASSETS_TYPE.ACCOUNTS_PAYABLE.getStatus()) {
                for (AccountsPayableVO vo : accountsPayableList) {
                    if (null != vo.getPid() && vo.getPid().intValue() != 0) {
                        // pid不为空则说明引用融资申请资产
                        AccountsPayableVO check = new AccountsPayableVO();
                        check.setId(vo.getPid().longValue());
                        List<AccountsPayableVO> list = selectAccountsPayableList(check);
                        if (null != list && list.size() > 0) {
                            if (E_V4_IS_USE.NOTUSED.getStatus() != list.get(0).getIsUse()) {
                                strUse.append("底层资产被占用或被使用,编号为:").append(list.get(0).getAssetNumber());
                                response.setInfo(strUse.toString());
                                strUse.delete(0, strUse.length());
                                return response;
                            }
                        }
                    }
                }
            }
            // 票据
            if (loanApplyVO.getAssetsType() == E_V4_ASSETS_TYPE.BILL.getStatus()) {
                for (BillVO vo : billList) {
                    if (null != vo.getPid() && vo.getPid().intValue() != 0) {
                        // pid不为空则说明引用融资申请资产
                        BillVO check = new BillVO();
                        check.setId(vo.getPid().longValue());
                        List<BillVO> list = selectBillList(check);
                        if (null != list && list.size() > 0) {
                            if (E_V4_IS_USE.NOTUSED.getStatus() != list.get(0).getIsUse()) {
                                strUse.append("底层资产被占用或被使用,编号为:").append(list.get(0).getAssetNumber());
                                response.setInfo(strUse.toString());
                                strUse.delete(0, strUse.length());
                                return response;
                            }
                        }
                    }
                }
            }
            
            // 资料清单
            for (AttachmentVo checkVO : dataAttachmentList) {
                if (E_V4_ATTACHMENT_TYPE.LOAN_PURCHASE_SALE_CONTRACT.getStatus().equals(checkVO.getType())) {
                    if (null == checkVO.getUrl() || "".equals(checkVO.getUrl())) {
                        response.setInfo("购销合同文件未上传");
                        return response;
                    }
                } else if (E_V4_ATTACHMENT_TYPE.LOAN_SALES_INVOICE.getStatus().equals(checkVO.getType())) {
                    if (null == checkVO.getUrl() || "".equals(checkVO.getUrl())) {
                        response.setInfo("销售发票(含清单)文件未上传");
                        return response;
                    }
                }
            }
            
            // 判断金额是否大于可用余额
            ContractQuotaV4Vo parameter = new ContractQuotaV4Vo();
            PageVo<?> page = new PageVo<Object>();
            parameter.setMasterContractNo(loanApplyVO.getMasterContractNo());
            List<?> list =  queryContract(parameter,page);
            if (list.size() > 0) {
                JSONObject json = (JSONObject) list.get(0);
                ContractQuotaV4Vo contractQuotaV4Vo = JSONObject.toJavaObject(json, ContractQuotaV4Vo.class);
                if (null == contractQuotaV4Vo) {
                    response.setInfo("获取合同信息为空");
                    return response;
                }
                BigDecimal financingAmount = loanApplyVO.getFinancing_amount();
                if (null != financingAmount) {
                    if (null != contractQuotaV4Vo.getAllAmount()) {
                        if (contractQuotaV4Vo.getAllAmount().compareTo(new BigDecimal(0)) == -1
                                || contractQuotaV4Vo.getAllAmount().compareTo(new BigDecimal(0)) == 0) {
                            response.setInfo("剩余可用余额小于等于0,不能进行放款申请");
                            return response;
                        }
                        if (financingAmount.compareTo(contractQuotaV4Vo.getAllAmount()) == 1) {
                            response.setInfo("融资金额不能大于剩余可用余额");
                            return response;
                        }
                    } else {
                        response.setInfo("获取可用余额为空");
                        return response;
                    }
                }
            }
        }
		
		ControllerUtils.setWho(loanApplyVO);
		loanApplyVO.setId(loanApplyId);
		// 2.设置businessid
		loanApplyVO.setFinancierBusinessId(user.getBusinessId().intValue());
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("loanApplyVO", loanApplyVO);
		
		// 3.用于查询是否存在企业
		V4BusinessAuthVO businessAuthVO = new V4BusinessAuthVO();
		businessAuthVO.setAuthType(E_V4_AUTH_TYPE.COREENTERPRISE.getStatus());
		// 用来校验
        StringBuffer temp = new StringBuffer();
		// 4.应收账款集合
		for (int i = 0; i < accountsReceivableList.size(); i++) {
			AccountsReceivableV4VO vo = accountsReceivableList.get(i);
			if (null == vo.getId() || vo.getId().intValue() == 0){
                if ("".equals(vo.getAssetNumber().trim()) && "".equals(vo.getCustomerName().trim()) && "".equals(vo.getOrderInfo().trim()) 
                        && null == vo.getOrderAmount() && null == vo.getOrderUnitPrice() && null == vo.getOrderNumber()
                        && null == vo.getAmountsReceivableMoney() && null == vo.getSignDate() && null == vo.getExpectedPaymentDate()
                        && "".equals(vo.getInvoiceInfo().trim()) && "".equals(vo.getRemark().trim())) {
                    accountsReceivableList.remove(i);
                    i--;
                    continue;
                }
            }
            // 校验底层资产对象
            if (E_V4_LOAN_STATE.TO_FUNDER_AUDI.getStatus() == loanApplyVO.getStatus() 
                    && E_V4_ASSETS_TYPE.ACCOUNTS_RECEIVABLE.getStatus() == loanApplyVO.getAssetsType().intValue()) {
                if (i == 0) {
                    temp.append(vo.getCustomerName());
                } else {
                    if (!temp.toString().equals(vo.getCustomerName())) {
                        response.setInfo("底层资产对象不一致");
                        return response;
                    } else {
                        temp.delete(0, temp.length());
                        temp.append(vo.getCustomerName());
                    }
                }
            }
			ControllerUtils.setWho(vo);
			if (null == vo.getFinancingApplyId()) {
				// 判断客户名称是否是系统里的已认证核心企业
				businessAuthVO.setEnterpriseName(vo.getCustomerName());
				V4BusinessAuthVO businessAuth = selectOneBusinessAuthByName(businessAuthVO);
				if (null != businessAuth) {
					if (businessAuth.getId() != null && businessAuth.getId() != 0L) {
						vo.setBusinessId(businessAuth.getId().intValue());
					}
				}
			}
			// 设置实际预计支付日期,后面保理要素用到
			vo.setExpectedPaymentDateActual(vo.getExpectedPaymentDate());
		}
		map.put("accountsReceivableV4List", accountsReceivableList);
		
		// 5.应付账款集合
		for (int i = 0; i < accountsPayableList.size(); i++) {
			AccountsPayableVO vo = accountsPayableList.get(i);
			if (null == vo.getId() || vo.getId().intValue() == 0){
                if ("".equals(vo.getAssetNumber().trim()) && "".equals(vo.getSupplierName().trim()) && "".equals(vo.getOrderInfo().trim()) 
                        && null == vo.getOrderAmount() && null == vo.getOrderUnitPrice() && null == vo.getOrderNumber()
                        && null == vo.getAmountsPayableMoney() && null == vo.getSignDate() && null == vo.getExpectedPaymentDate()
                        && "".equals(vo.getInvoiceInfo().trim()) && "".equals(vo.getRemark().trim())) {
                    accountsPayableList.remove(i);
                    i--;
                    continue;
                }
            }
            // 校验底层资产对象
            if (E_V4_LOAN_STATE.TO_FUNDER_AUDI.getStatus() == loanApplyVO.getStatus()
                    && E_V4_ASSETS_TYPE.ACCOUNTS_PAYABLE.getStatus() == loanApplyVO.getAssetsType().intValue()) {
                if (i == 0) {
                    temp.append(vo.getSupplierName());
                } else {
                    if (!temp.toString().equals(vo.getSupplierName())) {
                        response.setInfo("底层资产对象不一致");
                        return response;
                    } else {
                        temp.delete(0, temp.length());
                        temp.append(vo.getSupplierName());
                    }
                }
            }
			ControllerUtils.setWho(vo);
			if (null == vo.getFinancingApplyId()) {
				// 判断供应商名称是否是系统里的已认证核心企业
				businessAuthVO.setEnterpriseName(vo.getSupplierName());
				V4BusinessAuthVO businessAuth = selectOneBusinessAuthByName(businessAuthVO);
				if (null != businessAuth) {
					if (businessAuth.getId() != null && businessAuth.getId() != 0L) {
						vo.setBusinessId(businessAuth.getId().intValue());
					}
				}
			} 
			// 设置实际预计支付日期,后面保理要素用到
			vo.setExpectedPaymentDateActual(vo.getExpectedPaymentDate());
		}
		map.put("accountsPayableList", accountsPayableList);
		
		// 6.票据集合
		for (int i = 0; i < billList.size(); i++) {
			BillVO vo = billList.get(i);
			if (null == vo.getId() || vo.getId().intValue() == 0){
                if ("".equals(vo.getAssetNumber().trim()) && "".equals(vo.getAcceptorName().trim()) && "".equals(vo.getBillNo().trim()) 
                        && "".equals(vo.getOrderInfo().trim()) && null == vo.getOrderAmount() && null == vo.getOrderUnitPrice() && null == vo.getOrderNumber()
                        && null == vo.getBillAmount() && null == vo.getSignDate() && null == vo.getExpireDate() && null == vo.getBillingDate()
                        && "".equals(vo.getInvoiceInfo().trim()) && "".equals(vo.getRemark().trim())) {
                    billList.remove(i);
                    i--;
                    continue;
                }
            }
            // 校验底层资产对象
            if (E_V4_LOAN_STATE.TO_FUNDER_AUDI.getStatus() == loanApplyVO.getStatus()
                    && E_V4_ASSETS_TYPE.BILL.getStatus() == loanApplyVO.getAssetsType().intValue()) {
                if (i == 0) {
                    temp.append(vo.getAcceptorName());
                } else {
                    if (!temp.toString().equals(vo.getAcceptorName())) {
                        response.setInfo("底层资产对象不一致");
                        return response;
                    } else {
                        temp.delete(0, temp.length());
                        temp.append(vo.getAcceptorName());
                    }
                }
            }
			ControllerUtils.setWho(vo);
			if (null == vo.getFinancingApplyId()) {
				// 判断承兑人名称是否是系统里的已认证核心企业
				businessAuthVO.setEnterpriseName(vo.getAcceptorName());
				V4BusinessAuthVO businessAuth = selectOneBusinessAuthByName(businessAuthVO);
				if (null != businessAuth) {
					if (businessAuth.getId() != null && businessAuth.getId() != 0L) {
						vo.setBusinessId(businessAuth.getId().intValue());
					}
				}
			}
			// 设置实际到期日期,后面保理要素用到
			vo.setExpireDateActual(vo.getExpireDate());
		}
		map.put("billList", billList);
		
		// 底层资产至少需要一条
        if (E_V4_LOAN_STATE.TO_FUNDER_AUDI.getStatus() == loanApplyVO.getStatus()) {
            // 应收账款
            if (loanApplyVO.getAssetsType() == E_V4_ASSETS_TYPE.ACCOUNTS_RECEIVABLE.getStatus()) {
                if (accountsReceivableList.size() == 0) {
                    response.setInfo("底层资产至少需要一条");
                    return response;
                }
            }
            // 应付账款
            if (loanApplyVO.getAssetsType() == E_V4_ASSETS_TYPE.ACCOUNTS_PAYABLE.getStatus()) {
                if (accountsPayableList.size() == 0) {
                    response.setInfo("底层资产至少需要一条");
                    return response;
                }
            }
            // 票据
            if (loanApplyVO.getAssetsType() == E_V4_ASSETS_TYPE.BILL.getStatus()) {
                if (billList.size() == 0) {
                    response.setInfo("底层资产至少需要一条");
                    return response;
                }
            }
        }
		
		// 7.去除为空的附件
		for (int i = 0; i < dataAttachmentList.size(); i++) {
			AttachmentVo attachment = dataAttachmentList.get(i);
			if (attachment == null) {
				dataAttachmentList.remove(i);
				i--;
			} else {
				if (null == attachment.getUrl() || "".equals(attachment.getUrl())) {
					dataAttachmentList.remove(i);
					i--;
				} else {
					dataAttachmentList.get(i).setEnterpriseId(user.getEnterpriseId());
					ControllerUtils.setWho(dataAttachmentList.get(i));
				}
			}
		}
		for (int i = 0; i < assetList.size(); i++) {
			AttachmentVo attachment = assetList.get(i);
			if (attachment == null) {
				assetList.remove(i);
				i--;
			} else {
				if (null == attachment.getUrl() || "".equals(attachment.getUrl())) {
					assetList.remove(i);
					i--;
				} else {
					assetList.get(i).setEnterpriseId(user.getEnterpriseId());
					ControllerUtils.setWho(assetList.get(i));
				}
			}
		}
		
		if (E_V4_LOAN_STATE.TO_FUNDER_AUDI.getStatus() == loanApplyVO.getStatus()) {
    		if (assetList.size() < 1) {
    		    response.setInfo("底层资产附件未上传");
                return response;
    		}
		}
		
		map.put("dataAttachmentList", dataAttachmentList);
		
		map.put("assetList", assetList);
		
		
		if (null == loanApplyVO.getId() || loanApplyVO.getId() == 0L) {
			// 新增
			// 设置订单号
			List<LoanApply> loanApplyList = selectLoanApplyList(loanApplyVO);
			StringBuffer strNo = new StringBuffer(loanApplyVO.getFinancingOrderNumber());
			strNo.append("-B");
			if (loanApplyList.size() > 0) {
				LoanApply loan = loanApplyList.get(0);
				if (null != loan.getOrderNo() && !"".equals(loan.getOrderNo().trim())) {
					String orderNo = loan.getOrderNo();
					String[] strOrder = orderNo.split("-");
					Integer splitOrder = Integer.parseInt(strOrder[1].substring(1, strOrder[1].length())) + 1;
					strNo.append(splitOrder.toString());
				}
			} else {
				strNo.append("1");
			}
			loanApplyVO.setOrderNo(strNo.toString());
			
			map.put("parameter",map);
			map.put("sign", "insertLoanApply");
			ResBody result = TradeInvokeUtils.invoke("LoanApplyManagement", map);
			if (result.getSys() != null) {
				String retStatus = result.getSys().getStatus();
				if ("S".equals(retStatus)) {
					JSONObject output = (JSONObject) result.getOutput();
					String records = output.getString("result");
					if (Boolean.parseBoolean(records)) {
						response.setResponseType(ResponseType.SUCCESS);
						response.setInfo("保存成功");
					}
				}
			} else {
				response.setResponseType(ResponseType.ERROR);
				response.setInfo(I18NUtils.getText("sys.v2.client.call.service.fail"));//调用服务失败！
				super.log.error("调用服务失败！");
			}
		} else {
			// 修改
			map.put("deleteReceivableIdArray", deleteReceivableIdArray);
			map.put("deleteRepayableIdArray",deleteRepayableIdArray);
			map.put("deleteBillIdArray", deleteBillIdArray);
			map.put("deleteFileIdArray", deleteFileIdArray);
			map.put("parameter",map);
			map.put("sign", "updateLoanApply");
			ResBody result = TradeInvokeUtils.invoke("LoanApplyManagement", map);
			if (result.getSys() != null) {
				String retStatus = result.getSys().getStatus();
				if ("S".equals(retStatus)) {
					JSONObject output = (JSONObject) result.getOutput();
					String records = output.getString("result");
					if (Boolean.parseBoolean(records)) {
						response.setResponseType(ResponseType.SUCCESS);
						response.setInfo("保存成功");
					}
				}
			} else {
				response.setResponseType(ResponseType.ERROR);
				response.setInfo(I18NUtils.getText("sys.v2.client.call.service.fail"));//调用服务失败！
				super.log.error("调用服务失败！");
			}
		}
		
		return response;
	}
	

	
	/**
	 * 放款详情
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/loanApply/getLoanApply.htm")
	public String getLoanApply(@RequestParam("id")Long id) {
		UserVo user = ControllerUtils.getCurrentUser();
		if(user == null ){
			super.log.error("请先登录");
			return "ybl4.0/admin/doorl/login";
		}
		// 获取放款申请主信息
		LoanApply loanApply = new LoanApply();
		loanApply.setId(id);
		LoanApply loanApplyVO = new LoanApply();
		List<LoanApply> loanApplyList = selectLoanApplyList(loanApply);
		if (loanApplyList.size() > 0) {
			loanApplyVO = loanApplyList.get(0);
		}
		SubFinancingApplyVO subFinancingApplyVO = new SubFinancingApplyVO();
		subFinancingApplyVO.setId(loanApplyVO.getSubFinancingApplyId().longValue());
		List<SubFinancingApplyVO> subList = getSubList(subFinancingApplyVO);
		if (subList.size() > 0) {
			getRequest().setAttribute("financingApplyId", subList.get(0).getFinancing_apply_id());
		}
		// 获取资料列表
		AttachmentVo attachmentVo = new AttachmentVo();
		attachmentVo.setCategory(new Long((long)E_V4_ATTACHMENT_CATEGORY.LOAN_APPLY.getStatus()));
		attachmentVo.setEnterpriseId(user.getEnterpriseId());
		attachmentVo.setResourceId(loanApplyVO.getId().intValue());
		List<AttachmentVo> attachmentVoList = FinancingApplyCommonApi.getFwAttachmentList(attachmentVo);
		// 获取附件列表
		AttachmentVo attachment = new AttachmentVo();
		attachment.setCategory(new Long((long)E_V4_ATTACHMENT_CATEGORY.LOAN_APPLY.getStatus()));
		attachment.setType(String.valueOf(E_V4_ATTACHMENT_TYPE.LOAN_ASSETS.getStatus()));
		attachment.setEnterpriseId(user.getEnterpriseId());
		attachment.setResourceId(loanApplyVO.getId().intValue());
		List<AttachmentVo> assetList = FinancingApplyCommonApi.getFwAttachmentList(attachment);
		// 根据资产类型查找资产列表
		if (loanApplyVO.getAssetsType() == E_V4_ASSETS_TYPE.ACCOUNTS_RECEIVABLE.getStatus()) {
			// 应收账款
			AccountsReceivableV4VO accountsReceivableV4VO = new AccountsReceivableV4VO();
			accountsReceivableV4VO.setLoanApplyId(loanApplyVO.getId().intValue());
			List<AccountsReceivableV4VO> accountsReceivableList = selectAccountsReceivableList(accountsReceivableV4VO);
			getRequest().setAttribute("receivableList", accountsReceivableList);
		} else if (loanApplyVO.getAssetsType() == E_V4_ASSETS_TYPE.ACCOUNTS_PAYABLE.getStatus()) {
			// 应付账款
			AccountsPayableVO accountsPayableVO = new AccountsPayableVO();
			accountsPayableVO.setLoanApplyId(loanApplyVO.getId().intValue());
			List<AccountsPayableVO> accountsPayableList = selectAccountsPayableList(accountsPayableVO);
			getRequest().setAttribute("repayableList", accountsPayableList);
		} else if (loanApplyVO.getAssetsType() == E_V4_ASSETS_TYPE.BILL.getStatus()) {
			// 票据
			BillVO billVO = new BillVO();
			billVO.setLoanApplyId(loanApplyVO.getId().intValue());
			List<BillVO> billList = selectBillList(billVO);
			getRequest().setAttribute("billList", billList);
		}
		
		
		// 得到的列表按类型分别放到attribute里
		setAttachmentToAttr(attachmentVoList);
		getRequest().setAttribute("loanApplyVO", loanApplyVO);
		getRequest().setAttribute("assetList", assetList);
		getRequest().setAttribute("operType", "query");
		return "ybl4.0/admin/supplier/loanApply/add";
	}
	
	/**
	 * 放款申请列表(查融资成功的子订单)
	 * @param financingApplyVO
	 * @param pageVo
	 * @return
	 */
	@RequestMapping(value = "/loanApply/subFinancingApplyList.htm")
	public String list(SubFinancingApplyVO subFinancingApplyVO, PageVo<SubFinancingApplyVO> pageVo) {
		UserVo user = ControllerUtils.getCurrentUser();
		if(user == null ){
			super.log.error("请先登录");
			return "ybl4.0/admin/doorl/login";
		}
		subFinancingApplyVO.setBusiness_id(user.getBusinessId().intValue());
		subFinancingApplyVO.setFinancing_status(E_V4_FINANCING_STATE.FINANCING_COMPLETED.getStatus());
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("parameter",subFinancingApplyVO);
		map.put("sign", "selectSubFinancingApplyPage");
		map.put("page", pageVo);
		ResBody result = TradeInvokeUtils.invoke("LoanApplyManagement", map);
		PageVo<?> page=null;
		List<SubFinancingApplyVO> list=null;
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				log.info("交易成功====================");
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("result");
				page = JSONObject.parseObject(jsonPage, PageVo.class);
				list=JsonUtils.toList(records,SubFinancingApplyVO.class);
				getRequest().setAttribute("page", page);
				getRequest().setAttribute("list", list);
			}
		}
		getRequest().setAttribute("param", subFinancingApplyVO);
		return "ybl4.0/admin/supplier/loanApply/list";
	}
	
	
	@RequestMapping(value = "/loanApply/selectReceivable.htm")
	public String selectReceivable(AccountsReceivableV4VO accountsReceivableV4VO, String selectIds) {
		// 设置查询参数
		accountsReceivableV4VO.setIsUse(E_V4_IS_USE.NOTUSED.getStatus());
		// 应收账款
		List<AccountsReceivableV4VO> accountsReceivableList = selectAccountsReceivableList(accountsReceivableV4VO);
		if (null != selectIds && !"".equals(selectIds.trim())) {
			String[] ids = selectIds.split(",");
			// 循环用来选择应收账款打勾
			for (int i = 0; i < ids.length; i++) {
				for (AccountsReceivableV4VO vo : accountsReceivableList) {
					if (vo.getId().longValue() == Long.parseLong(ids[i])) {
						vo.setIsCheck(true);
						break;
					}
				}
			}
		}
		getRequest().setAttribute("receivableList", accountsReceivableList);
		getRequest().setAttribute("selectIds", selectIds);
		getRequest().setAttribute("accountsReceivableV4VO", accountsReceivableV4VO);
		return "ybl4.0/admin/supplier/loanApply/selectReceivable";
	}
	
	@RequestMapping(value = "/loanApply/selectPayable.htm")
	public String selectPayable(AccountsPayableVO accountsPayableVO, String selectIds) {
		// 设置查询参数
		accountsPayableVO.setIsUse(E_V4_IS_USE.NOTUSED.getStatus());
		// 应付账款
		List<AccountsPayableVO> accountsPayableList = selectAccountsPayableList(accountsPayableVO);
		if (null != selectIds && !"".equals(selectIds.trim())) {
			String[] ids = selectIds.split(",");
			// 循环用来选择应付账款打勾
			for (int i = 0; i < ids.length; i++) {
				for (AccountsPayableVO vo : accountsPayableList) {
					if (vo.getId().longValue() == Long.parseLong(ids[i])) {
						vo.setIsCheck(true);
						break;
					}
				}
			}
		}
		getRequest().setAttribute("repayableList", accountsPayableList);
		getRequest().setAttribute("selectIds", selectIds);
		getRequest().setAttribute("accountsPayableVO", accountsPayableVO);
		return "ybl4.0/admin/supplier/loanApply/selectPayable";
	}
	
	@RequestMapping(value = "/loanApply/selectBill.htm")
	public String selectBill(BillVO billVO, String selectIds) {
		// 设置查询参数
		billVO.setIsUse(E_V4_IS_USE.NOTUSED.getStatus());
		// 票据
		List<BillVO> billList = selectBillList(billVO);
		if (null != selectIds && !"".equals(selectIds.trim())) {
			String[] ids = selectIds.split(",");
			// 循环用来选择票据打勾
			for (int i = 0; i < ids.length; i++) {
				for (BillVO vo : billList) {
					if (vo.getId().longValue() == Long.parseLong(ids[i])) {
						vo.setIsCheck(true);
						break;
					}
				}
			}
		}
		getRequest().setAttribute("billList", billList);
		getRequest().setAttribute("selectIds", selectIds);
		getRequest().setAttribute("billVO", billVO);
		return "ybl4.0/admin/supplier/loanApply/selectBill";
	}
	
	/**
	 * 更改应收账款是否使用
	 */
	@ResponseBody
	@RequestMapping(value="/updateIsUseForAccountsReceivable")
	public ControllerResponse updateIsUseForAccountsReceivable(AccountsReceivableV4VO accountsReceivable){
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		if (E_V4_IS_USE.OCCUPY.getStatus() == accountsReceivable.getIsUse()) {
			// 检查是否被占用
			String[] selectIds = accountsReceivable.getSelectIds().split(",");
			for (int i = 0; i < selectIds.length; i++) {
				AccountsReceivableV4VO vo = new AccountsReceivableV4VO();
				vo.setId(Long.parseLong(selectIds[i]));
				List<AccountsReceivableV4VO> checkList = selectAccountsReceivableList(vo);
				AccountsReceivableV4VO check = checkList.get(0);
				if (null != check) {
					if (null != check.getIsUse()) {
						if (E_V4_IS_USE.NOTUSED.getStatus() != check.getIsUse()) {
							response.setInfo("应收账款资产被占用");
							return response;
						}
					}
				}
			}
		}
		Map<String,Object> maps = new HashMap<String,Object>();
		maps.put("parameter", accountsReceivable);
		maps.put("sign", "updateIsUseForAccountsReceivable");//所调用的服务中的方法		
		ResBody result = TradeInvokeUtils.invoke("LoanApplyManagement", maps);
 		if(result.getSys()!=null){
 			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				if (Boolean.parseBoolean(records)) {
					response.setResponseType(ResponseType.SUCCESS);
					response.setInfo("修改成功");
				}
			}
		}
		return response;
		
	}
	
	/**
	 * 更改应付账款是否使用
	 */
	@ResponseBody
	@RequestMapping(value="/updateIsUseForAccountsPayable")
	public ControllerResponse updateIsUseForAccountsPayable(AccountsPayableVO accountsPayableVO){
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		if (E_V4_IS_USE.OCCUPY.getStatus() == accountsPayableVO.getIsUse()) {
			// 检查是否被占用
			String[] selectIds = accountsPayableVO.getSelectIds().split(",");
			for (int i = 0; i < selectIds.length; i++) {
				AccountsPayableVO vo = new AccountsPayableVO();
				vo.setId(Long.parseLong(selectIds[i]));
				List<AccountsPayableVO> checkList = selectAccountsPayableList(vo);
				AccountsPayableVO check = checkList.get(0);
				if (null != check) {
					if (null != check.getIsUse()) {
						if (E_V4_IS_USE.NOTUSED.getStatus() != check.getIsUse()) {
							response.setInfo("应付账款资产被占用");
							return response;
						}
					}
				}
			}
		}
		Map<String,Object> maps = new HashMap<String,Object>();
		maps.put("parameter", accountsPayableVO);
		maps.put("sign", "updateIsUseForAccountsPayable");//所调用的服务中的方法		
		ResBody result = TradeInvokeUtils.invoke("LoanApplyManagement", maps);
 		if(result.getSys()!=null){
 			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				if (Boolean.parseBoolean(records)) {
					response.setResponseType(ResponseType.SUCCESS);
					response.setInfo("修改成功");
				}
			}
		}
		return response;
		
	}
	
	/**
	 * 更改票据是否使用
	 */
	@ResponseBody
	@RequestMapping(value="/updateIsUseForBill")
	public ControllerResponse updateIsUseForBill(BillVO billVO){
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		if (E_V4_IS_USE.OCCUPY.getStatus() == billVO.getIsUse()) {
			// 检查是否被占用
			String[] selectIds = billVO.getSelectIds().split(",");
			for (int i = 0; i < selectIds.length; i++) {
				BillVO vo = new BillVO();
				vo.setId(Long.parseLong(selectIds[i]));
				List<BillVO> checkList = selectBillList(vo);
				BillVO check = checkList.get(0);
				if (null != check) {
					if (null != check.getIsUse()) { 
						if (E_V4_IS_USE.NOTUSED.getStatus() != check.getIsUse()) {
							response.setInfo("应付账款资产被占用");
							return response;
						}
					}
				}
			}
		}
		Map<String,Object> maps = new HashMap<String,Object>();
		maps.put("parameter", billVO);
		maps.put("sign", "updateIsUseForBill");//所调用的服务中的方法		
		ResBody result = TradeInvokeUtils.invoke("LoanApplyManagement", maps);
 		if(result.getSys()!=null){
 			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				if (Boolean.parseBoolean(records)) {
					response.setResponseType(ResponseType.SUCCESS);
					response.setInfo("修改成功");
				}
			}
		}
		return response;
		
	}
	
	/**
	 * 查询子融资查询
	 */
	public List<SubFinancingApplyVO> getSubList(SubFinancingApplyVO subFinancingApplyVO){
		Map<String,Object> maps = new HashMap<String,Object>();
		maps.put("subFinancingApply", subFinancingApplyVO);
		maps.put("sign", "selectSubFinancingApply");//所调用的服务中的方法		
		ResBody result = TradeInvokeUtils.invoke("FinancingApplyManagement", maps);
		List<SubFinancingApplyVO> subFinancingApplyVOList =  null;
 		if(result.getSys()!=null){
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();//错误信息	
			if("S".equals(status)){//交易成功
				log.info("查询子融资查询交易成功====================");
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("financingSubApplyList");
				subFinancingApplyVOList=JsonUtils.toList(records,SubFinancingApplyVO.class);
			}else{
				super.log.error("查询子融资查询返回失败，信息："+erortx);
				return null;
			}			
		}
		return subFinancingApplyVOList;
		
	}
	
	/**
	 * 查询放款申请列表
	 */
	@ResponseBody
	@RequestMapping(value="getLoanApplyListBySubId")
	public ControllerResponse getLoanApplyListBySubId(LoanApply loanApply){
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		// 查询
		List<LoanApply> loanApplyList = selectLoanApplyList(loanApply);
		if (loanApplyList.size() > 0) {
			response.setResponseType(ResponseType.SUCCESS);
			response.setObject(loanApplyList);
		}
		return response;
	}
	
	
	/**
	 * 应收账款
	 */
	public List<AccountsReceivableV4VO> selectAccountsReceivableList(AccountsReceivableV4VO accountsReceivableV4VO){
		// 设置传递参数
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("parameter",accountsReceivableV4VO);
		map.put("sign", "selectAccountsReceivableList");
		ResBody result = TradeInvokeUtils.invoke("LoanApplyManagement", map);
		// 应收账款列表信息
		List<AccountsReceivableV4VO> accountsReceivableList=null;
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				accountsReceivableList=JsonUtils.toList(records,AccountsReceivableV4VO.class);
				log.info("查询应收账款列表成功====================");
			}
		}
		return accountsReceivableList;			
	}
	/**
	 * 应付账款列表
	 */
	public List<AccountsPayableVO> selectAccountsPayableList(AccountsPayableVO accountsPayableVO){
		// 设置传递参数
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("parameter",accountsPayableVO);
		map.put("sign", "selectAccountsPayableList");
		ResBody result = TradeInvokeUtils.invoke("LoanApplyManagement", map);
		// 应付账款列表信息
		List<AccountsPayableVO> accountsPayableList=null;
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				accountsPayableList=JsonUtils.toList(records,AccountsPayableVO.class);
				log.info("查询应付账款列表成功====================");
			}
		}
		return accountsPayableList;			
	}
	/**
	 * 票据列表
	 */
	public List<BillVO> selectBillList(BillVO billVO){
		// 设置传递参数
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("parameter",billVO);
		map.put("sign", "selectBillList");
		ResBody result = TradeInvokeUtils.invoke("LoanApplyManagement", map);
		// 票据列表信息
		List<BillVO> billList=null;
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				billList=JsonUtils.toList(records,BillVO.class);
				log.info("查询出票据列表成功====================");
			}
		}
		return billList;			
	}
	
	/**
	 * 放款申请列表
	 */
	public List<LoanApply> selectLoanApplyList(LoanApply loanApply){
		// 设置传递参数
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("parameter",loanApply);
		map.put("sign", "selectLoanApplyList");
		ResBody result = TradeInvokeUtils.invoke("LoanApplyManagement", map);
		// 放款申请列表信息
		List<LoanApply> loanApplyList=null;
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				loanApplyList=JsonUtils.toList(records,LoanApply.class);
				log.info("查询出放款申请列表成功====================");
			}
		}
		return loanApplyList;			
	}
	
	/**
	 * 查询业务认证企业名称列表
	 */
	public List<V4BusinessAuthVO> selectBusinessAuthNameList(V4BusinessAuthVO businessAuthVO){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("businessAuth",businessAuthVO);
		map.put("sign", "selectBusinessAuthNameList");
		ResBody result = TradeInvokeUtils.invoke("FinancingApplyManagement", map);
		//获取业务认证企业名称列表
		List<V4BusinessAuthVO> businessAuthList=null;
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("businessAuthList");
				businessAuthList=JsonUtils.toList(records,V4BusinessAuthVO.class);
				log.info("查询业务认证企业名称列表成功====================");
			}
		}
		return businessAuthList;			
	}
	
	/**
	 * 查询业务认证企业名称是否存在
	 */
	public V4BusinessAuthVO selectOneBusinessAuthByName(V4BusinessAuthVO businessAuthVO){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("businessAuth",businessAuthVO);
		map.put("sign", "selectOneBusinessAuthByName");
		ResBody result = TradeInvokeUtils.invoke("FinancingApplyManagement", map);
		//获取业务认证企业名称列表
		V4BusinessAuthVO businessAuth=null;
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("businessAuth");
				businessAuth=JsonUtils.toObject(records,V4BusinessAuthVO.class);
				log.info("查询业务认证企业名称列表成功====================");
			}
		}
		return businessAuth;			
	}
	
	/**
	 * 查询最新业务认证公共信息
	 * @param businessAuthVO
	 * @return
	 */
	public V4BusinessAuthVO queryNewestBusinessAuth(V4BusinessAuthVO businessAuthVO) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("businessAuth",businessAuthVO);
		map.put("sign", "queryNewestBusinessAuth");
		ResBody result = TradeInvokeUtils.invoke("FinancingApplyManagement", map);
		// 查询最新业务认证公共信息
		V4BusinessAuthVO businessAuth=null;
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("businessAuth");
				businessAuth=JsonUtils.toObject(records, V4BusinessAuthVO.class);
				log.info("查询出申请人信息成功====================");
			}
		}
		return businessAuth;
	}
	
	/**
	 * 获取合同额度信息
	 * @param parameters
	 * @param page
	 * @return
	 */
	public List<?> queryContract(ContractQuotaV4Vo parameters, PageVo<?> page) {
		// 调用服务，进行数据查询
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("v4ContractQuotaInfo", parameters);
		map.put("page", page);
		ResBody result = TradeInvokeUtils.invoke("V4QueryContractQuotaManagement", map);
		List<?> list = null;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String pageJson = output.getString("page");
				page = (PageVo<?>) JSONObject.parseObject(pageJson, PageVo.class);
				list=page.getRecords();
				if (list.size() > 0) {
					return list;
				}
				super.log.info("根据条件查询合同额度信息调用V4QueryContractQuotaManagement交易返回成功，信息：" + erortx);
			} else {
				super.log.error("根据条件查询合同额度信息调用V4QueryContractQuotaManagement交易返回失败，信息：" + erortx);
				return null;
			}
		}
		return null;
	}
	
	/**
     * 查询应收账款-根据资产编号
     */
    public List<AccountsReceivableV4VO> selectAccountsReceivable(AccountsReceivableV4VO accountsReceivableV4VO){
        // 设置传递参数
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("parameter",accountsReceivableV4VO);
        map.put("sign", "selectAccountsReceivable");
        ResBody result = TradeInvokeUtils.invoke("LoanApplyManagement", map);
        // 票据信息
        List<AccountsReceivableV4VO> accountsReceivableList = null;
        if (result.getSys() != null) {
            String retStatus = result.getSys().getStatus();
            if ("S".equals(retStatus)) {
                JSONObject output = (JSONObject) result.getOutput();
                String records = output.getString("result");
                accountsReceivableList=JsonUtils.toList(records,AccountsReceivableV4VO.class);
                log.info("查询出应收账款成功====================");
            }
        }
        return accountsReceivableList;            
    }
    
    /**
     * 查询应付账款-根据资产编号
     */
    public List<AccountsPayableVO> selectAccountsPayable(AccountsPayableVO accountsPayableVO){
        // 设置传递参数
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("parameter",accountsPayableVO);
        map.put("sign", "selectAccountsPayable");
        ResBody result = TradeInvokeUtils.invoke("LoanApplyManagement", map);
        // 应付账款信息
        List<AccountsPayableVO> accountsPayableVOList=null;
        if (result.getSys() != null) {
            String retStatus = result.getSys().getStatus();
            if ("S".equals(retStatus)) {
                JSONObject output = (JSONObject) result.getOutput();
                String records = output.getString("result");
                accountsPayableVOList=JsonUtils.toList(records,AccountsPayableVO.class);
                log.info("查询出应付账款列表成功====================");
            }
        }
        return accountsPayableVOList;            
    }
	
	/**
     * 查询票据-根据资产编号
     */
    public List<BillVO> selectBill(BillVO billVO){
        // 设置传递参数
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("parameter",billVO);
        map.put("sign", "selectBill");
        ResBody result = TradeInvokeUtils.invoke("LoanApplyManagement", map);
        // 票据信息
        List<BillVO> billList=null;
        if (result.getSys() != null) {
            String retStatus = result.getSys().getStatus();
            if ("S".equals(retStatus)) {
                JSONObject output = (JSONObject) result.getOutput();
                String records = output.getString("result");
                billList=JsonUtils.toList(records,BillVO.class);
                log.info("查询出票据成功====================");
            }
        }
        return billList;
    }
	
	/**
	 *  附件列表按类型分别放到attribute里
	 */
	public void setAttachmentToAttr(List<AttachmentVo> attachmentVoList) {
		for (AttachmentVo attachment : attachmentVoList) {
			// 这里类型先写死数字,后续更改
			if (E_V4_ATTACHMENT_TYPE.LOAN_PURCHASE_SALE_CONTRACT.getStatus().equals(attachment.getType())) {
				// 购销合同
				getRequest().setAttribute("file41", attachment);
				continue;
			}
			if (E_V4_ATTACHMENT_TYPE.LOAN_SALES_INVOICE.getStatus().equals(attachment.getType())) {
				// 销售发票(含清单)
				getRequest().setAttribute("file42", attachment);
				continue;
			}
			if (E_V4_ATTACHMENT_TYPE.LOAN_PURCHASE_STOCK_ORDER.getStatus().equals(attachment.getType())) {
				// 采购订单、出入库清单、库存清单
				getRequest().setAttribute("file43", attachment);
				continue;
			}
			if (E_V4_ATTACHMENT_TYPE.LOAN_OTHER_IMPORTANT_MATERIALS_RELATED_FINANCING.getStatus().equals(attachment.getType())) {
				// 其他与融资相关的重要材料
				getRequest().setAttribute("file44", attachment);
				continue;
			}
		}
	}
	
	/**
	 * 处理springMVC 前台返回yyyy-MM-dd 后台bean Date类型接收问题
	 * @param binder
	 */
	@InitBinder    
	public void initBinder(WebDataBinder binder) {    
	    binder.registerCustomEditor(Date.class, new PropertyEditorSupport() {  
	        public void setAsText(String value) {  
	            try {
	            	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	                setValue(dateFormat.parse(value));  
	            } catch(ParseException e) {  
	                setValue(null);  
	            }  
	        }  
	  
	        public String getAsText() {  
	            return new SimpleDateFormat("yyyy-MM-dd").format((Date) getValue());  
	        }          
	  
	    }); 
	}

}
