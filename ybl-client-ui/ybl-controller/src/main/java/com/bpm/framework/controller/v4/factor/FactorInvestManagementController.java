package com.bpm.framework.controller.v4.factor;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.SystemConst;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v4.factor.FinancingApplyChildInfo;
import cn.sunline.framework.controller.vo.v4.factor.SecuredLoanRepaymentVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 已放款项目管理控制器
 */
@Controller
@RequestMapping({ "/factorInvestManagementController" })
public class FactorInvestManagementController extends AbstractController{

	/**
	 * 
	 */
	private static final long serialVersionUID = -8318170577647094716L;
	/**
	 * 分页查询已放款记录
	 * @param pageVo
	 * @param securedLoanRepaymentVo
	 * @param flag
	 * @param request
	 * @return
	 */
	@RequestMapping({ "/getSecuredLoanRepaymentList.htm" })
	public String getSecuredLoanRepaymentList(PageVo<SecuredLoanRepaymentVo> pageVo,SecuredLoanRepaymentVo securedLoanRepaymentVo,@Param("flag")String flag,HttpServletRequest request) {
		Map<String,Object> map = new HashMap<String,Object>();
		SecuredLoanRepaymentVo securedLoanRepayment = new SecuredLoanRepaymentVo();
		/*设置查询条件*/
		/*
		 * 收款确认
		 * flag 为空或者"":全部，查询状态为8-待放款确认(等待融资方确认收款)9-已确认收款
		 * flag == 1,是，查询状态为9-已确认收款
		 * flag == 2,否，查询状态为8-待放款确认(等待融资方确认收款)
		 */
		if(null == flag||flag.equals("")){
			securedLoanRepayment.setAttribute1("8,9");
		}else if(flag.equals("1")){
			securedLoanRepayment.setStatus(9);
		}else{
			securedLoanRepayment.setStatus(8);
		}
		//放款申请单号
		if(null != securedLoanRepaymentVo.getOrderNo()&&securedLoanRepaymentVo.getOrderNo() != ""){
			securedLoanRepayment.setOrderNo(securedLoanRepaymentVo.getOrderNo());
		}
		/*
		 * 付款开始时间--付款结束时间
		 * 确认开始时间--确认结束时间
		 */
		if(null != securedLoanRepaymentVo.getPayStartDate()&&securedLoanRepaymentVo.getPayStartDate() != ""){
			securedLoanRepayment.setPayStartDate(securedLoanRepaymentVo.getPayStartDate());
		}
		if(null != securedLoanRepaymentVo.getPayEndDate()&&securedLoanRepaymentVo.getPayEndDate() != ""){
			securedLoanRepayment.setPayEndDate(securedLoanRepaymentVo.getPayEndDate());
		}
		if(null != securedLoanRepaymentVo.getConfirmStartDate()&&securedLoanRepaymentVo.getConfirmStartDate() != ""){
			securedLoanRepayment.setConfirmStartDate(securedLoanRepaymentVo.getConfirmStartDate());
		}
		if(null != securedLoanRepaymentVo.getConfirmEndDate()&&securedLoanRepaymentVo.getConfirmEndDate() != ""){
			securedLoanRepayment.setConfirmEndDate(securedLoanRepaymentVo.getConfirmEndDate());
		}
		
		/*根据登陆资金方ID过滤*/
		UserVo user = (UserVo)request.getSession().getAttribute(SystemConst.USER_SESSION_KEY);
		if(null != user){
			//账户已登录
			securedLoanRepayment.setBusiness_id(user.getBusinessId());
		}
		
		map.put("securedLoanRepayment",securedLoanRepayment);
		map.put("page", pageVo);
		ResBody result = TradeInvokeUtils.invoke("FactorInvestManagement", map);
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				log.info("已放款项目查询成功====================");
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("securedLoanRepaymentList");
				PageVo<?> page=JSONObject.parseObject(jsonPage, PageVo.class);
				List<SecuredLoanRepaymentVo> list=JsonUtils.toList(records,SecuredLoanRepaymentVo.class);
				getRequest().setAttribute("securedLoanRepayment", securedLoanRepayment);
				getRequest().setAttribute("flag", flag);
				getRequest().setAttribute("page", page);
				getRequest().setAttribute("list", list);
			}
		}
		return "ybl4.0/admin/factor/secured/list";
	}
	/**
	 * 分页查询已完成项目
	 * @param pageVo
	 * @param securedLoanRepaymentVo
	 * @param flag
	 * @param request
	 * @return
	 */
	@RequestMapping({ "/getSecuredLoanRepaymentFinishedList.htm" })
	public String getSecuredLoanRepaymentFinishedList(PageVo<SecuredLoanRepaymentVo> pageVo,SecuredLoanRepaymentVo securedLoanRepaymentVo,@Param("flag")String flag,HttpServletRequest request) {
		Map<String,Object> map = new HashMap<String,Object>();
		SecuredLoanRepaymentVo securedLoanRepayment = new SecuredLoanRepaymentVo();
		/*设置查询条件*/
		securedLoanRepayment.setRepaymentStatus(3);
		//放款申请单号
		if(null != securedLoanRepaymentVo.getOrderNo()&&securedLoanRepaymentVo.getOrderNo() != ""){
			securedLoanRepayment.setOrderNo(securedLoanRepaymentVo.getOrderNo());
		}
		/*
		 * 付款开始时间--付款结束时间
		 * 确认开始时间--确认结束时间
		 */
		if(null != securedLoanRepaymentVo.getPayStartDate()&&securedLoanRepaymentVo.getPayStartDate() != ""){
			securedLoanRepayment.setPayStartDate(securedLoanRepaymentVo.getPayStartDate());
		}
		if(null != securedLoanRepaymentVo.getPayEndDate()&&securedLoanRepaymentVo.getPayEndDate() != ""){
			securedLoanRepayment.setPayEndDate(securedLoanRepaymentVo.getPayEndDate());
		}
		if(null != securedLoanRepaymentVo.getConfirmStartDate()&&securedLoanRepaymentVo.getConfirmStartDate() != ""){
			securedLoanRepayment.setConfirmStartDate(securedLoanRepaymentVo.getConfirmStartDate());
		}
		if(null != securedLoanRepaymentVo.getConfirmEndDate()&&securedLoanRepaymentVo.getConfirmEndDate() != ""){
			securedLoanRepayment.setConfirmEndDate(securedLoanRepaymentVo.getConfirmEndDate());
		}
		
		/*根据登陆资金方ID过滤*/
		UserVo user = (UserVo)request.getSession().getAttribute(SystemConst.USER_SESSION_KEY);
		if(null != user){
			//账户已登录
			securedLoanRepaymentVo.setBusiness_id(user.getBusinessId());
		}
		
		map.put("securedLoanRepayment",securedLoanRepayment);
		map.put("page", pageVo);
		ResBody result = TradeInvokeUtils.invoke("FactorInvestManagement", map);
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				log.info("已完成项目查询成功====================");
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("securedLoanRepaymentList");
				PageVo<?> page=JSONObject.parseObject(jsonPage, PageVo.class);
				List<SecuredLoanRepaymentVo> list=JsonUtils.toList(records,SecuredLoanRepaymentVo.class);
				
				getRequest().setAttribute("page", page);
				getRequest().setAttribute("list", list);
			}
		}
		request.setAttribute("securedLoanRepayment", securedLoanRepayment);
		return "ybl4.0/admin/factor/secured/finish";
	}
	/**
	 * 分页查询融资失败的融资子订单列表
	 * @param pageVo
	 * @param financingApplyChildInfo
	 * @param request
	 * @return
	 */
	@SuppressWarnings({ "unused", "null" })
	@RequestMapping({ "/getFailedSubApplyList.htm" })
	public String getFailedSubApplyList(PageVo<FinancingApplyChildInfo> pageVo,FinancingApplyChildInfo financingApplyChildInfo,HttpServletRequest request) {
		Map<String,Object> map = new HashMap<String,Object>();
		FinancingApplyChildInfo child = new FinancingApplyChildInfo();
		/*根据融资子订单模糊查询*/
		if(null != financingApplyChildInfo.getOrdernNo()&&!financingApplyChildInfo.getOrdernNo().equals("")){
			child.setOrdernNo(financingApplyChildInfo.getOrdernNo());
		}
		/*融资方名称模糊查询*/
		if(null != financingApplyChildInfo.getEnterpriseName()&&!financingApplyChildInfo.getEnterpriseName().equals("")){
			child.setEnterpriseName(financingApplyChildInfo.getEnterpriseName());
		}
		/*融资申请开始时间-取主订单申请时间*/
		if(null != financingApplyChildInfo.getStartTime() && financingApplyChildInfo.getStartTime() != ""){
			child.setStartTime(financingApplyChildInfo.getStartTime());
		}
		/*融资申请结束时间*/
		if(null != financingApplyChildInfo.getEndTime() && financingApplyChildInfo.getEndTime() != ""){
			child.setEndTime(financingApplyChildInfo.getEndTime());
		}
		/*保理类型*/
		if(null != financingApplyChildInfo.getFactoringMode()){
			child.setFactoringMode(financingApplyChildInfo.getFactoringMode());
		}
		/*根据登陆资金方ID过滤*/
		UserVo user = (UserVo)request.getSession().getAttribute(SystemConst.USER_SESSION_KEY);
		if(null != user){
			//账户已登录
			child.setBusinessId(user.getBusinessId());
		}
		
		map.put("subFinancingApply",child);
		map.put("page", pageVo);
		ResBody result = TradeInvokeUtils.invoke("FactorFailedSubApplyPage", map);
		List<FinancingApplyChildInfo> list = null;
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				log.info("融资申请失败项目列表查询成功====================");
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("subFinancingApplyList");
				PageVo<?> page=JSONObject.parseObject(jsonPage, PageVo.class);
				list = JsonUtils.toList(records, FinancingApplyChildInfo.class);

				getRequest().setAttribute("page", page);
				getRequest().setAttribute("list", list);
			}
		}
		request.setAttribute("child", child);
		return "ybl4.0/admin/factor/subApply/failed";
	}
	/**
	 * 分页查询放款失败申请列表
	 * @param pageVo
	 * @param securedLoanRepaymentVo
	 * @param request
	 * @return
	 */
	@RequestMapping({ "/getFailedLoanApplyList.htm" })
	public String getFailedLoanApplyList(PageVo<SecuredLoanRepaymentVo> pageVo,SecuredLoanRepaymentVo securedLoanRepaymentVo,HttpServletRequest request) {
		Map<String,Object> map = new HashMap<String,Object>();
		SecuredLoanRepaymentVo vo = new SecuredLoanRepaymentVo();
		/*根据放款订单号模糊查询*/
		if(null != securedLoanRepaymentVo.getOrderNo()&&!securedLoanRepaymentVo.getOrderNo().equals("")){
			vo.setOrderNo(securedLoanRepaymentVo.getOrderNo());
		}
		/*放款申请开始时间*/
		if(null != securedLoanRepaymentVo.getPayStartDate() && securedLoanRepaymentVo.getPayStartDate() != ""){
			vo.setPayStartDate(securedLoanRepaymentVo.getPayStartDate());
		}
		/*放款申请结束时间*/
		if(null != securedLoanRepaymentVo.getPayEndDate() && securedLoanRepaymentVo.getPayEndDate() != ""){
			vo.setPayEndDate(securedLoanRepaymentVo.getPayEndDate());
		}
		/*根据登陆资金方ID过滤*/
		UserVo user = (UserVo)request.getSession().getAttribute(SystemConst.USER_SESSION_KEY);
		if(null != user){
			//账户已登录
			vo.setBusiness_id(user.getBusinessId());
		}
		
		map.put("loanApply",vo);
		map.put("page", pageVo);
		ResBody result = TradeInvokeUtils.invoke("FactorQueryFailLoanApplyManagement", map);
		if (result.getSys() != null) {
			String retStatus = result.getSys().getStatus();
			if ("S".equals(retStatus)) {
				log.info("放款失败的申请列表查询成功====================");
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("loanApplyList");
				PageVo<?> page=JSONObject.parseObject(jsonPage, PageVo.class);
				List<SecuredLoanRepaymentVo> list=JsonUtils.toList(records,SecuredLoanRepaymentVo.class);
				getRequest().setAttribute("page", page);
				getRequest().setAttribute("list", list);
			}
		}
		request.setAttribute("vo", vo);
		return "ybl4.0/admin/factor/loanApply/failed";
	}
}
