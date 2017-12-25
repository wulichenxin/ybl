package com.bpm.framework.controller.v4.factor;

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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v4.ContractTemplateVO;
import cn.sunline.framework.controller.vo.v4.factor.AccountsPayableElementsVo;
import cn.sunline.framework.controller.vo.v4.factor.AccountsReceivableElementsVo;
import cn.sunline.framework.controller.vo.v4.factor.BillElementsVo;
import cn.sunline.framework.controller.vo.v4.factor.FactorAttachmentVo;
import cn.sunline.framework.controller.vo.v4.factor.FactorLoanAuditVo;
import cn.sunline.framework.controller.vo.v4.factor.FormBillListVo;
import cn.sunline.framework.controller.vo.v4.factor.FormPayableListVo;
import cn.sunline.framework.controller.vo.v4.factor.FormReceivableListVo;
import cn.sunline.framework.controller.vo.v4.factor.enums.E_V4_ATTACHMENT_CATEGORY;
import cn.sunline.framework.controller.vo.v4.factor.enums.E_V4_ATTACHMENT_TYPE;
import cn.sunline.framework.controller.vo.v4.factor.enums.E_V4_STATUS;
import cn.sunline.framework.controller.vo.v4.supplier.AccountsPayableVO;
import cn.sunline.framework.controller.vo.v4.supplier.AccountsReceivableV4VO;
import cn.sunline.framework.controller.vo.v4.supplier.BillVO;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.annotation.Log;
import com.bpm.framework.annotation.OperationType;
import com.bpm.framework.annotation.ValidateSession;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.utils.date.DateUtils;
import com.bpm.framework.utils.json.JsonUtils;

/**
 * 资金方放款审核
 */
@Controller
@RequestMapping({ "/factorLoanAuditController" })
public class FactorLoanAuditController extends AbstractController {

	private static final long serialVersionUID = 1757197771596911485L;

	/**
	 * 资金方分页查询放款审核列表
	 * @param factorLoanAuditVo	放款审核实体
	 * @param pageVo 分页参数
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/loanAudit/loanAuditList.htm")
	public String loanAuditList(FactorLoanAuditVo factorLoanAuditVo,PageVo pageVo) {
		UserVo user = ControllerUtils.getCurrentUser();
		//登录验证
		if (null == user) {
			super.log.error("请先登录");
			return "ybl4.0/admin/doorl/login";
		}
		factorLoanAuditVo.setBusinessId(user.getBusinessId());//限制只能查询自己的放款申请记录
		factorLoanAuditVo.setStatus(E_V4_STATUS.WAIT_FACTOR_AUDIT.getStatus());//待资方办理
		queryLoanAuditByCondition(factorLoanAuditVo, pageVo);
		
		return "ybl4.0/admin/factor/loanAudit/loanAuditList";
	}

	/**
	 * 更新附件信息
	 * @param Attachment 附件对象
	 * @return
	 */
	@RequestMapping(value = "/updateAttachment")
	@ResponseBody
	@Log(operation = OperationType.Exe, info = "更新附件信息")
	public ControllerResponse updateAttachment(FactorAttachmentVo Attachment) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		UserVo user = ControllerUtils.getCurrentUser();
		//登录验证
		if (null == user) {
			response.setInfo("请先登录");// 参数错误
			super.log.error("请先登录");
			return response;
		}
		//参数验证
		if (null == Attachment) {
			response.setInfo("参数错误");// 参数错误
			super.log.error("更新附件对象不能为空！");
			return response;
		}
		//更新附件信息
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> aMapinfo = new HashMap<String, Object>();
		aMapinfo.put("id", Attachment.getId_());
		aMapinfo.put("url", Attachment.getUrl_());
		aMapinfo.put("newName", Attachment.getNew_name()); 
		aMapinfo.put("oldName", Attachment.getOld_name());
		aMapinfo.put("extName", Attachment.getExt_name());
		aMapinfo.put("fileSize", Attachment.getFile_size());
		aMapinfo.put("lastUpdateBy", user.getId());
		aMapinfo.put("lastUpdateTime", DateUtils.now());
		
