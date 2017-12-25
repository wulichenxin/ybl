package com.bpm.framework.controller.productManage;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.utils.i18n.I18NUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.AttachmentVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.ProductConfigArchiveMaterialVo;
import cn.sunline.framework.controller.vo.ProductConfigFeeVo;
import cn.sunline.framework.controller.vo.ProductConfigLoanMaterialVo;
import cn.sunline.framework.controller.vo.ProductVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.common.FormProductConfigObject;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

@Controller
@RequestMapping({"/productManageController"})
public class ProductManageController extends AbstractController {

    /**
     *保理端贷款管理controller
     */
    private static final long serialVersionUID = -2809460978768158852L;

  //查询所有产品
    @RequestMapping({"/queryAllProduct"})
    public String queryAll(ProductVo product , PageVo pageVo, String name_, String type_, String status_){
    	UserVo user = ControllerUtils.getCurrentUser();
		if(user == null){
			super.log.error("请先登录");
			return "/ybl/admin/index/login";
		}
		product.setEnterprise_id(user.getEnterpriseId());
    	/*product.setInitiator_("factor");*/
		Map<String,Object> maps = new HashMap<String,Object>();
		maps.put("paramter", product);
		maps.put("page", pageVo);
		maps.put("sign", "queryProductByCondition");//所调用的服务中的方法		
		ResBody result = TradeInvokeUtils.invoke("ProductsFactoryManagement", maps);					
		PageVo page=null;
		
		isSuccess(result);
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
 		getRequest().setAttribute("name_",name_);
 		getRequest().setAttribute("type_",type_);
 		getRequest().setAttribute("status_",status_);
 		getRequest().setAttribute("products", product);
		getRequest().setAttribute("page", page);
		
        return "ybl/admin/factor/product/productManage";
    }
    
    /**
     *新增产品 
     * 
     */
    @RequestMapping({" /insertProduct "})
    @ResponseBody
    public ControllerResponse insertProduct(ProductVo product){
    	ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
    	UserVo user = ControllerUtils.getCurrentUser();
    	if(user == null){
    		response.setInfo("请重新登录");
    		return response;
    	}
    	if(product==null){
			response.setInfo(I18NUtils.getText("sys.admin.paramter.error"));//参数错误
			super.log.error("新增产品不能为空！");
			return response;
		}
    	product.setEnterprise_id(user.getEnterpriseId());
    	ControllerUtils.setWho(product);
    	Map<String,Object> map = new HashMap<String,Object>();
    	map.put("paramter", product);
		map.put("sign", "insertProductInfo");
		ResBody result = null;
		result = TradeInvokeUtils.invoke("ProductsFactoryManagement", map);
		if(result!=null){
			if(result.getSys()!=null){
				String status = result.getSys().getStatus();//状态：'S'成功，'F'失败
				String erortx = result.getSys().getErortx();//错误信息
				if("S".equals(status)){//交易成功
					response.setResponseType(ResponseType.SUCCESS_SAVE);					
					response.setObject(result);//设置返回结果	
					response.setInfo(I18NUtils.getText("sys.client.operationSuccess"));//操作成功
					super.log.info("新增产品服务调用信息："+erortx);
				}else{
					response.setResponseType(ResponseType.ERROR);
					response.setInfo(I18NUtils.getText("sys.client.operationFail"));//操作失败！
					super.log.error("新增产品服务调用信息："+erortx);
				}
			}
		}else{
			response.setResponseType(ResponseType.ERROR);
			response.setInfo(I18NUtils.getText("call.service.failed"));//调用服务失败！
			super.log.error("调用服务失败！");
		}
		return response;
    }
    
