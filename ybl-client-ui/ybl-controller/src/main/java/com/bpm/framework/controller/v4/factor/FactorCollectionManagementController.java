package com.bpm.framework.controller.v4.factor;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.sunline.framework.controller.vo.AttachmentVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v2.FormAttachmentListVo;
import cn.sunline.framework.controller.vo.v4.factor.FactorCollectionManagementOverdueVo;
import cn.sunline.framework.controller.vo.v4.factor.FactorCollectionManagementRepaymentPlanVo;
import cn.sunline.framework.controller.vo.v4.factor.FactorCollectionManagementUnconfirmedVo;
import cn.sunline.framework.controller.vo.v4.factor.enums.E_V4_REPAYMENT_STATUS;
import cn.sunline.framework.util.Arith;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.Sys;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.utils.CollectionUtils;
import com.bpm.framework.utils.date.DateUtils;
import com.bpm.framework.utils.i18n.I18NUtils;
import com.bpm.framework.utils.json.JsonUtils;

/**
 * 云保理4.0资金方收款管理
 */
@SuppressWarnings({ "rawtypes", "unchecked" })
@Controller
@RequestMapping({ "/factorCollectionManagementController" })
public class FactorCollectionManagementController extends AbstractController {

	private static final long serialVersionUID = -2809460978768158852L;
	
	/**
	 * 待收款列表
	 * @param dto
	 * @param pageVo
	 * @return
	 */
	@RequestMapping(value = "/unconfirmed/list.htm")
	public String unconfirmed(FactorCollectionManagementUnconfirmedVo dto, PageVo pageVo) {
		UserVo user = ControllerUtils.getCurrentUser();
		dto.setPayeeBusinessId(user.getBusinessId().intValue());
		Map<String,Object> map = new HashMap<String,Object>();
		log.info("请求参数：" + JsonUtils.fromObject(dto));
		map.put("paramter",JsonUtils.fromObject(dto));
		map.put("sign", "selectUnConfirmedRepayment");
		map.put("page", pageVo);
		ResBody result = TradeInvokeUtils.invoke("FactorCollectionManagementTran", map);
		PageVo page=null;
		List<FactorCollectionManagementUnconfirmedVo> list=null;
		Sys sys = result.getSys();
		if (null != sys) {
			String retStatus = sys.getStatus();
			String erortx = sys.getErortx();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("result");
				page=(PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
				list=JsonUtils.toList(records,FactorCollectionManagementUnconfirmedVo.class);
				page.setRecords(list);
				getRequest().setAttribute("page", page);
			} else{
				log.error("待收款列表调用selectUnConfirmedRepayment服务返回失败，信息：" + erortx);
				getRequest().setAttribute("msg", erortx);
				return "500";
			}
		}
		getRequest().setAttribute("dto", dto);
		return "ybl4.0/admin/factor/collectionManagement/unconfirmed_list";
	}
	
