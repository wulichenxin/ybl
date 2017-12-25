package com.bpm.framework.controller.accountCenter;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.constant.Constant;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.utils.CollectionUtils;
import com.bpm.framework.utils.date.DateUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.BankAccountVo;
import cn.sunline.framework.controller.vo.MemberFundLines;
import cn.sunline.framework.controller.vo.MemberFundVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.WidthdralRecordVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 账户总览
 * 
 * @author MaiBenBen
 *
 */
@Controller
@RequestMapping({ "/accountOverview" })
public class AccountOverviewController extends AbstractController {

	private static final long serialVersionUID = -6410862792764700203L;

	/**
	 * 账户总览页面跳转，并加载数据
	 * 
	 * @param request
	 * @param id
	 *            用户id
	 * @return
	 */
	@RequestMapping({ "/queryAccountOverview" })
	public String queryAccountOverview(HttpServletRequest request) {
		// (1)获取当前登录人信息
		UserVo user = ControllerUtils.getCurrentUser();
		String certType = (String) getSession().getAttribute("type");
		// (2)查询当前登陆人的详细信息
		// 核心企业：enterprise;供应商：supplier;保理商：factor;未认证：visitor
		Long enterpriseId = user.getEnterpriseId();
		Long memberId = user.getId();
		// 区分不同的用户在账户中心展示不同的内容
		if (certType.equals(Constant.USER_CORE_ENTERPRISE)) {// 核心企业
			// (3)调用服务，查询会员资金信息
			List<MemberFundVo> memberFundList = queryMemberFundByCondition(enterpriseId, memberId);
			if (CollectionUtils.isNotEmpty(memberFundList)) {
				request.setAttribute("memberFund", memberFundList.get(0));
			}
		} else if (certType.equals(Constant.USER_FACTOR) || certType.equals(Constant.USER_SUPPLIER)) {// 保理商和供应商
			// (4)调用服务，查询会员银行账号信息
			List<BankAccountVo> bankAccountList = queryBankAccountByCondition(enterpriseId, memberId, 2);
			if (CollectionUtils.isNotEmpty(bankAccountList)) {
				request.setAttribute("bankAccountList", bankAccountList);// 银行账号信息
			}
			// (5)调用服务，查询会员资金信息
			List<MemberFundVo> memberFundList = queryMemberFundByCondition(enterpriseId, memberId);
			if (CollectionUtils.isNotEmpty(memberFundList)) {
				MemberFundVo memberFund = memberFundList.get(0);
				request.setAttribute("memberFund", memberFund);// 会员资金信息
				// (6)调用服务，查询会员资金行信息 (默认展示本月账单)
				int year = DateUtils.getYear(DateUtils.now());// 获取当前时间所在的年份
				int month = DateUtils.getMonth(DateUtils.now());// 获取当前时间所在的月份
				List<MemberFundLines> memberFundLinesList = queryMemberFundLineByCondition(enterpriseId,
						memberFund.getId(), year, month, 5);
				if (CollectionUtils.isNotEmpty(memberFundLinesList)) {
					request.setAttribute("memberFundLinesList", memberFundLinesList);// 会员资金行信息
					// 计算本月收入、本月支出
					BigDecimal monthIncom = BigDecimal.ZERO;
					BigDecimal monthExpenditure = BigDecimal.ZERO;
					for (MemberFundLines mfl : memberFundLinesList) {
						monthIncom = monthIncom.add(mfl.getIncome());
						monthExpenditure = monthExpenditure.add(mfl.getExpenditure());
					}
					request.setAttribute("monthIncom", monthIncom);// 本月收入
					request.setAttribute("monthExpenditure", monthExpenditure);// 本月支出
					if (memberFundLinesList.get(0) != null) {// 本月最后一条资金行记录
						BigDecimal monthUaseableAmount = memberFundLinesList.get(0).getUseableAmount();
						request.setAttribute("monthUaseableAmount", monthUaseableAmount);// 本月可用余额
					}
				}
				// (6)调用服务，查询会员资金行信息 (获取上月账单)
				int lastMonth = DateUtils.getMonth(DateUtils.now()) - 1;// 获取当前时间所在的月份的上一个月
				int lastYear = DateUtils.getYear(DateUtils.now());// 获取当前时间所在的月份的上一个月的所在的年份
				if (lastMonth == 0) {
					lastMonth = 12;
					lastYear -= lastYear;
				}
				List<MemberFundLines> lastMemberFundLinesList = queryMemberFundLineByCondition(enterpriseId,
						memberFund.getId(), lastYear, lastMonth, 1);
				if (CollectionUtils.isNotEmpty(lastMemberFundLinesList)) {
					if (lastMemberFundLinesList.get(0) != null) {// 上月最后一条资金行记录
						BigDecimal lastMonthUaseableAmount = lastMemberFundLinesList.get(0).getUseableAmount();
						request.setAttribute("lastMonthUaseableAmount", lastMonthUaseableAmount);// 上月可用余额
					}
				}
			}
		}
		return "ybl/admin/accountCenter/accountCenter/accountCenter";
	}