    /**
     * 
     * 查询当前产品表信息,配置产品、上线、下线时校验
     */
    @RequestMapping({"/queryProductInfoById"})
    @ResponseBody
    public ControllerResponse queryProductById(String id ){
    	ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
    	if(id.isEmpty()){
			response.setInfo(I18NUtils.getText("sys.admin.paramter.error"));//参数错误
			super.log.error("未选择产品id！");
			return response;
		}
    	ProductVo product = new ProductVo();
    	product.setId(Long.valueOf(id));
    	Map<String,Object> map = new HashMap<String,Object>();
    	map.put("paramter", product);
		map.put("sign", "queryProductByCondition");
		ResBody result = null;
		result = TradeInvokeUtils.invoke("ProductsFactoryManagement", map);
		List<Map> list= new ArrayList<>();
		if(result!=null){
			if(result.getSys()!=null){
				String status = result.getSys().getStatus();//状态：'S'成功，'F'失败
				JSONObject output  = (JSONObject) result.getOutput();
				if("S".equals(status)){//交易成功
					String resultJson = output.getString("result");
					list = JsonUtils.toList(resultJson, Map.class);
					response.setResponseType(ResponseType.SUCCESS);					
					response.setObject(list.get(0));//设置返回结果	
				}else{
					response.setResponseType(ResponseType.ERROR);
				}
			}
		}else{
			response.setResponseType(ResponseType.ERROR);
			response.setInfo(I18NUtils.getText("call.service.failed"));//调用服务失败！
			super.log.error("调用服务失败！");
		}
		return response;
    }
    
    /**
     * 配置产品（根据id查出对应的产品信息）
     * 
     */
    @RequestMapping({"/queryByProductId"})
    public String queryByProductId(String id,PageVo pageVo){
    	Map<String,Object> map = new HashMap<String,Object>();
    	map.put("id_", id);
    	Map<String,Object> maps = new HashMap<String,Object>();
		maps.put("paramter", map);
		maps.put("page", pageVo);
		maps.put("sign", "queryProductAndMateriaById");//所调用的服务中的方法		
		ResBody result = TradeInvokeUtils.invoke("ProductsFactoryManagement", maps);					
		JSONObject output = (JSONObject) result.getOutput();
		List<String> typeList = new ArrayList<>();
		Map<String, Object> proList= new HashMap<>();
		if(result.getSys()!=null){
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();//错误信息
			if("S".equals(status)){//交易成功
				String resultJson = output.getString("result");
				typeList = JsonUtils.toList(output.getString("types"), String.class);
				proList = JsonUtils.toMap(resultJson);
				super.log.error("根据条件查询产品信息调用queryProductAndMateriaById服务返回成功，信息："+proList);
			}else{
				super.log.error("根据条件查询产品信息调用queryProductAndMateriaById服务返回失败，信息："+erortx);
			}
		}
		getRequest().setAttribute("typeList", typeList);
		getRequest().setAttribute("attachment",proList.get("attachment"));
		getRequest().setAttribute("product", proList.get("product"));
		getRequest().setAttribute("arcList", proList.get("archives"));
		getRequest().setAttribute("matList", proList.get("materias"));
		getRequest().setAttribute("feeList", proList.get("fees"));
		getRequest().setAttribute("temList", proList.get("temps"));
    	return "ybl/admin/factor/product/productConfigure";
    }
    
    /**
     * 查看产品（根据id查出对应的产品信息）
     * 
     */
    @RequestMapping({"/lookQueryByProductId"})
    public String lookQueryByProductId(String id,PageVo pageVo){
    	Map<String,Object> map = new HashMap<String,Object>();
    	map.put("id_", id);
    	Map<String,Object> maps = new HashMap<String,Object>();
		maps.put("paramter", map);
		maps.put("page", pageVo);
		maps.put("sign", "queryProductAndMateriaById");//所调用的服务中的方法		
		ResBody result = TradeInvokeUtils.invoke("ProductsFactoryManagement", maps);					
		JSONObject output = (JSONObject) result.getOutput();
		List<String> typeList = new ArrayList<>();
		Map<String, Object> proList= new HashMap<>();
		if(result.getSys()!=null){
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();//错误信息
			if("S".equals(status)){//交易成功
				String resultJson = output.getString("result");
				typeList = JsonUtils.toList(output.getString("types"), String.class);
				proList = JsonUtils.toMap(resultJson);
				super.log.error("根据条件查询产品信息调用queryProductAndMateriaById服务返回成功，信息："+proList);
			}else{
				super.log.error("根据条件查询产品信息调用queryProductAndMateriaById服务返回失败，信息："+erortx);
			}
		}
		getRequest().setAttribute("typeList", typeList);
		getRequest().setAttribute("attachment",proList.get("attachment"));
		getRequest().setAttribute("product", proList.get("product"));
		getRequest().setAttribute("arcList", proList.get("archives"));
		getRequest().setAttribute("matList", proList.get("materias"));
		getRequest().setAttribute("feeList", proList.get("fees"));
		getRequest().setAttribute("temList", proList.get("temps"));
    	return "ybl/admin/factor/product/lookProductConfigure";
    }
    