	/**
	 * 弹出确认收款页面
	 * @param request
	 * @param repaymentId
	 * @return
	 */
	@RequestMapping("/{repaymentId}/{type}/preConfirmeRepayment.htm")
	public String preConfirmeRepayment(HttpServletRequest request,@PathVariable("repaymentId")Integer repaymentId,@PathVariable("type")Integer type) {
		UserVo user = ControllerUtils.getCurrentUser();
		Map<String,Object> map = new HashMap<String,Object>();
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("repaymentId", repaymentId);
		param.put("businessId", user.getBusinessId());
		log.info("请求参数：" + JsonUtils.fromObject(param));
		map.put("paramter",JsonUtils.fromObject(param));
		map.put("sign", "getRepaymentPlanById");
		ResBody result = TradeInvokeUtils.invoke("FactorCollectionManagementTran", map);
		Sys sys = result.getSys();
		if (null != sys) {
			String retStatus = sys.getStatus();
			String erortx = sys.getErortx();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String resultObj = output.getString("result");
				Map<String,Object> resultMap = JSONObject.parseObject(resultObj,Map.class);
				String repaymentPlan = resultMap.get("repaymentPlan").toString();
				FactorCollectionManagementRepaymentPlanVo vo = JSONObject.parseObject(repaymentPlan,FactorCollectionManagementRepaymentPlanVo.class);
				if(vo.getRepaymentStatus().equals(E_V4_REPAYMENT_STATUS.REPAYMENTED.getStatus())) {
					//已还款的逾期天数直接取数据库
					//逾期费用=（逾期金额 * 逾期利率）/360 *逾期天数
					vo.setOverdueFee(Arith.round(Arith.mul(Arith.div(Arith.mul(vo.getRepaymentPrincipal().doubleValue(),Arith.div(vo.getOverdueInterestRate().doubleValue(),100.0).doubleValue()).doubleValue(),360.0).doubleValue(),vo.getOverdueDays()), 2));
				}
				String attachment = resultMap.get("attachment").toString();
				List<AttachmentVo> attachments = JsonUtils.toList(attachment,AttachmentVo.class);
				getRequest().setAttribute("obj", vo);
				getRequest().setAttribute("attachment", attachments.size()>0?attachments.get(0):null);
			} else{
				log.error("弹出确认收款页面调用getRepaymentPlanById服务返回失败，信息：" + erortx);
				getRequest().setAttribute("msg", erortx);
				return "500";
			}
		}
		if(type == 1) {
			getRequest().setAttribute("url", "/factorCollectionManagementController/unconfirmed/list.htm");
		} else if(type == 2) {
			getRequest().setAttribute("url", "/factorCollectionManagementController/overdue/list.htm");
		} else {
			getRequest().setAttribute("msg", "非法访问！");
			return "500";
		}
		return "ybl4.0/admin/factor/collectionManagement/pre_confirme_repayment";
	}
	
	/**
	 * 保存确认收款
	 * @param repaymentId
	 * @param attachmentlist
	 * @return
	 */
	@RequestMapping(value = "/confirmeRepayment")
	@ResponseBody
	public ControllerResponse confirmeRepayment(Long repaymentId,String remark,FormAttachmentListVo attachmentlist) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		try {
			if(null == repaymentId) {
				response.setInfo("参数不能为空");
				return response;
			}
			UserVo user = ControllerUtils.getCurrentUser();
			//附件集合校验
			List<AttachmentVo> tempList = new ArrayList<AttachmentVo>();
			if(attachmentlist != null && null != attachmentlist.getAttachmentList() && attachmentlist.getAttachmentList().size() > 0){
				List<AttachmentVo> amList = attachmentlist.getAttachmentList();
				if(CollectionUtils.isNotEmpty(amList)){
					for(int i =0, j = amList.size() ; i < j ; i++){
						AttachmentVo attachmentVo = amList.get(i);
						if(attachmentVo != null && attachmentVo.getOldName() != null ){//防止页面空数据进入
							attachmentVo.setEnterpriseId(user.getEnterpriseId());
							ControllerUtils.setWho(attachmentVo);//设置时间、操作人
							tempList.add(attachmentVo);
						}
					}
					if(CollectionUtils.isEmpty(tempList)){
						response.setResponseType(ResponseType.ERROR);
						response.setInfo("上传收款确认附件！");
						return response;
					}
				}
			} else {
				response.setResponseType(ResponseType.ERROR);
				response.setInfo("上传收款确认附件！");
				return response;
			}
			Map<String,Object> map = new HashMap<String,Object>();
			Map<String,Object> param = new HashMap<String,Object>();
			param.put("repaymentId", repaymentId);
			param.put("remark", remark);
			param.put("userId", user.getId());
			param.put("enterpriseId", user.getEnterpriseId());
			param.put("businessId", user.getBusinessId());
			param.put("attachmentList", tempList);
			log.info("请求参数：" + JsonUtils.fromObject(param));
			map.put("paramter",JsonUtils.fromObject(param));
			map.put("sign", "confirmedRepayment");
			ResBody result = TradeInvokeUtils.invoke("FactorCollectionManagementTran", map);
			Sys sys = result.getSys();
			if (null != sys) {
				String retStatus = sys.getStatus();
				String erortx = sys.getErortx();
				if ("S".equals(retStatus)) {
					response.setResponseType(ResponseType.SUCCESS_SAVE);					
					response.setObject(result);//设置返回结果	
					response.setInfo(I18NUtils.getText("sys.v2.client.operationSuccess"));//操作成功
				} else{
					response.setResponseType(ResponseType.ERROR);
					response.setInfo(erortx);//操作失败！
				}
			}
		} catch (Exception e) {
			log.error("保存确认收款出现异常，信息：" + e.getMessage(),e);
			response.setResponseType(ResponseType.ERROR);
			response.setInfo(I18NUtils.getText("sys.v2.client.operationFail"));//操作失败！
		}
		return response;
	}
	/**
	 * 转为坏账
	 * @param repaymentId
	 * @return
	 */
	@RequestMapping(value = "/badDebt")
	@ResponseBody
	public ControllerResponse badDebt(Long repaymentId) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		try {
			if(null == repaymentId) {
				response.setInfo("参数不能为空");
				return response;
			}
			UserVo user = ControllerUtils.getCurrentUser();
			Map<String,Object> map = new HashMap<String,Object>();
			Map<String,Object> param = new HashMap<String,Object>();
			param.put("repaymentId", repaymentId);
			param.put("businessId", user.getBusinessId());
			log.info("请求参数：" + JsonUtils.fromObject(param));
			map.put("paramter",JsonUtils.fromObject(param));
			map.put("sign", "confirmedBadDebt");
			ResBody result = TradeInvokeUtils.invoke("FactorCollectionManagementTran", map);
			Sys sys = result.getSys();
			if (null != sys) {
				String retStatus = sys.getStatus();
				String erortx = sys.getErortx();
				if ("S".equals(retStatus)) {
					response.setResponseType(ResponseType.SUCCESS_SAVE);					
					response.setObject(result);//设置返回结果	
					response.setInfo(I18NUtils.getText("sys.v2.client.operationSuccess"));//操作成功
				}else{
					response.setResponseType(ResponseType.ERROR);
					response.setInfo(erortx);
				}
			}
		} catch (Exception e) {
			log.error("转为坏账出现异常，信息：" + e.getMessage(),e);
			response.setResponseType(ResponseType.ERROR);
			response.setInfo(I18NUtils.getText("sys.v2.client.operationFail"));//操作失败！
		}
		return response;
	}
	
	/**
	 * 逾期列表
	 * @param dto
	 * @param pageVo
	 * @return
	 */
	@RequestMapping(value = "/overdue/list.htm")
	public String overdue(FactorCollectionManagementOverdueVo dto, PageVo pageVo) {
		UserVo user = ControllerUtils.getCurrentUser();
		dto.setPayeeBusinessId(user.getBusinessId().intValue());
		Map<String,Object> map = new HashMap<String,Object>();
		dto.setRepaymentStatus(null);//查询未还款（还款日期已超限）和逾期状态
		dto.setNowDate(DateUtils.toString(new Date(),"yyyy-MM-dd"));
		log.info("请求参数：" + JsonUtils.fromObject(dto));
		map.put("paramter",JsonUtils.fromObject(dto));
		map.put("sign", "selectOverdueRepayment");
		map.put("page", pageVo);
		ResBody result = TradeInvokeUtils.invoke("FactorCollectionManagementTran", map);
		PageVo page=null;
		List<FactorCollectionManagementOverdueVo> list=null;
		Sys sys = result.getSys();
		if (null != sys) {
			String retStatus = sys.getStatus();
			String erortx = sys.getErortx();
			if ("S".equals(retStatus)) {
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("result");
				page=(PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
				list=JsonUtils.toList(records,FactorCollectionManagementOverdueVo.class);
				page.setRecords(list);
				Date now = new Date();
				for (int i = 0;i< page.getRecords().size();i++) {
					FactorCollectionManagementOverdueVo vo = (FactorCollectionManagementOverdueVo) page.getRecords().get(i);
					//计算逾期费用    
					//逾期天数=实际还款日期-应还日期
					vo.setOverdueDays(Long.valueOf(DateUtils.dayDiff(vo.getActualRepaymentDate()==null?now:vo.getActualRepaymentDate(),vo.getRepaymentDate())).intValue());
					if(vo.getOverdueDays().intValue() <= 0) {
						vo.setOverdueDays(0);
						vo.setOverdueFee(BigDecimal.ZERO);
					} else {
						//逾期费用=（逾期金额 * 逾期利率）/360 *逾期天数
						vo.setOverdueFee(Arith.round(Arith.mul(Arith.div(Arith.mul(vo.getRepaymentPrincipal().doubleValue(),Arith.div(vo.getOverdueInterestRate().doubleValue(),100.0).doubleValue()).doubleValue(),360.0).doubleValue(),vo.getOverdueDays()), 2));
					}
					//如果需要展示已还款的逾期直接取数据库的值不需要计算！
				}
				getRequest().setAttribute("page", page);
			} else{
				log.error("逾期列表调用selectOverdueRepayment服务返回失败，信息：" + erortx);
				getRequest().setAttribute("msg", erortx);
				return "500";
			}
		}
		getRequest().setAttribute("dto", dto);
		return "ybl4.0/admin/factor/collectionManagement/overdue_list";
	}
	
	/**
	 * 待开发页面
	 * @param request
	 * @return
	 */
	@RequestMapping("/developing.htm")
	public String developing(HttpServletRequest request) {
		return "ybl4.0/admin/factor/collectionManagement/developing";
	}
}
