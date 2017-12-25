package com.bpm.framework.controller.v4.supplier.Integratedquery;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v4.supplier.IntegerQueryVO;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.annotation.ValidateSession;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.controller.v4.common.FinancingApplyCommonApi;
import com.bpm.framework.utils.json.JsonUtils;

/**
 * 云保理4.0融资综合查询
 */
@Controller
@RequestMapping({ "/IntegratedQueryController" })
public class IntegratedQueryController extends AbstractController {

	private static final long serialVersionUID = -2809460978768158852L;
	@Autowired
	private FinancingApplyCommonApi financingapplycommonapi ;

	@ValidateSession(validate = true)
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/list.htm")
	public String list(IntegerQueryVO financinapply ,PageVo pageVo) {
		
		Map<String, Object> maps = new HashMap<String, Object>();
//		获取当前登录用户的企业id作为查询过滤条件
		UserVo userVo = ControllerUtils.getCurrentUser();
		Long  enterpriseid=userVo.getBusinessId();
		
		financinapply.setEnterprise_id(enterpriseid);
		maps.put("integrated", financinapply);
		maps.put("page", pageVo);
		maps.put("sign", "selectIntegratedQuery");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("IntegratedQueryManagement",
				maps);
		PageVo page = null;
		List<IntegerQueryVO> list = null;
		if (result != null && !"".equals(result)) {
			if (result.getSys() != null) {
				String status = result.getSys().getStatus();
				String erortx = result.getSys().getErortx();// 错误信息
				if ("S".equals(status)) {// 交易成功
					/*
					 * JSONObject output = (JSONObject) result.getOutput();
					 * PageVo<?> jsonPage = (PageVo) output.get("page");
					 * getRequest().setAttribute("page", jsonPage);
					 */
					JSONObject output = (JSONObject) result.getOutput();
					String jsonPage = output.getString("page");
					String records = output.getString("result");
					page = (PageVo<?>) JSONObject.parseObject(jsonPage,
							PageVo.class);

					getRequest().setAttribute("page", page);
					getRequest().setAttribute("financinapply", financinapply);
				}
			}
		}

		return "ybl4.0/admin/supplier/financingApplicationIntegratedQuery/list";

	}