    /**
     * 删除产品
     */
    @RequestMapping({"/deleteProduct"})
    @ResponseBody
    public ControllerResponse deleteProduct(ProductVo product){
    	ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
    	if(product.getId() < 0){
			response.setInfo(I18NUtils.getText("sys.admin.paramter.error"));//参数错误
			super.log.error("请选择要删除的产品!");
			return response;
		}
    	ControllerUtils.setWho(product);
    	Map<String,Object> map = new HashMap<String,Object>();
    	map.put("paramter", product);
		map.put("sign", "deleteProductById");
		ResBody result = null;
		result = TradeInvokeUtils.invoke("ProductsFactoryManagement", map);
		if(result!=null){
			if(result.getSys()!=null){
				String status = result.getSys().getStatus();//状态：'S'成功，'F'失败
				String erortx = result.getSys().getErortx();//错误信息
				if("S".equals(status)){//交易成功
					response.setResponseType(ResponseType.SUCCESS_DELETE);					
					response.setInfo(I18NUtils.getText("sys.client.operationSuccess"));//操作成功
					response.setInfo("删除产品成功");//设置返回的信息
					super.log.info("删除产品服务调用信息："+erortx);
				}else{
					response.setResponseType(ResponseType.ERROR);
					response.setInfo(I18NUtils.getText("sys.client.operationFail"));//操作失败！
					super.log.error("删除产品服务调用信息："+erortx);
				}
			}
		}else{
			response.setResponseType(ResponseType.ERROR);
			response.setInfo(I18NUtils.getText("call.service.failed"));//调用服务失败！
			super.log.error("调用服务失败！");
		}
		return response;
    }
    
    /**
     * 修改产品
     */
    @RequestMapping({"/updateProduct"})
    @ResponseBody
    public ControllerResponse updateProduct(ProductVo product,AttachmentVo attachmentVo){
    	ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
    	if(product.getId() < 0){
    		response.setInfo(I18NUtils.getText("sys.admin.paramter.error"));//参数错误
			super.log.error("请选择要修改的产品!");
			return response;
		}
    	
		ControllerUtils.setWho(attachmentVo);
		Map<String,Object> maps = new HashMap<String,Object>();
		maps.put("product", product);
		maps.put("attachment", attachmentVo);
    	Map<String,Object> map = new HashMap<String,Object>();
    	map.put("paramter", maps);
		map.put("sign", "updateProductInfoById");
		ResBody result = null;
		result = TradeInvokeUtils.invoke("ProductsFactoryManagement", map);
		if(result!=null){
			if(result.getSys()!=null){
				String status = result.getSys().getStatus();//状态：'S'成功，'F'失败
				String erortx = result.getSys().getErortx();//错误信息
				if("S".equals(status)){//交易成功
					response.setResponseType(ResponseType.SUCCESS_DELETE);					
					response.setObject(result);//设置返回结果	
					response.setInfo(I18NUtils.getText("sys.client.operationSuccess"));//操作成功
					super.log.info("修改产品服务调用信息："+erortx);
				}else{
					response.setResponseType(ResponseType.ERROR);
					response.setInfo(I18NUtils.getText("sys.client.operationFail"));//操作失败！
					super.log.error("修改产品服务调用信息："+erortx);
				}
			}
		}else{
			response.setResponseType(ResponseType.ERROR);
			response.setInfo(I18NUtils.getText("call.service.failed"));//调用服务失败！
			super.log.error("调用服务失败！");
		}
		return response;
    }
    
    
    
    //查询所有费用配置
    @RequestMapping({"/queryAllConfigFee"})
    public String queryAllConfigFee(String productId, String enterpriseId){
		
		Map<String,Object> maps = new HashMap<String,Object>();
		
		maps.put("sign", "queryAllProductFeeConf");//所调用的服务中的方法		
		ResBody result = TradeInvokeUtils.invoke("ProductsFactoryManagement", maps);					
		
		isSuccess(result);
 		if(result.getSys()!=null){
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();//错误信息	
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				List<Map> list= new ArrayList<>();
				list = JsonUtils.toList(records, Map.class);
				getRequest().setAttribute("list", list);
				super.log.error("根据条件查询费用调用queryAllProductFeeConf服务返回成功，信息："+list);
			}else{
				super.log.error("根据条件查询费用调用queryAllProductFeeConf服务返回失败，信息："+erortx);
				return null;
			}			
		}
 		getRequest().setAttribute("productId", productId);
 		getRequest().setAttribute("enterpriseId", enterpriseId);
 		