	/**
	 * 提现页面跳转，并加载数据
	 * 
	 */
	@RequestMapping({ "/toWithdrawalPage" })
	public String toWithdrawalPage(HttpServletRequest request) {
		// (1)获取当前登录人信息
		UserVo user = ControllerUtils.getCurrentUser();
		Long enterpriseId = user.getEnterpriseId();
		Long memberId = user.getId();
		// (2)调用服务，查询会员银行账号信息
		List<BankAccountVo> bankAccountList = queryBankAccountByCondition(enterpriseId, memberId, 2);
		if (CollectionUtils.isNotEmpty(bankAccountList)) {
			request.setAttribute("bankAccountList", bankAccountList);// 银行账号信息
		}
		// (3)调用服务，查询会员资金信息
		List<MemberFundVo> memberFundList = queryMemberFundByCondition(enterpriseId, memberId);
		if (CollectionUtils.isNotEmpty(memberFundList)) {
			MemberFundVo memberFund = memberFundList.get(0);
			request.setAttribute("memberFund", memberFund);// 会员资金信息
		}
		return "ybl/admin/bank/withdrawals";
	}
	
	/**
	 * 充值页面跳转，并加载数据
	 * 
	 */
	@RequestMapping({ "/toRechargePage" })
	public String toRechargePage(HttpServletRequest request) {
		// (1)获取当前登录人信息
		UserVo user = ControllerUtils.getCurrentUser();
		Long enterpriseId = user.getEnterpriseId();
		Long memberId = user.getId();
		// (2)调用服务，查询会员资金信息
		List<MemberFundVo> memberFundList = queryMemberFundByCondition(enterpriseId, memberId);
		if (CollectionUtils.isNotEmpty(memberFundList)) {
			MemberFundVo memberFund = memberFundList.get(0);
			request.setAttribute("memberFund", memberFund);// 会员资金信息
		}
		return "ybl/admin/bank/recharge";
	}
	
