package com.bpm.framework.controller.v4.factor;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v4.factor.FactorFinancingQueryVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.utils.json.JsonUtils;

/**
 * 资金方融资申请综合查询
 */
@Controller
@RequestMapping({ "/factorFinancingQueryController" })
public class FactorFinancingQueryController extends AbstractController {

	private static final long serialVersionUID = -6822807362750361909L;

	/**
	 * 资金方融资申请综合查询列表
	 * @param vo 融资申请综合查询对象
	 * @param pageVo 分页参数
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/financingQuery/list.htm")
	public String list(FactorFinancingQueryVo vo,PageVo pageVo) {
		UserVo user = ControllerUtils.getCurrentUser();
		//登录验证
		if (null == user) {
			super.log.error("请先登录");
			return "ybl4.0/admin/doorl/login";
		}
		vo.setBusinessId(user.getBusinessId());//只查询自己的融资申请记录
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("param",vo);
		map.put("sign", "queryFinancingInfo");//所调用的服务中的方法	
		map.put("page", pageVo);
		ResBody result = TradeInvokeUtils.invoke("FactorIntegratedQuery", map);
		PageVo page=null;
		List<FactorFinancingQueryVo> list = null;
		if (null != result.getSys()) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();//错误信息
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage = output.getString("page");
				String records = output.getString("result");
				page = (PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
				if(null != records) {
					list = JsonUtils.toList(records,FactorFinancingQueryVo.class);
				}
				super.log.info("根据条件查询融资申请综合查询服务返回成功，信息："+list);
			}else{
				super.log.error("根据条件查询融资申请综合查询服务返回失败，信息："+erortx);
				return null;
			}
		}
		getRequest().setAttribute("list", list);//融资申请记录List
		getRequest().setAttribute("page", page);
		getRequest().setAttribute("vo", vo);//融资申请综合查询对象
		return "ybl4.0/admin/factor/integratedQuery/financingQueryList";
	}
}
