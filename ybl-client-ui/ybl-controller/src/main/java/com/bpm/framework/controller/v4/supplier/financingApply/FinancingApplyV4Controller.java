package com.bpm.framework.controller.v4.supplier.financingApply;

import java.beans.PropertyEditorSupport;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import com.bpm.framework.utils.date.DateUtils;
import com.bpm.framework.utils.i18n.I18NUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.AttachmentVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v4.drools.StockHolderVO;
import cn.sunline.framework.controller.vo.v4.drools.V4BusinessAuthVO;
import cn.sunline.framework.controller.vo.v4.drools.enums.E_V4_AUTH_STATUS;
import cn.sunline.framework.controller.vo.v4.drools.enums.E_V4_AUTH_TYPE;
import cn.sunline.framework.controller.vo.v4.factor.enums.E_V4_ATTACHMENT_CATEGORY;
import cn.sunline.framework.controller.vo.v4.factor.enums.E_V4_ATTACHMENT_TYPE;
import cn.sunline.framework.controller.vo.v4.supplier.AccountsPayableVO;
import cn.sunline.framework.controller.vo.v4.supplier.AccountsReceivableV4VO;
import cn.sunline.framework.controller.vo.v4.supplier.ApplicantFinancialSituationVO;
import cn.sunline.framework.controller.vo.v4.supplier.BillVO;
import cn.sunline.framework.controller.vo.v4.supplier.ExternalGuaranteeSituationVO;
import cn.sunline.framework.controller.vo.v4.supplier.FinancingApplyVO;
import cn.sunline.framework.controller.vo.v4.supplier.FormFinancingObject;
import cn.sunline.framework.controller.vo.v4.supplier.LoanDebtSituationVO;
import cn.sunline.framework.controller.vo.v4.supplier.SubFinancingApplyVO;
import cn.sunline.framework.controller.vo.v4.supplier.enums.E_V4_ASSETS_TYPE;
import cn.sunline.framework.controller.vo.v4.supplier.enums.E_V4_FACTORING_MODE;
import cn.sunline.framework.controller.vo.v4.supplier.enums.E_V4_FINANCING_MODE;
import cn.sunline.framework.controller.vo.v4.supplier.enums.E_V4_FINANCING_STATE;
import cn.sunline.framework.controller.vo.v4.supplier.enums.E_V4_LOAN_DEBT_TYPE;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 云保理4.0融资方申请融资控制器
 */
@Controller
@RequestMapping({ "/financingApplyV4Controller" })
public class FinancingApplyV4Controller extends AbstractController {

    private static final long serialVersionUID = 1L;
    
    /**
     * 跳转到融资申请新增页面
     * @return
     */
    @RequestMapping(value = "/financingApply/add.htm")
    public String add(FinancingApplyVO financingApplyVO) {
        UserVo user = ControllerUtils.getCurrentUser();
        if(user == null ){
            super.log.error("请先登录");
            return "ybl4.0/admin/doorl/login";
        }
        // 获取融资申请订单申请人信息
        V4BusinessAuthVO businessAuthVO = new V4BusinessAuthVO();
        businessAuthVO.setAuthStatus(E_V4_AUTH_STATUS.AUDITSUCCESS.getStatus());
        businessAuthVO.setEnterpriseId(user.getEnterpriseId());
        V4BusinessAuthVO businessAuth=queryNewestBusinessAuth(businessAuthVO);
        financingApplyVO.setBusinessId(businessAuth.getId().intValue());
        // 获取附件列表
        AttachmentVo attachmentVo = new AttachmentVo();
        attachmentVo.setCategory(new Long((long)E_V4_ATTACHMENT_CATEGORY.BUSINESS_AUTH.getStatus()));// 第一次新增获取业务认证的附件
        attachmentVo.setEnterpriseId(user.getEnterpriseId());
        attachmentVo.setResourceId(user.getBusinessId().intValue());
        List<AttachmentVo> attachmentVoList = FinancingApplyCommonApi.getFwAttachmentList(attachmentVo);
        // 得到的列表按类型分别放到attribute里
        setAttachmentToAttr(attachmentVoList);
        getRequest().setAttribute("businessAuth", businessAuth);
        getRequest().setAttribute("financingApply", financingApplyVO);
        getRequest().setAttribute("operType", "insert");
        return "ybl4.0/admin/supplier/financingApply/add";
    }
    
