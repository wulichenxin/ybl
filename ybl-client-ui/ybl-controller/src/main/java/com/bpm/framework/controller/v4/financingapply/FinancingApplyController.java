package com.bpm.framework.controller.v4.financingapply;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
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
import com.bpm.framework.controller.v4.common.FinancingApplyCommonApi;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.EnterpriseVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v4.drools.StockHolderVO;
import cn.sunline.framework.controller.vo.v4.drools.V4BusinessAuthVO;
import cn.sunline.framework.controller.vo.v4.factor.enums.E_V4_ASSETS_TYPE;
import cn.sunline.framework.controller.vo.v4.supplier.AccountsPayableVO;
import cn.sunline.framework.controller.vo.v4.supplier.AccountsReceivableV4VO;
import cn.sunline.framework.controller.vo.v4.supplier.ApplicantFinancialSituationVO;
import cn.sunline.framework.controller.vo.v4.supplier.BillVO;
import cn.sunline.framework.controller.vo.v4.supplier.ExternalGuaranteeSituationVO;
import cn.sunline.framework.controller.vo.v4.supplier.FinancingApplyVO;
import cn.sunline.framework.controller.vo.v4.supplier.LoanDebtSituationVO;
import cn.sunline.framework.controller.vo.v4.supplier.SubFinancingApply;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 云保理4.0用户端登录控制器
 */
@Controller
@RequestMapping({ "/financingApplyController" })
public class FinancingApplyController extends AbstractController {

	private static final long serialVersionUID = -2809460978768158852L;
	
