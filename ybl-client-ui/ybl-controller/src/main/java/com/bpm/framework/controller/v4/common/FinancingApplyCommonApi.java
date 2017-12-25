package com.bpm.framework.controller.v4.common;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.sunline.framework.controller.vo.AttachmentVo;
import cn.sunline.framework.controller.vo.v4.drools.StockHolderVO;
import cn.sunline.framework.controller.vo.v4.drools.V4BusinessAuthVO;
import cn.sunline.framework.controller.vo.v4.factor.ContractV4Vo;
import cn.sunline.framework.controller.vo.v4.factor.PlatformAuditRecordVo;
import cn.sunline.framework.controller.vo.v4.factor.enums.E_V4_ASSETS_TYPE;
import cn.sunline.framework.controller.vo.v4.supplier.AccountsPayableVO;
import cn.sunline.framework.controller.vo.v4.supplier.AccountsReceivableV4VO;
import cn.sunline.framework.controller.vo.v4.supplier.ApplicantFinancialSituationVO;
import cn.sunline.framework.controller.vo.v4.supplier.BillVO;
import cn.sunline.framework.controller.vo.v4.supplier.ExternalGuaranteeSituationVO;
import cn.sunline.framework.controller.vo.v4.supplier.SupplierRiskManagementAuditVO;
import cn.sunline.framework.controller.vo.v4.supplier.FinancingApplyVO;
import cn.sunline.framework.controller.vo.v4.supplier.IntegerFundsMangementVO;
import cn.sunline.framework.controller.vo.v4.supplier.LoanDebtSituationVO;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.annotation.ValidateSession;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.date.DateUtils;
import com.bpm.framework.utils.json.JsonUtils;

/**
 * 云保理4.0融资申请公共api
 */
@Controller
@RequestMapping({ "/financingApplyCommonApi" })
public class FinancingApplyCommonApi extends AbstractController {

	/**
	 * 
	 */
	private static final long serialVersionUID = -2493091950421636311L;
	
