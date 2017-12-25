
package com.bpm.framework.controller.supplier;

import java.math.BigDecimal;
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
import com.bpm.framework.controller.common.AddressRedisCache;
import com.bpm.framework.controller.fileupload.AttachmentVo;
import com.bpm.framework.sequence.Sequence;
import com.bpm.framework.sequence.generator.DateTimeSequence;
import com.bpm.framework.utils.CollectionUtils;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.AreaVo;
import cn.sunline.framework.controller.vo.AuditRecordVo;
import cn.sunline.framework.controller.vo.CityVo;
import cn.sunline.framework.controller.vo.EnterpriseSignVo;
import cn.sunline.framework.controller.vo.EnterpriseVo;
import cn.sunline.framework.controller.vo.FinanceApplyVo;
import cn.sunline.framework.controller.vo.FinanceApplyVoucherVo;
import cn.sunline.framework.controller.vo.FinanceLoanMaterialVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.PlatformFeeVo;
import cn.sunline.framework.controller.vo.ProductConfigLoanMaterialVo;
import cn.sunline.framework.controller.vo.ProductVo;
import cn.sunline.framework.controller.vo.ProvinceVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.VoucherVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

@Controller
@RequestMapping({ "/loanApplicationController" })
public class LoanApplicationController extends AbstractController {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4292131223405382402L;