	/**
	 * 综合查询子融资查询
	 */
	@ValidateSession(validate = true)
	@RequestMapping(value = "/getlist")
	@ResponseBody
	public ControllerResponse getChildrenList(Long id) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		Map<String, Object> map = new HashMap<String, Object>();
		/*
		 * Map<String, Object> integrated = new HashMap<String, Object>();
		 * integrated.put("id_", id);
		 */
		map.put("id_", id);
		map.put("sign", "selcetIntegratedChildren");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("IntegratedQueryManagement",
				map);
		List<IntegerQueryVO> list = new ArrayList<IntegerQueryVO>();
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String ls = output.getString("list");
				list = JsonUtils.toList(ls, IntegerQueryVO.class);
			}
		}
		response.setObject(list);
		response.setResponseType(ResponseType.SUCCESS);
		return response;

	}

	/**
	 * 修改子融资订单为不可用
	 * 
	 */

	@RequestMapping(value = "/updateStatue")
	@ResponseBody
	public ControllerResponse updateStatue(Long id) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id_", id);
		map.put("sign", "updateStatue");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("IntegratedQueryManagement",
				map);
		if (result != null) {
			if (result.getSys() != null) {
				String status = result.getSys().getStatus();// 状态：'S'成功，'F'失败
				String erortx = result.getSys().getErortx();// 错误信息
				if ("S".equals(status)) {// 交易成功
					response.setResponseType(ResponseType.SUCCESS);
					response.setObject(result.getOutput());// 设置返回结果
					response.setInfo("修改成功");// 操作成功
					super.log.info("修改子融资状态：" + erortx);
				} else {
					response.setResponseType(ResponseType.ERROR);
					super.log.error("修改子融资状态：" + erortx);
				}
			}
		} else {
			response.setResponseType(ResponseType.ERROR);
		}
		return response;
	}


	/**融资方根据融资申请ID查询出竞标信息及详情页签信息
	 * 
	 * @param id 融资定单id
	 * @param childrenId融资子定单id
	 * @param statue 融资状态
	 * @param url  页面返回按钮得url路径
	 * @return
	 */
	@ValidateSession(validate = true)
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/view.htm")
	public String details(@Param("id") Long id,
			@Param("childrenId") Long childrenId,@Param("statue") int statue) {

		getRequest().setAttribute("id", id);
		getRequest().setAttribute("childrenId", childrenId);
		getRequest().setAttribute("statue", statue);
		getRequest().setAttribute("url","/IntegratedQueryController/list.htm");
		return "ybl4.0/admin/supplier/financingApplicationIntegratedQuery/view";
	}

	/**
	 * 签署主合同 默认先查询第一个tab页
	 */

	@ValidateSession(validate = true)
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/projectDetails.htm")
	public String projectDetails(Long id,Long childrenId) {
		// 根据ID查询竞标信息
		financingapplycommonapi.projectDetails(id, childrenId);	
		return "ybl4.0/admin/supplier/financingApplicationIntegratedQuery/tab/projectDetails";
	}

	/**
	 * 平台初审 默认先查询第2个tab页
	 */

	@ValidateSession(validate = true)
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/preliminarytrialPlatform")
	public String preliminarytrialPlatform(Long id, int audittype) {
		financingapplycommonapi.preliminarytrialPlatform(id, audittype);
		return "ybl4.0/admin/supplier/financingApplicationIntegratedQuery/tab/preliminarytrialPlatform";
	}

	/**
	 * 资方初审 默认先查询第3个tab页
	 */

	@ValidateSession(validate = true)
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/capitalTrial")
	public String capitalTrial(Long id, Long childrenId) {
		financingapplycommonapi.capitalTrial(id, childrenId);
		return "ybl4.0/admin/supplier/financingApplicationIntegratedQuery/tab/capitalTrial";
	}

	/**
	 * 
	 * 根据resource_id查询附件信息
	 */

	/**
	 * 选择意向资方 默认先查询第4个tab页
	 */

	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/chooseIntentionalCapital.htm")
	public String chooseIntentionalCapital(Integer id,Long childrenId) {
		financingapplycommonapi.chooseIntentionalCapital(id, childrenId);	
		return "ybl4.0/admin/supplier/financingApplicationIntegratedQuery/tab/chooseIntentionalCapital";
	}

	/**
	 * 资方终审 默认先查询第5个tab页
	 */
	@ValidateSession(validate = true)
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/capitalTrialLast")
	public String capitalTrialLast(Long id, Long childrenId) {
		financingapplycommonapi.capitalTrialLast(id, childrenId);
		return "ybl4.0/admin/supplier/financingApplicationIntegratedQuery/tab/capitalTrialLast";
	}

	/**
	 * 合作资方 默认先查询第6个tab页
	 */

	@ValidateSession(validate = true)
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/cooperativeCapital")
	public String cooperativeCapital(Long id,Long childrenId) {
		financingapplycommonapi.cooperativeCapital(id, childrenId);
		return "ybl4.0/admin/supplier/financingApplicationIntegratedQuery/tab/cooperativeCapital";
	}

	/**
	 * 平台复审 默认先查询第7个tab页
	 */

	@ValidateSession(validate = true)
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/platformreview")
	public String tab7(Long id, Long childrenId) {
		financingapplycommonapi.platformreview(id, childrenId);

		return "ybl4.0/admin/supplier/financingApplicationIntegratedQuery/tab/platformreview";
	}


	
	
	
	
	
	/**
	 * 根据融资定单id或者子定单的id查找其合同签署情况
	 */
	
	@ValidateSession(validate = true)
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/selectcontractdetail.htm")
	public String selectContractDetail(Long id ,Long childrenId) {
		financingapplycommonapi.selectContractDetail(id, childrenId);
		return "ybl4.0/admin/supplier/financingApplicationIntegratedQuery/tab/selectcontractdetail";

	}
	
	

}