		map.put("paramter", aMapinfo);
		map.put("sign", "updateAttachmentById");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("FactorLoanAudit", map);
		response.setResponseType(ResponseType.SUCCESS);
		if (null != result.getSys()) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();//错误信息
			if ("S".equals(status)) {
				response.setInfo("更新成功");//更新成功
				super.log.info("更新附件信息服务返回成功");
			}else{
				response.setResponseType(ResponseType.ERROR);
				response.setInfo("更新失败");// 更新失败
				super.log.error("更新附件信息服务返回失败：" + erortx);
			}
		}else {
			response.setResponseType(ResponseType.ERROR);
			response.setInfo("调用服务失败");// 调用服务失败
			super.log.error("调用服务失败！");
		}
		return response;
	}
	
	/**
	 * 根据放款申请id查询风控终审id
	 * @param lid 放款申请id
	 * @return
	 */
	public int getFinalRiskId(int lid) {
		Map<String,Object> map = new HashMap<String,Object>();
		Map<String,Object> mapinfo = new HashMap<String,Object>();
		mapinfo.put("id", lid);
		map.put("paramter",mapinfo);
		map.put("sign", "queryFinalRiskId");//所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("FactorLoanAudit", map);
		int rid = 0;
		if (null != result.getSys()) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();//错误信息
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				rid = JsonUtils.toObject(records, int.class);
				super.log.info("查询风控终审id服务返回成功，信息："+rid);
			}else{
				super.log.error("查询风控终审id服务返回失败，信息："+erortx);
			}
		}
		return rid;
	}
	
	/**
	 * 业务操作公共页面
	 * @param lid 放款申请id
	 * @return
	 */
	@ValidateSession(validate = true)
	@RequestMapping(value = "/{lid}/view.htm")
	public String details(@PathVariable("lid") int lid) {
		UserVo user = ControllerUtils.getCurrentUser();
		if (null == user) {
			super.log.error("请先登录");
			return "ybl4.0/admin/doorl/login";
		}
		//数据校验 根据放款申请id查询底层资产和放款申请状态
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> mapinfo = new HashMap<String, Object>();
		mapinfo.put("id", lid);//放款申请id
		mapinfo.put("businessId", user.getBusinessId());
		
		map.put("paramter", mapinfo);
		map.put("sign", "selectAssetsTypeById");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("FactorIndexManagement", map);
		if (null != result.getSys()) {
			String sta = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();//错误信息
			if ("S".equals(sta)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				FactorLoanAuditVo loanInfo = JsonUtils.toObject(records, FactorLoanAuditVo.class);
				Integer type = loanInfo.getAssetsType();
				Integer loanStatus = loanInfo.getStatus();
				
				getRequest().setAttribute("lid", lid);//放款申请id
				getRequest().setAttribute("assetsType", type);//底层资产类型
				getRequest().setAttribute("status", loanStatus);//放款申请状态
				super.log.info("根据放款id查询底层资产服务返回成功，信息："+ loanInfo);
			}else{
				super.log.error("根据放款id查询底层资产服务返回服务返回失败，信息："+erortx);
			}
		}
		return "ybl4.0/admin/factor/loanAudit/view";
	}
	
	/**
	 * 跳转至保理要素页面
	 * @param lid 放款申请id
	 * @return
	 */
	@RequestMapping(value = "/loanAudit/{lid}/toFactoringElements.htm")
	public String toFactoringElements(@PathVariable("lid")int lid) {
		UserVo user = ControllerUtils.getCurrentUser();
		if (null == user) {
			super.log.error("请先登录");
			return "ybl4.0/admin/doorl/login";
		}
		//数据校验 根据放款申请id查询底层资产和放款申请状态
		Map<String, Object> testMap = new HashMap<String, Object>();
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("id", lid);//放款申请id
		param.put("businessId", user.getBusinessId());
		
		testMap.put("paramter", param);
		testMap.put("sign", "selectAssetsTypeById");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("FactorIndexManagement", testMap);
		if (null != result.getSys()) {
			String sta = result.getSys().getStatus();
			String err = result.getSys().getErortx();//错误信息
			if ("S".equals(sta)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				FactorLoanAuditVo loanInfo = JsonUtils.toObject(records, FactorLoanAuditVo.class);
				Integer type = loanInfo.getAssetsType();//底层资产类型
				Integer loanStatus = loanInfo.getStatus();//放款申请状态
				super.log.info("根据放款id查询底层资产服务返回成功，信息："+ loanInfo);
				//根据放款申请id查询风控终审id
				int rid = getFinalRiskId(lid);
				
				Map<String,Object> mapInfo = new HashMap<String,Object>();
				mapInfo.put("id", rid);//风控终审id
				mapInfo.put("type", E_V4_ATTACHMENT_TYPE.RISK_CONTROL_MEASURES_MANAGEMENT_RISK_CONTROL.getStatus());
				mapInfo.put("category", E_V4_ATTACHMENT_CATEGORY.RISK_FINAL_AUDIT.getStatus());
				//查询风控措施
				queryAttachmentList(mapInfo);
				//查询底层资产
				getAssetsById(lid, type);
				
				getRequest().setAttribute("status", loanStatus);//放款申请状态
				getRequest().setAttribute("lid", lid);//放款申请id
				getRequest().setAttribute("assetsType", type);//底层资产类型
				if(1 == type) {//跳转至应收账款保理要素页面
					return "ybl4.0/admin/factor/loanAudit/receivableElements";
				}else if(2 == type) {//跳转至应付账款保理要素页面
					return "ybl4.0/admin/factor/loanAudit/payableElements";
				}else if(3 == type) {//跳转至票据保理要素页面
					return "ybl4.0/admin/factor/loanAudit/billElements";
				}
			}else{
				super.log.error("根据放款id查询底层资产服务返回服务返回失败，信息："+err);
			}
		}
		super.log.error("参数非法!");
		return "500";
	}
	
	/**
	 * 条件查询附件列表
	 */
	public void queryAttachmentList(Map<String, Object> mapInfo) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter",mapInfo);
		map.put("sign", "queryRiskAttachmentInfo");//所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("FactorLoanAudit", map);
		List<FactorAttachmentVo> Attachmentlist = null;
		if (null != result.getSys()) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();//错误信息
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				if(null != records) {
					Attachmentlist = JsonUtils.toList(records,FactorAttachmentVo.class);
				}
				getRequest().setAttribute("Attachmentlist", Attachmentlist);
				super.log.info("查询风控措施附件服务返回成功，信息："+Attachmentlist);
			}else{
				super.log.error("查询风控措施附件服务返回失败，信息："+erortx);
			}
		}
	}
	
	/**
	 * 根据放款申请id查询底层资产信息
	 * @param id 放款申请id
	 * @param assetsType 底层资产类型
	 */
	public void getAssetsById(int id, Integer assetsType) {
		Map<String,Object> map = new HashMap<String,Object>();
		if(1 == assetsType) {//应收账款
			Map<String,Object> mapInfo = new HashMap<String,Object>();
			mapInfo.put("id", id);//放款申请id
			
			map.put("paramter",mapInfo);
			map.put("sign", "queryReceivableById");//所调用的服务中的方法
			ResBody result = TradeInvokeUtils.invoke("FactoringElements", map);
			List<AccountsReceivableV4VO> assetslist = null;
			if (null != result.getSys()) {
				String status = result.getSys().getStatus();
				String erortx = result.getSys().getErortx();//错误信息
				if ("S".equals(status)) {
					JSONObject output = (JSONObject) result.getOutput();
					String records = output.getString("result");
					BigDecimal totalAmount = new BigDecimal(0);
					if(null != records) {
						assetslist = JsonUtils.toList(records,AccountsReceivableV4VO.class);
						//转让应收账款金额
						for (AccountsReceivableV4VO rvo : assetslist) {
							if(null != rvo.getAmountsReceivableMoney()) {
								totalAmount = totalAmount.add(rvo.getAmountsReceivableMoney());
							}
						}
					}
					Integer rightBusinessId = 0;
					if(null != assetslist && assetslist.size() > 0) {
						rightBusinessId = assetslist.get(0).getBusinessId();//获取底层资产对应的核心企业businessId
					}
					getRequest().setAttribute("rightBusinessId", rightBusinessId);
					getRequest().setAttribute("totalAmount", totalAmount);
					getRequest().setAttribute("assetslist", assetslist);
					super.log.info("根据放款申请id查询应收账款服务返回成功，信息："+assetslist);
				}else{
					super.log.error("根据放款申请id查询应收账款服务返回失败，信息："+erortx);
				}
			}
		}else if(2 == assetsType) {//应付账款
			Map<String,Object> mapInfo = new HashMap<String,Object>();
			mapInfo.put("id", id);//放款申请id
			
			map.put("paramter",mapInfo);
			map.put("sign", "queryPayableById");//所调用的服务中的方法
			ResBody result = TradeInvokeUtils.invoke("FactoringElements", map);
			List<AccountsPayableVO> assetslist = null;
			if (null != result.getSys()) {
				String status = result.getSys().getStatus();
				String erortx = result.getSys().getErortx();//错误信息
				if ("S".equals(status)) {
					JSONObject output = (JSONObject) result.getOutput();
					String records = output.getString("result");
					BigDecimal totalAmount = new BigDecimal(0);
					if(null != records) {
						assetslist = JsonUtils.toList(records,AccountsPayableVO.class);
						//转让应付账款金额
						for (AccountsPayableVO rvo : assetslist) {
							if(null != rvo.getAmountsPayableMoney()) {
								totalAmount =  totalAmount.add(rvo.getAmountsPayableMoney());
							}
						}
					}
					Integer rightBusinessId = 0;
					if(null != assetslist && assetslist.size() > 0) {
						rightBusinessId = assetslist.get(0).getBusinessId();//获取底层资产对应的核心企业不businessId
					}
					getRequest().setAttribute("rightBusinessId", rightBusinessId);
					getRequest().setAttribute("totalAmount", totalAmount);
					getRequest().setAttribute("assetslist", assetslist);
					super.log.info("根据放款申请id查询应付账款服务返回成功，信息："+assetslist);
				}else{
					super.log.error("根据放款申请id查询应付账款服务返回失败，信息："+erortx);
				}
			}
		}else if(3 == assetsType) {//票据
			Map<String,Object> mapInfo = new HashMap<String,Object>();
			mapInfo.put("id", id);//放款申请id
			
			map.put("paramter",mapInfo);
			map.put("sign", "queryBillById");//所调用的服务中的方法
			ResBody result = TradeInvokeUtils.invoke("FactoringElements", map);
			List<BillVO> assetslist = null;
			if (null != result.getSys()) {
				String status = result.getSys().getStatus();
				String erortx = result.getSys().getErortx();//错误信息
				if ("S".equals(status)) {
					JSONObject output = (JSONObject) result.getOutput();
					String records = output.getString("result");
					BigDecimal totalAmount = new BigDecimal(0);
					if(null != records) {
						assetslist = JsonUtils.toList(records,BillVO.class);
						//票面金额
						for (BillVO bvo : assetslist) {
							if(null != bvo.getBillAmount()) {
								totalAmount =  totalAmount.add(bvo.getBillAmount());
							}
						}
					}
					Integer rightBusinessId = 0;
					if(null != assetslist && assetslist.size() > 0) {
						rightBusinessId = assetslist.get(0).getBusinessId();//获取底层资产对应的核心企业不businessId
					}
					getRequest().setAttribute("rightBusinessId", rightBusinessId);
					getRequest().setAttribute("totalAmount", totalAmount);
					getRequest().setAttribute("assetslist", assetslist);
					super.log.info("根据放款申请id查询票据服务返回成功，信息："+assetslist);
				}else{
					super.log.error("根据放款申请id查询票据服务返回失败，信息："+erortx);
				}
			}
		}
	}
	
	/**
	 * 应收账款保理要素页面审核不通过
	 * @param assets
	 * @return
	 */
	@ValidateSession(validate = true)
	@RequestMapping(value = "/loanAudit/callBack")
	@ResponseBody
	public ControllerResponse callBack(String assets, int lid, Integer assetsType) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		UserVo user = ControllerUtils.getCurrentUser();
		//登录验证
		if (null == user) {
			super.log.error("请先登录");
			response.setInfo("请先登录！");//操作失败！
			return response;
		}
		Map<String,Object> map = new HashMap<String,Object>();
		Map<String,Object> mapinfo = new HashMap<String,Object>();
		mapinfo.put("lastUpdateTime", DateUtils.now());
		mapinfo.put("lastUpdateBy", user.getId());
		mapinfo.put("assets", assets);//底层资产编号
		mapinfo.put("assetsType", assetsType);//底层资产类型
		mapinfo.put("lid", lid);//放款申请id
		
		map.put("paramter",mapinfo);
		map.put("sign", "factorLoanCallback");//所调用的服务中的方法	
		//放款审核
		ResBody result = TradeInvokeUtils.invoke("FactorLoanAudit", map);
		if (null != result.getSys()) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();//错误信息
			if ("S".equals(status)) {
				response.setResponseType(ResponseType.SUCCESS);
				response.setInfo("审核成功！");
				super.log.info("调用factorLoanCallback服务返回成功");
				return response;
			}else{
				response.setInfo("审核失败！");
				super.log.error("调用factorLoanCallback服务返回失败" + erortx);
				return response;
			}
		}
		return response;
	}
	
	/**
	 * 应收账款保理要素页面审核提交
	 * @param lid 放款申请id
	 * @param rightBusinessId 融资方id
	 * @param vo 保理要素对象
	 * @param receivableListVo 底层资产list对象
	 * @return
	 */
	@ValidateSession(validate = true)
	@RequestMapping("/loanAudit/receivableElementsAudit")
	@ResponseBody
	public ControllerResponse audit(int lid, Integer rightBusinessId, AccountsReceivableElementsVo vo, FormReceivableListVo receivableListVo) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		UserVo user = ControllerUtils.getCurrentUser();
		//登录验证
		if (null == user) {
			super.log.error("请先登录");
			response.setInfo("请先登录！");//操作失败！
			return response;
		}
		//防止表单重复提交
		Map<String, Object> testMap = new HashMap<String, Object>();
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("id", lid);//放款申请id
		paramMap.put("businessId", user.getBusinessId());
		
		testMap.put("paramter", paramMap);
		testMap.put("sign", "selectAssetsTypeById");// 所调用的服务中的方法
		ResBody re = TradeInvokeUtils.invoke("FactorIndexManagement", testMap);
		if (null != re.getSys()) {
			String sta = re.getSys().getStatus();
			String err = re.getSys().getErortx();//错误信息
			if ("S".equals(sta)) {
				JSONObject output = (JSONObject) re.getOutput();
				String records = output.getString("result");
				FactorLoanAuditVo loanInfo = JsonUtils.toObject(records, FactorLoanAuditVo.class);
				Integer loanStatus = loanInfo.getStatus();
				super.log.info("根据放款id查询底层资产服务返回成功，信息："+ loanInfo);
				if(loanStatus > 2) {
					super.log.error("该订单已审核提交！");
					response.setInfo("该订单已审核提交！");//操作失败！
					return response;
				}else if(loanStatus < 2) {
					super.log.error("该订单还未到此操作！");
					response.setInfo("该订单还未到此操作！");//操作失败！
					return response;
				}
			}else{
				super.log.error("根据放款id查询底层资产服务返回服务返回失败，信息："+err);
			}
		}
		
		Map<String,Object> map = new HashMap<String,Object>();
		if(null == receivableListVo || null == receivableListVo.getAssetslist() || receivableListVo.getAssetslist().size() < 1) {
			super.log.error("无底层资产，审核失败！");
			response.setInfo("无底层资产，审核失败！");//操作失败！
			return response;
		}
		List<AccountsReceivableV4VO> assetslist = receivableListVo.getAssetslist();
		for (AccountsReceivableV4VO accountsReceivableV4VO : assetslist) {
			if(accountsReceivableV4VO.getExpectedPaymentDateActual().before(accountsReceivableV4VO.getTransferDate())) {
				super.log.error("转让日期必须小于到期日期！");
				response.setInfo("转让日期必须小于到期日期！");//操作失败！
				return response;
			}
			Long days = DateUtils.dayDiff(accountsReceivableV4VO.getExpectedPaymentDateActual(), accountsReceivableV4VO.getTransferDate());
			accountsReceivableV4VO.setFinancingTerm(new Integer(days.intValue()));
		}
		//填入放款申请id
		vo.setLoanApplyId(lid);
		ControllerUtils.setWho(vo);//设置时间、操作人
		
		Map<String,Object> mapinfo = new HashMap<String,Object>();
		mapinfo.put("userId", user.getBusinessId());
		mapinfo.put("lid", lid);
		mapinfo.put("rightBusinessId", rightBusinessId);
		mapinfo.put("type", 1);//类型为应收账款
		mapinfo.put("status", E_V4_STATUS.WAIT_AUTHORIZE.getStatus());//更改放款状态为待确权
		mapinfo.put("lastUpdateTime", DateUtils.now());
		mapinfo.put("lastUpdateBy", user.getId());
		mapinfo.put("AssetsList", assetslist);
		mapinfo.put("vo", vo);
		
		map.put("paramter",mapinfo);
		map.put("sign", "factorLoanAudit");//所调用的服务中的方法	
		//放款审核
		ResBody result = TradeInvokeUtils.invoke("FactorLoanAudit", map);
		if (null != result.getSys()) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();//错误信息
			if ("S".equals(status)) {
				super.log.info("调用factorLoanAudit服务返回成功");
				response.setResponseType(ResponseType.SUCCESS);
				response.setInfo("审核成功！");
				return response;
			}else{
				super.log.error("调用factorLoanAudit服务返回失败" + erortx);
				response.setInfo("审核失败！");
				return response;
			}
		}
		return response;
	}
	
	/**
	 * 应收付款保理要素页面审核提交
	 * @param lid 放款申请id
	 * @param rightBusinessId 融资方id
	 * @param vo 保理要素对象
	 * @param receivableListVo 底层资产list对象
	 * @return
	 */
	@ValidateSession(validate = true)
	@RequestMapping("/loanAudit/payableElementsAudit")
	@ResponseBody
	public ControllerResponse audit(int lid, Integer rightBusinessId, AccountsPayableElementsVo vo, FormPayableListVo formPayableListVo) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		UserVo user = ControllerUtils.getCurrentUser();
		//登录验证
		if (null == user) {
			super.log.error("请先登录");
			response.setInfo("请先登录！");//操作失败！
			return response;
		}
		//防止表单重复提交
		Map<String, Object> testMap = new HashMap<String, Object>();
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("id", lid);//放款申请id
		paramMap.put("businessId", user.getBusinessId());
		
		testMap.put("paramter", paramMap);
		testMap.put("sign", "selectAssetsTypeById");// 所调用的服务中的方法
		ResBody re = TradeInvokeUtils.invoke("FactorIndexManagement", testMap);
		if (null != re.getSys()) {
			String sta = re.getSys().getStatus();
			String err = re.getSys().getErortx();//错误信息
			if ("S".equals(sta)) {
				JSONObject output = (JSONObject) re.getOutput();
				String records = output.getString("result");
				FactorLoanAuditVo loanInfo = JsonUtils.toObject(records, FactorLoanAuditVo.class);
				Integer loanStatus = loanInfo.getStatus();
				super.log.info("根据放款id查询底层资产服务返回成功，信息："+ loanInfo);
				if(loanStatus > 2) {
					super.log.error("该订单已审核提交！");
					response.setInfo("该订单已审核提交！");//操作失败！
					return response;
				}else if(loanStatus < 2) {
					super.log.error("该订单还未到此操作！");
					response.setInfo("该订单还未到此操作！");//操作失败！
					return response;
				}
			}else{
				super.log.error("根据放款id查询底层资产服务返回服务返回失败，信息："+err);
			}
		}
		
		Map<String,Object> map = new HashMap<String,Object>();
		if(null == formPayableListVo || null == formPayableListVo.getAssetslist() || formPayableListVo.getAssetslist().size() < 1) {
			super.log.error("无底层资产，审核失败！");
			response.setInfo("无底层资产，审核失败！");//操作失败！
			return response;
		}
		List<AccountsPayableVO> assetslist = formPayableListVo.getAssetslist();
		for (AccountsPayableVO accountsPayableVO : assetslist) {
			if(accountsPayableVO.getExpectedPaymentDateActual().before(accountsPayableVO.getTransferDate())) {
				super.log.error("转让日期必须小于到期日期！");
				response.setInfo("转让日期必须小于到期日期！");//操作失败！
				return response;
			}
			Long days = DateUtils.dayDiff(accountsPayableVO.getExpectedPaymentDateActual(), accountsPayableVO.getTransferDate());
			accountsPayableVO.setFinancingTerm(new Integer(days.intValue()));
		}
		
		//填入放款申请id
		vo.setLoanApplyId(lid);
		ControllerUtils.setWho(vo);//设置时间、操作人
		
		Map<String,Object> mapinfo = new HashMap<String,Object>();
		mapinfo.put("userId", user.getBusinessId());
		mapinfo.put("lid", lid);
		mapinfo.put("rightBusinessId", rightBusinessId);
		mapinfo.put("type", 2);//类型为应付账款
		mapinfo.put("status", E_V4_STATUS.WAIT_AUTHORIZE.getStatus());//更改放款状态为待确权
		mapinfo.put("lastUpdateTime", DateUtils.now());
		mapinfo.put("lastUpdateBy", user.getId());
		mapinfo.put("AssetsList", assetslist);
		mapinfo.put("vo", vo);
		
		map.put("paramter",mapinfo);
		map.put("sign", "factorLoanAudit");//所调用的服务中的方法	
		//放款审核
		ResBody result = TradeInvokeUtils.invoke("FactorLoanAudit", map);
		if (null != result.getSys()) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();//错误信息
			if ("S".equals(status)) {
				super.log.info("调用factorLoanAudit服务返回成功");
				response.setResponseType(ResponseType.SUCCESS);
				response.setInfo("审核成功！");
				return response;
			}else{
				super.log.error("调用factorLoanAudit服务返回失败" + erortx);
				response.setInfo("审核失败！");
				return response;
			}
		}
		return response;
	}
	
	/**
	 * 票据保理要素页面审核提交
	 * @param lid 放款申请id
	 * @param rightBusinessId 融资方id
	 * @param vo 保理要素对象
	 * @param receivableListVo 底层资产list对象
	 * @return
	 */
	@ValidateSession(validate = true)
	@RequestMapping("/loanAudit/billElementsAudit")
	@ResponseBody
	public ControllerResponse audit(int lid, Integer rightBusinessId, BillElementsVo vo, FormBillListVo formBillListVo) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		UserVo user = ControllerUtils.getCurrentUser();
		//登录验证
		if (null == user) {
			super.log.error("请先登录");
			response.setInfo("请先登录！");//操作失败！
			return response;
		}
		//防止表单重复提交
		Map<String, Object> testMap = new HashMap<String, Object>();
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("id", lid);//放款申请id
		paramMap.put("businessId", user.getBusinessId());
		
		testMap.put("paramter", paramMap);
		testMap.put("sign", "selectAssetsTypeById");// 所调用的服务中的方法
		ResBody re = TradeInvokeUtils.invoke("FactorIndexManagement", testMap);
		if (null != re.getSys()) {
			String sta = re.getSys().getStatus();
			String err = re.getSys().getErortx();//错误信息
			if ("S".equals(sta)) {
				JSONObject output = (JSONObject) re.getOutput();
				String records = output.getString("result");
				FactorLoanAuditVo loanInfo = JsonUtils.toObject(records, FactorLoanAuditVo.class);
				Integer loanStatus = loanInfo.getStatus();
				super.log.info("根据放款id查询底层资产服务返回成功，信息："+ loanInfo);
				if(loanStatus > 2) {
					super.log.error("该订单已审核提交！");
					response.setInfo("该订单已审核提交！");//操作失败！
					return response;
				}else if(loanStatus < 2) {
					super.log.error("该订单还未到此操作！");
					response.setInfo("该订单还未到此操作！");//操作失败！
					return response;
				}
			}else{
				super.log.error("根据放款id查询底层资产服务返回服务返回失败，信息："+err);
			}
		}	
		
		Map<String,Object> map = new HashMap<String,Object>();
		if(null == formBillListVo || null == formBillListVo.getAssetslist() || formBillListVo.getAssetslist().size() < 1) {
			super.log.error("无底层资产，审核失败！");
			response.setInfo("无底层资产，审核失败！");//操作失败！
			return response;
		}
		List<BillVO> assetslist = formBillListVo.getAssetslist();
		for (BillVO billVO : assetslist) {
			if(billVO.getExpireDateActual().before(billVO.getTransferDate())) {
				super.log.error("转让日期必须小于到期日期！");
				response.setInfo("转让日期必须小于到期日期！");//操作失败！
				return response;
			}
			Long days = DateUtils.dayDiff(billVO.getExpireDateActual(), billVO.getTransferDate());
			billVO.setFinancingTerm(new Integer(days.intValue()));
		}
		
		//填入放款申请id
		vo.setLoanApplyId(lid);
		ControllerUtils.setWho(vo);//设置时间、操作人
		
		Map<String,Object> mapinfo = new HashMap<String,Object>();
		mapinfo.put("userId", user.getBusinessId());
		mapinfo.put("lid", lid);
		mapinfo.put("rightBusinessId", rightBusinessId);
		mapinfo.put("type", 3);//类型为票据
		mapinfo.put("status", E_V4_STATUS.WAIT_AUTHORIZE.getStatus());//更改放款状态为待确权
		mapinfo.put("lastUpdateTime", DateUtils.now());
		mapinfo.put("lastUpdateBy", user.getId());
		mapinfo.put("AssetsList", assetslist);
		mapinfo.put("vo", vo);
		
		map.put("paramter",mapinfo);
		map.put("sign", "factorLoanAudit");//所调用的服务中的方法	
		//放款审核
		ResBody result = TradeInvokeUtils.invoke("FactorLoanAudit", map);
		if (null != result.getSys()) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();//错误信息
			if ("S".equals(status)) {
				super.log.info("调用factorLoanAudit服务返回成功");
				response.setResponseType(ResponseType.SUCCESS);
				response.setInfo("审核成功！");
				return response;
			}else{
				super.log.error("调用factorLoanAudit服务返回失败" + erortx);
				response.setInfo("审核失败！");
				return response;
			}
		}
		return response;
	}
	
	
	/**
	 * 资金方分页查询待确权放款申请记录
	 * @param factorLoanAuditVo 待确权对象
	 * @param pageVo 分页参数
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/loanAudit/waitAuthorizeList.htm")
	public String waitAuthorizeList(FactorLoanAuditVo factorLoanAuditVo,PageVo pageVo) {
		//只查询待确权的放款申请记录
		UserVo user = ControllerUtils.getCurrentUser();
		//登录验证
		if (null == user) {
			super.log.error("请先登录");
			return "ybl4.0/admin/doorl/login";
		}
		factorLoanAuditVo.setRightBusinessId(user.getBusinessId());
		factorLoanAuditVo.setBusinessId(user.getBusinessId());
		factorLoanAuditVo.setStatus(E_V4_STATUS.WAIT_AUTHORIZE.getStatus());//待确权
		queryLoanAuditByCondition(factorLoanAuditVo, pageVo);
		
		return "ybl4.0/admin/factor/loanAudit/waitAuthorizeList";
	}
	
	/**
	 * 跳转至资产确权页面
	 * @param id 放款申请id
	 * @return
	 */
	@RequestMapping(value = "/loanAudit/{id}/toAssetAuthorize.htm")
	public String toAssetAuthorize(@PathVariable("id")Integer id) {
		UserVo user = ControllerUtils.getCurrentUser();
		//登录验证
		if (null == user) {
			super.log.error("请先登录");
			return "ybl4.0/admin/doorl/login";
		}
		//数据校验 根据放款申请id查询底层资产和放款申请状态
		Map<String, Object> testMap = new HashMap<String, Object>();
		Map<String, Object> mapinfo = new HashMap<String, Object>();
		mapinfo.put("id", id);//放款申请id
		mapinfo.put("businessId", user.getBusinessId());
		
		testMap.put("paramter", mapinfo);
		testMap.put("sign", "selectAssetsTypeById");// 所调用的服务中的方法
		ResBody re = TradeInvokeUtils.invoke("FactorIndexManagement", testMap);
		if (null != re.getSys()) {
			String sta = re.getSys().getStatus();
			String erortx = re.getSys().getErortx();//错误信息
			if ("S".equals(sta)) {
				JSONObject output = (JSONObject) re.getOutput();
				String records = output.getString("result");
				FactorLoanAuditVo loanInfo = JsonUtils.toObject(records, FactorLoanAuditVo.class);
				Integer type = loanInfo.getAssetsType();
				Integer loanStatus = loanInfo.getStatus();
				
				getRequest().setAttribute("lid", id);//放款申请id
				getRequest().setAttribute("assetsType", type);//底层资产类型
				getRequest().setAttribute("status", loanStatus);//放款申请状态
				super.log.info("根据放款id查询底层资产服务返回成功，信息："+ loanInfo);
			}else{
				super.log.error("根据放款id查询底层资产服务返回服务返回失败，信息："+erortx);
			}
		}
		// 查询附件
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sign", "queryprotocoltemplate");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("EnterpriseAssetOwnership", map);
		if (null != result) {
			if (null != result.getSys()) {
				String status = result.getSys().getStatus();
				String erortx = result.getSys().getErortx();// 错误信息
				if ("S".equals(status)) {
					JSONObject output = (JSONObject) result.getOutput();
					String contractTemplate = output.getString("result");
					if (null != contractTemplate) {
						List<ContractTemplateVO> list = JsonUtils.toList(contractTemplate, ContractTemplateVO.class);
						getRequest().setAttribute("list", list);
						super.log.info("根据条件查询模板服务返回成功，信息：" + list);
					}
				} else {
					super.log.error("根据条件查询查询模板服务返回失败，信息：" + erortx);
				}
			}
		}
		return "ybl4.0/admin/factor/loanAudit/factorAssetTransfer";
	}
	
	/**
	 * 分页查询放款申请记录
	 * @param factorLoanAuditVo
	 * @param pageVo
	 */
	@SuppressWarnings("rawtypes")
	public void queryLoanAuditByCondition(FactorLoanAuditVo factorLoanAuditVo, PageVo pageVo) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter",JsonUtils.fromObject(factorLoanAuditVo));
		map.put("sign", "queryListByCondition");//所调用的服务中的方法	
		map.put("page", pageVo);
		ResBody result = TradeInvokeUtils.invoke("FactorLoanAudit", map);
		PageVo page = null;
		List<FactorLoanAuditVo> list = null;
		if (null != result.getSys()) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();//错误信息
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage = output.getString("page");
				String records = output.getString("result");
				page = (PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
				list = JsonUtils.toList(records,FactorLoanAuditVo.class);
				
				getRequest().setAttribute("list", list);
				super.log.info("根据条件查询放款审核记录服务返回成功，信息："+list);
			}else{
				super.log.error("根据条件查询查询放款审核记录服务返回失败，信息："+erortx);
			}
		}
		getRequest().setAttribute("page", page);
		getRequest().setAttribute("factorLoanAuditVo", factorLoanAuditVo);
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