	@RequestMapping({ "/loanApplication" })
	public String loanApplication(EnterpriseSignVo enterpriseSign, PageVo pageVo) {

		UserVo user = ControllerUtils.getCurrentUser();
		if(null==user){
			return "ybl/admin/index/login";
		}
		
		enterpriseSign.setMemberId(user.getId());
		enterpriseSign.setEnterpriseId(user.getEnterpriseId());
		// 只查询签约状态为已签约的保理商信息
		enterpriseSign.setSignStatus("signed");

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", enterpriseSign);
		map.put("page", pageVo);
		map.put("sign", "queryEnterpriseByCondition");
		ResBody result = TradeInvokeUtils.invoke("FacteServiceManagement", map);
		PageVo page = null;
		List<EnterpriseSignVo> enterList = null;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage = output.getString("page");
				String records = output.getString("result");
				page = JSONObject.parseObject(jsonPage, PageVo.class);
				enterList = JsonUtils.toList(records, EnterpriseSignVo.class);
				
				getRequest().setAttribute("page", page);
				getRequest().setAttribute("enterList", enterList);
			}
		}

		// 查询所以省份
		Map<String, Object> condition = new HashMap<String, Object>();
		condition.put("sign", "queryAllProvince");
		ResBody res = TradeInvokeUtils.invoke("ProvinceManagement", condition);
		List<ProvinceVo> proList = null;
		if (res.getSys() != null) {
			String status = res.getSys().getStatus();
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) res.getOutput();
				String records = output.getString("result");
				proList = JsonUtils.toList(records, ProvinceVo.class);
				
				getRequest().setAttribute("proList", proList);
			}
		}
		
		getRequest().setAttribute("enterpriseSign", enterpriseSign);

		return "ybl/admin/supplier/application/loanApplication";
	}

	@RequestMapping({ "/factorDetails" })
	public String factorDetails(String id) {
		UserVo user = ControllerUtils.getCurrentUser();
		if (StringUtils.isEmpty(id)) {
			return null;
		}
		EnterpriseVo vo = new EnterpriseVo();
		vo.setId(Long.parseLong(id));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", vo);
		map.put("sign", "queryEnterpriseByCondition");
		ResBody result = TradeInvokeUtils.invoke("EnterpriseManagement", map);
		List<EnterpriseVo> enterList = null;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage = output.getString("page");
				String records = output.getString("result");
				enterList = JsonUtils.toList(records, EnterpriseVo.class);
				if(CollectionUtils.isNotEmpty(enterList)){
					getRequest().setAttribute("enter", enterList.get(0));
					
					EnterpriseVo enter = enterList.get(0);
					
					//获取省份名称
					ProvinceVo provinceEntry = null;
					List<ProvinceVo> list = AddressRedisCache.getProvinceList();
					if (CollectionUtils.isNotEmpty(list)) {
						for (ProvinceVo provice : list) {
							if (provice.getId().longValue()==enter.getProvinceId().longValue()) {
								provinceEntry = provice;
								getRequest().setAttribute("provinceName",provinceEntry.getName());
								break;
							}
						}
					}
					
					//获取城市名称
					CityVo cityEntry = null;
					List<CityVo> cityList = AddressRedisCache.getCityList();
					if (CollectionUtils.isNotEmpty(cityList)) {
						for (CityVo city : cityList) {
							if (city.getId().longValue()==enter.getCityId().longValue()) {
								cityEntry = city;
								getRequest().setAttribute("cityName",cityEntry.getName());
								break;
							}
						}
					}
					
					//获取区县名称
					AreaVo areaEntry = null;
					List<AreaVo> areaList = AddressRedisCache.getAreaList();
					if (CollectionUtils.isNotEmpty(areaList)) {
						for (AreaVo area : areaList) {
							if (area.getId().longValue()==enter.getAreaId().longValue()) {
								areaEntry = area;
								getRequest().setAttribute("areaName",areaEntry.getName());
								break;
							}
						}
					}
				}
			}
		}

		// 查询保理商产品信息
		Map<String, Object> condition = new HashMap<String, Object>();
		ProductVo product = new ProductVo();
		product.setEnterprise_id(Long.parseLong(id));
		product.setStatus_("online");
		condition.put("paramter", product);
		condition.put("sign", "queryProductByCondition");
		ResBody res = TradeInvokeUtils.invoke("ProductsFactoryManagement", condition);
		List<ProductVo> productVos = null;
		if (res.getSys() != null) {
			String status = res.getSys().getStatus();
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) res.getOutput();
				String jsonPage = output.getString("page");
				String records = output.getString("result");
				productVos = JsonUtils.toList(records, ProductVo.class);
				
				getRequest().setAttribute("productVos", productVos);
			}
		}
		//调用服务，进行签约表数据查询
		if(user!=null){
			Map<String, Object> paramters = new HashMap<String,Object>();
			paramters.put("enterprise2_id", Long.parseLong(id));//保理商企业id
			paramters.put("enterprise_id", user.getEnterpriseId());//供应商企业id
			Map<String,Object> memberSignMap = new HashMap<String,Object>();
			memberSignMap.put("paramter", paramters);
			memberSignMap.put("sign", "queryMemberSign");//所调用的服务中的方法
			ResBody results_ = TradeInvokeUtils.invoke("CustomerManagement", memberSignMap);	
			
	 		if(results_.getSys()!=null){
				if("S".equals(results_.getSys().getStatus())){//交易成功
					JSONObject outputs = (JSONObject) results_.getOutput();
					String records = outputs.getString("result");
					Map<String,Object>	memberSign = JsonUtils.toMap(records);
					getRequest().setAttribute("memberSign", memberSign);
				}
			}
		}

		return "ybl/admin/supplier/application/factorDetails";
	}

	// 融资申请初始化信息
	@RequestMapping({ "/financeApplication" })
	public String financeApplication(String id, String productId) {

		// 查询自己的信息
		UserVo user = ControllerUtils.getCurrentUser();
		if(null==user){
			return "ybl/admin/index/login";
		}
		EnterpriseVo enterprisensh = new EnterpriseVo();
		enterprisensh.setId(user.getEnterpriseId());
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", enterprisensh);
		map.put("sign", "queryEnterpriseByCondition");
		ResBody result = TradeInvokeUtils.invoke("EnterpriseManagement", map);
		List<EnterpriseVo> entershList = null;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage = output.getString("page");
				String records = output.getString("result");
				entershList = JsonUtils.toList(records, EnterpriseVo.class);
				if(CollectionUtils.isNotEmpty(entershList)){
					getRequest().setAttribute("entersh", entershList.get(0));
				}
			}
		}

		// 查询保理商信息
		EnterpriseVo enterprisebl = new EnterpriseVo();
		enterprisebl.setId(Long.parseLong(id));
		map.put("paramter", enterprisebl);
		map.put("sign", "queryEnterpriseByCondition");
		ResBody res = TradeInvokeUtils.invoke("EnterpriseManagement", map);
		List<EnterpriseVo> enterblList = null;
		if (res.getSys() != null) {
			String status = res.getSys().getStatus();
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) res.getOutput();
				String jsonPage = output.getString("page");
				String records = output.getString("result");
				enterblList = JsonUtils.toList(records, EnterpriseVo.class);
				if(CollectionUtils.isNotEmpty(enterblList)){
					getRequest().setAttribute("enterbl", enterblList.get(0));
				}
			}
		}

		// 查询产品详情
		ProductVo productVo = new ProductVo();
		productVo.setId(Long.parseLong(productId));
		map.put("paramter", productVo);
		map.put("sign", "queryProductByCondition");
		ResBody resu = TradeInvokeUtils.invoke("ProductsFactoryManagement", map);
		List<ProductVo> productList = null;
		if (resu.getSys() != null) {
			String status = resu.getSys().getStatus();
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) resu.getOutput();
				String jsonPage = output.getString("page");
				String records = output.getString("result");
				productList = JsonUtils.toList(records, ProductVo.class);
				if(CollectionUtils.isNotEmpty(productList)){
					getRequest().setAttribute("product", productList.get(0));
				}
			}
		}

		/* 根据产品查询融资申请需要提交的贷款材料*/
		map.put("paramter", productId);
		map.put("sign", "queryMaterialByProductId");
		ResBody results = TradeInvokeUtils.invoke("FinanceApplyManagement", map);
		List<ProductConfigLoanMaterialVo> materialList = null;
		if (results.getSys() != null) {
			String status = results.getSys().getStatus();
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) results.getOutput();
				String records = output.getString("result");
				materialList = JsonUtils.toList(records, ProductConfigLoanMaterialVo.class);
				if(CollectionUtils.isNotEmpty(materialList)){
					getRequest().setAttribute("materialList", materialList);
				}
			}
		}
		
		/*查询平台管理百分比*/
		Map<String,Object> condition = new HashMap<String,Object>();
		PlatformFeeVo feeVo = new PlatformFeeVo();
		feeVo.setCode("rateOfYear");
		condition.put("parameter", feeVo);
		condition.put("sign", "queryFeeItemByCode");
		ResBody resultbody = TradeInvokeUtils.invoke("PlatformFeeManagement", condition);
		if (result.getSys() != null) {
			String status = resultbody.getSys().getStatus();
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) resultbody.getOutput();
				String records = output.getString("result");
				feeVo = JsonUtils.toObject(records, PlatformFeeVo.class);
			    getRequest().setAttribute("feeVo", feeVo);
			}
		}
		

		// 生成贷款申请编号 UUID
		Sequence seq = new DateTimeSequence();
		String applyNum = seq.next("P");
		getRequest().setAttribute("applyNum", applyNum);

		return "ybl/admin/supplier/application/financeApplication";
	}
	
	

	//上传贷款材料附件
	/**
	 * attachment 上传附件信息 
	 * materialId 贷款材料id
	 * @return
	 */
	@RequestMapping({"/updloadMaterialAttachment"})
	@ResponseBody
	public ControllerResponse updloadMaterialAttachment(String attachment,String materialId){
		ControllerResponse response = new  ControllerResponse(ResponseType.FAILURE);
		if(StringUtils.isEmpty(attachment)||StringUtils.isEmpty(materialId)){
			response.setInfo("参数不符合规范！,请上传贷款材料");
			response.setResponseType(ResponseType.FAILURE);
			return response;
		}
		
		AttachmentVo attache = JsonUtils.toObject(attachment, AttachmentVo.class);
		Map<String,Object> condition = new HashMap<String,Object>();
		ControllerUtils.setWho(attache);
		condition.put("attachment", attache);
		condition.put("materialId", materialId);
		
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("paramter", condition);
		map.put("sign", "updloadMaterialAttachment");
		ResBody result = TradeInvokeUtils.invoke("FinanceApplyManagement", map);
		Boolean flag = false;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				flag = JsonUtils.toObject(records, Boolean.class);
			}
		}
		
		if(flag){
			response.setResponseType(ResponseType.SUCCESS);
			response.setInfo("文件上传成功");
		}else{
			response.setInfo("文件上传失败！");
		}
		
		return response;
	}
	
	
	//融资申请添加融资申请凭证
	/**
	 * 
	 * @param voucher
	 * @param pageVo
	 * @param addedMaterialId 已经添加的融资凭证id  以","分割
	 * @param enterpriseName 核心企业名称
	 * @return
	 */
	@RequestMapping({"/addFinanceApplyVoucher"})
	public String addFinanceApplyVoucher(VoucherVo voucher, PageVo<?> pageVo,String addedMaterialId){
		
		UserVo user = ControllerUtils.getCurrentUser();
		if(null==user){
			return "ybl/admin/index/login";
		}
		voucher.setEnterpriseId(user.getEnterpriseId());
		voucher.setStatus("available");
		voucher.setAttribute2("true");
		if(StringUtils.isNotEmpty(addedMaterialId)){
			String addedMaterialIds  = addedMaterialId.substring(0,addedMaterialId.length()-1);
			voucher.setAttribute1(addedMaterialIds);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", voucher);
		map.put("page", pageVo);
		map.put("sign", "queryVocherByNotRelate");
		ResBody result = TradeInvokeUtils.invoke("VoucherManagement", map);
		PageVo page = null;
		List<VoucherVo> voucherList = null;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage = output.getString("page");
				String records = output.getString("result");
				page = JSONObject.parseObject(jsonPage, PageVo.class);
				voucherList = JsonUtils.toList(records, VoucherVo.class);
				
				getRequest().setAttribute("page", page);
				getRequest().setAttribute("voucherList", voucherList);
			}
		}
		
		//查询核心企业
		Map< String, Object> cond = new HashMap<String,Object>();
		cond.put("role", "enterprise");
		cond.put("status", "agree");
		cond.put("sign", "queryEnterpriseByRole");
		ResBody res = TradeInvokeUtils.invoke("EnterpriseManagement", cond);
		List<EnterpriseVo> enterList = null;
		if (res.getSys() != null) {
			String status = res.getSys().getStatus();
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) res.getOutput();
				String jsonPage = output.getString("page");
				String records = output.getString("result");
				enterList = JsonUtils.toList(records, EnterpriseVo.class);
			}
		}
		
		getRequest().setAttribute("enterList", enterList);
		getRequest().setAttribute("voucher", voucher);
		getRequest().setAttribute("addedMaterialId", addedMaterialId);
		
		
		return "ybl/admin/supplier/application/financeApplyAddVoucher";
	}
	
	
	
	
	//融资申请提交
	@RequestMapping({"/financeApplySubmit"})
	@ResponseBody
	public ControllerResponse financeApplySubmit(long productId,String applyNum,String applyAmont, String periodType,
			int loanPeriod,String manageRatio ,String repaymentDate,String myArray,String addVoucherIds){
		
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		//提交前数据校验
		
		//融资申请贷款材料  把贷款材料id放到attribute1
		List<AttachmentVo> attachList = new ArrayList<AttachmentVo>();
		if(!StringUtils.isEmpty(myArray)){
			String[] str = myArray.split("#");
			for (int i = 0; i < str.length; i++) {
				if(str[i] != null && !"".equals(str[i])){
					JSONObject obj = JSONObject.parseObject(str[i]);
					AttachmentVo attache = JSONObject.parseObject(str[i], AttachmentVo.class);
					attache.setAttribute1(obj.getString("attribute1"));
					ControllerUtils.setWho(attache);
					attachList.add(attache);
				}
			}
		}
		
		// 查询产品详情
		ProductVo product = new ProductVo();
		product.setId(productId);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("paramter", product);
		map.put("sign", "queryProductByCondition");
		ResBody resu = TradeInvokeUtils.invoke("ProductsFactoryManagement", map);
		List<ProductVo> productList = null;
		if (resu.getSys() != null) {
			String status = resu.getSys().getStatus();
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) resu.getOutput();
				String records = output.getString("result");
				productList = JsonUtils.toList(records, ProductVo.class);
				if(CollectionUtils.isNotEmpty(productList)){
					product = productList.get(0);
				}
			}
		}
		
		//获取当前企业id
		UserVo user = ControllerUtils.getCurrentUser();
		if(null==user){
			response.setInfo("请先登录！");
			response.setResponseType(ResponseType.FAILURE);
			return response;
		}
		//组装融资申请信息
		FinanceApplyVo financeApply = new FinanceApplyVo();
		ControllerUtils.setWho(financeApply);
		financeApply.setName_(product.getName_());
		financeApply.setFactor_type(product.getType_());
		financeApply.setRate_(product.getRate_());
		financeApply.setOverdue_rate(product.getOverdue_rate());
		financeApply.setManage_rate(new BigDecimal(manageRatio));
		financeApply.setFinance_ratio(product.getFinance_ratio());
		financeApply.setSupplier_member_id(user.getId());
		financeApply.setFactoring_member_id(product.getCreatedBy());
		financeApply.setNumber_(applyNum);
		BigDecimal applyAmont_ = new BigDecimal(applyAmont);
		financeApply.setApply_amount(applyAmont_);
		financeApply.setRepayment_date(repaymentDate);
		financeApply.setLoan_period(loanPeriod);
		financeApply.setPeriod_type(periodType);
		financeApply.setStatus_("auditing");
		financeApply.setEnterprise_id(user.getEnterpriseId());
		financeApply.setBusiness_id(product.getId());
		financeApply.setFinance_body("product");
		financeApply.setPenalty_rate(product.getPenalty_rate());
		financeApply.setRepayment_type(product.getRepayment_type());
		financeApply.setRepayment_date_rule(product.getRepayment_date_rule());
		
		
		//查询融资贷款材料信息
		map.put("paramter", productId);
		map.put("sign", "queryMaterialByProductId");
		ResBody results = TradeInvokeUtils.invoke("FinanceApplyManagement", map);
		List<ProductConfigLoanMaterialVo> materialList = null;
		if (results.getSys() != null) {
			String status = results.getSys().getStatus();
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) results.getOutput();
				String records = output.getString("result");
				materialList = JsonUtils.toList(records, ProductConfigLoanMaterialVo.class);
			}
		}
		
		//组装融资申请贷款材料信息
		List<FinanceLoanMaterialVo> financeLoanMaterialList = new ArrayList<FinanceLoanMaterialVo>(); 
		if(CollectionUtils.isNotEmpty(materialList)){
			for (int i = 0; i < materialList.size(); i++) {
				FinanceLoanMaterialVo materialVo = new FinanceLoanMaterialVo();
				ControllerUtils.setWho(materialVo);
				materialVo.setCode_(materialList.get(i).getCode());
				materialVo.setName_(materialList.get(i).getName());
				materialVo.setRemark_(materialList.get(i).getRemark());
				materialVo.setEnterprise_id(user.getEnterpriseId());
				materialVo.setAttribute1(materialList.get(i).getId().toString());//存入产品贷款材料信息id 与attachement.attribute1对应
				financeLoanMaterialList.add(materialVo);
			}
		}
		
		//组装融资申请凭证信息
		List<FinanceApplyVoucherVo> applyVoucherVoList = new ArrayList<FinanceApplyVoucherVo>();
		if(StringUtils.isNotEmpty(addVoucherIds)){
			String[] addVoucherId = addVoucherIds.split(";");
			for (int i = 0; i < addVoucherId.length; i++) {
				FinanceApplyVoucherVo applyVoucherVo = new FinanceApplyVoucherVo();
				ControllerUtils.setWho(applyVoucherVo);
				applyVoucherVo.setVoucherId(Long.parseLong(addVoucherId[i]));
				applyVoucherVo.setVoucherStatus("not_certified");
				applyVoucherVoList.add(applyVoucherVo);
			}
		}
		
		//组装审核记录信息
		AuditRecordVo auditRecord = new AuditRecordVo();
		ControllerUtils.setWho(auditRecord);
		auditRecord.setType("finance_apply");
		auditRecord.setOperation("waiting");
		auditRecord.setEnterpriseId(user.getEnterpriseId());
		auditRecord.setStatus("1000_auditing");
		
		
		//将使用的融资凭证状态至为使用中
		List<VoucherVo> voucherList = new ArrayList<VoucherVo>();
		if(StringUtils.isNotEmpty(addVoucherIds)){
			String[] voucherId = addVoucherIds.split(";");
			for (int i = 0; i < voucherId.length; i++) {
				VoucherVo voucher = new VoucherVo();
				voucher.setId(Long.parseLong(voucherId[i]));
				ControllerUtils.setWho(voucher);
				voucher.setStatus("using");	
				voucher.setEnterpriseId(user.getEnterpriseId());
				voucherList.add(voucher);
			}
		}
		
		
		Map<String,Object> paramter = new HashMap<String,Object>();
		
		paramter.put("financeApply",financeApply);
		paramter.put("attachList",attachList);
		paramter.put("financeLoanMaterialList",financeLoanMaterialList);
		paramter.put("applyVoucherVoList",applyVoucherVoList);
		paramter.put("auditRecord", auditRecord);
		paramter.put("voucherList", voucherList);
		
		Map<String,Object> req = new HashMap<String,Object>(); 
		req.put("paramter", paramter);
		req.put("sign", "financeApplySubmit");
		ResBody result = TradeInvokeUtils.invoke("FinanceApplyManagement", req);
		boolean flag = false;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				flag = JsonUtils.toObject(records, Boolean.class);
			}
		}
		
		if(flag){
			response.setInfo("融资申请提交成功");
			response.setResponseType(ResponseType.SUCCESS);
		}else{
			response.setInfo("融资申请提交失败");
			response.setResponseType(ResponseType.FAILURE);
		}
		
		return response;
	}
	
	
	/**
	 * 融资申请提交前数据校验
	 * @param productId
	 * @param applyNum
	 * @param applyAmont
	 * @param periodType
	 * @param loanPeriod
	 * @param repaymentDate
	 * @param myArray
	 * @param addVoucherIds
	 * @return
	 */
	/*public ControllerResponse validateFinanceApply(long productId,String applyNum,String applyAmont, String periodType,
			int loanPeriod ,String repaymentDate,String myArray,String addVoucherIds){
		ControllerResponse response = new ControllerResponse(ResponseType.FAILURE);
		
		
		if(productId==0){
			response.setInfo("没有选择产品");
			response.setResponseType(ResponseType.FAILURE);
			return response;
		}
		
		if(StringUtils.isEmpty(applyNum)){
			response.setInfo("没有融资申请编号");
			response.setResponseType(ResponseType.FAILURE);
			return response;
		}
		
		
		
		return null;
	}*/
	
}