    /**
     * 修改
     * @return
     */
    @RequestMapping(value = "/financingApply/update.htm")
    public String update(@RequestParam("id")Long id,Integer subid) {
        UserVo user = ControllerUtils.getCurrentUser();
        if(user == null ){
            super.log.error("请先登录");
            return "ybl4.0/admin/doorl/login";
        }
        // 融资申请实体用于后面查询
        FinancingApplyVO financingApplyVO = new FinancingApplyVO();
        financingApplyVO.setApply_id(id);
        financingApplyVO.setId(id);
        // 融资申请主信息
        FinancingApplyVO financingApply = FinancingApplyCommonApi.getFinancingApply(id);
        // 根据资产类型查找资产列表
        if (financingApply.getAssetsType() == E_V4_ASSETS_TYPE.ACCOUNTS_RECEIVABLE.getStatus()) {
            // 应收账款
            List<AccountsReceivableV4VO> accountsReceivableList = FinancingApplyCommonApi.getAccountsReceivableById(financingApplyVO);
            getRequest().setAttribute("receivableList", accountsReceivableList);
        } else if (financingApply.getAssetsType() == E_V4_ASSETS_TYPE.ACCOUNTS_PAYABLE.getStatus()) {
            // 应付账款
            List<AccountsPayableVO> accountsPayableList = FinancingApplyCommonApi.getAccountsPayableById(financingApplyVO);
            getRequest().setAttribute("repayableList", accountsPayableList);
        } else if (financingApply.getAssetsType() == E_V4_ASSETS_TYPE.BILL.getStatus()) {
            // 票据
            List<BillVO> billList = FinancingApplyCommonApi.getBillById(financingApplyVO);
            getRequest().setAttribute("billList", billList);
        }
        // 获取附件列表
        AttachmentVo attachmentVo = new AttachmentVo();
        attachmentVo.setCategory(new Long((long)E_V4_ATTACHMENT_CATEGORY.FINANCING_APPLY.getStatus()));
        attachmentVo.setEnterpriseId(user.getEnterpriseId());
        attachmentVo.setResourceId(financingApply.getId().intValue());
        List<AttachmentVo> attachmentVoList = FinancingApplyCommonApi.getFwAttachmentList(attachmentVo);
        if (null != subid && subid != 0) {
            Map<String,Object> maps = new HashMap<String,Object>();
            SubFinancingApplyVO subFinancingApplyVO = new SubFinancingApplyVO();
            subFinancingApplyVO.setId(subid.longValue());
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
                    super.log.error("查询子融资查询返回失败，信息："+erortx);
                    return null;
                }       
            }
            // 获取补充资料附件列表
            attachmentVo.setCategory(new Long((long)E_V4_ATTACHMENT_CATEGORY.FINANCING_APPLY.getStatus()));// 融资申请,写死,后续更改
            attachmentVo.setEnterpriseId(user.getEnterpriseId());
            attachmentVo.setResourceId(subid);
            List<AttachmentVo> rejectList = FinancingApplyCommonApi.getFwAttachmentList(attachmentVo);
            getRequest().setAttribute("rejectList", rejectList);
        }
        // 资金方选择
        if (null != financingApply.getInvestorName() && !"".equals(financingApply.getInvestorName().trim())) {
            String[] array = financingApply.getInvestorName().split(",");
            StringBuffer sb = new StringBuffer();
            for(String s : array) {
                String[] sArray = s.split("-");
                sb.append(sArray[0]).append(",");
            }
            V4BusinessAuthVO businessAuthVO = new V4BusinessAuthVO();
            businessAuthVO.setIds(sb.toString().substring(0, sb.length()-1));
            businessAuthVO.setAuthType(E_V4_AUTH_TYPE.FUNDSIDE.getStatus()); // 资金方
            List<V4BusinessAuthVO> factoryList=selectBusinessAuthNameList(businessAuthVO);
            getRequest().setAttribute("factoryList", factoryList);
        }
        // 得到的列表按类型分别放到attribute里
        setAttachmentToAttr(attachmentVoList);
        getRequest().setAttribute("financingApply", financingApply);
        getRequest().setAttribute("factoringMode", financingApply.getFactoringMode());
        getRequest().setAttribute("operType", "update");
        getRequest().setAttribute("subid", subid);
        return "ybl4.0/admin/supplier/financingApply/add";
    }
    
    /**
     * 获取融资申请订单申请人信息
     * @return
     */
    @RequestMapping(value = "/financingApply/loadBusinessAuth")
    @ResponseBody
    public ControllerResponse loadBusinessAuth(FinancingApplyVO financingApplyVO) {
        ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
        V4BusinessAuthVO businessAuth=FinancingApplyCommonApi.getBusinessApply(financingApplyVO);
        if (null != businessAuth) {
            response.setResponseType(ResponseType.SUCCESS);
            response.setObject(businessAuth);
        }
        return response;
    }
    
    /**
     * 获取股东信息列表
     * @return
     */
    @RequestMapping(value = "/financingApply/loadStockHolderList")
    @ResponseBody
    public ControllerResponse loadStockHolderList(FinancingApplyVO financingApplyVO) {
        ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
        List<StockHolderVO> stockHolderList = FinancingApplyCommonApi.getStockHolderList(financingApplyVO);
        response.setResponseType(ResponseType.SUCCESS);
        response.setObject(stockHolderList);
        return response;
    }
    
    /**
     * 获取申请人财务情况
     * @return
     */
    @RequestMapping(value = "/financingApply/loadApplicantFinancial")
    @ResponseBody
    public ControllerResponse loadApplicantFinancial(FinancingApplyVO financingApplyVO) {
        ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
        ApplicantFinancialSituationVO situationVo = FinancingApplyCommonApi.getSituationInfoById(financingApplyVO);
        response.setResponseType(ResponseType.SUCCESS);
        response.setObject(situationVo);
        return response;
    }
    
    /**
     * 获取企业/个人的借款负债情况列表
     * @return
     */
    @RequestMapping(value = "/financingApply/loadLoanDebtSituationList")
    @ResponseBody
    public ControllerResponse loadLoanDebtSituationList(FinancingApplyVO financingApplyVO) {
        ControllerResponse response = new ControllerResponse(ResponseType.ERROR); 
        Map<String, Object> map = new HashMap<String, Object>();
        // 查询出企业/个人的借款负债情况列表
        List<LoanDebtSituationVO> loanDebtSituationList = FinancingApplyCommonApi.getLoanDebtSituationListById(financingApplyVO);
        // 分类企业/个人
        List<LoanDebtSituationVO> enterpriseLoanList = new ArrayList<LoanDebtSituationVO>();
        List<LoanDebtSituationVO> personDebtList = new ArrayList<LoanDebtSituationVO>();
        for (LoanDebtSituationVO loanDebtSituationVO : loanDebtSituationList) {
            if (loanDebtSituationVO.getType() == E_V4_LOAN_DEBT_TYPE.ENTERPRISELOAN.getStatus()) {
                // 企业借款
                enterpriseLoanList.add(loanDebtSituationVO);
            } else if (loanDebtSituationVO.getType() == E_V4_LOAN_DEBT_TYPE.PERSONALDEBT.getStatus()) {
                // 个人负债
                personDebtList.add(loanDebtSituationVO);
            }
        }
        map.put("enterpriseLoanList", enterpriseLoanList);
        map.put("personDebtList", personDebtList);
        response.setResponseType(ResponseType.SUCCESS);
        response.setObject(map);
        return response;
    }
    
    /**
     * 查询对外担保情况列表
     * @return
     */
    @RequestMapping(value = "/financingApply/loadExternalGuaranteeSituation")
    @ResponseBody
    public ControllerResponse loadExternalGuaranteeSituation(FinancingApplyVO financingApplyVO) {
        ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
        List<ExternalGuaranteeSituationVO> externalGuaranteeSituationList = FinancingApplyCommonApi.getExternalGuaranteeSituationById(financingApplyVO);
        response.setResponseType(ResponseType.SUCCESS);
        response.setObject(externalGuaranteeSituationList);
        return response;
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
    @RequestMapping(value = "/financingApply/saveAll")
    @ResponseBody
    @Log(operation=OperationType.Add, info="新增或修改融资申请")
    public ControllerResponse saveAll(FinancingApplyVO financingApplyVO, ApplicantFinancialSituationVO applicantFinancialSituationVO,
            FormFinancingObject formFinancingObject,String deleteEnterpriseLoanIdArray, String deletePersonDebtIdArray, 
            String deleteGuaranteeIdArray, String deleteReceivableIdArray, String deleteRepayableIdArray, String deleteBillIdArray,String fileIdArray,
            Integer financingApplyId,Integer subid,SubFinancingApplyVO subFinancingApplyVO) {
        ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
        UserVo user = ControllerUtils.getCurrentUser();
        if(user == null ){
            super.log.error("请先登录");
            return response;
        }
        
        Map<String,Object> map = new HashMap<String,Object>();

        // 补充资料
        if (null != subid && subid != 0) {
            List<AttachmentVo> rejectList =  formFinancingObject.getRejectList();
            // 去除为空的附件
            for (int i = 0; i < rejectList.size(); i++) {
                AttachmentVo attachment = rejectList.get(i);
                if (attachment == null) {
                    rejectList.remove(i);
                    i--;
                } else {
                    if (null == attachment.getUrl() || "".equals(attachment.getUrl())) {
                        rejectList.remove(i);
                        i--;
                    } else {
                        rejectList.get(i).setEnterpriseId(user.getEnterpriseId());
                        rejectList.get(i).setResourceId(subid);
                        ControllerUtils.setWho(rejectList.get(i));
                    }
                }
            }
            // 补充资料列表
            map.put("rejectList", rejectList);
            // 补充资料
            subFinancingApplyVO.setId(subid.longValue());
            ControllerUtils.setWho(subFinancingApplyVO);
            map.put("subFinancingApplyVO", subFinancingApplyVO);
            map.put("fileIdArray", fileIdArray);
            map.put("rejectParamter",map);
            map.put("sign", "updateSubFinancingApply");
            ResBody result = TradeInvokeUtils.invoke("FinancingApplyManagement", map);
            if (result.getSys() != null) {
                String retStatus = result.getSys().getStatus();
                if ("S".equals(retStatus)) {
                    JSONObject output = (JSONObject) result.getOutput();
                    String records = output.getString("isAdded");
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
            // 新增或修改
            // 应收账款
            List<AccountsReceivableV4VO> accountsReceivableList = formFinancingObject.getReceivableList();
            // 应付账款
            List<AccountsPayableVO> accountsPayableList = formFinancingObject.getRepayableList();
            // 票据
            List<BillVO> billList = formFinancingObject.getBillList();

            // 资料清单
            List<AttachmentVo> dataAttachmentList =  formFinancingObject.getDataAttachmentList();
            
            // 保存并提交则校验
            if (null != financingApplyVO.getFinancingStatus() 
                    && E_V4_FINANCING_STATE.TO_BE_SUBMITTED.getStatus() != financingApplyVO.getFinancingStatus()) {
                // 校验
                if (financingApplyVO.getFinancingMode() == E_V4_FINANCING_MODE.CONTRACTING_PARTY.getStatus()) {
                    // 签约资方
                    if (null == financingApplyVO.getInvestorName() || "".equals(financingApplyVO.getInvestorName())) {
                        response.setInfo("融资方式为签约资方时,需要选择最少一个资金方进行融资");
                        return response;
                    }
                } else if (financingApplyVO.getFinancingMode() == E_V4_FINANCING_MODE.BID.getStatus()) {
                    // 竞标
                    if (null == financingApplyVO.getBidExpireDate() || financingApplyVO.getBidExpireDate().compareTo(DateUtils.now("yyyy-MM-dd")) < 0) {
                        response.setInfo("融资方式为竞标时,竞标截止时间不能为空并且不能小于当前日期");
                        return response;
                    }
                }
                // 融资需求
                if (null == financingApplyVO.getFinancingAmount() || "".equals(financingApplyVO.getFinancingAmount())) {
                    response.setInfo("融资金额不能为空或者小于0");
                    return response;
                } else {
                    BigDecimal financingAmount = new BigDecimal(financingApplyVO.getFinancingAmount());
                    if (financingAmount.compareTo(BigDecimal.ZERO) == -1) {
                        response.setInfo("融资金额不能为空或者小于0");
                        return response;
                    }
                }
                if (null == financingApplyVO.getFinancingTerm() || financingApplyVO.getFinancingTerm().intValue() < 0) {
                    response.setInfo("融资期限不能为空或者小于0");
                    return response;
                }
                if (null == financingApplyVO.getFinancingRate() || "".equals(financingApplyVO.getFinancingRate())) {
                    response.setInfo("融资利率不能为空或者小于0大于100");
                    return response;
                } else {
                    BigDecimal financingRate = new BigDecimal(financingApplyVO.getFinancingRate());
                    if (financingRate.compareTo(BigDecimal.ZERO) == -1 || financingRate.compareTo(new BigDecimal(100)) == 1) {
                        response.setInfo("融资利率不能为空或者小于0大于100");
                        return response;
                    }
                }
                // 资产
                StringBuffer strBuffer = new StringBuffer();
                if (financingApplyVO.getAssetsType() == E_V4_ASSETS_TYPE.ACCOUNTS_RECEIVABLE.getStatus()) {
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
                } else if (financingApplyVO.getAssetsType() == E_V4_ASSETS_TYPE.ACCOUNTS_PAYABLE.getStatus()) {
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
                } else if (financingApplyVO.getAssetsType() == E_V4_ASSETS_TYPE.BILL.getStatus()) {
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
                
                // 申请人财务情况
                if (null == applicantFinancialSituationVO.getTotalAssetsNewest() || applicantFinancialSituationVO.getTotalAssetsNewest().compareTo(BigDecimal.ZERO) == -1) {
                    response.setInfo("总资产最新一期不能为空或者小于0");
                    return response;
                }
                if (null == applicantFinancialSituationVO.getTotalAssetsN1() || applicantFinancialSituationVO.getTotalAssetsN1().compareTo(BigDecimal.ZERO) == -1) {
                    response.setInfo("总资产n~1不能为空或者小于0");
                    return response;
                }
                if (null == applicantFinancialSituationVO.getTotalAssetsN2() || applicantFinancialSituationVO.getTotalAssetsN2().compareTo(BigDecimal.ZERO) == -1) {
                    response.setInfo("总资产n~2不能为空或者小于0");
                    return response;
                }
                if (null == applicantFinancialSituationVO.getBusinessIncomeNewest() || applicantFinancialSituationVO.getBusinessIncomeNewest().compareTo(BigDecimal.ZERO) == -1) {
                    response.setInfo("营业收入最新一期不能为空或者小于0");
                    return response;
                }
                if (null == applicantFinancialSituationVO.getBusinessIncomeN1() || applicantFinancialSituationVO.getBusinessIncomeN1().compareTo(BigDecimal.ZERO) == -1) {
                    response.setInfo("营业收入n~1不能为空或者小于0");
                    return response;
                }
                if (null == applicantFinancialSituationVO.getBusinessIncomeN2() || applicantFinancialSituationVO.getBusinessIncomeN2().compareTo(BigDecimal.ZERO) == -1) {
                    response.setInfo("营业收入n~2不能为空或者小于0");
                    return response;
                }
                if (null == applicantFinancialSituationVO.getNetProfitNewest() || applicantFinancialSituationVO.getNetProfitNewest().compareTo(BigDecimal.ZERO) == -1) {
                    response.setInfo("净利润最新一期不能为空或者小于0");
                    return response;
                }
                if (null == applicantFinancialSituationVO.getNetProfitN1() || applicantFinancialSituationVO.getNetProfitN1().compareTo(BigDecimal.ZERO) == -1) {
                    response.setInfo("净利润n~1不能为空或者小于0");
                    return response;
                }
                if (null == applicantFinancialSituationVO.getNetProfitN2() || applicantFinancialSituationVO.getNetProfitN2().compareTo(BigDecimal.ZERO) == -1) {
                    response.setInfo("净利润n~2不能为空或者小于0");
                    return response;
                }
                // 资料清单
                for (AttachmentVo checkVO : dataAttachmentList) {
                    if (E_V4_ATTACHMENT_TYPE.FINANCING_APPLICATION_FORM.getStatus().equals(checkVO.getType())) {
                        if (null == checkVO.getUrl() || "".equals(checkVO.getUrl())) {
                            response.setInfo("融资申请表文件未上传");
                            return response;
                        }
                    } else if (E_V4_ATTACHMENT_TYPE.ACCOUNTS_RECEIVABLE_ACCOUNTS_RECEIVABLE.getStatus().equals(checkVO.getType())) {
                        if (null == checkVO.getUrl() || "".equals(checkVO.getUrl())) {
                            response.setInfo("应收账款总账及明细账文件未上传");
                            return response;
                        }
                    } else if (E_V4_ATTACHMENT_TYPE.LEASE_CONTRACT_PAYMENT_NEARLY_THREE_MONTHS.getStatus().equals(checkVO.getType())) {
                        if (null == checkVO.getUrl() || "".equals(checkVO.getUrl())) {
                            response.setInfo("租赁合同及近三个月缴费单据未上传");
                            return response;
                        }
                    } else if (E_V4_ATTACHMENT_TYPE.FINANCIAL_STATEMENTS_LAST_THREE_YEARS_RECENT_SIX_MONTHS.getStatus().equals(checkVO.getType())) {
                        if (null == checkVO.getUrl() || "".equals(checkVO.getUrl())) {
                            response.setInfo("最近三年经审计的财务报告及最近六个月财务报表文件未上传");
                            return response;
                        }
                    } else if (E_V4_ATTACHMENT_TYPE.NEARLY_YEAR_BANK_ACCOUNT_RUNNING_WARTER.getStatus().equals(checkVO.getType())) {
                        if (null == checkVO.getUrl() || "".equals(checkVO.getUrl())) {
                            response.setInfo("近一年的银行账户流水文件未上传");
                            return response;
                        }
                    } else if (E_V4_ATTACHMENT_TYPE.VALUE_ADDED_TAX_NEARLY_SIX_MONTHS.getStatus().equals(checkVO.getType())) {
                        if (null == checkVO.getUrl() || "".equals(checkVO.getUrl())) {
                            response.setInfo("近六个月的增值纳税申报表文件未上传");
                            return response;
                        }
                    } else if (E_V4_ATTACHMENT_TYPE.FINNACING_PURCHASE_SALE_CONTRACT.getStatus().equals(checkVO.getType())) {
                        if (null == checkVO.getUrl() || "".equals(checkVO.getUrl())) {
                            response.setInfo("购销合同文件未上传");
                            return response;
                        }
                    } else if (E_V4_ATTACHMENT_TYPE.FINNACING_SALES_INVOICE.getStatus().equals(checkVO.getType())) {
                        if (null == checkVO.getUrl() || "".equals(checkVO.getUrl())) {
                            response.setInfo("销售发票(含清单)文件未上传");
                            return response;
                        }
                    } else if (E_V4_ATTACHMENT_TYPE.FINNACING_PURCHASE_STOCK_ORDER.getStatus().equals(checkVO.getType())) {
                        if (null == checkVO.getUrl() || "".equals(checkVO.getUrl())) {
                            response.setInfo("采购订单、出入库清单、库存清单文件未上传");
                            return response;
                        }
                    }
                }
            }
            if (financingApplyVO.getFinancingMode() == E_V4_FINANCING_MODE.CONTRACTING_PARTY.getStatus()) {
                String[] investorList = financingApplyVO.getInvestorName().split(",");
                if (investorList.length > 10) {
                    response.setInfo("融资方式为签约资方时,最多只能选择10个资金方进行融资");
                    return response;
                }
            }
            
            // 1.融资申请对象
            if (null != financingApplyId) {
                // 不为空则为修改
                financingApplyVO.setId(financingApplyId.longValue());
                ControllerUtils.setWho(financingApplyVO);
            } else {
                financingApplyVO.setBusinessId(user.getBusinessId().intValue());
                ControllerUtils.setWho(financingApplyVO);
            }
            if (financingApplyVO.getFinancingMode() == E_V4_FINANCING_MODE.PLATFORM_RECOMMENDATION.getStatus()) {
                // 平台推荐
                financingApplyVO.setInvestorName(null);
                financingApplyVO.setBidExpireDate(null);
            } else if (financingApplyVO.getFinancingMode() == E_V4_FINANCING_MODE.CONTRACTING_PARTY.getStatus()) {
                // 签约资方
                financingApplyVO.setBidExpireDate(null);
            } else if (financingApplyVO.getFinancingMode() == E_V4_FINANCING_MODE.BID.getStatus()) {
                // 竞标
                financingApplyVO.setInvestorName(null);
            }
            map.put("financingApplyVO", financingApplyVO);
            
            // 2.申请人财务情况集合
            if (null != applicantFinancialSituationVO) {
                if (null != applicantFinancialSituationVO.getFinancialSituationId()) {
                    applicantFinancialSituationVO.setId(applicantFinancialSituationVO.getFinancialSituationId().longValue());
                }
                ControllerUtils.setWho(applicantFinancialSituationVO);
            }
            map.put("applicantFinancialSituationVO", applicantFinancialSituationVO);
            
            // 3.企业借款个人负债集合
            List<LoanDebtSituationVO> loanDebtSituationList = new ArrayList<LoanDebtSituationVO>();
            loanDebtSituationList.addAll(formFinancingObject.getEnterpriseLoanList());
            loanDebtSituationList.addAll(formFinancingObject.getPersonDebtList());
            // 新增时去除掉整行没填的数据
            for (int i = 0; i < loanDebtSituationList.size(); i++) {
                LoanDebtSituationVO vo = loanDebtSituationList.get(i);
                if (null == vo.getId() || vo.getId().intValue() == 0){
                    if (null == vo.getLoanAmount() && "".equals(vo.getTerm().trim()) && "".equals(vo.getCreditor().trim()) 
                            && null == vo.getLoanDate() && null == vo.getExpireDate() && null == vo.getBalance() 
                            && "".equals(vo.getRemark().trim())) {
                        loanDebtSituationList.remove(i);
                        i--;
                        continue;
                    }
                }
                ControllerUtils.setWho(vo);
            }
            map.put("loanDebtSituationList", loanDebtSituationList);
            
            // 4.对外担保集合
            List<ExternalGuaranteeSituationVO> externalGuaranteeList = formFinancingObject.getGuaranteeList();
            // 新增时去除掉整行没填的数据
            for (int i = 0; i < externalGuaranteeList.size(); i++) {
                ExternalGuaranteeSituationVO vo = externalGuaranteeList.get(i);
                if (null == vo.getId() || vo.getId().intValue() == 0){
                    if (null == vo.getGuaranteeAmount() && "".equals(vo.getTerm().trim()) && "".equals(vo.getGuarantor().trim()) 
                            && "".equals(vo.getGuaranteeMode().trim()) && null == vo.getExpireDate() && null == vo.getBalance() 
                            && "".equals(vo.getRemark().trim())) {
                        externalGuaranteeList.remove(i);
                        i--;
                        continue;
                    }
                }
                ControllerUtils.setWho(vo);
            }
            map.put("externalGuaranteeSituationList", externalGuaranteeList);
            
            // 用于查询是否存在企业
            V4BusinessAuthVO businessAuthVO = new V4BusinessAuthVO();
            businessAuthVO.setAuthType(E_V4_AUTH_TYPE.COREENTERPRISE.getStatus());
            // 5.应收账款集合赋值
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
                ControllerUtils.setWho(vo);
                // 设置实际预计支付日期,后面保理要素用到
                vo.setExpectedPaymentDateActual(vo.getExpectedPaymentDate());
                // 判断客户名称是否是系统里的已认证核心企业
                businessAuthVO.setEnterpriseName(vo.getCustomerName());
                V4BusinessAuthVO businessAuth = selectOneBusinessAuthByName(businessAuthVO);
                if (null != businessAuth) {
                    if (businessAuth.getId() != null && businessAuth.getId() != 0L) {
                        vo.setBusinessId(businessAuth.getId().intValue());
                    }
                }
            }
            map.put("accountsReceivableV4List", accountsReceivableList);
            
            // 6.应付账款集合赋值
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
                ControllerUtils.setWho(vo);
                // 设置实际预计支付日期,后面保理要素用到
                vo.setExpectedPaymentDateActual(vo.getExpectedPaymentDate());
                // 判断供应商名称是否是系统里的已认证核心企业
                businessAuthVO.setEnterpriseName(vo.getSupplierName());
                V4BusinessAuthVO businessAuth = selectOneBusinessAuthByName(businessAuthVO);
                if (null != businessAuth) {
                    if (businessAuth.getId() != null && businessAuth.getId() != 0L) {
                        vo.setBusinessId(businessAuth.getId().intValue());
                    }
                }
            }
            map.put("accountsPayableList", accountsPayableList);
            
            // 7.票据集合赋值
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
                ControllerUtils.setWho(vo);
                // 设置实际到期日期,后面保理要素用到
                vo.setExpireDateActual(vo.getExpireDate());
                // 判断承兑人名称是否是系统里的已认证核心企业
                businessAuthVO.setEnterpriseName(vo.getAcceptorName());
                V4BusinessAuthVO businessAuth = selectOneBusinessAuthByName(businessAuthVO);
                if (null != businessAuth) {
                    if (businessAuth.getId() != null && businessAuth.getId() != 0L) {
                        vo.setBusinessId(businessAuth.getId().intValue());
                    }
                }
            }
            map.put("billList", billList);
            
            // 去除为空的附件
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
            
            // 8.资料清单列表
            map.put("dataAttachmentList", dataAttachmentList);
            if (null == financingApplyId || financingApplyId == 0L) {
                // 新增
                map.put("insertParamter",map);
                map.put("sign", "insertFinancingApply");
                ResBody result = TradeInvokeUtils.invoke("FinancingApplyManagement", map);
                if (result.getSys() != null) {
                    String retStatus = result.getSys().getStatus();
                    if ("S".equals(retStatus)) {
                        JSONObject output = (JSONObject) result.getOutput();
                        String records = output.getString("isAdded");
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
                map.put("deleteEnterpriseLoanIdArray",deleteEnterpriseLoanIdArray);
                map.put("deletePersonDebtIdArray",deletePersonDebtIdArray);
                map.put("deleteGuaranteeIdArray",deleteGuaranteeIdArray);
                map.put("deleteReceivableIdArray", deleteReceivableIdArray);
                map.put("deleteRepayableIdArray",deleteRepayableIdArray);
                map.put("deleteBillIdArray", deleteBillIdArray);
                map.put("updateParamter",map);
                map.put("sign", "updateFinancingApply");
                ResBody result = TradeInvokeUtils.invoke("FinancingApplyManagement", map);
                if (result.getSys() != null) {
                    String retStatus = result.getSys().getStatus();
                    if ("S".equals(retStatus)) {
                        JSONObject output = (JSONObject) result.getOutput();
                        String records = output.getString("isUpdated");
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
        }
        
        return response;
    }
    

    
    /**
     * 融资详情
     * @param id
     * @return
     */
    @RequestMapping(value = "/financingApply/getFinancingApply.htm")
    public String getFinancingApply(@RequestParam("id")Long id,Integer subid) {
        UserVo user = ControllerUtils.getCurrentUser();
        if(user == null ){
            super.log.error("请先登录");
            return "ybl4.0/admin/doorl/login";
        }
        // 融资申请实体用于后面查询
        FinancingApplyVO financingApplyVO = new FinancingApplyVO();
        financingApplyVO.setApply_id(id);
        financingApplyVO.setId(id);
        // 融资申请主信息
        FinancingApplyVO financingApply = FinancingApplyCommonApi.getFinancingApply(id);
        // 根据资产类型查找资产列表
        if (financingApply.getAssetsType() == E_V4_ASSETS_TYPE.ACCOUNTS_RECEIVABLE.getStatus()) {
            // 应收账款
            List<AccountsReceivableV4VO> accountsReceivableList = FinancingApplyCommonApi.getAccountsReceivableById(financingApplyVO);
            getRequest().setAttribute("receivableList", accountsReceivableList);
        } else if (financingApply.getAssetsType() == E_V4_ASSETS_TYPE.ACCOUNTS_PAYABLE.getStatus()) {
            // 应付账款
            List<AccountsPayableVO> accountsPayableList = FinancingApplyCommonApi.getAccountsPayableById(financingApplyVO);
            getRequest().setAttribute("repayableList", accountsPayableList);
        } else if (financingApply.getAssetsType() == E_V4_ASSETS_TYPE.BILL.getStatus()) {
            // 票据
            List<BillVO> billList = FinancingApplyCommonApi.getBillById(financingApplyVO);
            getRequest().setAttribute("billList", billList);
        }
        // 获取附件列表
        AttachmentVo attachmentVo = new AttachmentVo();
        attachmentVo.setCategory(new Long((long)E_V4_ATTACHMENT_CATEGORY.FINANCING_APPLY.getStatus()));// 融资申请
        attachmentVo.setEnterpriseId(user.getEnterpriseId());
        attachmentVo.setResourceId(financingApply.getId().intValue());
        List<AttachmentVo> attachmentVoList = FinancingApplyCommonApi.getFwAttachmentList(attachmentVo);
        if (null != subid && subid != 0) {
            Map<String,Object> maps = new HashMap<String,Object>();
            SubFinancingApplyVO subFinancingApplyVO = new SubFinancingApplyVO();
            subFinancingApplyVO.setId(subid.longValue());
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
                    super.log.error("查询子融资查询返回失败，信息："+erortx);
                    return null;
                }       
            }
            // 获取附件列表
            attachmentVo.setCategory(new Long((long)E_V4_ATTACHMENT_CATEGORY.FINANCING_APPLY.getStatus()));
            attachmentVo.setEnterpriseId(user.getEnterpriseId());
            attachmentVo.setResourceId(subid);
            List<AttachmentVo> rejectList = FinancingApplyCommonApi.getFwAttachmentList(attachmentVo);
            getRequest().setAttribute("rejectList", rejectList);
        }
        // 资金方选择
        if (null != financingApply.getInvestorName() && !"".equals(financingApply.getInvestorName().trim())) {
            String[] array = financingApply.getInvestorName().split(",");
            StringBuffer sb = new StringBuffer();
            for(String s : array) {
                String[] sArray = s.split("-");
                sb.append(sArray[0]).append(",");
            }
            V4BusinessAuthVO businessAuthVO = new V4BusinessAuthVO();
            businessAuthVO.setIds(sb.toString().substring(0, sb.length()-1));
            businessAuthVO.setAuthType(E_V4_AUTH_TYPE.FUNDSIDE.getStatus()); // 资金方
            List<V4BusinessAuthVO> factoryList=selectBusinessAuthNameList(businessAuthVO);
            getRequest().setAttribute("factoryList", factoryList);
        }
        // 得到的列表按类型分别放到attribute里
        setAttachmentToAttr(attachmentVoList);
        getRequest().setAttribute("financingApply", financingApply);
        getRequest().setAttribute("operType", "query");
        getRequest().setAttribute("subid", subid);
        return "ybl4.0/admin/supplier/financingApply/add";
    }
    
    /**
     * 明保理融资申请列表
     * @param financingApplyVO
     * @param pageVo
     * @return
     */
    @RequestMapping(value = "/financingApply/outList.htm")
    public String outList(FinancingApplyVO financingApplyVO, PageVo<FinancingApplyVO> pageVo) {
        UserVo user = ControllerUtils.getCurrentUser();
        if(user == null ){
            super.log.error("请先登录");
            return "ybl4.0/admin/doorl/login";
        }
        // 明保理
        financingApplyVO.setBusinessId(user.getBusinessId().intValue());
        financingApplyVO.setFactoringMode(E_V4_FACTORING_MODE.FACTORING_OUT.getStatus());
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("financingApply",financingApplyVO);
        map.put("sign", "selectFinancingApplyPage");
        map.put("page", pageVo);
        ResBody result = TradeInvokeUtils.invoke("FinancingApplyManagement", map);
        PageVo<?> page=null;
        List<FinancingApplyVO> list=null;
        if (result.getSys() != null) {
            String retStatus = result.getSys().getStatus();
            if ("S".equals(retStatus)) {
                log.info("交易成功====================");
                JSONObject output = (JSONObject) result.getOutput();
                String jsonPage=output.getString("page");
                String records = output.getString("result");
                page = JSONObject.parseObject(jsonPage, PageVo.class);
                list=JsonUtils.toList(records,FinancingApplyVO.class);
                getRequest().setAttribute("page", page);
                getRequest().setAttribute("list", list);
            }
        }
        getRequest().setAttribute("financingApply", financingApplyVO);
        return "ybl4.0/admin/supplier/financingApply/outList";
    }
    
    /**
     * 暗保理融资申请列表
     * @param financingApplyVO
     * @param pageVo
     * @return
     */
    @RequestMapping(value = "/financingApply/darkList.htm")
    public String darkList(FinancingApplyVO financingApplyVO, PageVo<FinancingApplyVO> pageVo) {
        UserVo user = ControllerUtils.getCurrentUser();
        if(user == null ){
            super.log.error("请先登录");
            return "ybl4.0/admin/doorl/login";
        }
        // 暗保理
        financingApplyVO.setBusinessId(user.getBusinessId().intValue());
        financingApplyVO.setFactoringMode(E_V4_FACTORING_MODE.DARK_FACTORING.getStatus());
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("financingApply",financingApplyVO);
        map.put("sign", "selectFinancingApplyPage");
        map.put("page", pageVo);
        ResBody result = TradeInvokeUtils.invoke("FinancingApplyManagement", map);
        PageVo<?> page=null;
        List<FinancingApplyVO> list=null;
        if (result.getSys() != null) {
            String retStatus = result.getSys().getStatus();
            if ("S".equals(retStatus)) {
                log.info("交易成功====================");
                JSONObject output = (JSONObject) result.getOutput();
                String jsonPage=output.getString("page");
                String records = output.getString("result");
                page = JSONObject.parseObject(jsonPage, PageVo.class);
                list=JsonUtils.toList(records,FinancingApplyVO.class);
                getRequest().setAttribute("page", page);
                getRequest().setAttribute("list", list);
            }
        }
        getRequest().setAttribute("financingApply", financingApplyVO);
        return "ybl4.0/admin/supplier/financingApply/darkList";
    }
    
    /**
     * 融资申请页面选择资金方列表
     * @param businessAuthVO
     * @return
     */
    @RequestMapping(value = "/financingApply/selectFactory.htm")
    public String selectFactory(V4BusinessAuthVO businessAuthVO, String investorName) {
        // 查询条件,资金方
        businessAuthVO.setAuthType(E_V4_AUTH_TYPE.FUNDSIDE.getStatus());
        List<V4BusinessAuthVO> list=selectBusinessAuthNameList(businessAuthVO);
        if (null != investorName && !"".equals(investorName.trim())) {
            String[] ids = investorName.split(",");
            // 循环用来选择资金方打勾
            for (int i = 0; i < ids.length; i++) {
                for (V4BusinessAuthVO vo : list) {
                    String[] checkStr = ids[i].split("-");
                    if (vo.getId().longValue() == Long.parseLong(checkStr[0])) {
                        vo.setIsCheck(true);
                        break;
                    }
                }
            }
        }
        getRequest().setAttribute("list", list);
        getRequest().setAttribute("param", businessAuthVO);
        getRequest().setAttribute("investorName", investorName);
        return "ybl4.0/admin/supplier/financingApply/selectFactory";
    }
    
    /**
     * 融资申请页面选择核心企业列表
     * @param businessAuthVO
     * @return
     */
    @RequestMapping(value = "/financingApply/selectEnterprise")
    @ResponseBody
    public ControllerResponse selectEnterprise() {
        ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
        UserVo user = ControllerUtils.getCurrentUser();
        if(user == null ){
            super.log.error("请先登录");
            return response;
        }
        Map<String,Object> map = new HashMap<String,Object>();
        V4BusinessAuthVO businessAuthVO = new V4BusinessAuthVO();
        //查询条件,核心企业
        businessAuthVO.setAuthType(E_V4_AUTH_TYPE.COREENTERPRISE.getStatus());
        map.put("businessAuth",businessAuthVO);
        map.put("sign", "selectBusinessAuthNameList");
        ResBody result = TradeInvokeUtils.invoke("FinancingApplyManagement", map);
        List<V4BusinessAuthVO> list=null;
        if (result.getSys() != null) {
            String retStatus = result.getSys().getStatus();
            if ("S".equals(retStatus)) {
                log.info("交易成功====================");
                JSONObject output = (JSONObject) result.getOutput();
                String records = output.getString("businessAuthList");
                list=JsonUtils.toList(records,V4BusinessAuthVO.class);
                response.setResponseType(ResponseType.SUCCESS);
                response.setObject(list);
            }
        }
        return response;
    }

    
    /**
     * 查询子融资查询
     */
    @ResponseBody
    @RequestMapping(value="getSubList")
    public ControllerResponse getSubList(SubFinancingApplyVO subFinancingApplyVO){
        ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
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
                for (SubFinancingApplyVO subVo : subFinancingApplyVOList) {
                    subVo.setFinancing_amount(subVo.getFinancing_amount().setScale(2, BigDecimal.ROUND_UP));
                    subVo.setFinancing_rate(subVo.getFinancing_rate().setScale(2, BigDecimal.ROUND_UP));
                }
                response.setResponseType(ResponseType.SUCCESS);
                response.setObject(subFinancingApplyVOList);
            }else{
                super.log.error("查询子融资查询返回失败，信息："+erortx);
                return null;
            }           
        }
        return response;
        
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
     *  附件列表按类型分别放到attribute里
     */
    public void setAttachmentToAttr(List<AttachmentVo> attachmentVoList) {
        for (AttachmentVo attachment : attachmentVoList) {
            if (E_V4_ATTACHMENT_TYPE.BUSINESS_LICENSE_THIRD.getStatus().equals(attachment.getType())) {
                // 营业执照(三证合一)
                getRequest().setAttribute("file12", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.ACCOUNT_OPENING_PERMIT.getStatus().equals(attachment.getType())) {
                // 开户许可证
                getRequest().setAttribute("file13", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.AGENCY_CREDIT_CODE.getStatus().equals(attachment.getType())) {
                // 机构信用代码证
                getRequest().setAttribute("file14", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.LEGAL_REPRESENTATIVE_IDENTITY.getStatus().equals(attachment.getType())) {
                // 法人代表人身份证
                getRequest().setAttribute("file15", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.COMPANYS_ARTICLES_ASSOCIATION.getStatus().equals(attachment.getType())) {
                // 公司章程
                getRequest().setAttribute("file16", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.CAPITAL_VERFICATION_REPORT.getStatus().equals(attachment.getType())) {
                // 验资报告
                getRequest().setAttribute("file17", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.ENTERPRISE_CREDIT_REPORT.getStatus().equals(attachment.getType())) {
                // 企业信用报告
                getRequest().setAttribute("file18", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.INTRODUCTION_COMPANY_SHAREHOLDERS.getStatus().equals(attachment.getType())) {
                // 公司股东介绍(包含实际控制人、股东关系、股权结构)
                getRequest().setAttribute("file21", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.COMPANY_EXECUTIVES.getStatus().equals(attachment.getType())) {
                // 公司高管介绍(包含董事长、总经理、财务总监等)
                getRequest().setAttribute("file22", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.COMPANY_BUSINESS_INTRODUCTION.getStatus().equals(attachment.getType())) {
                // 公司业务介绍(说明公司的主要经营业务、营收情况等)
                getRequest().setAttribute("file23", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.FINANCING_APPLICATION_FORM.getStatus().equals(attachment.getType())) {
                // 融资申请表
                getRequest().setAttribute("file11", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.ACCOUNTS_RECEIVABLE_ACCOUNTS_RECEIVABLE.getStatus().equals(attachment.getType())) {
                // 应收账款总账及明细账
                getRequest().setAttribute("file55", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.ACCOUNTS_PAYABLE_ACCOUNTS_PAYABLE.getStatus().equals(attachment.getType())) {
                // 应付账款总账及明细账
                getRequest().setAttribute("file56", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.LOAN_QUERY_AUTHORIZATION.getStatus().equals(attachment.getType())) {
                // 贷款卡、贷款卡查询授权
                getRequest().setAttribute("file19", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.LEASE_CONTRACT_PAYMENT_NEARLY_THREE_MONTHS.getStatus().equals(attachment.getType())) {
                // 租赁合同及近三个月缴费单据
                getRequest().setAttribute("file20", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.FINANCIAL_STATEMENTS_LAST_THREE_YEARS_RECENT_SIX_MONTHS.getStatus().equals(attachment.getType())) {
                // 最近三年经审计的财务报告及最近六个月财务报表
                getRequest().setAttribute("file24", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.BANK_CREDIT_LOAN_DETAILS.getStatus().equals(attachment.getType())) {
                // 银行授信及贷款明细
                getRequest().setAttribute("file25", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.DESCRIPTION_EXTERNAL.getStatus().equals(attachment.getType())) {
                // 对外担保情况说明
                getRequest().setAttribute("file26", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.NEARLY_YEAR_BANK_ACCOUNT_RUNNING_WARTER.getStatus().equals(attachment.getType())) {
                // 近一年的银行账户流水
                getRequest().setAttribute("file27", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.VALUE_ADDED_TAX_NEARLY_SIX_MONTHS.getStatus().equals(attachment.getType())) {
                // 近六个月的增值纳税申报表
                getRequest().setAttribute("file28", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.FINNACING_PURCHASE_SALE_CONTRACT.getStatus().equals(attachment.getType())) {
                // 购销合同
                getRequest().setAttribute("file29", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.FINNACING_SALES_INVOICE.getStatus().equals(attachment.getType())) {
                // 销售发票(含清单)
                getRequest().setAttribute("file30", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.FINNACING_PURCHASE_STOCK_ORDER.getStatus().equals(attachment.getType())) {
                // 采购订单、出入库清单、库存清单
                getRequest().setAttribute("file31", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.OTHER_IMPORTANT_MATERIALS_RELATED_FINANCING.getStatus().equals(attachment.getType())) {
                // 其他与融资相关的重要材料
                getRequest().setAttribute("file32", attachment);
                continue;
            }
            if (E_V4_ATTACHMENT_TYPE.OTHER_SUPPLEMENTARY_INFORMATION.getStatus().equals(attachment.getType())) {
                // 其他补充资料
                getRequest().setAttribute("file33", attachment);
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