	/**
	 * 根据融资订单的id查询融资订单信息
	 */
	public static FinancingApplyVO getFinancingApply(Long financingApplyId) {
		//根据ID查询融资申请
		Map<String,Object> map = new HashMap<String,Object>();
		FinancingApplyVO financingApplyVO = new FinancingApplyVO();
		if(null != financingApplyId){
			financingApplyVO.setId(financingApplyId);
			financingApplyVO.setApply_id(financingApplyId);
		}
		map.put("financingApply",financingApplyVO);
		ResBody result = TradeInvokeUtils.invoke("V4FinancingApplyQueryById", map);
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output1 = (JSONObject) result.getOutput();
				String records1 = output1.getString("financingApply");
				financingApplyVO = JsonUtils.toObject(records1, FinancingApplyVO.class);
			}
		}
		return financingApplyVO;
	}
	
	/**
	 * 根据融资订单的id查询当前业务用户所属的融资订单信息
	 * @param long1 
	 */
	public static FinancingApplyVO getCurrentUserFinancingApplyDetail(Long financingApplyId,Long subFinancingApplyId, Long businessId) {
		Map<String,Object> map = new HashMap<String,Object>();
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("financingApplyId", financingApplyId);
		param.put("subFinancingApplyId", subFinancingApplyId);
		param.put("businessId", businessId);
		map.put("paramter",JsonUtils.fromObject(param));
		map.put("sign", "getCurrentUserFinancingApplyDetail");
		FinancingApplyVO financingApplyVO = null;
		ResBody result = TradeInvokeUtils.invoke("FactorRiskManagementTran", map);
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String financingApply = output.getString("result");
				if(StringUtils.isEmpty(financingApply)) {
					return null;
				}
				financingApplyVO = JsonUtils.toObject(financingApply, FinancingApplyVO.class);
			}
		}
		return financingApplyVO;
	}
	
	/*
	 * 根据融资订单的业务ID查询出申请人信息
	 */
	public static V4BusinessAuthVO getBusinessApply(FinancingApplyVO financingApply) {
		//根据ID查询竞标信息
		Map<String,Object> map = new HashMap<String,Object>();
		FinancingApplyVO vo = new FinancingApplyVO();
		if(null !=financingApply.getBusinessId()){
			vo.setBusinessId(financingApply.getBusinessId());
		}
		map.put("financingApply",vo);
		ResBody result = TradeInvokeUtils.invoke("V4FinancingApplyBusinessAuthInfoById", map);
		//融资申请订单申请人信息
		V4BusinessAuthVO businessAuth=null;
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("businessApply");
				businessAuth=JsonUtils.toObject(records, V4BusinessAuthVO.class);
			}
		}
		return businessAuth;
	}
	
	/*
	 * 根据融资订单的业务ID查询出股东列表
	 */
	public static List<StockHolderVO> getStockHolderList(FinancingApplyVO financingApply) {
		//根据ID查询竞标信息
		Map<String,Object> map = new HashMap<String,Object>();
		FinancingApplyVO vo = new FinancingApplyVO();
		if(null !=financingApply.getBusinessId()){
			vo.setBusinessId(financingApply.getBusinessId());
		}
		map.put("financingApply",vo);
		ResBody result = TradeInvokeUtils.invoke("V4FinancingApplyStockHolderList", map);
		//融资申请订单股东列表信息
		List<StockHolderVO> stockHolderList=null;
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("stockHolderList");
				stockHolderList=JsonUtils.toList(records,StockHolderVO.class);
			}
		}
		return stockHolderList;
	}
	
	/*
	 * 根据融资订单的业务ID查询出申请人财务情况
	 */
	public static ApplicantFinancialSituationVO getSituationInfoById(FinancingApplyVO financingApply) {
		//根据ID查询竞标信息
		Map<String,Object> map = new HashMap<String,Object>();
		FinancingApplyVO vo = new FinancingApplyVO();
		if(null !=financingApply.getId()){
			vo.setId(financingApply.getId());
		}
		map.put("financingApply",vo);
		ResBody result = TradeInvokeUtils.invoke("V4FianncingApplySituationInfoById", map);
		//融资申请订单申请人财务情况
		ApplicantFinancialSituationVO situationVo=null;
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("situation");
				situationVo=JsonUtils.toObject(records, ApplicantFinancialSituationVO.class);
			}
		}
		return situationVo;
	}
	
	/*
	 * 根据融资申请ID查询出企业/个人的借款负债情况列表
	 */
	public static List<LoanDebtSituationVO> getLoanDebtSituationListById(FinancingApplyVO financingApply){
		//根据ID查询竞标信息
		Map<String,Object> map = new HashMap<String,Object>();
		FinancingApplyVO vo = new FinancingApplyVO();
		if(null !=financingApply.getId()){
			vo.setId(financingApply.getId());
		}
		map.put("financingApply",vo);
		ResBody result = TradeInvokeUtils.invoke("V4FinancingApplyLoanDebtSituationListById", map);
		//查询出企业/个人的借款负债情况列表
		List<LoanDebtSituationVO> loanDebtSituationList=null;
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("deptSituationList");
				loanDebtSituationList=JsonUtils.toList(records,LoanDebtSituationVO.class);
			}
		}
		return loanDebtSituationList;		
	}
	
	/*
	 * 根据融资申请ID查询出对外担保情况列表
	 */
	public static List<ExternalGuaranteeSituationVO> getExternalGuaranteeSituationById(FinancingApplyVO financingApply){
		//根据ID查询竞标信息
		Map<String,Object> map = new HashMap<String,Object>();
		FinancingApplyVO vo = new FinancingApplyVO();
		if(null !=financingApply.getId()){
			vo.setId(financingApply.getId());
		}
		map.put("financingApply",vo);
		ResBody result = TradeInvokeUtils.invoke("V4FinancingApplyExternalGuaranteeSituationById", map);
		//融资申请订单查询出对外担保情况列表
		List<ExternalGuaranteeSituationVO> externalGuaranteeSituationList=null;
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("externalGuaranteeSituationList");
				externalGuaranteeSituationList=JsonUtils.toList(records,ExternalGuaranteeSituationVO.class);
			}
		}
		return externalGuaranteeSituationList;			
	}
	
	/*
	 * 根据融资申请ID查询出底层资产
	 * 1、应收账款
	 * 2、应付账款
	 * 3、票据
	 * 信息列表
	 */
	/*1、应收账款列表*/
	public static List<AccountsReceivableV4VO> getAccountsReceivableById(FinancingApplyVO financingApply){
		//根据ID查询竞标信息
		Map<String,Object> map = new HashMap<String,Object>();
		FinancingApplyVO vo = new FinancingApplyVO();
		if(null !=financingApply.getId()){
			vo.setId(financingApply.getId());
		}
		map.put("financingApply",vo);
		ResBody result = TradeInvokeUtils.invoke("V4FinancingApplyAccountsReceivableList", map);
		//1、应收账款列表信息
		List<AccountsReceivableV4VO> accountsReceivableList=null;
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("accountsReceivableList");
				accountsReceivableList=JsonUtils.toList(records,AccountsReceivableV4VO.class);
			}
		}
		return accountsReceivableList;			
	}
	/*2、应付账款列表*/
	public static List<AccountsPayableVO> getAccountsPayableById(FinancingApplyVO financingApply){
		//根据ID查询竞标信息
		Map<String,Object> map = new HashMap<String,Object>();
		FinancingApplyVO vo = new FinancingApplyVO();
		if(null !=financingApply.getId()){
			vo.setId(financingApply.getId());
		}
		map.put("financingApply",vo);
		ResBody result = TradeInvokeUtils.invoke("V4FinancingApplyAccountsPayableList", map);
		//2、应付账款列表信息
		List<AccountsPayableVO> accountsPayableList=null;
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("accountsPayableList");
				accountsPayableList=JsonUtils.toList(records,AccountsPayableVO.class);
			}
		}
		return accountsPayableList;			
	}
	/*3、票据列表*/
	public static List<BillVO> getBillById(FinancingApplyVO financingApply){
		//根据ID查询竞标信息
		Map<String,Object> map = new HashMap<String,Object>();
		FinancingApplyVO vo = new FinancingApplyVO();
		if(null !=financingApply.getId()){
			vo.setId(financingApply.getId());
		}
		map.put("financingApply",vo);
		ResBody result = TradeInvokeUtils.invoke("V4FinancingApplyBillList", map);
		//2、票据列表信息
		List<BillVO> billList=null;
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("billList");
				billList=JsonUtils.toList(records,BillVO.class);
			}
		}
		return billList;			
	}
	
	/*4、获取附件*/
	public static List<AttachmentVo> getAttachmentListByFinancingApply(Integer resourceId,Integer category,String type){
		Map<String,Object> map = new HashMap<String,Object>();
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("resourceId",resourceId);
		paramMap.put("category",category);
		paramMap.put("type",type);
		map.put("paramter",JsonUtils.fromObject(paramMap));
		map.put("sign","selectAttachmentList");
		ResBody result = TradeInvokeUtils.invoke("FactorRiskManagementTran", map);
		List<AttachmentVo> aList=null;
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				aList=JsonUtils.toList(records,AttachmentVo.class);
			}
		}
		return aList;			
	}
	
	/*4、获取当前用户所属的融资子订单附件*/
	public static List<AttachmentVo> getAttachmentListByCurrentUserSubFinancingApply(Long businessId,Long financingApplyId,Long subFinancingApplyId,Integer category,String type){
		Map<String,Object> map = new HashMap<String,Object>();
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("businessId",businessId);
		paramMap.put("financingApplyId",financingApplyId);
		paramMap.put("subFinancingApplyId", subFinancingApplyId);
		paramMap.put("category",category);
		paramMap.put("type",type);
		map.put("paramter",JsonUtils.fromObject(paramMap));
		map.put("sign","getAttachmentListByCurrentUserSubFinancingApply");
		ResBody result = TradeInvokeUtils.invoke("FactorRiskManagementTran", map);
		List<AttachmentVo> aList=null;
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				aList=JsonUtils.toList(records,AttachmentVo.class);
			}
		}
		return aList;			
	}
	

    /**
     * 查询融资申请附件列表
     */
    public static List<AttachmentVo> getFwAttachmentList(AttachmentVo attachmentVo){
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("paramter",attachmentVo);
        map.put("sign","queryAttchmentByCondition");
        ResBody result = TradeInvokeUtils.invoke("AttachmentManagement", map);
        //融资申请附件列表
        List<AttachmentVo> attachmentList=null;
        if (result.getSys() != null) {
            String retStatus = result.getSys().getStatus();
            if ("S".equals(retStatus)) {
                JSONObject output = (JSONObject) result.getOutput();
                String records = output.getString("result");
                attachmentList=JsonUtils.toList(records,AttachmentVo.class);
            }
        }
        return attachmentList;          
    }
	
	/**
	 * 融资申请详情
	 * @param financingApplyId
	 * @param subFinancingApplyId
	 * @return
	 */
	@RequestMapping(value = "/{financingApplyId}/{subFinancingApplyId}/financingApplyDetail.htm")
	public String financingApplyDetail(@PathVariable("financingApplyId")Long financingApplyId,@PathVariable("subFinancingApplyId")Long subFinancingApplyId) {
		//1、融资申请订单信息
		FinancingApplyVO financing = FinancingApplyCommonApi.getFinancingApply(financingApplyId);
		if(null != financing && StringUtils.isNotEmpty(financing.getInvestorName())) {
			String[] array = financing.getInvestorName().split(",");
			StringBuffer sb = new StringBuffer();
			for(String s : array) {
				String[] sArray = s.split("-");
				sb.append(sArray[1]).append(",");
			}
			financing.setInvestorName(sb.toString().substring(0, sb.length()-1));
		}
		getRequest().setAttribute("financing", financing);
		//2、查询申请人信息
		V4BusinessAuthVO businessAuth = FinancingApplyCommonApi.getBusinessApply(financing);
		getRequest().setAttribute("businessAuth", businessAuth);
		//3、查询股东列表信息
		List<StockHolderVO> stockHolderList = FinancingApplyCommonApi.getStockHolderList(financing);
		getRequest().setAttribute("stockHolderList", stockHolderList);
		//4、查询申请人财务情况
		ApplicantFinancialSituationVO situationVo = FinancingApplyCommonApi.getSituationInfoById(financing);
		getRequest().setAttribute("situationVo", situationVo);
		//5、查询出企业/个人的借款负债情况列表
		List<LoanDebtSituationVO> loanDebtSituationList = FinancingApplyCommonApi.getLoanDebtSituationListById(financing);
		getRequest().setAttribute("loanDebtSituationList", loanDebtSituationList);
		//6、查询对外担保情况列表
		List<ExternalGuaranteeSituationVO> externalGuaranteeSituationList = FinancingApplyCommonApi.getExternalGuaranteeSituationById(financing);
		getRequest().setAttribute("externalGuaranteeSituationList", externalGuaranteeSituationList);
		//底层资产列表展示 1、应收账款 2、应付账款 3、票据
		if(financing.getAssetsType().intValue() == E_V4_ASSETS_TYPE.ACCOUNTS_RECEIVABLE.getStatus()) {
			/*1、应收账款列表*/
			List<AccountsReceivableV4VO> accountsReceivableList = FinancingApplyCommonApi.getAccountsReceivableById(financing);
			getRequest().setAttribute("accountsReceivableList", accountsReceivableList);
		} else if(financing.getAssetsType().intValue() == E_V4_ASSETS_TYPE.ACCOUNTS_PAYABLE.getStatus()) {
			/*2、应付账款列表*/
			List<AccountsPayableVO> accountsPayableList = FinancingApplyCommonApi.getAccountsPayableById(financing);
			getRequest().setAttribute("accountsPayableList", accountsPayableList);
		} else if(financing.getAssetsType().intValue() == E_V4_ASSETS_TYPE.BILL.getStatus()) {
			/*3、票据列表*/
			List<BillVO> billList = FinancingApplyCommonApi.getBillById(financing);
			getRequest().setAttribute("billList", billList);
		}
		//4、获取融资申请资料清单
		List<AttachmentVo> attachments = FinancingApplyCommonApi.getAttachmentListByFinancingApply(financing.getId().intValue(),12,null);
		getRequest().setAttribute("attachments", attachments);
		if(null != subFinancingApplyId) {
			//5、获取子订单补充资料
			List<AttachmentVo> supplementAttachments = FinancingApplyCommonApi.getAttachmentListByFinancingApply(subFinancingApplyId.intValue(),13,"34");
			getRequest().setAttribute("supplementAttachments", supplementAttachments);
		}
		return "ybl4.0/admin/common/financing_apply_details";
	}
	
	
	
	//跳转到详情页面
	/**
	 * 
	 * @param id 融资定单id
	 * @param childrenId融资字定单id
	 * @param statue 如果入口为母定单则为融资定单的融资状态，如入口为子定单，则为子订单融资状态
	 * @return
	 */
	@ValidateSession(validate = true)
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/view.htm")
	public String details(@Param("id") Long id,
			@Param("childrenId") Long childrenId,@Param("statue") int statue ,@Param("url")String url) {

		getRequest().setAttribute("id", id);
		getRequest().setAttribute("childrenId", childrenId);
		getRequest().setAttribute("statue", statue);
		getRequest().setAttribute("url", url);
		return "ybl4.0/admin/common/finacingapplydetail/view";
	}
	//融资综合查询，tab页签
	
	/**
	 * 签署主合同 默认先查询第一个tab页
	 */

	
	public  void projectDetails(Long id,Long childrenId) {
		// 根据ID查询竞标信息
				Map<String, Object> map = new HashMap<String, Object>();
				FinancingApplyVO financingApplyVO = new FinancingApplyVO();
				if (null != id) {
					financingApplyVO.setId(id);
					financingApplyVO.setApply_id(id);
				}
				map.put("financingApply", financingApplyVO);
				ResBody result = TradeInvokeUtils.invoke("V4FinancingApplyQueryById",
						map);
				/**
				 * 1、融资申请订单信息
				 */
				FinancingApplyVO financing=null;
				if (result.getSys() != null) {
					String retStatus = result.getSys().getStatus();
					if ("S".equals(retStatus)) {
						log.info("主键查询竞标数据成功====================");
						JSONObject output = (JSONObject) result.getOutput();
						String records = output.getString("financingApply");
						financing=JsonUtils.toObject(records, FinancingApplyVO.class);
						
						//根据融资期限<日期>计算融资期限天数<融资期限 - 系统日期>
						if(null != financing.getBidExpireDate()){
							financing.setGap(DateUtils.dayDiff(financing.getBidExpireDate(),new Date()));//返回间隔天数
						}
						
						
						getRequest().setAttribute("financing", financing);
					}
				}
				
				/**
				 * 2、查询申请人信息
				 */
				if(null != financing.getBusinessId()){
					V4BusinessAuthVO businessAuth = getBusinessApply(financing);
					if(null != businessAuth){
						//获取到申请人信息
						getRequest().setAttribute("businessAuth", businessAuth);
					}
				}
				
				/**
				 * 3、查询股东列表信息
				 */
				if(null != financing.getBusinessId()){
					List<StockHolderVO> stockHolderList = getStockHolderList(financing);
					if(stockHolderList.size() > 0){
						//获取到股东列表信息
						getRequest().setAttribute("stockHolderList", stockHolderList);
					}
				}
				
				/**
				 * 4、查询申请人财务情况
				 */
				if(null != financing.getId()){
					ApplicantFinancialSituationVO situationVo = getSituationInfoById(financing);
					if(null != situationVo){
						//获取到申请人财务情况
						getRequest().setAttribute("situationVo", situationVo);
					}
				}
				
				/**
				 * 5、查询出企业/个人的借款负债情况列表
				 */
				if(null != financing.getId()){
					List<LoanDebtSituationVO> loanDebtSituationList = getLoanDebtSituationListById(financing);
					if(loanDebtSituationList.size() > 0){
						//获取企业/个人的借款负债情况列表
						getRequest().setAttribute("loanDebtSituationList", loanDebtSituationList);
					}
				}
				
				/**
				 * 6、查询对外担保情况列表
				 */
				if(null != financing.getId()){
					List<ExternalGuaranteeSituationVO> externalGuaranteeSituationList = getExternalGuaranteeSituationById(financing);
					if(externalGuaranteeSituationList.size() > 0){
						//获取查询对外担保情况列表
						getRequest().setAttribute("externalGuaranteeSituationList", externalGuaranteeSituationList);
					}
				}
				
				/**
				 * 底层资产列表展示
				 * 1、应收账款
				 * 2、应付账款
				 * 3、票据
				 */
				
				if(financing.getAssetsType().intValue() == E_V4_ASSETS_TYPE.ACCOUNTS_RECEIVABLE.getStatus()) {
					/*1、应收账款列表*/
					List<AccountsReceivableV4VO> accountsReceivableList = FinancingApplyCommonApi.getAccountsReceivableById(financing);
					getRequest().setAttribute("accountsReceivableList", accountsReceivableList);
				} else if(financing.getAssetsType().intValue() == E_V4_ASSETS_TYPE.ACCOUNTS_PAYABLE.getStatus()) {
					/*2、应付账款列表*/
					List<AccountsPayableVO> accountsPayableList = FinancingApplyCommonApi.getAccountsPayableById(financing);
					getRequest().setAttribute("accountsPayableList", accountsPayableList);
				} else if(financing.getAssetsType().intValue() == E_V4_ASSETS_TYPE.BILL.getStatus()) {
					/*3、票据列表*/
					List<BillVO> billList = FinancingApplyCommonApi.getBillById(financing);
					getRequest().setAttribute("billList", billList);
				}
				//4、获取融资申请资料清单
				List<AttachmentVo> attachments = FinancingApplyCommonApi.getAttachmentListByFinancingApply(financing.getId().intValue(),12,null);
				getRequest().setAttribute("attachments", attachments);
				//5如果查看的是子订单 则查询补充资料
				if(childrenId!=null && childrenId>0){
					List<AttachmentVo> attachmentsChild = getAttachmentListByFinancingApply(childrenId.intValue(),13,null);
					getRequest().setAttribute("attachmentsChild",
							attachmentsChild);
					//设置类型 判断补充资料tab页是否显示
					getRequest().setAttribute("typeChange",
							"child");
				}


	
	}

	/**
	 * 平台初审 默认先查询第2个tab页
	 */

	@ValidateSession(validate = true)
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/preliminarytrialPlatform")
	public  void preliminarytrialPlatform(Long id, int audittype) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("audit_type", audittype);
		map.put("resource_id", id);
		map.put("category", 1);
		map.put("sign", "platformTrial");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("IntegratedQueryManagement",
				map);
		List<PlatformAuditRecordVo> audit=new ArrayList<PlatformAuditRecordVo>();
		if (result != null && !"".equals(result)) {
			if (result.getSys() != null) {
				String status = result.getSys().getStatus();
				if ("S".equals(status)) {// 交易成功
					JSONObject output = (JSONObject) result.getOutput();
					String records = output.getString("record");
					audit = JsonUtils.toList(records, PlatformAuditRecordVo.class);
					getRequest().setAttribute("records", audit);
				}
			}

		}
	}

	/**
	 * 资方初审 默认先查询第3个tab页
	 */

	@ValidateSession(validate = true)
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/capitalTrial")
	public  void capitalTrial(Long id, Long childrenId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("audit_type", 1);
		
		// 判断入口，如果是点击融资订单查看，则根据融资订单id查询，如果是子订单查看则通过融资自订单查询
		if (childrenId == null) {
			map.put("id_", id);
			map.put("sign", "fristExamination");// 所调用的服务中的方法
		} else {
			map.put("id_", childrenId);
			map.put("sign", "fristExaminationByChildrenId");// 所调用的服务中的方法
		}
		ResBody result = TradeInvokeUtils.invoke("IntegratedQueryManagement",
				map);
		List<SupplierRiskManagementAuditVO> ls = new ArrayList<SupplierRiskManagementAuditVO>();
		if (result != null && !"".equals(result)) {
			if (result.getSys() != null) {
				String status = result.getSys().getStatus();
				if ("S".equals(status)) {// 交易成功
					JSONObject output = (JSONObject) result.getOutput();
					String records = output.getString("examinationlist");
					if(records !=null){
						ls = JsonUtils.toList(records,
								SupplierRiskManagementAuditVO.class);
						
					}
					if (ls.size() > 0) {
						getRequest().setAttribute("records", ls);
					}
				}
			}

		}
	}

	/**
	 * 
	 * 根据resource_id查询附件信息
	 */

	/**
	 * 选择意向资方 默认先查询第4个tab页
	 */

	@ValidateSession(validate = true)
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/chooseIntentionalCapital")
	public  void chooseIntentionalCapital(Integer id,Long childrenId) {
		Map<String, Object> maps = new HashMap<String, Object>();
		    /*if(childrenId !=null){	
		    	maps.put("id_", childrenId);
		    	maps.put("selection_status", "1,2");	
		    	maps.put("audit_type", 1);
		    	maps.put("sign", "fundsByselectionStatus");// 所调用的服务中的方法
		    }else{	*/   
		    	maps.put("financing_apply_id", id);
		    	//maps.put("selection_status", "1,2");
		    	maps.put("audit_type", 1);
		    	maps.put("audit_result",1);
		    	maps.put("sign", "fundsByselectionStatus");// 所调用的服务中的方法
		    
		    ResBody result = TradeInvokeUtils.invoke(
				"IntegratedQueryManagement", maps);
		isSuccess(result);
		List<IntegerFundsMangementVO> fund=new ArrayList<IntegerFundsMangementVO>(); 
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String stringPage = output.getString("funds");
				if(stringPage!=null&&!"[]".equals(stringPage)){
					fund=JsonUtils.toList(stringPage,IntegerFundsMangementVO.class);		
					getRequest().setAttribute("fund", fund);
				}
				
			} else {
				super.log.error("根据条件查询账款调用queryList服务返回失败，信息：" + erortx);

			}
		}

	}

	/**
	 * 资方终审 默认先查询第5个tab页
	 */
	@ValidateSession(validate = true)
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/capitalTrialLast")
	public  void capitalTrialLast(Long id, Long childrenId) {
		SupplierRiskManagementAuditVO factorRiskManagementAuditHistoryVo=new SupplierRiskManagementAuditVO();
		//查询终审条件
		factorRiskManagementAuditHistoryVo.setAuditType(2);
		Map<String, Object> map = new HashMap<String, Object>();
		//判断入口，如果是点击融资订单查看，则根据融资订单id查询，如果是子订单查看则通过融资自订单查询
		if(childrenId==null){
			//如果子订单id为空则通过融资订单id查询
			factorRiskManagementAuditHistoryVo.setFinancingApplyId(Integer.valueOf(id.toString()));
		}else{
			//如果子订单id不为空 直接通过子订单查询
			factorRiskManagementAuditHistoryVo.setSubFinancingApplyId(Integer.valueOf(childrenId.toString()));
		}
		map.put("parameter", factorRiskManagementAuditHistoryVo);
		map.put("sign", "selectFactorRiskManagementAuditAndCooperationElements");//所调用的服务中的方法		
		ResBody result = TradeInvokeUtils.invoke("PlatformFinancingApplyManagement", map);
		List<SupplierRiskManagementAuditVO> ls=new ArrayList<SupplierRiskManagementAuditVO>();
		List<AttachmentVo> attachmentList=new ArrayList<AttachmentVo>();
			if(result!=null  &&!"".equals(result)){
		    	   if (result.getSys() != null) {
		   			String status = result.getSys().getStatus();
		   			if ("S".equals(status)) {// 交易成功
		   				JSONObject output = (JSONObject) result.getOutput();	
		   				String records = output.getString("result");	  
		   				ls = JsonUtils.toList(records, SupplierRiskManagementAuditVO.class);
		   				if(ls.size()>0){	   					
		   					getRequest().setAttribute("records", ls);
		   					//查询风控措施附件
		   					for (SupplierRiskManagementAuditVO entity : ls) {
		   						AttachmentVo attachmentVo=new AttachmentVo();
		   						attachmentVo.setCategory(4L);
		   						attachmentVo.setType("60");
		   						attachmentVo.setResourceId(Integer.valueOf(entity.getId().toString()));
		   						List<AttachmentVo> attachments = SelectAttachmentList(attachmentVo);
		   						if(attachments!=null){
		   							attachmentList.addAll(attachments);
		   							
		   						}
							}
		   					if(attachmentList!=null && attachmentList.size()>0){
		   						String ifHaveRecords=attachmentList.get(0).getNewName();
		   						if(ifHaveRecords!=null&&!"".equals(ifHaveRecords)){
		   							ifHaveRecords="haveRecords";
		   							getRequest().setAttribute("ifHaveRecords", ifHaveRecords);
		   						}
		   					}
		   					getRequest().setAttribute("attachmentList", attachmentList);
		   				}
		   			}
		   		}
			
		}

	}

	/**
	 * 合作资方 默认先查询第6个tab页
	 */

	@ValidateSession(validate = true)
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/cooperativeCapital")
	public  void cooperativeCapital(Long id,Long childrenId) {
		Map<String, Object> maps = new HashMap<String, Object>();
		/*if(childrenId !=null){	
	    	maps.put("id_", childrenId);
	    	maps.put("selection_status", "2");	
	    	maps.put("audit_type", 2);
	    	maps.put("sign", "fundsByselectionStatus");// 所调用的服务中的方法
	    }else{*/	   
	    	maps.put("financing_apply_id", id);
        	//maps.put("selection_status", "2");
	    	maps.put("audit_result",1);
	    	maps.put("audit_type", 2);
	    	maps.put("sign", "fundsByselectionStatus");// 所调用的服务中的方法	    	
	    
		
		ResBody result = TradeInvokeUtils.invoke(
				"IntegratedQueryManagement", maps);
		isSuccess(result);
		List<IntegerFundsMangementVO> fund=new ArrayList<IntegerFundsMangementVO>(); 
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String stringPage = output.getString("funds");
				if(stringPage!=null&&!"[]".equals(stringPage)){
					fund=JsonUtils.toList(stringPage,IntegerFundsMangementVO.class);		
					getRequest().setAttribute("fund", fund);
				}
				
			} else {
				super.log.error("根据条件查询账款调用queryList服务返回失败，信息：" + erortx);

			}
		}
	}

	/**
	 * 平台复审 默认先查询第7个tab页
	 */

	@ValidateSession(validate = true)
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/platformreview")
	public  void platformreview(Long id, Long childrenId) {
		Map<String, Object> map = new HashMap<String, Object>();
		if(childrenId !=null&&!"".equals(childrenId)){
			map.put("resource_id", childrenId);
			map.put("audit_type", 2);
			map.put("category", 1);
			map.put("sign", "platformTrial");// 所调用的服务中的方法
		}else{
			map.put("id_", id);
			map.put("sign", "platAuditById");// 所调用的服务中的方法
		}
		
		ResBody result = TradeInvokeUtils.invoke("IntegratedQueryManagement",
				map);
		List<PlatformAuditRecordVo> audit=new ArrayList<PlatformAuditRecordVo>();
		if (result != null && !"".equals(result)) {
			if (result.getSys() != null) {
				String status = result.getSys().getStatus();
				if ("S".equals(status)) {// 交易成功

					JSONObject output = (JSONObject) result.getOutput();
					String records = output.getString("record");
					audit  = JsonUtils.toList(records, PlatformAuditRecordVo.class);
					getRequest().setAttribute("records", audit);
				}
			}

		}

	}

	

	


	

	
	
	public List<AttachmentVo> SelectAttachmentList(AttachmentVo  attachment){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", attachment);
		map.put("sign", "queryAttchmentByCondition");// 所调用的服务中的方法
		ResBody resultAttachment = TradeInvokeUtils.invoke("AttachmentManagement", map);
		isSuccess(resultAttachment);
		JSONObject output = (JSONObject) resultAttachment.getOutput();
		String resultJson = output.getString("result");
		List<AttachmentVo> attachmentList = null;
		if(!"[]".equals(resultJson)&&resultJson!=null){
		
		attachmentList = JsonUtils.toList(resultJson, AttachmentVo.class);
		}
		return attachmentList;
		
		
	}
	
	
	///	查询附件
	public AttachmentVo SelectAttachment(AttachmentVo attachment){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", attachment);
		map.put("sign", "queryAttchmentByCondition");// 所调用的服务中的方法
		ResBody resultAttachment = TradeInvokeUtils.invoke("AttachmentManagement", map);
		isSuccess(resultAttachment);
		JSONObject output = (JSONObject) resultAttachment.getOutput();
		String resultJson = output.getString("result");
		List<AttachmentVo> attachmentList = null;
		if(!"[]".equals(resultJson)&&resultJson!=null){
		
		attachmentList = JsonUtils.toList(resultJson, AttachmentVo.class);
		}
		if(attachmentList != null && attachmentList.size()>=0){
		attachment = attachmentList.get(0);
		}
		return attachment;
		
		
	}
	
	
	/**
	 * 根据融资定单id或者子定单的id查找其合同签署情况
	 */
	
	
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/selectcontractdetail.htm")
	public  void selectContractDetail(Long id ,Long childrenId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("appid", id);
		map.put("applid", childrenId);
		map.put("sign", "selectcontractdetail");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("ContractMangement",
				map);
		ContractV4Vo contractvo=new ContractV4Vo();
		if (result != null && !"".equals(result)) {
			if (result.getSys() != null) {
				String status = result.getSys().getStatus();
				String erortx = result.getSys().getErortx();// 错误信息
				if ("S".equals(status)) {// 交易成功
					JSONObject output = (JSONObject) result.getOutput();
					String stringPage = output.getString("contractInfo");
					contractvo=JsonUtils.toObject(stringPage,ContractV4Vo.class);
					if(contractvo.getId() !=0){
						
						AttachmentVo attachment=new AttachmentVo();
						attachment.setType("37");
						attachment.setCategory(5L);
						attachment.setResourceId(Integer.parseInt(contractvo.getId().toString()));
						AttachmentVo attachments=SelectAttachment(attachment);
						getRequest().setAttribute("attachment", attachments);
						getRequest().setAttribute("entity", contractvo);
					}
				}
			}
		}


	}
	
	
	


}
