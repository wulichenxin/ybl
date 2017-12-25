package com.bpm.framework.controller.supplier;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.constant.Constant;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.controller.fileupload.AttachmentVo;
import com.bpm.framework.utils.CollectionUtils;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.EnterpriseVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.VoucherVo;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 凭证管理controller
 * 
 * @author lenovo
 *
 */
@Controller
@RequestMapping({ "/voucherController" })
public class VoucherController extends AbstractController {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@RequestMapping({ "/voucherManage" })
	public String voucherManage(VoucherVo voucher, PageVo pageVo) {
		
		UserVo user = ControllerUtils.getCurrentUser();
		
		if(null==user){
			return "ybl/admin/index/login";
		}
		
		voucher.setEnterpriseId(user.getEnterpriseId());
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
				page = JsonUtils.toObject(jsonPage, PageVo.class);
				voucherList = JsonUtils.toList(records, VoucherVo.class);
				
				getRequest().setAttribute("page", page);
				getRequest().setAttribute("voucherList", voucherList);
			}
		}
		
		//查询核心企业
		Map< String, Object> condition = new HashMap<String,Object>();
		condition.put("role", "enterprise");
		condition.put("status", "agree");
		condition.put("sign", "queryEnterpriseByRole");
		ResBody res = TradeInvokeUtils.invoke("EnterpriseManagement", condition);
		List<EnterpriseVo> enterList = null;
		if (res.getSys() != null) {
			String status = res.getSys().getStatus();
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) res.getOutput();
				String records = output.getString("result");
				enterList = JsonUtils.toList(records, EnterpriseVo.class);
				
				getRequest().setAttribute("enterList", enterList);
			}
		}
		
		getRequest().setAttribute("voucher", voucher);
		return "ybl/admin/supplier/application/voucherManage";
	}

	@RequestMapping({"/addVoucherinit"})
	public String addVoucherinit(){
		//加载核心企业
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
				String records = output.getString("result");
				enterList = JsonUtils.toList(records, EnterpriseVo.class);
				
				getRequest().setAttribute("enterList", enterList);
			}
		}
		return "ybl/admin/supplier/application/voucherAdd";
	}
	
	@RequestMapping({ "/addVoucherinfo" })
	@ResponseBody
	public ControllerResponse addVoucherinfo(VoucherVo vo,String attachmentArray ) {
		ControllerResponse response = new ControllerResponse(ResponseType.FAILURE);
		
		Map<String, Object> condition = new HashMap<String, Object>();
		ControllerUtils.setWho(vo);
		UserVo user = ControllerUtils.getCurrentUser();
		if(null==user){
			response.setResponseType(ResponseType.FAILURE, "请先登录！");
			return response;
		}
		vo.setMemberId(user.getId());
		vo.setStatus("available");
		vo.setEnterpriseId(user.getEnterpriseId());
		
		//附件信息
		List<AttachmentVo> attachList = new ArrayList<AttachmentVo>();
		if(StringUtils.isNotEmpty(attachmentArray)){
			String[] str = attachmentArray.split("#");
			for (int i = 0; i < str.length; i++) {
				AttachmentVo attache = JsonUtils.toObject(str[i], AttachmentVo.class);
				ControllerUtils.setWho(attache);
				attache.setEnterpriseId(user.getEnterpriseId());
				attachList.add(attache);
			}
		}
		condition.put("voucher", vo);
		condition.put("attachList", attachList);
		
		Map<String, Object> req = new HashMap<String, Object>();
		req.put("paramter", condition);
		req.put("sign", "insertVoucher");
		ResBody result = TradeInvokeUtils.invoke("VoucherManagement", req);
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			JSONObject output = (JSONObject) result.getOutput();
			String records = output.getString("result");
			if ("S".equals(status) && Boolean.parseBoolean(records)) {
				response.setInfo("凭证添加成功");
				response.setResponseType(ResponseType.SUCCESS);
			}else{
				response.setInfo("凭证添加失败！");
				response.setResponseType(ResponseType.FAILURE);
			}
		}

		return response;
	}
	
	@RequestMapping({"/deleteVoucherByIds"})
	@ResponseBody
	public ControllerResponse deleteVoucherBysId(String id){
		ControllerResponse res = new ControllerResponse(ResponseType.FAILURE);
		String[] ids = id.split(";");
		if(ids.length < 1){
			res.setInfo("请选择要删除的记录！");
			res.setResponseType(ResponseType.ERROR);
			return res ;
		}
		
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("paramter", id);
		map.put("sign", "deleteVoucherByIds");
		ResBody  result = TradeInvokeUtils.invoke("VoucherManagement", map);
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			if ("S".equals(status)) {
				res.setResponseType(ResponseType.SUCCESS);
				res.setInfo("删除成功!");
				return res;
			}else{
				res.setInfo("删除失败");
			}
		}
		return res;
	}
	
	
	
	//修改凭证信息初始化页面
	@RequestMapping({"/updatePageInit"})
	public String updatePageInit(String id){
		//根据id查询信息
		VoucherVo vo =new VoucherVo();
		vo.setId(Long.parseLong(id));
		PageVo<?> page = new PageVo<>();
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("paramter", vo);
		map.put("sign", "queryVocherByNotRelate");
		ResBody  result = TradeInvokeUtils.invoke("VoucherManagement", map);
		List<VoucherVo> voucherList = null;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage = output.getString("page");
				String records = output.getString("result");
				page = JSONObject.parseObject(jsonPage, PageVo.class);
				voucherList = JsonUtils.toList(records, VoucherVo.class);
				if(CollectionUtils.isNotEmpty(voucherList)){
					getRequest().setAttribute("voucher",voucherList.get(0));
				}
			}
		}
		
		//根据id查询凭这个关联的附件
		Map<String ,Object> condition  = new HashMap<String,Object>();
		condition.put("paramter", id);
		condition.put("sign", "queryAttachByVoucherId");
		ResBody  resu = TradeInvokeUtils.invoke("VoucherManagement", condition);
		List<AttachmentVo> attachmentList = new ArrayList<AttachmentVo>();
		if (resu.getSys() != null) {
			String status = resu.getSys().getStatus();
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) resu.getOutput();
				String jsonPage = output.getString("page");
				String records = output.getString("result");
				attachmentList = JsonUtils.toList(records, AttachmentVo.class);
				
				getRequest().setAttribute("attachmentList", attachmentList);
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
		
		return "ybl/admin/supplier/application/voucherUpdate";
	}
	
	
	
	
	@RequestMapping({"/updateVoucherById"})
	@ResponseBody
	public ControllerResponse updateVoucherById(VoucherVo  voucher,String deleteIds,String attachmentArray){
		ControllerResponse response = new ControllerResponse(ResponseType.FAILURE);
		
		List<AttachmentVo> attachList = new ArrayList<AttachmentVo>();
		if(StringUtils.isNotEmpty(attachmentArray)){
			String[] str = attachmentArray.split("#");
			for (int i = 0; i < str.length; i++) {
				AttachmentVo attach = JsonUtils.toObject(str[i], AttachmentVo.class);
				ControllerUtils.setWho(attach);
				attachList.add(attach);
			}
		}
		ControllerUtils.setWho(voucher);
		Map<String,Object> condition = new HashMap<String,Object>();
		condition.put("voucher", voucher);
		condition.put("deleteIds", deleteIds);
		condition.put("attachList", attachList);
		
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("paramter", condition);
		map.put("sign", "updateVoucherById");
		ResBody  result = TradeInvokeUtils.invoke("VoucherManagement", map);
		boolean flag = false;//更新是否成功标识
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) result.getOutput();
				String records = output.getString("result");
				flag = JsonUtils.toObject(records, Boolean.class);
				response.setResponseType(ResponseType.SUCCESS);
				response.setInfo("更新成功");
			}else{
				response.setInfo("更新失败！");
			}
		}
		return response;
	}

	/**
	 * 标的详情添加凭证弹出框页面
	 * @param ids 已添加的凭证id拼装的字符串（查询的需要去掉这些）
	 */
	@RequestMapping({ "/toVoucherSelect-{ids}" })
	public String toVoucherSelect(@PathVariable String ids,PageVo<?> page) {
		UserVo user = ControllerUtils.getCurrentUser();
		if(null==user){
			return "ybl/admin/index/login";
		}
		getRequest().setAttribute("ids", ids);
		if (user != null && user.getEnterpriseId() != null) {
			VoucherVo voucher = new VoucherVo();
			voucher.setMemberId(user.getId());
			voucher.setStatus(Constant.VOUCHER_AVAILABLE);//查询可使用的凭证
			voucher.setAttribute1(ids);/*备用字段1用来塞-已添加的凭证id拼装的字符串（查询的需要去掉这些）*/
			voucher.setAttribute2("1");/*备用字段2随便塞一个值，筛选掉已过期的凭证*/
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("paramter", voucher);
			map.put("page", page);
			map.put("sign", "queryVocherByNotRelate");
			ResBody result = TradeInvokeUtils.invoke("VoucherManagement", map);
			if (result.getSys() != null) {
				String status = result.getSys().getStatus();
				if ("S".equals(status)) {
					JSONObject output = (JSONObject) result.getOutput();
					String jsonPage = output.getString("page");
					String records = output.getString("result");
					page = JSONObject.parseObject(jsonPage, PageVo.class);
					List<VoucherVo> voucherList = JsonUtils.toList(records, VoucherVo.class);
					getRequest().setAttribute("page", page);
					getRequest().setAttribute("voucherList", voucherList);
				}
			}
		}
		return "ybl/admin/supplier/subject/subjectVoucherAdd";
	}

	/**
	 * 查看凭证信息
	 */
	@RequestMapping({"/showVoucherById"})
	public String showVoucherById(String id){
		//根据id查询信息
		VoucherVo vo =new VoucherVo();
		vo.setId(Long.parseLong(id));
		PageVo<?> page = new PageVo<>();
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("paramter", vo);
		map.put("sign", "queryVocherByNotRelate");
		ResBody  result = TradeInvokeUtils.invoke("VoucherManagement", map);
		List<VoucherVo> voucherList = null;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) result.getOutput();
				String jsonPage = output.getString("page");
				String records = output.getString("result");
				page = JSONObject.parseObject(jsonPage, PageVo.class);
				voucherList = JsonUtils.toList(records, VoucherVo.class);
				if(CollectionUtils.isNotEmpty(voucherList)){
					getRequest().setAttribute("voucher",voucherList.get(0));
				}
			}
		}
		
		//根据id查询凭这个关联的附件
		Map<String ,Object> condition  = new HashMap<String,Object>();
		condition.put("paramter", id);
		condition.put("sign", "queryAttachByVoucherId");
		ResBody  resu = TradeInvokeUtils.invoke("VoucherManagement", condition);
		List<AttachmentVo> attachmentList = new ArrayList<AttachmentVo>();
		if (resu.getSys() != null) {
			String status = resu.getSys().getStatus();
			if ("S".equals(status)) {
				JSONObject output = (JSONObject) resu.getOutput();
				String jsonPage = output.getString("page");
				String records = output.getString("result");
				attachmentList = JsonUtils.toList(records, AttachmentVo.class);
			}
		}
		getRequest().setAttribute("attachmentList", attachmentList);
		
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
				
				getRequest().setAttribute("enterList", enterList);
			}
		}
		return "ybl/admin/supplier/application/showVoucherById";
	}
	
	/**
	 * 进入添加凭证页面
	 */
	@RequestMapping({ "/toVoucherAdd" })
	public String toVoucherAdd() {
		return "ybl/admin/supplier/application/voucherAdd";
	}

}
