package com.bpm.framework.controller.accountCenter;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.bpm.framework.SystemConst;
import com.bpm.framework.constant.Constant;
import com.bpm.framework.controller.AbstractController;
import com.bpm.framework.controller.ControllerResponse;
import com.bpm.framework.controller.ControllerUtils;
import com.bpm.framework.controller.ResponseType;
import com.bpm.framework.controller.fileupload.AttachmentVo;
import com.bpm.framework.utils.CollectionUtils;
import com.bpm.framework.utils.StringUtils;
import com.bpm.framework.utils.i18n.I18NUtils;
import com.bpm.framework.utils.json.JsonUtils;

import cn.sunline.framework.controller.vo.EnterpriseVo;
import cn.sunline.framework.controller.vo.PageVo;
import cn.sunline.framework.controller.vo.RoleAuthVo;
import cn.sunline.framework.controller.vo.UserVo;
import cn.sunline.framework.controller.vo.common.FormListObject;
import cn.sunline.ybl.sys.util.trade.ResBody;
import cn.sunline.ybl.sys.util.trade.TradeInvokeUtils;

/**
 * 企业信息controller
 * 
 * @author MaiBenBen
 *
 */
@Controller
@RequestMapping({ "/enterpriseController" })
public class EnterpriseController extends AbstractController {

	private static final long serialVersionUID = -8726824202586592682L;

	/**
	 * 角色认证页面跳转
	 * 
	 * @param roleType
	 *            角色类型
	 * @return
	 */
	@RequestMapping({ "/toRoleAuth" })
	public String toRoleAuth(HttpServletRequest request, String roleType) {
		// (1)获取当前登录人的信息
		UserVo user = ControllerUtils.getCurrentUser();
		// (2)判断是否登录（获取不到登陆人信息，则返回登陆页面）
		Long enterpriseId = user.getEnterpriseId();
		if(StringUtils.isEmpty(roleType)){
			roleType = user.getCertRole();
		}
		// (3)判断必要参数
		if (StringUtils.isNotEmpty(roleType) && enterpriseId.longValue()>0) {
			EnterpriseVo parameters = new EnterpriseVo();
			parameters.setId(enterpriseId);
			// (4)调用服务，进行用户数据查询
			// 查询用户的方法（调用服务，得到用户数据集合）
			List<EnterpriseVo> enterpriseList = queryEnterpriseByCondition(parameters);
			if (CollectionUtils.isNotEmpty(enterpriseList)) {// 若存在，返回页面数据
				request.setAttribute("enterprise", enterpriseList.get(0));
			}
		}
		request.setAttribute("roleType", roleType);
		return "ybl/admin/accountCenter/authentication/roleAuthen";
	}

	/**
	 * 编辑页面跳转，并加载数据
	 * 
	 * @param request
	 * @param roleType
	 *            角色类型
	 * @return
	 */
	@RequestMapping({ "/editEnterprise" })
	public String editEnterprise(HttpServletRequest request, String roleType) {
		// (1)获取当前登录人的信息
		UserVo user = ControllerUtils.getCurrentUser();
		Long enterpriseId = 0L;
		if (user != null && user.getEnterpriseId() != null) {
			enterpriseId = user.getEnterpriseId();
		}
		// (1)判断必要参数
		if (StringUtils.isNotEmpty(roleType) && enterpriseId.longValue() > 0) {
			EnterpriseVo parameters = new EnterpriseVo();
			parameters.setId(enterpriseId);
			// (2)调用服务，进行用户数据查询
			// 查询用户的方法（调用服务，得到用户数据集合）
			List<EnterpriseVo> enterpriseList = queryEnterpriseByCondition(parameters);
			if (CollectionUtils.isNotEmpty(enterpriseList)) {// 若存在，返回页面数据
				request.setAttribute("enterprise", enterpriseList.get(0));

			}
			// (5)查询附件信息(前缀是userCertificate_)
			String attachType = "userCertificate_";
			AttachmentVo attach = new AttachmentVo();
			attach.setResourceId(enterpriseId);
			attach.setEnterpriseId(enterpriseId);
			attach.setAttribute1(attachType);
			List<AttachmentVo> attachmentList = queryAttchmentByCondition(attach);
			if (CollectionUtils.isNotEmpty(attachmentList)) {// 若存在，返回页面数据
				request.setAttribute("attachmentList", attachmentList);
			}
		}
		request.setAttribute("roleType", roleType);
		return "ybl/admin/accountCenter/authentication/userAuthen";
	}

