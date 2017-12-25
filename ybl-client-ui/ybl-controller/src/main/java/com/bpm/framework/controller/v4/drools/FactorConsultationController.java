package com.bpm.framework.controller.v4.drools;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.annotation.ValidateSession;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.controller.login.ProductSuccessCaseVo;
import com.bpm.framework.controller.login.V2ProductVo;
import com.bpm.framework.controller.login.V2VisitorVo;
import com.bpm.framework.controller.validcode.ValidCodeUtil;
import com.bpm.framework.utils.CollectionUtils;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.AttachmentVo;
import cn.sunline.framework.controller.vo.EnterpriseVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.v2.FormAttachmentListVo;
import cn.sunline.framework.controller.vo.v4.drools.V4CardAutoVO;
import cn.sunline.framework.controller.vo.v4.drools.V4EnterpriseVO;
import cn.sunline.framework.controller.vo.v4.drools.V4ProductVO;
import cn.sunline.framework.controller.vo.v4.drools.enums.E_V4_ISHOT;
import cn.sunline.framework.controller.vo.v4.drools.enums.E_V4_PUSH_PRODUCT;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 保理咨询V4
 * @author win7
 *
 */
@Controller
@RequestMapping({ "/factorConsultationController" })
@ValidateSession(validate = false)
public class FactorConsultationController extends AbstractController {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2062048489067294599L;
	
	
	/**
	 * 跳转预约页面
	 * @return
	 */
	@RequestMapping(value = "/toVisitor.htm")
	public String toVisitor(String id){
		getRequest().setAttribute("id", id);
		return "ybl4.0/admin/doorl/blzx-info";
		
	}
	
	/**
	 * 保理咨询首页
	 * @return
	 */
	@RequestMapping(value="/blzxIndex.htm")
	public String blzxIndex(String type){
		V4ProductVO product = new V4ProductVO();
		product.setHot(E_V4_ISHOT.ISHOT.getStatus()); //热门保理
		product.setStatus(E_V4_PUSH_PRODUCT.ISPUSH.getStatus()); //上架产品
		PageVo pageVo = new PageVo<>();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("parameter", product);
		map.put("page", pageVo);
		map.put("sign", "queryProductInfo");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("V4ProductManagement", map);
		String erortx = result.getSys().getErortx();// 错误信息
		List<V4ProductVO> v4productList = null;
		JSONObject output = (JSONObject) result.getOutput();
		if ("S".equals(result.getSys().getStatus())) {// 交易成功
			String resultJson = output.getString("result");
			v4productList = JsonUtils.toList(resultJson, V4ProductVO.class);
			super.log.info("获取热门保理产品queryProductInfo服务返回成功信息：" + erortx);
			for(int i=0; i<(v4productList.size()<6?v4productList.size():6); i++){
				switch (i) {
				case 0:
					ControllerUtils.getRequest().setAttribute("v4productList0", v4productList.get(i)); //附件数组对象
					break;
				case 1:
					ControllerUtils.getRequest().setAttribute("v4productList1", v4productList.get(i)); //附件数组对象
					break;
				case 2:
					ControllerUtils.getRequest().setAttribute("v4productList2", v4productList.get(i)); //附件数组对象
					break;
				case 3:
					ControllerUtils.getRequest().setAttribute("v4productList3", v4productList.get(i)); //附件数组对象
					break;
				case 4:
					ControllerUtils.getRequest().setAttribute("v4productList4", v4productList.get(i)); //附件数组对象
					break;
				case 5:
					ControllerUtils.getRequest().setAttribute("v4productList5", v4productList.get(i)); //附件数组对象
					break;
				}
			}
		}else{
			super.log.info("获取热门保理产品queryProductInfo服务返回失败信息：" + erortx);
			return null;
		}
		return "ybl4.0/admin/doorl/blzx-index";
	}
	