	/**
	 * 资金方分页查询竞标类型的融资申请列表
	 * @return
	 */

	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/bidRecord/list.htm")
	public String list(PageVo<FinancingApplyVO> pageVo,FinancingApplyVO vo,@Param("flag")Integer flag) {
		Map<String,Object> map = new HashMap<String,Object>();
		FinancingApplyVO financingApplyVO = new FinancingApplyVO();
		if(flag==null||flag == 0){
			financingApplyVO.setAttribute1("0");//设置竞标列表默认排序规则--按照更新时间排序
		}else if(flag == 1){
			financingApplyVO.setAttribute1("1");//设置竞标列表按照融资利率排序
		}else if(flag == 2){
			financingApplyVO.setAttribute1("2");//设置竞标列表按照融资期限排序
		}else{
			financingApplyVO.setAttribute1("3");//设置竞标列表按照融资金额排序
		}
		
		financingApplyVO.setFinancingMode(3);//设置融资申请类型为竞标
		financingApplyVO.setFinancingStatus(3);//设置融资申请状态为待资方初审
		
		map.put("financingApply",financingApplyVO);
		map.put("page", pageVo);
		ResBody result = TradeInvokeUtils.invoke("V4FinancingApplyManagement", map);
		@SuppressWarnings("rawtypes")
		PageVo page=null;
		List<FinancingApplyVO> list=null;
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				log.info("竞标数据查询成功====================");
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("financingApplyList");
				page=(PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
				list=JsonUtils.toList(records,FinancingApplyVO.class);
				
				page.setRecordCount((long)list.size());
				getRequest().setAttribute("page", page);
				getRequest().setAttribute("list", list);
			}
		}
		return "ybl4.0/admin/factor/financingApply/bidRecord/list";
	}
	
	/**
	 * 资金方根据竞标ID查询出竞标信息及详情页签信息
	 * 1、竞标记录信息
	 * 2、申请人信息
	 * @return
	 */
	@RequestMapping(value = "/bidRecord/details.htm")
	public String details(@Param("id")Long id) {
		UserVo user = ControllerUtils.getCurrentUser();
		if(null == user){
			//用户登录信息已失效
			return "redirect:/loginV4Controller/index.htm";
		}
		
		//根据ID查询竞标信息
		Map<String,Object> map = new HashMap<String,Object>();
		FinancingApplyVO financingApplyVO = new FinancingApplyVO();
		if(null != id){
			financingApplyVO.setApply_id(id);
		}
		map.put("financingApply",financingApplyVO);
		ResBody result = TradeInvokeUtils.invoke("V4FinancingApplyQueryById", map);
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
				if(null != records){
					financing=JsonUtils.toObject(records, FinancingApplyVO.class);
					//截止日期加一天
					Calendar c = Calendar.getInstance();  
			        c.setTime(financing.getBidExpireDate());  
			        c.add(Calendar.DAY_OF_MONTH, 1);// 今天+1天  
					financing.setBigExpireDate(c.getTime());
				}
				getRequest().setAttribute("financing", financing);
			}
		}
		
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
		
		return "ybl4.0/admin/factor/financingApply/bidRecord/details";
	}
	
	/**
	 * 融资方我要参与
	 */
	@RequestMapping(value = "/insertSubFinancingApply")
	@ResponseBody
	@Log(operation=OperationType.Exe,info="我要参与--生成融资子订单信息")
	public ControllerResponse insertSubFinancingApply(String appId,String orderNo) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		UserVo user = ControllerUtils.getCurrentUser();
		if(null == user){
			response.setInfo("您的登录信息已失效，请重新登录");
			return response;
		}
		FinancingApplyVO vo = new FinancingApplyVO();
		vo.setApply_id(Long.parseLong(appId));
		FinancingApplyVO total = getFinancingApply(vo);//总投标资方数据
		//截标时间校验
		Calendar c = Calendar.getInstance();  
        c.setTime(total.getBidExpireDate());  
        c.add(Calendar.DAY_OF_MONTH, 1);
        total.setBigExpireDate(c.getTime());
		if(total.getBigExpireDate().getTime() < (new Date()).getTime()){
			response.setInfo("该竞标已截止");
			return response;
		}
		SubFinancingApply subFinancingApply = new SubFinancingApply();
		subFinancingApply.setFinancingApplyId(Long.parseLong(appId));
		subFinancingApply.setBusinessId(user.getBusinessId());
		List<SubFinancingApply> subList = getSubFinancingApplyList(subFinancingApply);
		if(null != subList&&subList.size() > 0){
			//1、已有该用户(资金方)的融资子订单(该资金方已参与)
			response.setInfo("您已参与该竞标项目，请勿重复操作");
			response.setResponseType(ResponseType.FAILURE);
		}else{
			//2、没有该用户(资金方)的融资子订单(该资金方未参与)
			/**
			 *判断该竞标项目是否已经满标
			 */
			if(total.getCount() >= 10){
				response.setInfo("啊哦，你下手太慢了,该竞标项目已经满标");
				response.setResponseType(ResponseType.FAILURE);
			}else{
				SubFinancingApply sub = new SubFinancingApply();
				
				//根据登录用户信息获取该账户的企业信息
				EnterpriseVo enterprise = null;
				if(null != user.getEnterpriseId()){
					EnterpriseVo enterpriseVo = new EnterpriseVo();
					enterpriseVo.setId(user.getEnterpriseId());
					Map<String, Object> map = new HashMap<String, Object>();
					map.put("enterprise", enterpriseVo);
					ResBody result = TradeInvokeUtils.invoke("FactorQueryEnterpriseById", map);
					if (result.getSys() != null) {
						String status = result.getSys().getStatus();
						if ("S".equals(status)) {// 交易成功
							log.info("交易成功====================");
							JSONObject output = (JSONObject) result.getOutput();
							String records = output.getString("enterprise");
							enterprise=JsonUtils.toObject(records, EnterpriseVo.class);
						}
					}
				}
				if(null != enterprise){
					sub.setFunderName(enterprise.getEnterpriseName());
				}
				
				//3、根据已投标资金方数量生成下一个子订单信息并保存
				
				sub.setFinancingApplyId(Long.parseLong(appId));
				sub.setFinancingStatus("3");//融资子订单初始状态-待资方初审状态
				sub.setBusinessId(user.getBusinessId());	//资方id
				sub.setEnable(1);
				sub.setCreatedBy(user.getId());
				sub.setCreatedTime(new Date());
				sub.setLastUpdateBy(user.getId());
				sub.setLastUpdateTime(new Date());
				
				//子订单号
				StringBuilder subOrderNo = new StringBuilder(orderNo);
				subOrderNo.append("-A");
				subOrderNo.append(total.getCount()+1);
				sub.setOrderNo(subOrderNo.toString());
				
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("financingSubApply", sub);
				
				ResBody result = TradeInvokeUtils.invoke("FactorInsertSubFinancingApply", map);
				JSONObject output = (JSONObject) result.getOutput();
				
				if (result.getSys() != null) {
					String status = result.getSys().getStatus();
					if ("S".equals(status)) {// 交易成功
						String isAdded = output.getString("isAdded");
						if(null != isAdded&&isAdded.equals("true")){
							response.setResponseType(ResponseType.SUCCESS);
							response.setInfo("参与竞标成功！");
						}else{
							response.setResponseType(ResponseType.FAILURE);
							response.setInfo("参与竞标失败！");
						}
					} else {
						response.setResponseType(ResponseType.FAILURE);
						response.setInfo("参与竞标失败！");
					}
				}
			}
		}
		return response;
	}
	
	/**
	 * 获取融资申请主信息 
	 * @param financingApplyVO
	 * @return
	 */
	public FinancingApplyVO getFinancingApply(FinancingApplyVO financingApplyVO) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("financingApply",financingApplyVO);
		ResBody result = TradeInvokeUtils.invoke("V4FinancingApplyQueryById", map);
		// 融资申请订单信息
		FinancingApplyVO financing=null;
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				log.info("交易成功====================");
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("financingApply");
				if(null != records){
					financing=JsonUtils.toObject(records, FinancingApplyVO.class);
				}
			}
		}
		return financing;
	}
	
	/**
	 * 根据登录用户BusinessId和融资申请ID查询出融资子订单列表
	 */
	public List<SubFinancingApply> getSubFinancingApplyList(SubFinancingApply subFinancingApply){
		//根据ID查询竞标信息
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("subFinancingApply",subFinancingApply);
		ResBody result = TradeInvokeUtils.invoke("V4SubFinancingApplyManagement", map);
		//2、票据列表信息
		List<SubFinancingApply> subList=null;
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("subFinancingApplyList");
				if(null != records){
					subList=JsonUtils.toList(records,SubFinancingApply.class);
					log.info("获取融资子订单列表成功====================");
				}
			}
		}
		return subList;		
		
	}
}