	/**
	 * 保存/编辑企业数据
	 * 
	 * @param request
	 * @param parameters
	 *            提交的企业数据
	 * @param roleType
	 *            角色类型
	 * @param formListObject
	 *            form集合对象
	 * @return
	 */
	@RequestMapping(value = "/addOrUpdateEnterprise")
	@ResponseBody
	public ControllerResponse addOrUpdateEnterprise(EnterpriseVo parameters, String roleType,
			FormListObject formListObject) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		RoleAuthVo roleAuth = new RoleAuthVo();
		// (1)判断是否有数据
		if (parameters == null || StringUtils.isEmpty(parameters.getEnterpriseName())) {
			response.setInfo(I18NUtils.getText("sys.client.paramter.error"));// 参数错误
			super.log.error("保存/编辑企业数据对象不能为空！");
			return response;
		}
		// (2)判断角色认证类型是否为空
		if (StringUtils.isEmpty(roleType)) {
			response.setInfo(I18NUtils.getText("sys.client.roletype.not.null"));// 角色认证类型不能为空！
			super.log.error("角色认证类型不能为空！");
			return response;
		}
		// 设置参数
		Long enterpriseId = parameters.getId();
		ControllerUtils.setWho(parameters);// 设置时间、操作人
		parameters.setEnable(1);// 设置有效字段（0：否，1：是）
		parameters.setSign("");// 设置签名字段
		parameters.setStatus(Constant.USER_AUTH_AUTHING);// 认证状态
		// (3)判断是否上传图片并将参数传入
		if (formListObject != null && CollectionUtils.isNotEmpty(formListObject.getAttachmentlist())) {
			List<AttachmentVo> attachmentList = formListObject.getAttachmentlist();
			if (CollectionUtils.isNotEmpty(attachmentList)) {
				for (AttachmentVo attachment : attachmentList) {
					ControllerUtils.setWho(attachment);// 设置时间、操作人
					if (enterpriseId != null) {
						attachment.setResourceId(enterpriseId);
					}
				}
				roleAuth.setAttachmentList(attachmentList);
			} else {
				response.setInfo(I18NUtils.getText("sys.client.certicates.photo.not.null"));// 证件照不能为空！
				super.log.error("证件照不能为空！");
				return response;
			}
		} else {
			if (enterpriseId == null) {// 新增时必填，更新可不修改
				response.setInfo(I18NUtils.getText("sys.client.certicates.photo.not.null"));// 证件照不能为空！
				super.log.error("证件照不能为空！");
				return response;
			}
		}
		// (4)校验企业的各种证件号码是否重复（新增时需要判断）
		String licenseNo = parameters.getLicenseNo();// 营业执照注册号
		String orgCodeNo = parameters.getOrgCodeNo();// 机构代码证号
		String taxNo = parameters.getTaxNo();// 税务登记号
		String financeNo = parameters.getFinanceNo();// 财务登记证号
		// 查询用户的方法（调用服务，得到用户数据集合）
		List<EnterpriseVo> enterpriseList = queryEnterpriseAll();
		if (CollectionUtils.isNotEmpty(enterpriseList)) {// 若存在，则给出提示
			for (EnterpriseVo enterprise : enterpriseList) {
				if (enterprise != null) {
					if ((enterpriseId != null && enterprise.getId().longValue() != enterpriseId.longValue())
							|| (enterpriseId == null)) {// 新增时比较、更新时不和自己的数据比较
						// 判断营业执照注册号是否重复
						if (licenseNo != null && licenseNo.equals(enterprise.getLicenseNo())) {
							response.setInfo(I18NUtils.getText("sys.client.licenseNumber") + "[" + licenseNo + "]"
									+ I18NUtils.getText("sys.client.already.used.please.change"));// 营业执照注册号已被使用,请换一个号码
							super.log.error("新增企业的营业执照注册号重复！");
							return response;
						}
						// 判断机构代码证号是否重复
						if (orgCodeNo != null && orgCodeNo.equals(enterprise.getOrgCodeNo())) {
							response.setInfo(I18NUtils.getText("sys.client.orgCodeNo") + "[" + orgCodeNo + "]"
									+ I18NUtils.getText("sys.client.already.used.please.change"));// 机构代码证号已被使用,请换一个号码
							super.log.error("新增企业的机构代码证号重复！");
							return response;
						}
						// 判断税务登记号是否重复
						if (taxNo != null && taxNo.equals(enterprise.getTaxNo())) {
							response.setInfo(I18NUtils.getText("sys.client.taxNo") + "[" + taxNo + "]"
									+ I18NUtils.getText("sys.client.already.used.please.change"));// 税务登记号已被使用,请换一个号码
							super.log.error("新增企业的税务登记号重复！");
							return response;
						}
						// 判断财务登记证号是否重复
						if (financeNo != null && financeNo.equals(enterprise.getFinanceNo())) {
							response.setInfo(I18NUtils.getText("sys.client.financeNo") + "[" + financeNo + "]"
									+ I18NUtils.getText("sys.client.already.used.please.change"));// 财务登记证号已被使用,请换一个号码
							super.log.error("新增企业的财务登记证号重复！");
							return response;
						}
					}
				}
			}
		}
		// 三证合一(1:是;0:否)
		// (工商营业执照licenseNo、机构代码证orgCodeNo和税务登记证taxNo)
		if (StringUtils.isNotEmpty(parameters.getIsThreeInOne()) && "1".equals(parameters.getIsThreeInOne())) {
			parameters.setOrgCodeNo(licenseNo);
			parameters.setTaxNo(licenseNo);
		} 
		// 是否永久有效经营
		if (StringUtils.isEmpty(parameters.getEndDate())) {// 永久有效（考虑到时间字段不能为空，设置一个较长的时间2099-12-31）
			parameters.setEndDate("2099-12-31");
		}
		// (5)新增/编辑操作
		Object result = null;
		Map<String, Object> map = new HashMap<String, Object>();
		// 获取当前登录人的信息,将认证角色塞到attribute1中，当前登录人的id塞到attribute2
		UserVo user = ControllerUtils.getCurrentUser();
		if (enterpriseId == null) { // 新增
			Long memberId = user.getId();
			parameters.setAttribute2(memberId.toString());// 当前登录人的会员id
			parameters.setAttribute1(roleType);// 认证角色
			roleAuth.setEnterprise(parameters);
			// (6)调用服务，进行数据保存
			map.put("paramter", roleAuth);
			map.put("sign", "insertEnterpriseInfo");// 所调用的服务中的方法
			result = TradeInvokeUtils.invoke("EnterpriseManagement", map);
			response.setResponseType(ResponseType.SUCCESS_SAVE);
		} else {// 编辑
			// (6)调用服务，进行数据更新
			roleAuth.setEnterprise(parameters);
			map.put("paramter", roleAuth);
			map.put("sign", "updateEnterpriseMessageById");// 所调用的服务中的方法
			result = TradeInvokeUtils.invoke("EnterpriseManagement", map);
			response.setResponseType(ResponseType.SUCCESS_UPDATE);
		}
		// (7)对调用服务后的返回数据进行解析
		if (result != null) {
			Map<String, Object> jsonMap = JsonUtils.toMap(result);
			JSONObject sys = (JSONObject) jsonMap.get("sys");
			if (sys != null) {
				String status = sys.getString("status");// 状态：'S'成功，'F'失败
				String erortx = sys.getString("erortx");// 错误信息
				if ("S".equals(status)) {// 交易成功
					response.setObject(result);// 设置返回结果
					response.setInfo(I18NUtils.getText("sys.client.add.success"));// 添加成功
					super.log.info("新增/编辑insertEnterpriseInfo/updateEnterpriseMessageById服务调用信息：" + erortx);
					if (enterpriseId == null) {
						// (8)新增成功用户信息存到session中
						UserVo userVo = new UserVo();
						userVo.setId(user.getId());
						userVo.setUserName(user.getUserName());
						List<UserVo> userList = queryMemberByCondition(userVo);
						if (CollectionUtils.isNotEmpty(userList)) {
							super.getSession().setAttribute(SystemConst.USER_SESSION_KEY, userList.get(0));
						}
					}
				} else {
					response.setResponseType(ResponseType.ERROR);
					response.setInfo(I18NUtils.getText("sys.client.add.fail"));// 添加失败
					super.log.error("新增/编辑insertEnterpriseInfo/updateEnterpriseMessageById服务调用信息：" + erortx);
				}
			}
		} else {
			response.setResponseType(ResponseType.ERROR);
			response.setInfo(I18NUtils.getText("sys.client.call.service.fail"));// 调用服务失败
			super.log.error("调用服务失败！");
		}
		return response;
	}

	/**
	 * 根据条件查询单个企业
	 * 
	 * @param request
	 * @param parameters
	 *            企业查询条件
	 * @return EnterpriseVo 企业信息
	 */
	@RequestMapping(value = "/findOneEnterprise")
	@ResponseBody
	public EnterpriseVo findOneEnterprise(EnterpriseVo parameters) {
		// (1) 判断必要参数是否存在
		if (parameters == null) {
			super.log.error("parameters不能为空");
			return null;
		}
		// (2)单个企、企业数据查询
		List<EnterpriseVo> enterpriseList = queryEnterpriseByCondition(parameters);
		if (CollectionUtils.isNotEmpty(enterpriseList)) {
			parameters = enterpriseList.get(0);
			return parameters;
		}
		return null;
	}

	/**
	 * 根据用户信息查询企业信息
	 * 
	 * @param request
	 * @param parameters
	 *            企业查询条件
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/queryEnterpriseByCondition")
	@ResponseBody
	public List<EnterpriseVo> queryEnterpriseByCondition(EnterpriseVo parameters) {
		parameters.setEnable(1);// （0：否，1：是）
		// 调用服务，进行数据查询
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", parameters);
		map.put("page", new PageVo());
		map.put("sign", "queryEnterpriseByCondition");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("EnterpriseManagement", map);
		JSONObject output = (JSONObject) result.getOutput();
		List<EnterpriseVo> enterpriseList = null;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				String resultJson = output.getString("result");
				enterpriseList = JsonUtils.toList(resultJson, EnterpriseVo.class);
				super.log.info("根据条件查询企业调用queryEnterpriseByCondition服务返回成功，信息：" + erortx);
			} else {
				super.log.error("根据条件查询企业调用queryEnterpriseByCondition服务返回失败，信息：" + erortx);
				return null;
			}
		}
		return enterpriseList;
	}

	/**
	 * 根据用户信息查询企业信息
	 * 
	 * @param request
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/queryEnterpriseAll")
	@ResponseBody
	public List<EnterpriseVo> queryEnterpriseAll() {
		// 调用服务，进行数据查询
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", "");
		map.put("page", new PageVo());
		map.put("sign", "queryEnterpriseAll");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("EnterpriseManagement", map);
		JSONObject output = (JSONObject) result.getOutput();
		List<EnterpriseVo> enterpriseList = null;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				String resultJson = output.getString("result");
				enterpriseList = JsonUtils.toList(resultJson, EnterpriseVo.class);
				super.log.info("查询所有企业调用queryEnterpriseAll服务返回成功，信息：" + erortx);
			} else {
				super.log.error("查询所有企业调用queryEnterpriseAll服务返回失败，信息：" + erortx);
				return null;
			}
		}
		return enterpriseList;
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
	 * 根据企业id修改企业信息
	 * 
	 * @param request
	 * @param parameters
	 *            企业对象
	 * @return
	 */
	@RequestMapping(value = "/updateEnterprise")
	@ResponseBody
	public ControllerResponse updateEnterprise(HttpServletRequest request, EnterpriseVo parameters) {
		ControllerResponse response = new ControllerResponse(ResponseType.ERROR);
		// (1)判断必要参数
		if (!(parameters != null && parameters.getId() != null)) {
			super.log.error("修改企业时，企业对象及id不能为空！");
			response.setInfo(I18NUtils.getText("sys.client.paramter.error"));// 参数错误
			return response;
		}
		// (2)查询企业是否存在
		EnterpriseVo param = new EnterpriseVo();
		param.setId(parameters.getId());
		param.setEnable(1);
		List<EnterpriseVo> enterpriseList = queryEnterpriseByCondition(param);
		if (CollectionUtils.isNotEmpty(enterpriseList)) {
			param = enterpriseList.get(0);
			// (2)调用服务，进行数据更新
			Map<String, Object> map = new HashMap<String, Object>();
			ControllerUtils.setWho(param);// 设置时间、操作人
			param.setCompanyProfile(parameters.getCompanyProfile());
			map.put("paramter", param);
			map.put("sign", "updateEnterpriseById");// 所调用的服务中的方法
			ResBody result = TradeInvokeUtils.invoke("EnterpriseManagement", map);
			// (3)对调用服务后的返回数据进行解析
			if (result != null) {
				if (result.getSys() != null) {
					String estatus = result.getSys().getStatus();// 状态：'S'成功，'F'失败
					String erortx = result.getSys().getErortx();// 错误信息
					if ("S".equals(estatus)) {// 交易成功
						response.setInfo(I18NUtils.getText("sys.client.update.success"));// 企业信息更新成功！
						response.setResponseType(ResponseType.SUCCESS_UPDATE);
						super.log.info("企业信息更新,调用updateEnterpriseById服务，信息：" + erortx);
					} else {
						response.setInfo(I18NUtils.getText("sys.client.update.fail"));// 企业信息更新失败！
						super.log.error("企业信息更新,调用updateEnterpriseById服务，信息：" + erortx);
					}
				}
			} else {
				response.setInfo(I18NUtils.getText("sys.client.call.service.fail"));// 调用服务失败
				super.log.error("调用服务失败！");
			}
		} else {
			response.setInfo(I18NUtils.getText("sys.client.update.fail.record.unexist"));// 企业信息更新失败,记录不存在！
			super.log.error("企业信息更新失败,记录不存在！");
		}
		return response;
	}

	/**
	 * 根据条件查询附件信息
	 * 
	 * @param request
	 * @param parameters
	 *            附件查询条件
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/queryAttchmentByCondition")
	@ResponseBody
	public List<AttachmentVo> queryAttchmentByCondition(AttachmentVo parameters) {
		parameters.setEnable(1);// （0：否，1：是）
		// 调用服务，进行数据查询
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paramter", parameters);
		map.put("page", new PageVo());
		map.put("sign", "queryAttchmentByCondition");// 所调用的服务中的方法
		ResBody result = TradeInvokeUtils.invoke("AttachmentManagement", map);
		JSONObject output = (JSONObject) result.getOutput();
		List<AttachmentVo> attachmentList = null;
		if (result.getSys() != null) {
			String status = result.getSys().getStatus();
			String erortx = result.getSys().getErortx();// 错误信息
			if ("S".equals(status)) {// 交易成功
				String resultJson = output.getString("result");
				attachmentList = JsonUtils.toList(resultJson, AttachmentVo.class);
				super.log.info("根据条件查询企业调用queryAttchmentByCondition服务返回成功，信息：" + erortx);
			} else {
				super.log.error("根据条件查询企业调用queryAttchmentByCondition服务返回失败，信息：" + erortx);
				return null;
			}
		}
		return attachmentList;
	}
}