	/**
	 * 查询产品信息
	 * @param pageVo
	 * @param map
	 */
	@RequestMapping(value = "/queryProductList.htm")
	public String queryProductList(V4ProductVO product,PageVo pageVo)
	{
		Map<String, Object> maps = new HashMap<String, Object>();
		String webType = "";
		//产品类型
		if(null != product.getAttribute1())
		{
			//池保理
			if("pool".equals(product.getAttribute1()))
			{
				webType = "pool";
				product.setType(1);
			}else if("just".equals(product.getAttribute1()))//正向保理
			{
				webType = "just";
				product.setType(2);
			}
		}
		//融资金额
		if(null != product.getMinAmount())
		{
			if(product.getMinAmount().compareTo(new BigDecimal(100))==0)
			{
				webType = "100";
			}else if(product.getMinAmount().compareTo(new BigDecimal(500))==0)
			{
				webType = "500";
			}else if(product.getMinAmount().compareTo(new BigDecimal(1000))==0)
			{
				webType = "1000";
			}
		}
		//融资利率
		if(null != product.getRate())
		{
			if(product.getRate().compareTo(new BigDecimal(5))==0)
			{
				webType = "5";
			}else if(product.getRate().compareTo(new BigDecimal(10))==0)
			{
				webType = "10";
			}else if(product.getRate().compareTo(new BigDecimal(20))==0)
			{
				webType = "20";
			}
		}
		product.setStatus(E_V4_PUSH_PRODUCT.ISPUSH.getStatus()); //上架产品
		maps.put("parameter", product);
		maps.put("page", pageVo);
		maps.put("sign", "queryProductByCondition");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("V4ProductManagement", maps);
		PageVo page=null;
		if(result.getSys()!=null){
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();//错误信息	
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("result");
				page=(PageVo) JSONObject.parseObject(jsonPage, PageVo.class);
				List<Map> list= new ArrayList<>();
				list = JsonUtils.toList(records, Map.class);
				getRequest().setAttribute("list", list);
				super.log.error("根据条件查询所有产品调用queryProductByCondition服务返回成功，信息："+list);
			}else{
				super.log.error("根据条件查询所有产品调用queryProductByCondition服务返回失败，信息："+erortx);
				return null;
			}			
		}
 		/*getRequest().setAttribute("name_",name_);
 		getRequest().setAttribute("type_",type_);*/
		//页面样式回显
 		getRequest().setAttribute("queryParam", product);
        getRequest().setAttribute("webType", webType);
		getRequest().setAttribute("page", page);
        return "ybl4.0/admin/doorl/blzx-list";
	}
	
	/**
	 * 查询产品信息
	 * @param pageVo
	 * @param map
	 */
	@RequestMapping(value = "/queryProductById.htm")
	public String queryProductById(V4ProductVO product,PageVo pageVo)
	{
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("parameter", product);
		maps.put("sign", "queryProductById");// 所调用的服务中的方法
		V4ProductVO productVo = new V4ProductVO();
		ResBody resultBody = TradeInvokeUtils.invoke("V4ProductManagement", maps);
		PageVo page=null;
		if(resultBody.getSys()!=null){
			String status = resultBody.getSys().getStatus();
			String erortx = resultBody.getSys().getErortx();//错误信息	
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) resultBody.getOutput();
				JSONObject result = output.getJSONObject("result");
				/*String jsonPage=output.getString("page");
				page=(PageVo) JSONObject.parseObject(jsonPage, PageVo.class);*/
				// 1 融资主体
				if (StringUtils.isNotEmpty(result.getString("product"))) {
					productVo = JsonUtils.toObject(result.getString("product"), V4ProductVO.class);
				}
				super.log.error("根据条件查询所有产品调用queryProductByCondition服务返回成功，信息："+productVo);
			}else{
				super.log.error("根据条件查询所有产品调用queryProductByCondition服务返回失败，信息："+erortx);
				return null;
			}			
		}
		//查询成功案例
		List<ProductSuccessCaseVo> list = queryProductSuccessCase(Integer.parseInt(product.getId().toString()));
 		getRequest().setAttribute("products", productVo);
 		getRequest().setAttribute("list", list);
		getRequest().setAttribute("page", page);
        return "ybl4.0/admin/doorl/blzx-details";
	}
	private List<ProductSuccessCaseVo> queryProductSuccessCase(Integer id)
	{
		List<ProductSuccessCaseVo> list = null;
		ProductSuccessCaseVo product = new ProductSuccessCaseVo();
		product.setProductId(id);
		Map<String, Object> maps = new HashMap<String, Object>();
		maps.put("parameter", product);
		maps.put("sign", "queryAllCase");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("V4ProductManagement", maps);
		if(result.getSys()!=null){
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();//错误信息	
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage=output.getString("page");
				String records = output.getString("result");
				list= new ArrayList<>();
				list = JsonUtils.toList(records, ProductSuccessCaseVo.class);
				super.log.error("根据条件查询所有产品调用queryProductByCondition服务返回成功，信息："+list);
			}else{
				super.log.error("根据条件查询所有产品调用queryProductByCondition服务返回失败，信息："+erortx);
				return null;
			}			
		}
		return list;
	}
	
	/**
	 * 新增预约信息
	 * @return 
	 */
	@RequestMapping(value = "/insertVisitor")
	@ResponseBody
	public ControllerResponse insertVisitor(String productId,String name,String phone, String smsCode,String enterpriseName)
	{
		// 调用服务，进行数据查询
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		if(!"S".equals(ValidCodeUtil.checkedValidCode(phone, smsCode))) {
			response.setInfo("验证码错误");
			return response;
		}
		V2VisitorVo parameters = new V2VisitorVo();
		parameters.setproductId(Long.parseLong(productId));
		parameters.setName(name);
		parameters.setCreatedTime(new Date());
		parameters.setLastUpdateTime(new Date());
		parameters.setRegisterTime(new Date());
		parameters.setOperationTime(new Date());
		parameters.setCreatedTime(new Date());
		parameters.setStatus("pending");  //待处理状态
		parameters.setTelephone(phone);
		parameters.setEnterpriseName(enterpriseName);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", parameters);
		map.put("sign", "insertVisitorInfo");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("V2VisitorsManagement", map);
		if (result != null) {
			if (result.getSys() != null) {
				String status = result.getSys().getStatus();
				String erortx = result.getSys().getErortx();// 错误信息
				if ("S".equals(status)) {// 交易成功
					response.setResponseType(ResponseType.SUCCESS);
					super.log.info("新增产品预约信息，调用insertVisitorInfo服务成功：" + erortx);
					return response;
				} else {
					response.setResponseType(ResponseType.ERROR);
					super.log.error("新增产品预约信息，调用insertVisitorInfo服务失败：" + erortx);
				}
			}
		} else {
			super.log.error("调用服务失败！");
		}
	return response;	
	}
}