        return "ybl/admin/factor/product/configFee";
    }
    
    //删除选中的费用配置
    @RequestMapping({"/deleteProductFee"})
    @ResponseBody
    public ControllerResponse deleteProductFee(String  fees){
    	ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
    	if(fees.isEmpty()){
    		response.setInfo(I18NUtils.getText("sys.admin.paramter.error"));//参数错误
			super.log.error("请选择要删除的费用项!");
			return response;
		}
    	Map<String,Object> map = new HashMap<String,Object>();
    	map.put("fees", fees);
    	Map<String,Object> maps = new HashMap<String,Object>();
    	maps.put("paramter", map);
		maps.put("sign", "deleteProductFee");
		ResBody result = null;
		result = TradeInvokeUtils.invoke("ProductsFactoryManagement", maps);
		if(result!=null){
			if(result.getSys()!=null){
				String status = result.getSys().getStatus();//状态：'S'成功，'F'失败
				String erortx = result.getSys().getErortx();//错误信息
				if("S".equals(status)){//交易成功
					response.setResponseType(ResponseType.SUCCESS_DELETE);					
					response.setObject(result);//设置返回结果	
					response.setInfo(I18NUtils.getText("sys.client.operationSuccess"));//操作成功
					super.log.info("删除产品费用项服务调用信息："+erortx);
				}else{
					response.setResponseType(ResponseType.ERROR);
					response.setInfo(I18NUtils.getText("sys.client.operationFail"));//操作失败！
					super.log.error("删除产品费用项服务调用信息："+erortx);
				}
			}
		}else{
			response.setResponseType(ResponseType.ERROR);
			response.setInfo(I18NUtils.getText("call.service.failed"));//调用服务失败！
			super.log.error("调用服务失败！");
		}
		return response;
    }
    
    //新增选中的费用配置
    @RequestMapping({"/insertProductFee"})
    @ResponseBody
    public ControllerResponse insertProductFee(String fees,String productId,String enterpriseId){
    	ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
    	if(fees.isEmpty()){
    		response.setInfo(I18NUtils.getText("sys.admin.paramter.error"));//参数错误
			super.log.error("请选择要添加的费用项!");
			return response;
		}
    	ProductConfigFeeVo productConfigFee = new ProductConfigFeeVo();
    	ControllerUtils.setWho(productConfigFee);
    	productConfigFee.setProductId(Long.valueOf(productId));
    	productConfigFee.setEnterpriseid(Long.valueOf(enterpriseId));
    	//把配置ids和费用对象放入map
    	Map<String,Object> map = new HashMap<String,Object>();
    	map.put("productFee", productConfigFee);
    	map.put("fees", fees);
    	Map<String,Object> maps = new HashMap<String,Object>();
    	maps.put("paramter", map);
		maps.put("sign", "insertProductFee");
		ResBody result = null;
		result = TradeInvokeUtils.invoke("ProductsFactoryManagement", maps);
		if(result!=null){
			if(result.getSys()!=null){
				String status = result.getSys().getStatus();//状态：'S'成功，'F'失败
				String erortx = result.getSys().getErortx();//错误信息
				if("S".equals(status)){//交易成功
					response.setResponseType(ResponseType.SUCCESS_DELETE);					
					response.setObject(result);//设置返回结果	
					response.setInfo(I18NUtils.getText("sys.client.operationSuccess"));//操作成功
					super.log.info("添加产品费用项服务调用信息："+erortx);
				}else{
					response.setResponseType(ResponseType.ERROR);
					response.setInfo(I18NUtils.getText("sys.client.operationFail"));//操作失败！
					super.log.error("添加产品费用项服务调用信息："+erortx);
				}
			}
		}else{
			response.setResponseType(ResponseType.ERROR);
			response.setInfo(I18NUtils.getText("call.service.failed"));//调用服务失败！
			super.log.error("调用服务失败！");
		}
		return response;
    }
    
    
    //查询所有材料配置
    @RequestMapping({"/queryAllConfigMaterial"})
    public String queryAllConfigMaterial(String productId, String enterpriseId){
		
		Map<String,Object> maps = new HashMap<String,Object>();
		
		maps.put("sign", "queryAllProductLoanMateriaPlatConf");//所调用的服务中的方法		
		ResBody result = TradeInvokeUtils.invoke("ProductsFactoryManagement", maps);					
		
		isSuccess(result);
 		if(result.getSys()!=null){
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();//错误信息	
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				List<Map> list= new ArrayList<>();
				list = JsonUtils.toList(records, Map.class);
				getRequest().setAttribute("list", list);
				super.log.error("根据条件查询材料配置调用queryAllProductLoanMateriaPlatConf服务返回成功，信息："+list);
			}else{
				super.log.error("根据条件查询材料配置调用queryAllProductLoanMateriaPlatConf服务返回失败，信息："+erortx);
				return null;
			}			
		}
 		getRequest().setAttribute("productId", productId);
 		getRequest().setAttribute("enterpriseId", enterpriseId);
		
        return "ybl/admin/factor/product/configMaterial";
    }
    
    //新增选中的贷款材料配置
    @RequestMapping({"/insertProductMateria"})
    @ResponseBody
    public ControllerResponse insertProductMateria(String materials,String productId,String enterpriseId){
    	ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
    	if(materials.isEmpty()){
    		response.setInfo(I18NUtils.getText("sys.admin.paramter.error"));//参数错误
			super.log.error("请选择要添加的贷款材料配置项!");
			return response;
		}
    	ProductConfigLoanMaterialVo productConfigLoanMaterial = new ProductConfigLoanMaterialVo();
    	ControllerUtils.setWho(productConfigLoanMaterial);
    	productConfigLoanMaterial.setBusinessId(Long.valueOf(productId));
    	productConfigLoanMaterial.setType("product");
    	productConfigLoanMaterial.setEnterpriseid(Long.valueOf(enterpriseId));
    	//把配置ids和贷款材料配置对象放入map
    	Map<String,Object> map = new HashMap<String,Object>();
    	map.put("productMaterial", productConfigLoanMaterial);
    	map.put("materials", materials);
    	Map<String,Object> maps = new HashMap<String,Object>();
    	maps.put("paramter", map);
		maps.put("sign", "insertProductMaterial");
		ResBody result = null;
		result = TradeInvokeUtils.invoke("ProductsFactoryManagement", maps);
		if(result!=null){
			if(result.getSys()!=null){
				String status = result.getSys().getStatus();//状态：'S'成功，'F'失败
				String erortx = result.getSys().getErortx();//错误信息
				if("S".equals(status)){//交易成功
					response.setResponseType(ResponseType.SUCCESS_DELETE);					
					response.setObject(result);//设置返回结果	
					response.setInfo(I18NUtils.getText("sys.client.operationSuccess"));//操作成功
					super.log.info("添加产品贷款材料配置项服务调用信息："+erortx);
				}else{
					response.setResponseType(ResponseType.ERROR);
					response.setInfo(I18NUtils.getText("sys.client.operationFail"));//操作失败！
					super.log.error("添加产品贷款材料配置项服务调用信息："+erortx);
				}
			}
		}else{
			response.setResponseType(ResponseType.ERROR);
			response.setInfo(I18NUtils.getText("call.service.failed"));//调用服务失败！
			super.log.error("调用服务失败！");
		}
		return response;
    }
    
  //删除选中的材料配置
    @RequestMapping({"/deleteProductMaterial"})
    @ResponseBody
    public ControllerResponse deleteProductMaterial(String  materials){
    	ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
    	if(materials.isEmpty()){
    		response.setInfo(I18NUtils.getText("sys.admin.paramter.error"));//参数错误
			super.log.error("请选择要删除的材料配置!");
			return response;
		}
    	Map<String,Object> map = new HashMap<String,Object>();
    	map.put("materials", materials);
    	Map<String,Object> maps = new HashMap<String,Object>();
    	maps.put("paramter", map);
		maps.put("sign", "deleteProductMaterial");
		ResBody result = null;
		result = TradeInvokeUtils.invoke("ProductsFactoryManagement", maps);
		if(result!=null){
			if(result.getSys()!=null){
				String status = result.getSys().getStatus();//状态：'S'成功，'F'失败
				String erortx = result.getSys().getErortx();//错误信息
				if("S".equals(status)){//交易成功
					response.setResponseType(ResponseType.SUCCESS_DELETE);					
					response.setObject(result);//设置返回结果	
					response.setInfo(I18NUtils.getText("sys.client.operationSuccess"));//操作成功
					super.log.info("删除产品材料配置服务调用信息："+erortx);
				}else{
					response.setResponseType(ResponseType.ERROR);
					response.setInfo(I18NUtils.getText("sys.client.operationFail"));//操作失败！
					super.log.error("删除产品材料配置服务调用信息："+erortx);
				}
			}
		}else{
			response.setResponseType(ResponseType.ERROR);
			response.setInfo(I18NUtils.getText("call.service.failed"));//调用服务失败！
			super.log.error("调用服务失败！");
		}
		return response;
    }
    
  //查询所有归档材料配置
    @RequestMapping({"/queryAllConfigPigeonhole"})
    public String queryAllConfigPigeonhole(String productId, String enterpriseId){
		
		Map<String,Object> maps = new HashMap<String,Object>();
		
		maps.put("sign", "queryAllProductLoanMateriaArchiveConf");//所调用的服务中的方法		
		ResBody result = TradeInvokeUtils.invoke("ProductsFactoryManagement", maps);					
		
		isSuccess(result);
 		if(result.getSys()!=null){
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();//错误信息	
			if("S".equals(status)){//交易成功
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				List<Map> list= new ArrayList<>();
				list = JsonUtils.toList(records, Map.class);
				getRequest().setAttribute("list", list);
				super.log.error("根据条件查询归档材料调用queryAllProductLoanMateriaArchiveConf服务返回成功，信息："+list);
			}else{
				super.log.error("根据条件查询归档材料调用queryAllProductLoanMateriaArchiveConf服务返回失败，信息："+erortx);
				return null;
			}			
		}
 		getRequest().setAttribute("productId", productId);
 		getRequest().setAttribute("enterpriseId", enterpriseId);
		
        return "ybl/admin/factor/product/configPigeonhole";
    }
    
  //删除选中的贷款归档材料配置
    @RequestMapping({"/deleteProductArchive"})
    @ResponseBody
    public ControllerResponse deleteProductArchive(String  archives){
    	ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
    	if(archives.isEmpty()){
    		response.setInfo(I18NUtils.getText("sys.admin.paramter.error"));//参数错误
			super.log.error("请选择要删除的贷款归档材料!");
			return response;
		}
    	Map<String,Object> map = new HashMap<String,Object>();
    	map.put("archives", archives);
    	Map<String,Object> maps = new HashMap<String,Object>();
    	maps.put("paramter", map);
		maps.put("sign", "deleteProductArchive");
		ResBody result = null;
		result = TradeInvokeUtils.invoke("ProductsFactoryManagement", maps);
		if(result!=null){
			if(result.getSys()!=null){
				String status = result.getSys().getStatus();//状态：'S'成功，'F'失败
				String erortx = result.getSys().getErortx();//错误信息
				if("S".equals(status)){//交易成功
					response.setResponseType(ResponseType.SUCCESS_DELETE);					
					response.setObject(result);//设置返回结果	
					response.setInfo(I18NUtils.getText("sys.client.operationSuccess"));//操作成功
					super.log.info("删除产品贷款归档材料服务调用信息："+erortx);
				}else{
					response.setResponseType(ResponseType.ERROR);
					response.setInfo(I18NUtils.getText("sys.client.operationFail"));//操作失败！
					super.log.error("删除产品贷款归档材料服务调用信息："+erortx);
				}
			}
		}else{
			response.setResponseType(ResponseType.ERROR);
			response.setInfo(I18NUtils.getText("call.service.failed"));//调用服务失败！
			super.log.error("调用服务失败！");
		}
		return response;
    }
    
  //新增选中的贷款归档材料配置
    @RequestMapping({"/insertProductArchive"})
    @ResponseBody
    public ControllerResponse insertProductArchive(String archives,String productId,String enterpriseId){
    	ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
    	if(archives.isEmpty()){
    		response.setInfo(I18NUtils.getText("sys.admin.paramter.error"));//参数错误
			super.log.error("请选择要添加的贷款归档材料配置项!");
			return response;
		}
    	ProductConfigArchiveMaterialVo productConfigArchiveMaterial = new ProductConfigArchiveMaterialVo();
    	ControllerUtils.setWho(productConfigArchiveMaterial);
    	productConfigArchiveMaterial.setProductId(Long.valueOf(productId));
    	productConfigArchiveMaterial.setEnterpriseid(Long.valueOf(enterpriseId));
    	//把配置ids和贷款归档材料配置对象放入map
    	Map<String,Object> map = new HashMap<String,Object>();
    	map.put("productArchive", productConfigArchiveMaterial);
    	map.put("archives", archives);
    	Map<String,Object> maps = new HashMap<String,Object>();
    	maps.put("paramter", map);
		maps.put("sign", "insertProductArchive");
		ResBody result = null;
		result = TradeInvokeUtils.invoke("ProductsFactoryManagement", maps);
		if(result!=null){
			if(result.getSys()!=null){
				String status = result.getSys().getStatus();//状态：'S'成功，'F'失败
				String erortx = result.getSys().getErortx();//错误信息
				if("S".equals(status)){//交易成功
					response.setResponseType(ResponseType.SUCCESS_DELETE);					
					response.setObject(result);//设置返回结果	
					response.setInfo(I18NUtils.getText("sys.client.operationSuccess"));//操作成功
					super.log.info("添加产品贷款归档材料配置项服务调用信息："+erortx);
				}else{
					response.setResponseType(ResponseType.ERROR);
					response.setInfo(I18NUtils.getText("sys.client.operationFail"));//操作失败！
					super.log.error("添加产品贷款归档材料配置项服务调用信息："+erortx);
				}
			}
		}else{
			response.setResponseType(ResponseType.ERROR);
			response.setInfo(I18NUtils.getText("call.service.failed"));//调用服务失败！
			super.log.error("调用服务失败！");
		}
		return response;
    }
    
    /**
     * 修改产品
     */
    @RequestMapping({"/updateProductConfig"})
    @ResponseBody
    public ControllerResponse updateProductConfig(ProductVo product,AttachmentVo attachmentVo,FormProductConfigObject ProductConfigObjectList){
    	ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
    	if(product.getId() < 0){
    		response.setInfo(I18NUtils.getText("sys.admin.paramter.error"));//参数错误
			super.log.error("请选择要修改的产品!");
			return response;
		}
    	//获取费用集合
    	List<ProductConfigFeeVo> feeList = ProductConfigObjectList.getFeeList();
    	//获取材料集合
    	List<ProductConfigLoanMaterialVo> materiaList = ProductConfigObjectList.getMaterialList();
    	//获取归档材料集合
    	List<ProductConfigArchiveMaterialVo> archiveList = ProductConfigObjectList.getArchiveMaterialList();
    	
    	attachmentVo.setId(Long.valueOf(0));
		ControllerUtils.setWho(attachmentVo);
		Map<String,Object> maps = new HashMap<String,Object>();
		maps.put("product", product);
		maps.put("attachment", attachmentVo);
		maps.put("feeList", feeList);
		maps.put("materiaList", materiaList);
		maps.put("archiveList", archiveList);
    	Map<String,Object> map = new HashMap<String,Object>();
    	map.put("paramter", maps);
		map.put("sign", "updateProductInfoByProductId");
		ResBody result = null;
		result = TradeInvokeUtils.invoke("ProductsFactoryManagement", map);
		if(result!=null){
			if(result.getSys()!=null){
				String status = result.getSys().getStatus();//状态：'S'成功，'F'失败
				String erortx = result.getSys().getErortx();//错误信息
				if("S".equals(status)){//交易成功
					response.setResponseType(ResponseType.SUCCESS_DELETE);					
					response.setObject(result);//设置返回结果	
					response.setInfo(I18NUtils.getText("sys.client.operationSuccess"));//操作成功
					super.log.info("修改产品服务调用信息："+erortx);
				}else{
					response.setResponseType(ResponseType.ERROR);
					response.setInfo(I18NUtils.getText("sys.client.operationFail"));//操作失败！
					super.log.error("修改产品服务调用信息："+erortx);
				}
			}
		}else{
			response.setResponseType(ResponseType.ERROR);
			response.setInfo(I18NUtils.getText("call.service.failed"));//调用服务失败！
			super.log.error("调用服务失败！");
		}
		return response;
    }
  
}