	/**
	 * 提现记录页面跳转，并加载数据
	 * 
	 */
	@RequestMapping({ "/toWithdrawalsRecordPage" })
	public String toWithdrawalsRecordPage(HttpServletRequest request,PageVo<?> page) {
		// (1)获取当前登录人信息
		UserVo user = ControllerUtils.getCurrentUser();
		Long memberId = user.getId();
		WidthdralRecordVo parameters = new WidthdralRecordVo();
		parameters.setEnable(1);// （0：否，1：是）
		parameters.setMemberId(memberId);
		// 调用服务，进行数据查询
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", parameters);
		map.put("page", page);
		map.put("sign", "queryWithdralRecordByCondition");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("WithdralsRecordManagement", map);
		JSONObject output = (JSONObject) result.getOutput();
		List<WidthdralRecordVo> widthdralRecordList = null;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				String resultJson = output.getString("result");
				String pageJson = output.getString("page");
				page = (PageVo<?>) JSONObject.parseObject(pageJson, PageVo.class);
				widthdralRecordList = JsonUtils.toList(resultJson, WidthdralRecordVo.class);
				request.setAttribute("page", page);
				request.setAttribute("widthdralRecordList", widthdralRecordList);
				super.log.info("根据条件查询提现记录信息调用queryWithdralRecordByCondition服务返回成功，信息：" + erortx);
			} else {
				super.log.error("根据条件查询提现记录信息调用queryWithdralRecordByCondition服务返回失败，信息：" + erortx);
			}
		}
		return "ybl/admin/bank/withdrawalsRecord";
	}

	/**
	 * 根据用户信息查询用户
	 * 
	 * @param request
	 * @param parameters
	 *            用户查询条件
	 * @return userList 用户对象集合
	 */
	@RequestMapping(value = "/queryMemberByCondition")
	@ResponseBody
	public List<UserVo> queryMemberByCondition(UserVo parameters) {
		parameters.setEnable(1);// （0：否，1：是）
		// 调用服务，进行数据查询
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", parameters);
		map.put("page", new PageVo<>());
		map.put("sign", "queryMemberByCondition");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("MemberManagement", map);
		JSONObject output = (JSONObject) result.getOutput();
		List<UserVo> userList = null;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				String resultJson = output.getString("result");
				userList = JsonUtils.toList(resultJson, UserVo.class);
				super.log.info("根据条件查询用户调用queryMemberByCondition服务返回成功，信息：" + erortx);
			} else {
				super.log.error("根据条件查询用户调用queryMemberByCondition服务返回失败，信息：" + erortx);
				return null;
			}
		}
		return userList;
	}

	/**
	 * 根据企业id查询银行账号信息
	 * 
	 * @param request
	 * @param enterpriseId
	 *            企业id
	 * @return userList 银行账号信息
	 */
	@RequestMapping(value = "/queryBankAccountByCondition")
	@ResponseBody
	public List<BankAccountVo> queryBankAccountByCondition(Long enterpriseId, Long memberId, int countPage) {
		BankAccountVo parameters = new BankAccountVo();
		parameters.setEnable(1);// （0：否，1：是）
		parameters.setEnterpriseId(enterpriseId);
		parameters.setMemberId(memberId);
		PageVo<?> page = new PageVo<>();
		page.setPageSize(countPage);
		// 调用服务，进行数据查询
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", parameters);
		map.put("page", page);
		map.put("sign", "queryBankAccountByCondition");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("BankAccountsManagement", map);
		JSONObject output = (JSONObject) result.getOutput();
		List<BankAccountVo> bankAccountVoList = null;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				String resultJson = output.getString("result");
				bankAccountVoList = JsonUtils.toList(resultJson, BankAccountVo.class);
				super.log.info("根据条件查询银行账号信息调用queryBankAccountByCondition服务返回成功，信息：" + erortx);
			} else {
				super.log.error("根据条件查询银行账号信息调用queryBankAccountByCondition服务返回失败，信息：" + erortx);
				return null;
			}
		}
		return bankAccountVoList;
	}

	/**
	 * 根据条件查询会员资金信息
	 * 
	 * @param request
	 * @param parameters
	 *            查询条件
	 * @return userList 会员资金对象集合
	 */
	@RequestMapping(value = "/queryMemberFundByCondition")
	@ResponseBody
	public List<MemberFundVo> queryMemberFundByCondition(Long enterpriseId, Long memberId) {
		MemberFundVo parameters = new MemberFundVo();
		parameters.setEnterpriseId(enterpriseId);
		parameters.setMemberId(memberId);
		parameters.setEnable(1);// （0：否，1：是）
		// 调用服务，进行数据查询
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", parameters);
		map.put("page", new PageVo<>());
		map.put("sign", "queryMemberFundByCondition");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("MemberFundManagement", map);
		JSONObject output = (JSONObject) result.getOutput();
		List<MemberFundVo> memberFundList = null;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				String resultJson = output.getString("result");
				memberFundList = JsonUtils.toList(resultJson, MemberFundVo.class);
				super.log.info("根据条件查询会员资金信息调用queryMemberFundByCondition服务返回成功，信息：" + erortx);
			} else {
				super.log.error("根据条件查询会员资金信息调用queryMemberFundByCondition服务返回失败，信息：" + erortx);
				return null;
			}
		}
		return memberFundList;
	}

	/**
	 * 根据条件查询会员资金行信息
	 * 
	 * @param request
	 * @param parameters
	 *            查询条件
	 * @return userList 会员资金行对象集合
	 */
	@RequestMapping(value = "/queryMemberFundLineByCondition")
	@ResponseBody
	public List<MemberFundLines> queryMemberFundLineByCondition(Long enterpriseId, Long memberFundId, int year,
			int month, int countPage) {
		MemberFundLines parameters = new MemberFundLines();
		// 查询今年当月的账单信息
		if (year != 0 && month != 0) {
			String startTime = DateUtils.toString(DateUtils.beginTimeOfMonth(year, month));
			String endTime = DateUtils.toString(DateUtils.endTimeOfMonth(year, month));
			parameters.setAttribute1(startTime);// 备用字段attribute1 塞当月第一天
			parameters.setAttribute2(endTime);// 备用字段attribute2塞当月最后一天
		}
		parameters.setEnterpriseId(enterpriseId);
		parameters.setMemberFundId(memberFundId);
		parameters.setEnable(1);// （0：否，1：是）
		PageVo<?> page = new PageVo<>();
		page.setPageSize(countPage);
		// 调用服务，进行数据查询
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", parameters);
		map.put("page", page);
		map.put("sign", "queryMemberFundLineByCondition");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("MemberFundLineManagement", map);
		JSONObject output = (JSONObject) result.getOutput();
		List<MemberFundLines> memberFundLineList = null;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				String resultJson = output.getString("result");
				memberFundLineList = JsonUtils.toList(resultJson, MemberFundLines.class);
				super.log.info("根据条件查询会员资金行信息调用queryMemberFundByCondition服务返回成功，信息：" + erortx);
			} else {
				super.log.error("根据条件查询会员行信息调用queryMemberFundByCondition服务返回失败，信息：" + erortx);
				return null;
			}
		}
		return memberFundLineList;
	}
}
