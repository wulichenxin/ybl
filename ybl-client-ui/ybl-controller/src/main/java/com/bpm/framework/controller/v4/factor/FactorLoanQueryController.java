package com.bpm.framework.controller.v4.factor;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v4.factor.FactorLoanQueryVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.utils.json.JsonUtils;

/**
 * 资金方放款申请综合查询
 */
@Controller
@RequestMapping({ "/factorLoanQueryController" })
public class FactorLoanQueryController extends AbstractController {

	private static final long serialVersionUID = -6822807362750361909L;

	/**
	 * 资金方放款申请综合查询列表
	 * @param vo 放款综合查询实体
	 * @param pageVo
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	@RequestMapping(value = "/loanQuery/list.htm")
	public String list(FactorLoanQueryVo vo,PageVo pageVo) {
		UserVo user = ControllerUtils.getCurrentUser();
		//登录验证
		if (null == user) {
			super.log.error("请先登录");
			return "ybl4.0/admin/doorl/login";
		}
		vo.setBusinessId(user.getBusinessId());//只查询自己的的放款申请记录
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("param",vo);
		map.put("sign", "queryLoanInfo");//所调用的服务中的方法	
		map.put("page", pageVo);
		ResBody resultInfo = TradeInvokeUtils.invoke("FactorIntegratedQuery", map);
		PageVo page=null;
		List<FactorLoanQueryVo> listInfo = null;
		if (resultInfo.getSys() != null) {
			String status = resultInfo.getSys().getStatus();
			String erortx = resultInfo.getSys().getErortx();//错误信息
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) resultInfo.getOutput();
				String jsonPage = output.getString("page");
				String records = output.getString("result");
				page = (PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
				if(null != records) {
					listInfo = JsonUtils.toList(records,FactorLoanQueryVo.class);
				}
				super.log.info("根据条件查询放款申请综合查询服务返回成功，信息："+listInfo);
			}else{
				super.log.error("根据条件查询放款申请综合查询服务返回失败，信息："+erortx);
				return null;
			}
		}
		getRequest().setAttribute("list", listInfo);//放款申请记录List
		getRequest().setAttribute("page", page);
		getRequest().setAttribute("vo", vo);//放款综合查询实体
		return "ybl4.0/admin/factor/integratedQuery/loanQueryList";
	}
}
